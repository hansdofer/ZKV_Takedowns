local ZKVTD = GetMod("ZKV_Takedowns")
-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- Native Settings UI
-- ====================================================================================================================

local i18n = ZKVTD.i18n
local utils = ZKVTD.utils

local SettingsUI = {}
SettingsUI.canDoSettingsUI = true
ZKVTD.SettingsUI = SettingsUI
ZKVTD.Modules["SettingsUI"] = SettingsUI

-- ====================================================================================================================

function SettingsUI:Init()
    local nativeSettings = utils.GetNativeSettingsMod()
    if not nativeSettings then
        ZKVTD.print("Warning: Skipping setup of Native Settings UI due to missing dependency.")
        self.canDoSettingsUI = false
        return
    end
    self.canDoSettingsUI = true
    self.nativeSettings = nativeSettings
end

-- ====================================================================================================================

local function GetSubcategoryFullPath(subCategoryPath)
    return ZKVTD.nativeSettingsBasePath .. "/" .. subCategoryPath
end

function SettingsUI.AddSubCategory(subCategoryPath, subCategoryLabelKey, labelPrefix, optionalIndex)
    if not SettingsUI.canDoSettingsUI then return end
    local subCategoryLabel = i18n:GetString(subCategoryLabelKey, "<missing_category_label>")
    if labelPrefix and labelPrefix ~= "" then
        subCategoryLabel = labelPrefix ..  " - " .. subCategoryLabel
    end

    local path = GetSubcategoryFullPath(subCategoryPath)
    -- ZKVTD.debug("Settings: Add subCategory:", path)
    SettingsUI.nativeSettings.addSubcategory(path, subCategoryLabel, optionalIndex)
end

local function GetLocalizedStrings(widgeti18StringKey)
    local widgetLabelKey = widgeti18StringKey .. ".label"
    local widgetTooltipKey = widgeti18StringKey .. ".tooltip"
    local widgetLabel = i18n:GetString(widgetLabelKey, "<missing_label>")
    local widgetTooltip = i18n:GetString(widgetTooltipKey, "<missing_tooltip>")
    return widgetLabel, widgetTooltip
end

