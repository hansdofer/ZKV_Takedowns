local ZKVTD = GetMod("ZKV_Takedowns")
-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- ====================================================================================================================

-- ====================================================================================================================
-- TODO: Logic to ensure Settings UI state, file state and ZKVTD.config state are all in-sync

function ZKVTD:LoadSettings()
    ZKVTD.debug("LoadSettings()")
    local file = io.open(self.configFileName, 'r')
    if file == nil then
        ZKVTD.printError("Failed to open '" .. self.configFileName .. "'")
        return
    end

    local rawContents = file:read("*a")
    local validJSON, decodedSettingsTable = ZKVTD.pcall(function() return json.decode(rawContents) end)
    file:close()

    if not validJSON or decodedSettingsTable == nil then
        ZKVTD.printError("Invalid JSON parsed from '" .. self.configFileName .. "' validJSON: ", validJSON, "decodedSettingsTable:", decodedSettingsTable)
        return
    end

    for key, _ in pairs(ZKVTD.config) do
        if decodedSettingsTable[key] ~= nil then
            ZKVTD.SetConfigValue(key, decodedSettingsTable[key])
        end
    end

    -- Fire all the config callbacks - Espedcially before we init the settings UI so that it starts out in-sync with loaded config
    ZKVTD.InitAllCallbacks()
end

local function ConfigToJson()
    return json.encode(ZKVTD.config)
end

function ZKVTD:SaveSettings()
    ZKVTD.debug("SaveSettings()")
    local validJSON, encodedJSONStr = pcall(ConfigToJson)

    if validJSON and encodedJSONStr ~= nil then
        local file = io.open(self.configFileName, "w+")
        file:write(encodedJSONStr)
        file:close()
    end
end
