-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- ====================================================================================================================
local ZKVTD = GetMod("ZKV_Takedowns")
local utils = ZKVTD.utils
local constants = {}
ZKVTD.constants = constants

local weaponTypes = {
    "Wea_Fists",

    -- "Wea_LongBlade",
    "Wea_Katana",
    "Wea_Machete",

    -- "Wea_ShortBlade",
    "Wea_Knife",
    "Wea_Chainsword",

    "Wea_OneHandedClub",
    "Wea_TwoHandedClub",
    "Wea_Hammer",
    "Cyb_MantisBlades",
    "Cyb_StrongArms",
    "Cyb_NanoWires",
    -- "Cyb_Launcher",
}
local weaponTypesIndices = utils.Table_createInverseArray_Strings(weaponTypes)
constants.weaponTypes = weaponTypes
constants.weaponTypesIndices = weaponTypesIndices


-- local weaponCategories_sharedAnims = {
--     Wea_Fists = {"Wea_Fists", "Cyb_StrongArms"},
--     Wea_LongBlade = {"Wea_LongBlade", "Wea_Katana", "Wea_Machete"},
--     Wea_ShortBlade = {"Wea_ShortBlade", "Wea_Knife", "Wea_Chainsword"}
-- }
-- constants.weaponCategories_sharedAnims = weaponCategories_sharedAnims


-- local takedownAnims = {
--     -- ==== ====
--     -- CDPR effects/workspots

--     -- Default takedown
--     "finisher_default",                     -- Throat-punch with haymaker follow-up

--     -- Unarmed Aerial
--     "AerialTakedown_Simple",                -- Occipital smash
--     "AerialTakedown_Back_Simple",           -- Face-to-ground smash

--     -- Long Blades
--     "Wea_Katana",                           -- Impale from front
--     "Wea_Katana_Back",                      -- Kneel and behead. Target turns to face V

--     -- Mantis Blades
--     "Cyb_MantisBlades",                     -- Double-impale and lift
--     "Cyb_MantisBlades_Back",                -- Double-impale and lift (target turns to face V)
--     "AerialTakedown_MantisBlades",          -- Ground-slam with neck/head impale
--     "AerialTakedown_Back_MantisBlades",     -- Ground-slam with neck/head impale

--     -- Gorilla Arms
--     "Cyb_StrongArms_Back",                  -- No difference from finisher_default in CDPR effectSet

--     -- ==== ====
--     -- ZKVTD custom effects/workspots

--     -- Katana
--     "ZKVTD_Katana_backstab",                -- Same as Wea_Katana but target remains facing away from V
--     "ZKVTD_Katana_behead_behind",           -- Same as Wea_Katana_Back but target remains facing away from V

--     -- Monowire
--     "ZKVTD_Monowire_behead_behind",         -- Monowire behead-from-behind takedown. Target kneels and head flies off.

--     "ZKVTD_Knife_backstab",                 -- Same as ZKVTD_Katana_backstab, but with offsets adjusted for a shorter blade

--     -- Repurposed attack animations
--     -- _QuickDeath == Target dies and ragdolls quickly, instead of using katana front-stab death sequence
--     "ZKVTD_Takedown_HeavyAttack01",             -- Strong attack from neutral
--     "ZKVTD_Takedown_HeavyAttack01_QuickDeath",
--     "ZKVTD_Takedown_HeavyAttack02",             -- Strong attack 2nd hit in combo
--     "ZKVTD_Takedown_HeavyAttack02_QuickDeath",
--     "ZKVTD_Takedown_ComboAttack03",             -- Light attack, third hit in combo
--     "ZKVTD_Takedown_ComboAttack03_QuickDeath",
--     "ZKVTD_Takedown_SafeAttack",                -- ??? Unsure when the base game uses this attack
--     "ZKVTD_Takedown_BlockAttack",               -- Strong attack from block (Defensive attack)
-- }
-- local takedownAnimsIndices = utils.Table_createInverseArray_Strings(takedownAnims)
-- constants.takedownAnims = takedownAnims
-- constants.takedownAnimsIndices = takedownAnimsIndices


