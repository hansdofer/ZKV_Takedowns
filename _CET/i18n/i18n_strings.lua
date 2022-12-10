-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- ====================================================================================================================
local ZKVTD = GetMod("ZKV_Takedowns")
local i18n_strings = {}
ZKVTD:AddModule("i18n_strings", i18n_strings)
ZKVTD.i18n.strings = i18n_strings

local i18n = ZKVTD.i18n
local function AddStringsForLanguage( langKey, stringsTable )
    for key, value in pairs(stringsTable) do
        i18n:AddString(langKey, key, value)
    end
end

-- ====================================================================================================================
-- Localization Strings for ZKVTD
-- Any missing entries will just show the English string as default
-- Please submit translations on GitHub: https://github.com/Kvalyr/ZKV_Takedowns
-- ====================================================================================================================

function i18n_strings:Init()
    local strings_EN = {
        ["Animations"] = "Animations",

        -- Takedown animations
        ["finisher_default.label"] = "Default Finisher",
        ["finisher_default.tooltip"] = "Throat-punch followed by Haymaker knockdown",
        ["AerialTakedown_Simple.label"] = "Aerial Takedown (Unarmed)",
        ["AerialTakedown_Simple.tooltip"] = "Aerial Takedown (Unarmed)",
        ["AerialTakedown_Back_Simple.label"] = "Aerial Takedown (Behind) (Unarmed)",
        ["AerialTakedown_Back_Simple.tooltip"] = "Aerial Takedown (Behind) (Unarmed)",
        ["AerialTakedown_MantisBlades.label"] = "Aerial Takedown (Mantis Blades)",
        ["AerialTakedown_MantisBlades.tooltip"] = "Aerial Takedown (Mantis Blades)",
        ["AerialTakedown_Back_MantisBlades.label"] = "Aerial Takedown (Behind) (Mantis Blades)",
        ["AerialTakedown_Back_MantisBlades.tooltip"] = "Aerial Takedown (Behind) (Mantis Blades)",

        ["Wea_Katana.label"] = "Long Blade 2H Impale",
        ["Wea_Katana.tooltip"] = "Two-Handed Impale Finisher (Katana)",
        ["Wea_Katana_Back.label"] = "Decapitate",
        ["Wea_Katana_Back.tooltip"] = "Decapitate (Katana) - Target turns to face V",

        ["Cyb_MantisBlades.label"] = "Double-Impale-and-Lift Finisher (Front)",
        ["Cyb_MantisBlades.tooltip"] = "Double-Impale-and-Lift Finisher (Front)",
        ["Cyb_MantisBlades_Back.label"] = "Double-Impale-and-Lift Finisher (Behind)",
        ["Cyb_MantisBlades_Back.tooltip"] = "Double-Impale-and-Lift Finisher (Behind)",

        ["ZKVTD_Takedown_HeavyAttack01.label"] = "Heavy Attack 1",
        ["ZKVTD_Takedown_HeavyAttack01.tooltip"] = "Heavy Attack 1",
        ["ZKVTD_Takedown_HeavyAttack02.label"] = "Heavy Attack 2",
        ["ZKVTD_Takedown_HeavyAttack02.tooltip"] = "Heavy Attack 2",
        ["ZKVTD_Takedown_ComboAttack03.label"] = "Combo Attack 3",
        ["ZKVTD_Takedown_ComboAttack03.tooltip"] = "Combo Attack 3",
        ["ZKVTD_Takedown_BlockAttack.label"] = "Defensive Attack",
        ["ZKVTD_Takedown_BlockAttack.tooltip"] = "Defensive Attack",
        ["ZKVTD_Takedown_SafeAttack.label"] = "Safe Attack",
        ["ZKVTD_Takedown_SafeAttack.tooltip"] = "Safe Attack",

        ["ZKVTD_Katana_backstab.label"] = "Long Blade Backstab",
        ["ZKVTD_Katana_backstab.tooltip"] = "Two-Handed Impale Backstab (Katana)",
        ["ZKVTD_Katana_behead_behind.label"] = "Decapitate (Behind)",
        ["ZKVTD_Katana_behead_behind.tooltip"] = "Decapitate (Katana) - Target remains facing away from V",
        ["ZKVTD_Knife_backstab.label"] = "Short Blade 2H Backstab",
        ["ZKVTD_Knife_backstab.tooltip"] = "Short Blade 2H Backstab",
        ["ZKVTD_Monowire_behead_behind.label"] = "Decapitate",
        ["ZKVTD_Monowire_behead_behind.tooltip"] = "Decapitate by lateral crossover-slice with monowires",

        -- Weapons -- TODO: Pull from game's own localization files?
        ["Wea_Fists"] = "Fists",
        ["Wea_ShortBlade"] = "Short Blade",
        ["Wea_Knife"] = "Knife",
        ["Wea_LongBlade"] = "Long Blade",
        ["Wea_Katana"] = "Katana",
        ["Wea_Chainsword"] = "Chainsword",
        ["Wea_Machete"] = "Machete",
        ["Wea_OneHandedClub"] = "1H Club",
        ["Wea_TwoHandedClub"] = "2H Club",
        ["Wea_Hammer"] = "Hammer",
        ["Cyb_MantisBlades"] = "Mantis Blades",
        ["Cyb_StrongArms"] = "Gorilla Arms",
        ["Cyb_NanoWires"] = "Monowire",
        -- ["Cyb_Launcher"] = "Wea_Machete",

        ["zkvtd_settings.category.takedowns"] = "Takedowns",
        ["zkvtd_settings.category.mtb_animswap"] = "Mantis Blades Finishers",
        ["zkvtd_settings.category.misc_tweaks"] = "Miscellaneous Tweaks",
        ["zkvtd_settings.category.takedowns_byweapon"] = "Takedowns - Animation Choices",

        ["zkvtd_settings.Takedowns.OnlyMelee.label"] = "Only with Melee Weapon In-Hand",
        ["zkvtd_settings.Takedowns.OnlyMelee.tooltip"] = "Toggle whether or not the new takedown/kill prompt shows only with a melee weapon held (On) or with any weapon (Off) \nGrappling is unaffected.",

        ["zkvtd_settings.Takedowns.NonLethalBlunt.label"] = "Non-Lethal Blunt",
        ["zkvtd_settings.Takedowns.NonLethalBlunt.tooltip"] = "Toggles whether or not takedowns with blunt weapons (fists, gorilla arms, clubs, bats, etc.) leave the target unconscious instead of dead.\n Switch this off to make blunt weapon takedowns lethal.",

        ["zkvtd_settings.MTBAnimSwap.UseAerial.label"] = "Use Mantis Blades Aerial Takedown Finisher",
        ["zkvtd_settings.MTBAnimSwap.UseAerial.tooltip"] = "Switch this on to use the Aerial Takedown animation as a Mantis Blades finisher in combat instead of the normal finisher animation.",

        ["zkvtd_settings.MTBAnimSwap.RandomChoice.label"] = "Also use normal Mantis Blades Finisher",
        ["zkvtd_settings.MTBAnimSwap.RandomChoice.tooltip"] = "Switch this on to have the mod choose randomly between the Aerial Takedown animation and the original animation for Mantis Blades finishers during combat. \nHas no effect if the previous setting is off.",

        ["zkvtd_settings.Misc_Stealth.MeleeMult.label"] = "Stealth Melee Damage Multiplier",
        ["zkvtd_settings.Misc_Stealth.MeleeMult.tooltip"] = "This damage multiplier is applied to attacks from stealth.\n Sufficiently high damage can turn strong attacks (such as Mantis Blade leap attacks) into instant takedowns by triggering finishers.\n The default in the base game is +30% damage (i.e.; 1.3)",
    }
    AddStringsForLanguage("en-us", strings_EN)

    -- ====================================================================================================================

    -- Polski
    -- Initial translation done with Google Translate - Corrections welcome at https://github.com/Kvalyr/ZKV_Takedowns!
    local strings_PL = {
        ["zkvtd_settings.category.takedowns"] = "Takedowns",
        ["zkvtd_settings.category.mtb_animswap"] = "Mantis Blades Wykańczacze",
        ["zkvtd_settings.category.misc_tweaks"] = "Różne poprawki",
        ["zkvtd_settings.category.takedowns_byweapon"] = "Takedowns - Wybór animacji",

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
        ["Animations"] = "動畫",

        -- Takedown animations
        ["finisher_default.label"] = "預設終結技",
        ["finisher_default.tooltip"] = "強力一擊擊倒伴隨而來的擊打喉嚨",
        ["AerialTakedown_Simple.label"] = "騰空擊倒（徒手）",
        ["AerialTakedown_Simple.tooltip"] = "騰空擊倒（徒手）",
        ["AerialTakedown_Back_Simple.label"] = "騰空擊倒（背後）（徒手）",
        ["AerialTakedown_Back_Simple.tooltip"] = "騰空擊倒（背後）（徒手）",
        ["AerialTakedown_MantisBlades.label"] = "騰空擊倒（螳螂刀）",
        ["AerialTakedown_MantisBlades.tooltip"] = "騰空擊倒（螳螂刀）",
        ["AerialTakedown_Back_MantisBlades.label"] = "騰空擊倒（背後）（螳螂刀）",
        ["AerialTakedown_Back_MantisBlades.tooltip"] = "騰空擊倒（背後）（螳螂刀）",

        ["Wea_Katana.label"] = "雙手持長刀刺穿",
        ["Wea_Katana.tooltip"] = "雙手刺穿（武士刀）",
        ["Wea_Katana_Back.label"] = "斬首",
        ["Wea_Katana_Back.tooltip"] = "斬首（武士刀）——目標轉向面對V",

        ["Cyb_MantisBlades.label"] = "雙手刺穿並被舉起的終結技（正面）",
        ["Cyb_MantisBlades.tooltip"] = "雙手刺穿並被舉起的終結技（正面）",
        ["Cyb_MantisBlades_Back.label"] = "雙手刺穿並被舉起的終結技（背後）",
        ["Cyb_MantisBlades_Back.tooltip"] = "雙手刺穿並被舉起的終結技（背後）",

        ["ZKVTD_Takedown_HeavyAttack01.label"] = "強力攻擊 1",
        ["ZKVTD_Takedown_HeavyAttack01.tooltip"] = "強力攻擊 1",
        ["ZKVTD_Takedown_HeavyAttack02.label"] = "強力攻擊 2",
        ["ZKVTD_Takedown_HeavyAttack02.tooltip"] = "強力攻擊 2",
        ["ZKVTD_Takedown_ComboAttack03.label"] = "連擊 3",
        ["ZKVTD_Takedown_ComboAttack03.tooltip"] = "連擊 3",
        ["ZKVTD_Takedown_BlockAttack.label"] = "防禦攻擊",
        ["ZKVTD_Takedown_BlockAttack.tooltip"] = "防禦攻擊",
        ["ZKVTD_Takedown_SafeAttack.label"] = "無損攻擊",
        ["ZKVTD_Takedown_SafeAttack.tooltip"] = "無損攻擊",

        ["ZKVTD_Katana_backstab.label"] = "長刀背刺",
        ["ZKVTD_Katana_backstab.tooltip"] = "雙手背刺刺穿（武士刀）",
        ["ZKVTD_Katana_behead_behind.label"] = "斬首（背後）",
        ["ZKVTD_Katana_behead_behind.tooltip"] = "斬首（武士刀）——目標仍背對著V",
        ["ZKVTD_Knife_backstab.label"] = "雙手持短刀背刺",
        ["ZKVTD_Knife_backstab.tooltip"] = "雙手持短刀背刺",
        ["ZKVTD_Monowire_behead_behind.label"] = "斬首",
        ["ZKVTD_Monowire_behead_behind.tooltip"] = "鐮線橫向交叉切割斬首",

        -- Weapons -- TODO: Pull from game's own localization files?
        ["Wea_Fists"] = "拳",
        ["Wea_ShortBlade"] = "短刀",
        ["Wea_Knife"] = "小刀",
        ["Wea_LongBlade"] = "長刀",
        ["Wea_Katana"] = "武士刀",
        ["Wea_Chainsword"] = "鏈鋸劍",
        ["Wea_Machete"] = "開山刀",
        ["Wea_OneHandedClub"] = "單手棍",
        ["Wea_TwoHandedClub"] = "雙手棍",
        ["Wea_Hammer"] = "槌",
        ["Cyb_MantisBlades"] = "螳螂刀",
        ["Cyb_StrongArms"] = "大猩猩手臂",
        ["Cyb_NanoWires"] = "鐮線",
        -- ["Cyb_Launcher"] = "Wea_Machete",

        ["zkvtd_settings.category.takedowns"] = "擊倒",
        ["zkvtd_settings.category.mtb_animswap"] = "螳螂刀終結技",
        ["zkvtd_settings.category.misc_tweaks"] = "雜項調整",
        ["zkvtd_settings.category.takedowns_byweapon"] = "擊倒 - 動畫選擇",

        ["zkvtd_settings.Takedowns.OnlyMelee.label"] = "僅於手持近戰武器時",
        ["zkvtd_settings.Takedowns.OnlyMelee.tooltip"] = "切換使否顯示新的「擊倒/殺死」提示，僅於持有近戰武器（開）或任何武器（關）時。\n擒伏不受此影響。",

        ["zkvtd_settings.Takedowns.NonLethalBlunt.label"] = "非致命鈍器",
        ["zkvtd_settings.Takedowns.NonLethalBlunt.tooltip"] = "預設情況下，使用鈍器武器（拳頭、大猩猩手臂、棍棒、球棒等）擊倒時，僅會使目標失去知覺。\n關閉此項會使擊倒成為致命。",

        ["zkvtd_settings.MTBAnimSwap.UseAerial.label"] = "使用螳螂刀騰空擊倒的終結技",
        ["zkvtd_settings.MTBAnimSwap.UseAerial.tooltip"] = "切換此選項可於戰鬥中使用騰空擊倒動畫，使其成為螳螂刀的終結技，而非是正常的終結技動畫。",

        ["zkvtd_settings.MTBAnimSwap.RandomChoice.label"] = "也能使用普通的螳螂刀終結技",
        ["zkvtd_settings.MTBAnimSwap.RandomChoice.tooltip"] = "切換此選項可讓模組於戰鬥中使用騰空擊倒動畫時，隨機選用螳螂刀終結技動畫或原始終結技動畫。\n如果先前設定關閉，則此項無效。",

        ["zkvtd_settings.Misc_Stealth.MeleeMult.label"] = "潛行近戰傷害倍數",
        ["zkvtd_settings.Misc_Stealth.MeleeMult.tooltip"] = "此傷害倍數適用於潛行攻擊。\n足夠高的傷害可觸發終結技，將強力攻擊（例如螳螂刀的騰空攻擊）轉變為即時擊殺。\n在基本遊戲內預設是 +30% 傷害（即; 1.3）",
    }
    AddStringsForLanguage("zh-tw", strings_ZHTW)

    -- ====================================================================================================================
end
