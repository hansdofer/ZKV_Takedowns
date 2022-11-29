-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- ====================================================================================================================

local version = "0.3.0"
local modString = "ZKV_Takedowns v" .. version
local ZKV_Takedowns = {
    version = version,
    modString = modString,
    description = modString .. " - Takedowns & Finishers Overhaul for CP2077 - Version: " .. version,
    descSimple = "Takedowns & Finishers Overhaul",
    nativeSettingsBasePath = "/ZKV",
    configFileName = "config.json",
}
local ZKVTD = ZKV_Takedowns
ZKVTD.debugMode = false
ZKVTD.version = version
ZKVTD.modString = modString
ZKVTD.print = function(...) print(modString, ": ", ...) end
ZKVTD.printError = function(...) print(modString, ":ERROR: ", ...) end
ZKVTD.debug = function(...)
    -- TODO: Move to shared utils
    if not ZKVTD.debugMode then return end
    print(modString, ": ", ...)
end

function ZKVTD:GetNativeSettingsMod()
    -- TODO: Move to shared utils
    local nativeSettings = GetMod("nativeSettings")
    if not nativeSettings then
        self.print("Warning: Native Settings UI is not installed. Please install this dependency if you want to configure " .. self.descSimple)
        return
    end

    if not nativeSettings.pathExists(self.nativeSettingsBasePath) then
        nativeSettings.addTab(self.nativeSettingsBasePath, "Kvalyr Mods")
    end

    return nativeSettings
end

function ZKVTD.pcall(func, ...)
    -- TODO: Move to shared utils
    local status_ok, retVal = pcall(func, ...)
    if status_ok then
        return status_ok, retVal
    else
        ZKVTD.printError("Problem executing func - retVal: ", "'" .. tostring(retVal) .. "'")
    end
end

function ZKVTD.assert(testVal, msg)
    -- TODO: Move to shared utils
    if not testVal then
        ZKVTD.print("[Fatal error]: '" .. tostring(msg) .. "'")
        assert(testVal, msg)
    end
end

function ZKVTD.doFile(filePath)
    -- TODO: Move to shared utils
    ZKVTD.debug("doFile: Executing Lua file: " .. filePath)
    local status_ok, retVal = pcall(dofile, filePath)
    if status_ok then
        ZKVTD.debug("doFile: Finished executing file: " .. filePath)
    else
        ZKVTD.printError("doFile: Problem executing file: " .. filePath)
        ZKVTD.printError("doFile: '" .. tostring(retVal) .. "'")
    end
    ZKVTD.assert(status_ok, tostring(retVal))
end

-- ====================================================================================================================

function ZKVTD.GetConfigValue(key, default)
    local value = ZKVTD.config[key]
    if value == nil then
        return default
    end
    return value
end

function ZKVTD.SetConfigValue(key, value, noSave)
    ZKVTD.config[key] = value
    if not noSave then
        ZKVTD:SaveSettings() -- TODO: Do we really want to call this on each value update? Probably not..
    end
end
function ZKVTD.SetDefaultConfigValue(key, value) ZKVTD.SetConfigValue(key, value, true) end

