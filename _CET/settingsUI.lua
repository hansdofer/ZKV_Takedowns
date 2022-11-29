local ZKVTD = GetMod("ZKV_Takedowns")
-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- Native Settings UI
-- ====================================================================================================================

local strlower = string.lower
local strupper = string.upper

local function firstToUpper(str)
    return (str:gsub("^%l", strupper))
end
local function firstOnlyToUpper(str)
    return firstToUpper(strlower(str))
end

-- ====================================================================================================================

local nativeSettings = ZKVTD:GetNativeSettingsMod()
if not nativeSettings then
    ZKVTD.print("Warning: Skipping setup of Native Settings UI due to missing dependency.")
    return
end
local modPathPrefix = "zkvtd_"

-- ====================================================================================================================

local function GetSubcategoryFullPath(subCategoryPath)
    return ZKVTD.nativeSettingsBasePath .. "/" .. subCategoryPath
end

local function AddSubCategory(subCategoryPath, subCategoryLabel, optionalIndex)
    local path = GetSubcategoryFullPath(subCategoryPath)
    ZKVTD.debug("Settings: Add subCategory:", path)
    nativeSettings.addSubcategory(path, subCategoryLabel, optionalIndex)
end

local function AddWidgetToSubCategory_Switch(subCategory, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    local fullPath = GetSubcategoryFullPath(subCategory)
    return nativeSettings.addSwitch(fullPath, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback)
end

local function AddWidgetToSubCategory_SliderInt(subCategory, widgetLabel, widgetTooltip, sliderMin, sliderMax, sliderStep, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    local fullPath = GetSubcategoryFullPath(subCategory)
    return nativeSettings.addRangeInt(fullPath, widgetLabel, widgetTooltip, sliderMin, sliderMax, sliderStep, widgetInitValue, widgetDefaultValue, widgetUpdateCallback)
end

local function AddWidgetToSubCategory_SliderFloat(subCategory, widgetLabel, widgetTooltip, sliderMin, sliderMax, sliderStep, sliderFormat, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    local fullPath = GetSubcategoryFullPath(subCategory)
    if not sliderFormat then sliderFormat = "%.2f" end
    return nativeSettings.addRangeFloat(fullPath, widgetLabel, widgetTooltip, sliderMin, sliderMax, sliderStep, sliderFormat, widgetInitValue, widgetDefaultValue, widgetUpdateCallback)
end


-- local function AddWidgetToSubCategory(subCategory, widgetType, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
--     local fullPath = GetSubcategoryFullPath(subCategory)
--     return AddWidget(fullPath, widgetType, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
-- end

-- ====================================================================================================================

local function AddSubCategory_Takedowns()
    local subCategoryKey = modPathPrefix .. "takedowns"
    AddSubCategory(subCategoryKey, "ZKVTD - Finisher & Takedown Overhaul - Takedowns")

    AddWidgetToSubCategory_Switch(
        subCategoryKey,
        "Only with Melee Weapon In-Hand",
        "Toggle whether or not the new takedown/kill prompt shows only with a melee weapon held (On) or with any weapon (Off) \nGrappling is unaffected.",
        ZKVTD.GetConfigValue("Takedowns_OnlyWithMeleeWeaponHeld"),
        true,
        ZKVTD.GetConfigCallback("Update_Takedowns_OnlyMelee")
    )

    AddWidgetToSubCategory_Switch(
        subCategoryKey,
        "Non-Lethal Blunt",
        "Toggles whether or not takedowns with blunt weapons (fists, gorilla arms, clubs, bats, etc.) leave the target unconscious instead of dead.\n Switch this off to make blunt weapon takedowns lethal.",
        ZKVTD.GetConfigValue("Takedowns_NonLethalBlunt"),
        true,
        ZKVTD.GetConfigCallback("Update_Takedowns_NonLethalBlunt")
    )
end

-- ====================================================================================================================

local function AddSubCategory_MTBAnimSwap()
    local subCategoryKey = modPathPrefix .. "mtb_animswap"
    AddSubCategory(subCategoryKey, "ZKVTD - Finisher & Takedown Overhaul - Mantis Blades Finishers")

    AddWidgetToSubCategory_Switch(
        subCategoryKey,
        "Add Mantis Blades Aerial Takedown Finisher",
        "Switch this on to enable use of the Aerial Takedown animation as a Mantis Blades finisher in combat instead of the normal finisher animation.",
        ZKVTD.GetConfigValue("MantisSwap_Finishers_UseAerialTakedownAnimation"),
        true,
        ZKVTD.GetConfigCallback("Update_MTBAnimSwap_UseAerial")
    )

    AddWidgetToSubCategory_Switch(
        subCategoryKey,
        "Use ONLY Mantis Blades Aerial Finisher",
        "Switch this on to have the mod choose randomly between the Aerial Takedown animation and the original animation for Mantis Blades finishers during combat. \nHas no effect if the previous setting is off.",
        ZKVTD.GetConfigValue("MantisSwap_Finishers_MixDifferentAnimations"),
        true,
        ZKVTD.GetConfigCallback("Update_MTBAnimSwap_RandomChoice")
    )
end

-- ====================================================================================================================

local function AddSubCategory_Misc()
    local subCategoryKey = modPathPrefix .. "misc_tweaks"
    AddSubCategory(subCategoryKey, "ZKVTD - Finisher & Takedown Overhaul - Miscellaneous Tweaks")

    local stealthDmgMult_sliderMin = 1.0
    local stealthDmgMult_sliderMax = 10
    local stealthDmgMult_sliderStep = 0.05
    local stealthDmgMult_default = 1.3
    AddWidgetToSubCategory_SliderFloat(
        subCategoryKey,
        "Stealth Melee Damage Multiplier",
        "This damage multiplier is applied to attacks from stealth.\n Sufficiently high damage can turn strong attacks (such as Mantis Blade leap attacks) into instant takedowns by triggering finishers.\n The default in the base game is +30% damage (i.e.; 1.3)",
        stealthDmgMult_sliderMin,
        stealthDmgMult_sliderMax,
        stealthDmgMult_sliderStep,
        "%.2f",
        ZKVTD.GetConfigValue("Misc_Stealth_MeleeMult"),
        stealthDmgMult_default,
        ZKVTD.GetConfigCallback("Update_Misc_Stealth_MeleeMult")
    )

end

local function initFunc()
    AddSubCategory_Takedowns()
    AddSubCategory_MTBAnimSwap()
    AddSubCategory_Misc()
end


ZKVTD.pcall(initFunc)

ZKVTD.print("Native Settings UI Loaded!")