-- utils.TweakDB_CreateArrayOfFlatsAndIndices(takedownAnims, "ZKVTD.TakedownAnims", true)
-- utils.TweakDB_CreateArrayOfFlatsAndIndices(weaponTypes, "ZKVTD.WeaponTypes", true)

-- -- ====================================================================================================================
-- function ZKVTD:ValidateWeaponType(weaponType)
--     if not self.constants.weaponTypesIndices[weaponType] then
--         utils.printError("Invalid weaponType:", weaponType)
--         return false
--     end
--     return true
-- end

-- function ZKVTD:ValidateAnimKey(animKey)
--     if not self.constants.takedownAnimsIndices[animKey] then
--         utils.printError("Invalid animKey:", animKey)
--         return false
--     end
--     return true
-- end

-- -- ====================================================================================================================
-- -- Allowed animations by weapon

-- local allowedAnims_FISTS = {
--     "finisher_default",
--     "AerialTakedown_Back_Simple",
--     "AerialTakedown_Simple",
-- }


-- local allowedAnims_LONG_BLADE = {
--     "Wea_Katana",
--     "Wea_Katana_Back",

--     "ZKVTD_Katana_backstab",
--     "ZKVTD_Katana_behead_behind",

--     "ZKVTD_Takedown_SafeAttack",
--     "ZKVTD_Takedown_BlockAttack",
-- }

-- local allowedAnims_SHORT_BLADE = {
--     "ZKVTD_Knife_backstab",
--     "ZKVTD_Takedown_SafeAttack",
--     "ZKVTD_Takedown_BlockAttack",
-- }

-- local allowedAnims_MEDIUM_BLADE = {}
-- for _, anim in ipairs(allowedAnims_LONG_BLADE) do table.insert(allowedAnims_MEDIUM_BLADE, anim) end
-- for _, anim in ipairs(allowedAnims_SHORT_BLADE) do table.insert(allowedAnims_MEDIUM_BLADE, anim) end


-- local allowedAnims_ONE_HANDED_CLUB = {
--     "ZKVTD_Takedown_HeavyAttack02_QuickDeath",
-- }

-- local allowedAnims_TWO_HANDED_CLUB = {
--     "ZKVTD_Takedown_ComboAttack03_QuickDeath",
-- }

-- local allowedAnims_HAMMER = {
--     "ZKVTD_Takedown_HeavyAttack02_QuickDeath",
-- }

-- local allowedAnims_MANTIS_BLADES = {
--     "Cyb_MantisBlades",
--     "Cyb_MantisBlades_Back",
--     "AerialTakedown_MantisBlades",
--     "AerialTakedown_Back_MantisBlades",

--     "ZKVTD_Takedown_BlockAttack",
-- }

-- local allowedAnims_MONOWIRE = {
--     "ZKVTD_Monowire_behead_behind",
-- }

-- local allowedAnimsByWeapon = {
--     Wea_Fists = allowedAnims_FISTS,

--     Wea_LongBlade = allowedAnims_LONG_BLADE,
--     Wea_Katana = allowedAnims_LONG_BLADE,

--     Wea_Machete = allowedAnims_MEDIUM_BLADE,
--     Wea_Chainsword = allowedAnims_MEDIUM_BLADE,

--     Wea_ShortBlade = allowedAnims_SHORT_BLADE,
--     Wea_Knife = allowedAnims_SHORT_BLADE,

--     Wea_OneHandedClub = allowedAnims_ONE_HANDED_CLUB,
--     Wea_TwoHandedClub = allowedAnims_TWO_HANDED_CLUB,
--     Wea_Hammer = allowedAnims_HAMMER,

--     Cyb_MantisBlades = allowedAnims_MANTIS_BLADES,
--     Cyb_StrongArms = allowedAnims_FISTS,
--     Cyb_NanoWires = allowedAnims_MONOWIRE,
-- }
-- constants.allowedAnimsByWeapon = allowedAnimsByWeapon

-- for idx, weaponType in ipairs(weaponTypes) do
--     utils.TweakDB_CreateArrayOfFlatsAndIndices(takedownAnims, "ZKVTD.TakedownAnims", true)
-- end