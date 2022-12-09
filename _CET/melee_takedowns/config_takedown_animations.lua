-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- Default Config values
-- ====================================================================================================================
-- !! Here be dragons !!
-- Changing anything below this line is unsupported. Don't complain to the mod author if things break when you change stuff below this point.
-- ====================================================================================================================
local ZKVTD = GetMod("ZKV_Takedowns")
local utils = ZKVTD.utils
-- local MeleeTakedowns = ZKVTD.Modules.MeleeTakedowns

-- -- The tables below are where the various finisher/takedown animation workspots are mapped to different weapons.
-- -- WARNING: Change these at your own risk. Some combinations of weapon and workspot can crash the game or cause a softlock, trapping you in a stuck animation.
-- -- Entries in the tables should be strings referencing the tag of a takedown or finisher effect

-- ---- ---- ---- ----
-- Melee Weapons
-- ---- ----

-- Fists & Gorilla Arms
local takedown_anims_weapon_FISTS = {
    "finisher_default", -- Throat-punch to Haymaker
    -- "Cyb_StrongArms_Back",       -- No difference from finisher_default in CDPR effectSet
    "AerialTakedown_Back_Simple", -- Face-to-ground smash
    "AerialTakedown_Simple", -- Occipital smash
}

-- Katana
local takedown_anims_weapon_LONG_BLADE = {
    -- "Wea_Katana",                -- 2h Gut stab
    -- "Wea_Katana_Back",           -- Behead

    -- "ZKVTD_Takedown_HeavyAttack01",  -- Quick vertical slice
    -- "ZKVTD_Takedown_HeavyAttack02",  -- Quick diagonal slice
    -- "ZKVTD_Takedown_SafeAttack",        -- Slice left-to-right into side of neck
    -- "ZKVTD_Takedown_BlockAttack",       -- Quick horizontal left-to-right slash, left-hand splayed (Defensive Attack)

    "ZKVTD_Katana_backstab", -- 2h Backstab (WIP)
    "ZKVTD_Katana_behead_behind", -- Behead, target facing away from V
}

-- Knife, Machete & Chain SWord
local takedown_anims_weapon_SHORT_BLADE = {
    -- "ZKVTD_Takedown_HeavyAttack01",     -- Quick horizontal stab to back of neck
    -- "ZKVTD_Takedown_HeavyAttack02",  -- Quick vertical stab to back of neck

    -- "ZKVTD_Takedown_SafeAttack",     -- Quick stab to back of neck
    "ZKVTD_Takedown_BlockAttack", -- Quick stab to back of neck
    -- "ZKVTD_Knife_backstab",          -- 2h Backstab

    -- "finisher_default",
}

-- 1h Club
-- References to animations for one-handed blunt exist in the game files, but the actual animations are missing or unfinished
local takedown_anims_weapon_ONE_HANDED_CLUB = {
    -- "finisher_default",

    -- "ZKVTD_Takedown_HeavyAttack01",     -- Downward strike (Blackjack-like)
    -- "ZKVTD_Takedown_HeavyAttack02",  -- Diagonal left-to-right strike
    -- "ZKVTD_Takedown_SafeAttack",
    -- "ZKVTD_Takedown_BlockAttack",    -- Sideways left-to-right strike (Defensive Attack)
    "ZKVTD_Takedown_HeavyAttack02_QuickDeath",
}

-- 2h Club
-- References to finisher animations for two-handed club exist in the game files, but the actual animations are missing or unfinished
local takedown_anims_weapon_TWO_HANDED_CLUB = {
    -- "finisher_default",

    -- "ZKVTD_Takedown_HeavyAttack01",     -- Diagonal bottom-right-to-top-left strike
    -- "ZKVTD_Takedown_HeavyAttack02",     -- Diagonal bottom-left-to-top-right strike
    -- "ZKVTD_Takedown_SafeAttack",
    -- "ZKVTD_Takedown_BlockAttack",          -- Mid-shaft interruptive thrust (Defensive attack)
    -- "ZKVTD_Takedown_HeavyAttack01_QuickDeath",
    -- "ZKVTD_Takedown_HeavyAttack02_QuickDeath",
    "ZKVTD_Takedown_ComboAttack03_QuickDeath", -- Downwards 2h strike
}

