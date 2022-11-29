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

local function AddWidget(path, widgetType, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    local addFunc = nativeSettings["add" .. firstOnlyToUpper(widgetType)]
    return addFunc(path, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
end

local function AddWidgetToSubCategory(subCategory, widgetType, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    local fullPath = GetSubcategoryFullPath(subCategory)
    return AddWidget(fullPath, widgetType, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
end

-- ====================================================================================================================

local function AddTakedownsSubCategory()
    local subCategoryKey = modPathPrefix .. "takedowns"
    AddSubCategory(subCategoryKey, "ZKVTD - Finisher & Takedown Overhaul - Takedowns")

    AddWidgetToSubCategory(
        subCategoryKey,
        "Switch",
        "Only with Melee Weapon In-Hand",
        "Toggle whether or not the new takedown/kill prompt shows only with a melee weapon held (On) or with any weapon (Off)",
        ZKVTD.GetConfigValue("Takedowns_OnlyWithMeleeWeaponHeld"),
        true,
        ZKVTD.GetConfigCallback("Update_Takedowns_OnlyMelee")
    )

    AddWidgetToSubCategory(
        subCategoryKey,
        "Switch",
        "Non-Lethal Blunt",
        "By default, takedowns with blunt weapons (fists, gorilla arms, clubs, bats, etc.) leave the target unconscious. Switch this off to make takedowns lethal instead.",
        ZKVTD.GetConfigValue("Takedowns_NonLethalBlunt"),
        true,
        ZKVTD.GetConfigCallback("Update_Takedowns_NonLethalBlunt")
    )
end

-- ====================================================================================================================

local function AddMTBAnimSwapSubCategory()
    local subCategoryKey = modPathPrefix .. "mtb_animswap"
    AddSubCategory(subCategoryKey, "ZKVTD - Finisher & Takedown Overhaul - Mantis Blades Finishers")

    AddWidgetToSubCategory(
        subCategoryKey,
        "Switch",
        "Add Mantis Blades Aerial Takedown Finisher",
        "Switch this on to eanble use of the Aerial Takedown animation as a Mantis Blades finisher in combat instead of the normal finisher animation.",
        ZKVTD.GetConfigValue("MantisSwap_Finishers_UseAerialTakedownAnimation"),
        true,
        ZKVTD.GetConfigCallback("Update_MTBAnimSwap_UseAerial")
    )

    AddWidgetToSubCategory(
        subCategoryKey,
        "Switch",
        "Use ONLY Mantis Blades Aerial Takedown Finisher",
        "Switch this on to have the mod choose randomly between the Aerial Takedown animation and the original animation for Mantis Blades finishers during combat. Has no effect if the previous setting is off.",
        ZKVTD.GetConfigValue("MantisSwap_Finishers_MixDifferentAnimations"),
        true,
        ZKVTD.GetConfigCallback("Update_MTBAnimSwap_RandomChoice")
    )
end

local function initFunc()
    AddTakedownsSubCategory()
    AddMTBAnimSwapSubCategory()
end


ZKVTD.pcall(initFunc)

ZKVTD.print("Native Settings UI Loaded!")
