local ZKVTD = GetMod("ZKV_Takedowns")
-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- In-memory config table
-- ====================================================================================================================
local Config = {}
local configTable = {}
local configCallbacks = {}
ZKVTD.Config = Config
ZKVTD.configTable = configTable
ZKVTD.configCallbacks = configCallbacks
ZKVTD.Modules["MemConfig"] = Config
ZKVTD.Modules["Config"] = Config
-- ====================================================================================================================

function Config.GetValue( key, default )
    -- TODO: Move to settings.lua
    local value = configTable[key]
    if value == nil then
        return default
    end
    return value
end

function Config.SetValue( key, value, noSave )
    -- TODO: Move to settings.lua
    configTable[key] = value
    if not noSave then
        ZKVTD:SaveSettings() -- TODO: Do we really want to call this on each value update? Probably not..
    end
end

function Config.SetDefaultValue( key, value )
    ZKVTD.Config.SetValue(key, value, true)
end

-- local function dumpConfig()
--     -- TODO: Move to settings.lua
--     if not ZKVTD.debugMode then return end

--     for key, value in pairs(configTable) do
--         if type(value) == "table" then
--             ZKVTD.debug("Config: ", key, ": ", #value, "(table)")
--         else
--             ZKVTD.debug("Config: ", key, ": ", value)
--         end
--     end
-- end

function Config.AddCallback( callbackKey, callbackFunc )
    local existing = configCallbacks[callbackKey]
    if existing then
        ZKVTD.print("Error: Config callback already exists at key:", callbackKey)
    else
        configCallbacks[callbackKey] = callbackFunc
        ZKVTD.debug("Added config callback at key:", callbackKey)
    end
end

function Config.AddCallback_GenericSetFlat( flatKey, configKey, default, callbackKey, multiplier )
    if default == nil then
        default = true
    end

    local function callbackFunc( newValue )
        if newValue == nil then
            newValue = ZKVTD.Config.GetValue(configKey, default)
        else
            ZKVTD.Config.SetValue(configKey, newValue)
        end
        local success = TweakDB:SetFlat(flatKey, newValue)
        ZKVTD.debug("-Config Callback-", flatKey, "newValue:", newValue, "SetFlat success:", success)
        if not success then
            ZKVTD.printError("Failed to SetFlat:", "'" .. flatKey .. "'", newValue)
        end

        -- dumpConfig()
    end

    if not callbackKey or callbackKey == "" then
        callbackKey = "SetFlat_" .. flatKey
    end

    Config.AddCallback(callbackKey, callbackFunc)
end

function Config.GetCallback( callbackKey )
    -- TODO: Move to settings.lua
    local callbackFunc = configCallbacks[callbackKey]
    if not callbackFunc then
        ZKVTD.debug("Warning: Failed to retrieve config callback:", callbackKey)
        return function()
            ZKVTD.debug("Warning: Dummy callback for:", callbackKey)
        end
    end
    return callbackFunc
end

function Config.CallCallback( callbackKey )
    -- TODO: Move to settings.lua
    local func = ZKVTD.Config.GetCallback(callbackKey)
    local funcType = type(func)
    if funcType == "function" then
        return func()
    else
        ZKVTD.print("Error: Invalid type (" .. funcType .. ") for config callback:", callbackKey)
    end
end

-- ====================================================================================================================

function Config.InitAllCallbacks()
    for _, callbackFunc in pairs(configCallbacks) do
        callbackFunc()
    end
end
