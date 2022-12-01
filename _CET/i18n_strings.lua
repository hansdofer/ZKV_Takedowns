-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- ====================================================================================================================
local ZKVTD = GetMod("ZKV_Takedowns")
local i18n_strings = {}
ZKVTD.i18n.strings = i18n_strings
local i18n = ZKVTD.i18n
local function AddStringsForLanguage(langKey, stringsTable)
    for key, value in pairs(stringsTable) do
        i18n:AddString(langKey, key, value)
    end
end
-- ====================================================================================================================
-- Localization Strings for ZKVTD
-- ====================================================================================================================

local strings_EN = {
    ["zkvtd_settings.category.takedowns"] = "Takedowns",
    ["zkvtd_settings.category.mtb_animswap"] = "Mantis Blades Finishers",
    ["zkvtd_settings.category.misc_tweaks"] = "Miscellaneous Tweaks",

    ["zkvtd_settings.Takedowns.OnlyMelee.label"] = "Only with Melee Weapon In-Hand",
    ["zkvtd_settings.Takedowns.OnlyMelee.tooltip"] = "Toggle whether or not the new takedown/kill prompt shows only with a melee weapon held (On) or with any weapon (Off) \nGrappling is unaffected.",

    ["zkvtd_settings.Takedowns.NonLethalBlunt.label"] = "Non-Lethal Blunt",
    ["zkvtd_settings.Takedowns.NonLethalBlunt.tooltip"] = "Toggles whether or not takedowns with blunt weapons (fists, gorilla arms, clubs, bats, etc.) leave the target unconscious instead of dead.\n Switch this off to make blunt weapon takedowns lethal.",

    ["zkvtd_settings.MTBAnimSwap.UseAerial.label"] = "Use Mantis Blades Aerial Takedown Finisher",
    ["zkvtd_settings.MTBAnimSwap.UseAerial.tooltip"] = "Switch this on to use the Aerial Takedown animation as a Mantis Blades finisher in combat instead of the normal finisher animation.",

    ["zkvtd_settings.MTBAnimSwap.RandomChoice.label"] = "Also use normal Mantis Blades Aerial Finisher",
    ["zkvtd_settings.MTBAnimSwap.RandomChoice.tooltip"] = "Switch this on to have the mod choose randomly between the Aerial Takedown animation and the original animation for Mantis Blades finishers during combat. \nHas no effect if the previous setting is off.",

    ["zkvtd_settings.Misc_Stealth.MeleeMult.label"] = "Stealth Melee Damage Multiplier",
    ["zkvtd_settings.Misc_Stealth.MeleeMult.tooltip"] = "This damage multiplier is applied to attacks from stealth.\n Sufficiently high damage can turn strong attacks (such as Mantis Blade leap attacks) into instant takedowns by triggering finishers.\n The default in the base game is +30% damage (i.e.; 1.3)",
}
AddStringsForLanguage("en-us", strings_EN)

-- ====================================================================================================================

-- Polski
-- Initial translation done with Google Translate - Corrections welcome!
local strings_PL = {
    ["zkvtd_settings.category.takedowns"] = "Takedowns",
    ["zkvtd_settings.category.mtb_animswap"] = "Mantis Blades Wykańczacze",
    ["zkvtd_settings.category.misc_tweaks"] = "Różne poprawki",

    ["zkvtd_settings.Takedowns.OnlyMelee.label"] = "Tylko z bronią białą w ręku",
    ["zkvtd_settings.Takedowns.OnlyMelee.tooltip"] = "Przełącz, czy nowy monit o zabicie ma być wyświetlany tylko przy trzymanej broni białej (wł.) czy przy dowolnej broni (wył.) \nChwytanie pozostaje niezmienione.",

    ["zkvtd_settings.Takedowns.NonLethalBlunt.label"] = "Nieśmiercionośna broń obuchowa",
    ["zkvtd_settings.Takedowns.NonLethalBlunt.tooltip"] = "Przełącza, czy zabójstwa obuchową bronią (pięściami, ramionami goryli, pałkami, nietoperzami itp.) pozostawiają cel nieprzytomnym zamiast martwym.\n Wyłącz tę opcję, aby obalenia obuchową bronią były śmiertelne.",

    ["zkvtd_settings.MTBAnimSwap.UseAerial.label"] = "Użyj wykańczacza powietrza Mantis Blades",
    ["zkvtd_settings.MTBAnimSwap.UseAerial.tooltip"] = "Włącz tę opcję, aby używać animacji Aerial Takedown jako finiszera Modliszki w walce zamiast normalnej animacji finiszera.",

    ["zkvtd_settings.MTBAnimSwap.RandomChoice.label"] = "Używaj również zwykłych Mantis Blades Aerial Finisher",
    ["zkvtd_settings.MTBAnimSwap.RandomChoice.tooltip"] = "Włącz tę opcję, aby mod losowo wybierał między animacją Aerial Takedown a oryginalną animacją zakończenia Mantis Blades podczas walki. \nNie działa, jeśli poprzednie ustawienie jest wyłączone.",

    ["zkvtd_settings.Misc_Stealth.MeleeMult.label"] = "Mnożnik obrażeń w walce wręcz w ukryciu",
    ["zkvtd_settings.Misc_Stealth.MeleeMult.tooltip"] = "Ten mnożnik obrażeń jest stosowany do ataków z ukrycia.\n Wystarczająco wysokie obrażenia mogą zamienić silne ataki (takie jak ataki Modliszkowego Ostrza z wyskoku) w natychmiastowe obalenia, uruchamiając ciosy kończące.\n Domyślnie w podstawowej grze jest to +30% obrażeń (tj.; 1.3)",
}
AddStringsForLanguage("pl-pl", strings_PL)

-- ====================================================================================================================

-- العربية
local strings_AR = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("ar-ar", strings_AR)

-- ====================================================================================================================

-- Čeština
local strings_CZ = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("cz-cz", strings_CZ)

-- ====================================================================================================================

-- Deutsch
local strings_DE = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("de-de", strings_DE)

-- ====================================================================================================================

-- Español
local strings_ES = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("es-es", strings_ES)

-- ====================================================================================================================

-- Español de Latinoamérica
local strings_ESMX = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("es-mx", strings_ESMX)

-- ====================================================================================================================

-- Français
local strings_FR = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("fr-fr", strings_FR)

-- ====================================================================================================================

-- Magyar
local strings_HU = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("hu-hu", strings_HU)

-- ====================================================================================================================

-- Italiano
local strings_IT = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("it-it", strings_IT)

-- ====================================================================================================================

-- 日本語
local strings_JP = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("jp-jp", strings_JP)

-- ====================================================================================================================

-- 한국인
local strings_KR = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("kr-kr", strings_KR)

-- ====================================================================================================================

-- Português brasileiro
local strings_PTBR = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("pt-br", strings_PTBR)

-- ====================================================================================================================

-- Русский
local strings_RU = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("ru-ru", strings_RU)

-- ====================================================================================================================

-- ชาวไทย
local strings_TH = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("th-th", strings_TH)

-- ====================================================================================================================

-- Türkçe
local strings_TR = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("tr-tr", strings_TR)

-- ====================================================================================================================

-- Chinese (PRC)
local strings_ZHCN = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("zh-cn", strings_ZHCN)

-- ====================================================================================================================

-- Chinese (TW)
local strings_ZHTW = {
    -- TODO: Using strings_EN as a reference, add translation strings here
}
AddStringsForLanguage("zh-tw", strings_ZHTW)

-- ====================================================================================================================
