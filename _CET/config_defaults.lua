local ZKVTD = GetMod("ZKV_Takedowns")
-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- Default Config values - Editing this file is not advisable - Use the in-game settings UI instead (Main Menu -> Mods -> Kvalyr Mods)
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



local StealthMeleeDamageMultiplier = 1.30 -- Default in CP2077 v1.61: 1.30


-- -- Unlock camera during finishers & takedowns
-- -- May cause weirdness
-- -- WIP - CURRENTLY UNUSED
-- local TakedownsFinishers_UnlockCamera = true

-- -- Unlock movement during finishers & takedowns
-- -- Will cause weirdness
-- -- WIP - CURRENTLY UNUSED
-- local TakedownsFinishers_UnlockControls = true


ZKVTD.SetDefaultConfigValue("MantisSwap_Finishers_UseAerialTakedownAnimation", MantisSwap_Finishers_UseAerialTakedownAnimation)
ZKVTD.SetDefaultConfigValue("MantisSwap_Finishers_MixDifferentAnimations", MantisSwap_Finishers_MixDifferentAnimations)
ZKVTD.SetDefaultConfigValue("Takedowns_OnlyWithMeleeWeaponHeld", Takedowns_OnlyWithMeleeWeaponHeld)
ZKVTD.SetDefaultConfigValue("Takedowns_NonLethalBlunt", Takedowns_NonLethalBlunt)
ZKVTD.SetDefaultConfigValue("Misc_Stealth_MeleeMult", StealthMeleeDamageMultiplier)

ZKVTD.print("Default Configuration loaded!")
