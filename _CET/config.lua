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


-- ====================================================================================================================
-- !! Here be dragons !!
-- Changing anything below this line is unsupported. Don't complain to the mod author if things break when you change stuff below this point.
-- ====================================================================================================================

-- The tables below are where the various finisher/takedown animation workspots are mapped to different weapons.
-- WARNING: Change these at your own risk. Some combinations of weapon and workspot can crash the game or cause a softlock, trapping you in a stuck animation.
-- 'finishers' tables must only contain strings matching the tags of effects in the `finisher.es` effectSet with associated finisher workspots
-- 'takedowns' tables must only contain strings matching the tags of effects in the `takedowns.es` effectSet with associated takedown workspots

local finisher_anims_weapon_FISTS = {
    finishers = {
        "finisher_default",
    },
    takedowns = {
        "AerialTakedown_Back_Simple",
        "AerialTakedown_Simple",
    },
}

local finisher_anims_weapon_KATANA = {
    finishers = {
        "Wea_Katana",
        "Wea_Katana_Back",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_KNIFE = {
    finishers = {
        "Wea_Katana",
        "Wea_Katana_Back",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_MACHETE = {
    finishers = {
        "finisher_default",
        "Wea_Katana",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_CHAIN_SWORD = {
    finishers = {
        "finisher_default",
        "Wea_Katana",
        "Wea_Katana_Back",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_SHORT_BLADE = {
    finishers = {
        "finisher_default",
        "Wea_Katana",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_LONG_BLADE = {
    finishers = {
        "Wea_Katana",
        "Wea_Katana_Back",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_HAMMER = {
    finishers = {
        "Wea_Hammer_Back",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_ONE_HANDED_CLUB = {
    finishers = {
        "finisher_default",
    },
    takedowns = {
    },
}

local finisher_anims_weapon_TWO_HANDED_CLUB = {
    finishers = {
        "finisher_default",
    },
    takedowns = {
    },
}

-- Mantis Blades
local finisher_anims_cyber_MANTIS_BLADES = {
    finishers = {
        "Cyb_MantisBlades_Back",
        -- "Cyb_MantisBlades",
    },
    takedowns = {
        "AerialTakedown_Back_MantisBlades",
        -- "AerialTakedown_MantisBlades",
    },
}

-- Gorilla Arms
local finisher_anims_cyber_STRONG_ARMS = {
    finishers = {
        "finisher_default",
        "Cyb_StrongArms_Back",
    },
    takedowns = {
        "AerialTakedown_Back_Simple",
        "AerialTakedown_Simple",
    },
}

-- Monowire
local finisher_anims_cyber_MONOWIRE = {
    finishers = {
        "finisher_default",
    },
    takedowns = {
    },
}

-- Launcher
local finisher_anims_cyber_LAUNCHER = {
    finishers = {
        "finisher_default",
    },
    takedowns = {
    },
}

local finisherAnims = {
    Wea_Fists = finisher_anims_weapon_FISTS,

    Wea_Chainsword = finisher_anims_weapon_CHAIN_SWORD,
    Wea_Katana = finisher_anims_weapon_KATANA,
    Wea_Knife = finisher_anims_weapon_KNIFE,
    Wea_LongBlade = finisher_anims_weapon_LONG_BLADE,
    Wea_Machete = finisher_anims_weapon_MACHETE,
    Wea_ShortBlade = finisher_anims_weapon_SHORT_BLADE,

    Wea_Hammer = finisher_anims_weapon_HAMMER,
    Wea_OneHandedClub = finisher_anims_weapon_ONE_HANDED_CLUB,
    Wea_TwoHandedClub = finisher_anims_weapon_TWO_HANDED_CLUB,

    Cyb_Launcher = finisher_anims_cyber_LAUNCHER,
    Cyb_MantisBlades = finisher_anims_cyber_MANTIS_BLADES,
    Cyb_NanoWires = finisher_anims_cyber_MONOWIRE,
    Cyb_StrongArms = finisher_anims_cyber_STRONG_ARMS,
}

-- ====================================================================================================================
-- ZKV_Takedowns
-- All configuration values are above - Don't touch the stuff below if all you want to do is configure the mod
-- ====================================================================================================================

ZKV_Takedowns.config["MantisSwap_Finishers_UseAerialTakedownAnimation"] = MantisSwap_Finishers_UseAerialTakedownAnimation
ZKV_Takedowns.config["MantisSwap_Finishers_MixDifferentAnimations"] = MantisSwap_Finishers_MixDifferentAnimations
ZKV_Takedowns.config["Takedowns_OnlyWithMeleeWeaponHeld"] = Takedowns_OnlyWithMeleeWeaponHeld
ZKV_Takedowns.config["finisherAnims"] = finisherAnims

ZKV_Takedowns.print("Config Finished!")