-- Hammer
-- References to finisher animations for hammer exist in the game files, but the actual animations are missing or unfinished
local takedown_anims_weapon_HAMMER = {
    -- "finisher_default",

    -- "ZKVTD_Takedown_HeavyAttack01",     -- Right-left downwards strike
    -- "ZKVTD_Takedown_HeavyAttack02",  -- Left-right downwards strike
    -- -- "ZKVTD_Takedown_SafeAttack",
    -- "ZKVTD_Takedown_BlockAttack",    -- Quick downwards right-left strike
    "ZKVTD_Takedown_HeavyAttack02_QuickDeath",
}

-- ---- ---- ---- ----
-- Cyberware
-- ---- ----

-- Mantis Blades
-- Default: Finisher-from-behind and aerial-takedown-from-behind
-- Uncomment the other entries (by removing '--') to also use their equivalents from-front. Might look weird or move you around when doing takedowns from behind.
local takedown_anims_cyber_MANTIS_BLADES = {
    "Cyb_MantisBlades_Back", -- Double-impale and lift
    "AerialTakedown_Back_MantisBlades", -- Ground-slam with neck/head impale
    -- "ZKVTD_Cyb_MantisBlades_Back",          -- Double-impale and lift

    -- "ZKVTD_Takedown_HeavyAttack01",
    -- "ZKVTD_Takedown_HeavyAttack02",
    -- "ZKVTD_Takedown_SafeAttack",
    -- "ZKVTD_Takedown_BlockAttack",           -- X-slice to back of neck

    -- "AerialTakedown_MantisBlades",
    -- "Cyb_MantisBlades",
}

-- Gorilla Arms use fist anims

-- Monowire
-- Cyb_NanoWires - These animations exist in-game in a broken/unfinished state - Not worth using yet, but maybe someday..
local takedown_anims_cyber_MONOWIRE = {
    -- "finisher_default",
    -- "Cyb_NanoWires",
    "ZKVTD_Monowire_behead_behind",
    -- "ZKVTD_Takedown_HeavyAttack01",
    -- "ZKVTD_Takedown_HeavyAttack02",     -- Double horizontal slice (behead)
    -- "ZKVTD_Takedown_SafeAttack",
    -- "ZKVTD_Takedown_BlockAttack",
}

-- Launcher
-- Only listed here for completeness
local takedown_anims_cyber_LAUNCHER = { "finisher_default" }

-- ====================================================================================================================
-- ZKV_Takedowns
-- All configuration values are above - Don't touch the stuff below if all you want to do is configure the mod
-- ====================================================================================================================

local takedownAnimsByWeapon = {
    Wea_Fists = takedown_anims_weapon_FISTS,

    -- Long Blades share anims
    Wea_LongBlade = takedown_anims_weapon_LONG_BLADE,
    Wea_Katana = takedown_anims_weapon_LONG_BLADE, -- takedown_anims_weapon_KATANA,

    -- Short Blades share anims
    Wea_ShortBlade = takedown_anims_weapon_SHORT_BLADE,
    Wea_Chainsword = takedown_anims_weapon_SHORT_BLADE, -- takedown_anims_weapon_CHAIN_SWORD,
    Wea_Knife = takedown_anims_weapon_SHORT_BLADE, -- takedown_anims_weapon_KNIFE,
    Wea_Machete = takedown_anims_weapon_SHORT_BLADE, -- takedown_anims_weapon_MACHETE,

    Wea_OneHandedClub = takedown_anims_weapon_ONE_HANDED_CLUB,

    -- Hammer uses 2H Club anims
    Wea_TwoHandedClub = takedown_anims_weapon_TWO_HANDED_CLUB,
    Wea_Hammer = takedown_anims_weapon_HAMMER,

    Cyb_MantisBlades = takedown_anims_cyber_MANTIS_BLADES,

    -- StrongArms share anims with fists
    Cyb_StrongArms = takedown_anims_weapon_FISTS, -- takedown_anims_cyber_STRONG_ARMS,

    Cyb_NanoWires = takedown_anims_cyber_MONOWIRE,
    Cyb_Launcher = takedown_anims_cyber_LAUNCHER,
}

ZKVTD.Config.SetDefaultValue("takedownAnims_defaultsLoaded", true)
ZKVTD.Config.SetDefaultValue("takedownAnims", takedownAnimsByWeapon)

ZKVTD.print("(Old) Takedown Animations Configuration loaded!")
