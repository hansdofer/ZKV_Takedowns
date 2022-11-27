-- ====================================================================================================================
-- ZKV_Takedowns by Kvalyr for CP2077
-- Config values
-- ====================================================================================================================

-- Set this value to true or false to toggle using the Aerial Takedown for Mantis Blades finishers.
-- i.e.; If this is true, the Mantis Blades aerial takedown animation added in 1.5 will be used in place of the normal mantis blades finisher animation.
local MantisSwap_Finishers_UseAerialTakedownAnimation = true

-- Set this value to true or false to toggle using either the Aerial Takedown animation or the old finisher animation on a 50/50 basis.
-- i.e.; If this is true, then about 50% of the time, the new Mantis Blades aerial takedown animation from 1.5 will be used for MB finishers.
-- If 'MantisSwap_Finishers_UseAerialTakedownAnimation' is true and this is false, then the 1.5 aerial takedown animation will be used 100% of the time.
-- If 'MantisSwap_Finishers_UseAerialTakedownAnimation' is false then this has no effect.
local MantisSwap_Finishers_MixDifferentAnimations = false


-- Set this value to true or false to toggle the new takedown/kill prompt showing only with a melee weapon held (true) or with any weapon (false)
local Takedowns_OnlyWithMeleeWeaponHeld = true


-- By default, takedowns with blunt weapons (fists, gorilla arms, clubs, bats, etc.) leave the target unconscious
-- Set this to false to make those takedowns lethal instead
local Takedowns_NonLethalBlunt = true


-- ====================================================================================================================
-- !! Here be dragons !!
-- Changing anything below this line is unsupported. Don't complain to the mod author if things break when you change stuff below this point.
-- ====================================================================================================================

-- The tables below are where the various finisher/takedown animation workspots are mapped to different weapons.
-- WARNING: Change these at your own risk. Some combinations of weapon and workspot can crash the game or cause a softlock, trapping you in a stuck animation.
-- Entries in the tables should be strings referencing the tag of a takedown or finisher effect

-- ---- ---- ---- ----
-- Melee Weapons
-- ---- ----

-- Fists & Gorilla Arms
local takedown_anims_weapon_FISTS =
{
    "finisher_default",             -- Throat-punch to Haymaker
    "AerialTakedown_Back_Simple",   -- Face-to-ground smash
    "AerialTakedown_Simple",        -- Occipital smash
    -- "Cyb_StrongArms_Back",       -- No difference from finisher_default in CDPR effectSet
}

-- Katana
local takedown_anims_weapon_LONG_BLADE =
{
    -- "Wea_Katana",                -- 2h Gut stab
    -- "Wea_Katana_Back",           -- Behead
    "ZKVTD_Katana_backstab",        -- 2h Backstab (WIP)
    "ZKVTD_Katana_behead_behind",   -- Behead, target facing away from V
}

-- Knife, Machete & Chain SWord
local takedown_anims_weapon_SHORT_BLADE =
{
    -- "finisher_default",
    "ZKVTD_Knife_backstab",         -- Backstab (WIP)
    -- "AerialTakedown_Back_Simple",
    -- "AerialTakedown_Simple",
    -- "AerialTakedown_Back_MantisBlades",
    -- "AerialTakedown_MantisBlades",
}

-- 1h Club
-- References to animations for one-handed blunt exist in the game files, but the actual animations are missing or unfinished
local takedown_anims_weapon_ONE_HANDED_CLUB =
{
    "finisher_default",
}

-- 2h Club / Hammer
-- References to animations for two-handed club and/or hammer exist in the game files, but the actual animations are missing or unfinished
local takedown_anims_weapon_TWO_HANDED_CLUB =
{
    "finisher_default",
}


-- ---- ---- ---- ----
-- Cyberware
-- ---- ----

-- Mantis Blades
-- Default: Finisher-from-behind and aerial-takedown-from-behind
-- Uncomment the other entries (by removing '--') to also use their equivalents from-front. Might look weird or move you around when doing takedowns from behind.
local takedown_anims_cyber_MANTIS_BLADES = {
    "Cyb_MantisBlades_Back",            -- Double-impale and lift
    "AerialTakedown_Back_MantisBlades", -- Ground-slam with neck/head impale

    -- "AerialTakedown_MantisBlades",
    -- "Cyb_MantisBlades",
}

-- Gorilla Arms use fist anims

-- Monowire
-- Cyb_NanoWires - These animations exist in-game in a broken/unfinished state - Not worth using yet, but maybe someday..
local takedown_anims_cyber_MONOWIRE = {
    "finisher_default",
    -- "Cyb_NanoWires",
}

-- Launcher
-- Only listed here for completeness
local takedown_anims_cyber_LAUNCHER = {
    "finisher_default",
}


-- ====================================================================================================================
-- ZKV_Takedowns
-- All configuration values are above - Don't touch the stuff below if all you want to do is configure the mod
-- ====================================================================================================================

local takedownAnimsByWeapon = {
    Wea_Fists = takedown_anims_weapon_FISTS,

    -- Long Blades share anims
    Wea_LongBlade = takedown_anims_weapon_LONG_BLADE,
    Wea_Katana = takedown_anims_weapon_LONG_BLADE, --takedown_anims_weapon_KATANA,

    -- Short Blades share anims
    Wea_ShortBlade = takedown_anims_weapon_SHORT_BLADE,
    Wea_Chainsword = takedown_anims_weapon_SHORT_BLADE, --takedown_anims_weapon_CHAIN_SWORD,
    Wea_Knife = takedown_anims_weapon_SHORT_BLADE, --takedown_anims_weapon_KNIFE,
    Wea_Machete = takedown_anims_weapon_SHORT_BLADE, --takedown_anims_weapon_MACHETE,

    Wea_OneHandedClub = takedown_anims_weapon_ONE_HANDED_CLUB,

    -- Hammer uses 2H Club anims
    Wea_TwoHandedClub = takedown_anims_weapon_TWO_HANDED_CLUB,
    Wea_Hammer = takedown_anims_weapon_TWO_HANDED_CLUB, --takedown_anims_weapon_HAMMER,

    Cyb_MantisBlades = takedown_anims_cyber_MANTIS_BLADES,

    -- StrongArms share anims with fists
    Cyb_StrongArms = takedown_anims_weapon_FISTS, --takedown_anims_cyber_STRONG_ARMS,

    Cyb_NanoWires = takedown_anims_cyber_MONOWIRE,
    Cyb_Launcher = takedown_anims_cyber_LAUNCHER,
}

ZKV_Takedowns.config["MantisSwap_Finishers_UseAerialTakedownAnimation"] = MantisSwap_Finishers_UseAerialTakedownAnimation
ZKV_Takedowns.config["MantisSwap_Finishers_MixDifferentAnimations"] = MantisSwap_Finishers_MixDifferentAnimations
ZKV_Takedowns.config["Takedowns_OnlyWithMeleeWeaponHeld"] = Takedowns_OnlyWithMeleeWeaponHeld
ZKV_Takedowns.config["Takedowns_NonLethalBlunt"] = Takedowns_NonLethalBlunt
ZKV_Takedowns.config["takedownAnims"] = takedownAnimsByWeapon

ZKV_Takedowns.print("Config Finished!")