function SettingsUI.AddWidgetToSubCategory_Switch(subCategory, widgeti18nStringKey, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    if not SettingsUI.canDoSettingsUI then return end
    local widgetLabel, widgetTooltip = GetLocalizedStrings(widgeti18nStringKey)

    local fullPath = GetSubcategoryFullPath(subCategory)
    return SettingsUI.nativeSettings.addSwitch(fullPath, widgetLabel, widgetTooltip, widgetInitValue, widgetDefaultValue, widgetUpdateCallback)
end

function SettingsUI.AddWidgetToSubCategory_SliderInt(subCategory, widgeti18nStringKey, sliderMin, sliderMax, sliderStep, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    if not SettingsUI.canDoSettingsUI then return end
    local widgetLabel, widgetTooltip = GetLocalizedStrings(widgeti18nStringKey)
    local fullPath = GetSubcategoryFullPath(subCategory)
    return SettingsUI.nativeSettings.addRangeInt(fullPath, widgetLabel, widgetTooltip, sliderMin, sliderMax, sliderStep, widgetInitValue, widgetDefaultValue, widgetUpdateCallback)
end

function SettingsUI.AddWidgetToSubCategory_SliderFloat(subCategory, widgeti18nStringKey, sliderMin, sliderMax, sliderStep, sliderFormat, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    if not SettingsUI.canDoSettingsUI then return end
    local widgetLabel, widgetTooltip = GetLocalizedStrings(widgeti18nStringKey)
    local fullPath = GetSubcategoryFullPath(subCategory)
    if not sliderFormat then sliderFormat = "%.2f" end

    ZKVTD.debug("AddWidgetToSubCategory_SliderFloat", subCategory, widgeti18nStringKey, sliderMin, sliderMax, sliderStep, sliderFormat, widgetInitValue, widgetDefaultValue, widgetUpdateCallback, optionalIndex)
    return SettingsUI.nativeSettings.addRangeFloat(fullPath, widgetLabel, widgetTooltip, sliderMin, sliderMax, sliderStep, sliderFormat, widgetInitValue, widgetDefaultValue, widgetUpdateCallback)
end

-- ====================================================================================================================
-- local modPathPrefix = "zkvtd_"



-- local function AddSubCategory_Takedowns()
--     local subCategoryPath = modPathPrefix .. "takedowns"
--     SettingsUI.AddSubCategory(subCategoryPath, "zkvtd_settings.category.takedowns", ZKVTD.displayName)

--     SettingsUI.AddWidgetToSubCategory_Switch(
--         subCategoryPath,
--         "zkvtd_settings.Takedowns.OnlyMelee",
--         ZKVTD.Config.GetValue("Takedowns_OnlyWithMeleeWeaponHeld"),
--         true,
--         ZKVTD.Config.GetCallback("Update_Takedowns_OnlyMelee")
--     )

--     SettingsUI.AddWidgetToSubCategory_Switch(
--         subCategoryPath,
--         "zkvtd_settings.Takedowns.NonLethalBlunt",
--         ZKVTD.Config.GetValue("Takedowns_NonLethalBlunt"),
--         true,
--         ZKVTD.Config.GetCallback("Update_Takedowns_NonLethalBlunt")
--     )
-- end

-- -- ====================================================================================================================

-- local function AddSubCategory_MTBAnimSwap()
--     local subCategoryPath = modPathPrefix .. "mtb_animswap"
--     SettingsUI.AddSubCategory(subCategoryPath, "zkvtd_settings.category.mtb_animswap", ZKVTD.displayName)

--     SettingsUI.AddWidgetToSubCategory_Switch(
--         subCategoryPath,
--         "zkvtd_settings.MTBAnimSwap.UseAerial",
--         ZKVTD.Config.GetValue("MantisSwap_Finishers_UseAerialTakedownAnimation"),
--         true,
--         ZKVTD.Config.GetCallback("Update_MTBAnimSwap_UseAerial")
--     )

--     SettingsUI.AddWidgetToSubCategory_Switch(
--         subCategoryPath,
--         "zkvtd_settings.MTBAnimSwap.RandomChoice",
--         ZKVTD.Config.GetValue("MantisSwap_Finishers_MixDifferentAnimations"),
--         true,
--         ZKVTD.Config.GetCallback("Update_MTBAnimSwap_RandomChoice")
--     )
-- end

-- -- ====================================================================================================================

-- local function AddSubCategory_Misc()
--     local subCategoryPath = modPathPrefix .. "misc_tweaks"
--     SettingsUI.AddSubCategory(subCategoryPath, "zkvtd_settings.category.misc", ZKVTD.displayName)

--     local stealthDmgMult_sliderMin = 1.0
--     local stealthDmgMult_sliderMax = 10
--     local stealthDmgMult_sliderStep = 0.05
--     local stealthDmgMult_default = 1.3
--     SettingsUI.AddWidgetToSubCategory_SliderFloat(
--         subCategoryPath,
--         "zkvtd_settings.Misc_Stealth.MeleeMult",
--         stealthDmgMult_sliderMin,
--         stealthDmgMult_sliderMax,
--         stealthDmgMult_sliderStep,
--         "%.2f",
--         ZKVTD.Config.GetValue("Misc_Stealth_MeleeMult"),
--         stealthDmgMult_default,
--         ZKVTD.Config.GetCallback("Update_Misc_Stealth_MeleeMult")
--     )
-- end

-- local function initFunc()
--     -- AddSubCategory_Takedowns()
--     -- AddSubCategory_MTBAnimSwap()
--     -- AddSubCategory_Misc()
-- end


-- utils.pcall(initFunc)