local function dumpConfig()
    if not ZKVTD.debugMode then return end

    for key, value in pairs(ZKVTD.config) do
        if type(value) == "table" then
            ZKVTD.debug("Config: ", key, ": ", #value, "(table)")
        else
            ZKVTD.debug("Config: ", key, ": ", value)
        end
    end
end

function ZKVTD.GetConfigCallback(callbackKey)
    local callbackFunc = ZKVTD.configCallbacks[callbackKey]
    if not callbackFunc then
        ZKVTD.debug("Warning: Failed to retrieve config callback:", callbackKey)
        return function() end
    end
    return callbackFunc
end
function ZKVTD.CallConfigCallback(callbackKey)
    local func = ZKVTD.GetConfigCallback(callbackKey)
    local funcType = type(func)
    if funcType == "function" then
        return func()
    else
        ZKVTD.print("Error: Invalid type (" .. funcType .. ") for config callback:", callbackKey)
    end
end

local function addConfigCallback_ByKey(callbackKey, callbackFunc)
    local existing = ZKVTD.configCallbacks[callbackKey]
    if existing then
        ZKVTD.print("Error: Config callback already exists at key:", callbackKey)
    else
        ZKVTD.configCallbacks[callbackKey] = callbackFunc
        ZKVTD.debug("Added config callback at key:", callbackKey)
    end
end

local function addConfigCallback_SetFlat(flatKey, configKey, default, callbackKey)
    if default == nil then default = true end

    local function callbackFunc(newValue)
        if newValue == nil then
            newValue = ZKVTD.GetConfigValue(configKey, default)
        else
            ZKVTD.SetConfigValue(configKey, newValue)
        end
        local success = TweakDB:SetFlat(flatKey, newValue)
        ZKVTD.debug("-Config Callback-", flatKey, "newValue:", newValue, "SetFlat success:", success)
        if not success then
            ZKVTD.printError("Failed to SetFlat:", "'"..flatKey.."'", newValue)
        end

        dumpConfig()
    end

    if not callbackKey or callbackKey == "" then
        callbackKey = "SetFlat_" .. flatKey
    end

    addConfigCallback_ByKey(callbackKey, callbackFunc)
end

function ZKVTD.InitAllCallbacks()
    for _, callbackFunc in pairs(ZKVTD.configCallbacks) do
        callbackFunc()
    end
end

local function Update_Takedowns_OnlyMelee(newValue)
    -- Make takedown prompt only show when a weapon is held
    local instigatorPrereqs = TweakDB:GetFlat("Takedown.Grapple.instigatorPrereqs") -- Use grapple's prereqs as our basis
    local configKey = "Takedowns_OnlyWithMeleeWeaponHeld"
    if newValue == nil then
        newValue = ZKVTD.GetConfigValue(configKey, true)
    end

    ZKVTD.SetConfigValue(configKey, newValue)
    if newValue == true then
        table.insert(instigatorPrereqs, "Prereqs.MeleeWeaponHeldPrereq")
    end

    local flatKey = "Takedown.Kv_MeleeTakedown.instigatorPrereqs"
    local success = TweakDB:SetFlat(flatKey, instigatorPrereqs)
    ZKVTD.debug("-Config Callback-", flatKey, "newValue:", newValue, "SetFlat success:", success)
    if not success then
        ZKVTD.printError("Failed to SetFlat:", "'"..flatKey.."'", newValue)
    end
end


-- ====================================================================================================================


local function SetupSettings()
    ZKVTD.debug("SetupSettings")
    ZKVTD.doFile("settings.lua")
    ZKVTD:LoadSettings()
    ZKVTD.doFile("settingsUI.lua")
end

local function SetupDefaultConfig()
    ZKVTD.debug("SetupDefaultConfig")
    ZKVTD.config = {}
    ZKVTD.configCallbacks = {}

    ZKVTD.doFile("config_defaults.lua")
    ZKVTD.doFile("config_takedown_animations.lua")

    dumpConfig()

    addConfigCallback_ByKey("Update_Takedowns_OnlyMelee", Update_Takedowns_OnlyMelee)
    addConfigCallback_SetFlat("ZKVTD.Takedowns.nonLethalBlunt", "Takedowns_NonLethalBlunt", true, "Update_Takedowns_NonLethalBlunt")
    addConfigCallback_SetFlat("ZKVTD.MantisBladesAnimSwap.UseAerial", "MantisSwap_Finishers_UseAerialTakedownAnimation", true, "Update_MTBAnimSwap_UseAerial")
    addConfigCallback_SetFlat("ZKVTD.MantisBladesAnimSwap.RandomChoice", "MantisSwap_Finishers_MixDifferentAnimations", true, "Update_MTBAnimSwap_RandomChoice")

end


local function SetupMeleeTakedowns()
    ZKVTD.debug("SetupMeleeTakedowns")
    if not ZKVTD.GetConfigValue("takedownAnims_defaultsLoaded", false) then
        ZKVTD.printError("Cannot initialize melee takedowns without loading default config first.")
        return
    end
    -- Set up new interaction at same interaction layer as Grapple, using Choice2 (Grapple uses Choice1)
    TweakDB:CloneRecord("Interactions.Kv_MeleeTakedown", "Interactions.Takedown")
    TweakDB:SetFlat("Interactions.Kv_MeleeTakedown.action", "Choice2")
    TweakDB:SetFlat("Interactions.Kv_MeleeTakedown.name", "Kv_MeleeTakedown")

    -- Create new Takedown record and link to new interaction
    TweakDB:CloneRecord("Takedown.Kv_MeleeTakedown", "Takedown.Grapple")
    TweakDB:SetFlat("Takedown.Kv_MeleeTakedown.objectActionUI", "Interactions.Kv_MeleeTakedown")
    TweakDB:SetFlat("Takedown.Kv_MeleeTakedown.actionName", "Kv_MeleeTakedown")

    -- Make takedown prompt only show when a weapon is held
    -- ZKVTD.configCallbacks.Update_Takedowns_OnlyMelee()

    local takedownAnims = ZKVTD.config["takedownAnims"]
    if takedownAnims == nil then
        ZKVTD.print("ERROR: nil takedownAnims table!")
        takedownAnims = {}
    end

    for weapon_key, animTable in pairs(takedownAnims) do
        local takedownsCount = #animTable
        ZKVTD.debug("ZKVTD ===================================== ")
        ZKVTD.debug("ZKVTD", weapon_key, takedownsCount)

        local takedownsCountFlatKey = "ZKVTD.MeleeTakedownAnims." .. weapon_key .. ".count"
        TweakDB:SetFlat(takedownsCountFlatKey, tostring(takedownsCount))

        for idx_key, anim in ipairs(animTable) do
            local flatKey = "ZKVTD.MeleeTakedownAnims." .. weapon_key .. idx_key-1
            TweakDB:SetFlat(flatKey, anim)
        end
        ZKVTD.print("ZKVTD", weapon_key, takedownsCount)
        -- e.g.;
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana0
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana1
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana2
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.count -> "3"
    end

end


local function onInit()
    ZKVTD.print("Init")

    ZKVTD.pcall(SetupDefaultConfig)
    ZKVTD.pcall(SetupMeleeTakedowns)
    -- ZKVTD.pcall(SetupControlUnlocks)

    ZKVTD.pcall(SetupSettings)
    ZKVTD.print("Fully Loaded!")
end

function ZKVTD:New()
    registerForEvent("onInit", onInit)
    return ZKVTD
end


return ZKVTD:New()
