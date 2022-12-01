-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- ====================================================================================================================
local ZKVTD = GetMod("ZKV_Takedowns")
local utils = ZKVTD.utils
local strlower = string.lower

local i18n = {}
local englishLangKey = "en-us"
i18n.locales = {}
ZKVTD.i18n = i18n

-- ====================================================================================================================


local function LangTable_GetString(langTable, stringKey)
    stringKey = strlower(stringKey)
    local str = langTable[stringKey]
    if str ~= "" then
        return str
    end
    return nil
end


local function LangTable_HasString(langTable, stringKey)
    stringKey = strlower(stringKey)
    local str = langTable[stringKey]
    return utils.IsStrValid(str)
end


local function LangTable_AddString(langTable, stringKey, stringValue, allowOverwrite)
    stringKey = strlower(stringKey)
    if not allowOverwrite and LangTable_HasString(langTable, stringKey) then
        return false
    end
    langTable[stringKey] = stringValue
    return true
end

-- ====================================================================================================================


function i18n:AddLanguageTable(langKey, langLabelEnglish, langLabelLocalized)
    if not utils.IsStrValid(langKey) then return end
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

function i18n:GetLanguageTable(langKey)
    ZKVTD.debug("GetLanguageTable()", langKey)
    if langKey == "enGB" or langKey == "enUS" or langKey == "enIE" then
        langKey = englishLangKey
    end
    langKey = strlower(langKey)
    return self.locales[langKey]
end

function i18n:AddString(langKey, stringKey, stringValue)
    ZKVTD.debug("AddString()", langKey)
    local localeTable = self:GetLanguageTable(langKey)
    localeTable:AddString(stringKey, stringValue, false)
end
function i18n:AddStringEnglish(stringKey, stringValue)
    return i18n:AddString(englishLangKey, stringKey, stringValue)
end

function i18n:GetStringForLang(langKey, stringKey, default, allowEnglishFallback, allowEmpty)
    langKey = string.lower(langKey)
    if allowEnglishFallback == nil then allowEnglishFallback = true end
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

function i18n:GetString(stringKey, default, allowEnglishFallback, allowEmpty)
    local langKey = i18n:GetCurrentLanguageKey()
    return i18n:GetStringForLang(langKey, stringKey, default, allowEnglishFallback, allowEmpty)
end

function i18n:GetStringEnglish(stringKey, default, allowEmpty)
    i18n:GetStringForLang(englishLangKey, stringKey, default, false, allowEmpty)
end

-- GetMod("ZKV_Takedowns").i18n:GetCurrentLanguageKey()
function i18n:GetCurrentLanguageKey()
    local locCode = Game.GetSettingsSystem():GetGroup("/language"):GetVar("OnScreen"):GetValue().value
    ZKVTD.debug("Game locCode:", locCode)
    return locCode or "en-us"
end

-- GetMod("ZKV_Takedowns").i18n:DumpStrings()
function i18n:DumpStrings()
    for _,v in pairs(self.locales) do
        for key, val in pairs(v) do
            ZKVTD.debug("i18n", key, val)
        end
    end
end

-- ====================================================================================================================

-- CP2077 official text languages
-- TODO: Remaining localized labels
i18n:AddLanguageTable("en-us", "English", "English")

i18n:AddLanguageTable("ar-ar", "Arabic", "العربية")
i18n:AddLanguageTable("cz-cz", "Czech", "Čeština")
i18n:AddLanguageTable("de-de", "German", "Deutsch")
i18n:AddLanguageTable("es-es", "Spanish", "Español")
i18n:AddLanguageTable("es-mx", "Latin America Spanish", "Español de Latinoamérica")
i18n:AddLanguageTable("fr-fr", "French", "Français")
i18n:AddLanguageTable("hu-hu", "Hungarian", "Magyar")
i18n:AddLanguageTable("it-it", "Italian", "Italiano")
i18n:AddLanguageTable("jp-jp", "Japanese", "日本語")
i18n:AddLanguageTable("kr-kr", "Korean", "한국인")
i18n:AddLanguageTable("pl-pl", "Polish", "Polski")
i18n:AddLanguageTable("pt-br", "Brazilian Portuguese", "Português brasileiro")
i18n:AddLanguageTable("ru-ru", "Russian", "Русский")
i18n:AddLanguageTable("th-th", "Thai", "ชาวไทย")
i18n:AddLanguageTable("tr-tr", "Turkish", "Türkçe")
i18n:AddLanguageTable("zh-cn", "Chinese (PRC)", nil)
i18n:AddLanguageTable("zh-tw", "Chinese (Taiwan)", nil)
