-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- ====================================================================================================================
local ZKVTD = GetMod("ZKV_Takedowns")
local utils = ZKVTD.utils
local strlower = string.lower
local gsub = string.gsub

local i18n = {}
local englishLangKey = "en-us"
i18n.locales = {}
ZKVTD.i18n = i18n

ZKVTD:AddModule("i18n", i18n)

-- ====================================================================================================================

-- If a string starts with this, i18n will be skipped, this string will be stripped and the raw string is returned
i18n.skipKey = "__SKIPi18n"

local function LangTable_GetString( langTable, stringKey )
    stringKey = strlower(stringKey)
    local str = langTable[stringKey]
    if str ~= "" then
        return str
    end
    return nil
end

local function LangTable_HasString( langTable, stringKey )
    stringKey = strlower(stringKey)
    local str = langTable[stringKey]
    return utils.IsStrValid(str)
end

local function LangTable_AddString( langTable, stringKey, stringValue, allowOverwrite )
    stringKey = strlower(stringKey)
    if not allowOverwrite and LangTable_HasString(langTable, stringKey) then
        return false
    end
    langTable[stringKey] = stringValue
    return true
end

-- ====================================================================================================================

function i18n:AddLanguageTable( langKey, langLabelEnglish, langLabelLocalized )
    if not utils.IsStrValid(langKey) then
        return
    end
    local localeTable = {}
    localeTable.strings = {}
    localeTable._labelEnglish = langLabelEnglish or utils.titleCase(langKey)
    localeTable._labelLocal = langLabelLocalized or localeTable._labelEnglish
    localeTable.GetString = LangTable_GetString
    localeTable.HasString = LangTable_HasString
    localeTable.AddString = LangTable_AddString
    langKey = strlower(langKey)
    self.locales[langKey] = localeTable
end

function i18n:GetLanguageTable( langKey )
    if langKey == "enGB" or langKey == "enUS" or langKey == "enIE" then
        langKey = englishLangKey
    end
    langKey = strlower(langKey)
    return self.locales[langKey]
end

function i18n:AddString( langKey, stringKey, stringValue )
    local localeTable = self:GetLanguageTable(langKey)
    localeTable:AddString(stringKey, stringValue, false)
end
function i18n:AddStringEnglish( stringKey, stringValue )
    return i18n:AddString(englishLangKey, stringKey, stringValue)
end

function i18n:GetStringForLang( langKey, stringKey, default, allowEnglishFallback, allowEmpty )
    langKey = string.lower(langKey)
    if allowEnglishFallback == nil then
        allowEnglishFallback = true
    end
    local localeTable = self:GetLanguageTable(langKey)

    local localizedStr = localeTable:GetString(stringKey)

    if not utils.IsStrValid(localizedStr, allowEmpty) then
        if langKey ~= englishLangKey and allowEnglishFallback then
            default = self:GetStringEnglish(stringKey, default, allowEmpty)
        end
        localizedStr = default
    end
    return localizedStr
end

function i18n:GetString( stringKey, default, allowEnglishFallback, allowEmpty )

    if utils.Str_starts_with(stringKey, i18n.skipKey) then
        local tempStr = gsub(stringKey, i18n.skipKey, "")
        tempStr = gsub(tempStr, ".label", "")
        tempStr = gsub(tempStr, ".tooltip", "")
        return tempStr
    end

    local langKey = i18n:GetCurrentLanguageKey()
    return i18n:GetStringForLang(langKey, stringKey, default, allowEnglishFallback, allowEmpty)
end

function i18n:GetStringEnglish( stringKey, default, allowEmpty )
    i18n:GetStringForLang(englishLangKey, stringKey, default, false, allowEmpty)
end

-- GetMod("ZKV_Takedowns").i18n:GetCurrentLanguageKey()
function i18n:GetCurrentLanguageKey()
    local locCode = Game.GetSettingsSystem():GetGroup("/language"):GetVar("OnScreen"):GetValue().value
    -- ZKVTD.debug("Game locCode:", locCode)
    return locCode or "en-us"
end

function i18n:NoTranslateString( str )
    return i18n.skipKey .. str
end

-- GetMod("ZKV_Takedowns").i18n:DumpStrings()
function i18n:DumpStrings()
    for _, v in pairs(self.locales) do
        for key, val in pairs(v) do
            ZKVTD.debug("i18n", key, val)
        end
    end
end

-- ====================================================================================================================

function i18n:Init()
    -- CP2077 official text languages
    -- TODO: Remaining localized labels
    self:AddLanguageTable("en-us", "English", "English")

    self:AddLanguageTable("ar-ar", "Arabic", "العربية")
    self:AddLanguageTable("cz-cz", "Czech", "Čeština")
    self:AddLanguageTable("de-de", "German", "Deutsch")
    self:AddLanguageTable("es-es", "Spanish", "Español")
    self:AddLanguageTable("es-mx", "Latin America Spanish", "Español de Latinoamérica")
    self:AddLanguageTable("fr-fr", "French", "Français")
    self:AddLanguageTable("hu-hu", "Hungarian", "Magyar")
    self:AddLanguageTable("it-it", "Italian", "Italiano")
    self:AddLanguageTable("jp-jp", "Japanese", "日本語")
    self:AddLanguageTable("kr-kr", "Korean", "한국인")
    self:AddLanguageTable("pl-pl", "Polish", "Polski")
    self:AddLanguageTable("pt-br", "Brazilian Portuguese", "Português brasileiro")
    self:AddLanguageTable("ru-ru", "Russian", "Русский")
    self:AddLanguageTable("th-th", "Thai", "ชาวไทย")
    self:AddLanguageTable("tr-tr", "Turkish", "Türkçe")
    self:AddLanguageTable("zh-cn", "Chinese (PRC)", nil)
    self:AddLanguageTable("zh-tw", "Chinese (Taiwan)", nil)
end
