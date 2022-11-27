-- ====================================================================================================================
-- ZKV_Takedowns by Kvalyr for CP2077
-- ====================================================================================================================
local version = "0.2.1"
local modString = "ZKV_Takedowns v" .. version
ZKV_Takedowns = {
    description = modString .. " - Takedowns & Finishers Overhaul for CP2077 - Version: " .. version
}
ZKV_Takedowns.version = version
ZKV_Takedowns.modString = modString
ZKV_Takedowns.print = function(...) print(modString, ": ", ...) end

function ZKV_Takedowns.assert(testVal, msg)
    if not testVal then
        ZKV_Takedowns.print("[Fatal error]: '" .. tostring(msg) .. "'")
        assert(testVal, msg)
    end
end

function ZKV_Takedowns.doFile(filePath)
    ZKV_Takedowns.print("doFile: Executing Lua file: " .. filePath)
    local status_ok, retVal = pcall(dofile, filePath)
    if status_ok then
        ZKV_Takedowns.print("doFile: Finished executing file: " .. filePath)
    else
        ZKV_Takedowns.print("doFile: ERROR executing file: " .. filePath)
        ZKV_Takedowns.print("doFile: ERROR: " .. "'" .. tostring(retVal) .. "'")
    end
    ZKV_Takedowns.assert(status_ok, tostring(retVal))
    -- print("---")
end


local function SetupConfig()
    ZKV_Takedowns.print("SetupConfig")
    ZKV_Takedowns.config = {}
    ZKV_Takedowns.doFile("config.lua")

    for key, value in pairs(ZKV_Takedowns.config) do
        if type(value) == "table" then
            ZKV_Takedowns.print("Config: ", key, ":", #value)
        else
            ZKV_Takedowns.print("Config: ", key, ":", value, "(table)")
        end
    end

    local nonLethalBlunt = ZKV_Takedowns.config["Takedowns_NonLethalBlunt"]
    if nonLethalBlunt == nil then
        nonLethalBlunt = true
    end
    TweakDB:SetFlat("ZKVTD.Takedowns.nonLethalBlunt", nonLethalBlunt)

end


local function SetupMantisAnimSwap()
    local useAerial = ZKV_Takedowns.config["MantisSwap_Finishers_UseAerialTakedownAnimation"]
    if useAerial == nil then
        useAerial = true
    end
    local mixAnims = ZKV_Takedowns.config["MantisSwap_Finishers_MixDifferentAnimations"]
    if mixAnims == nil then
        mixAnims = true
    end
    TweakDB:SetFlat("ZKVTD.MantisBladesAnimSwap.UseAerial", useAerial)
    TweakDB:SetFlat("ZKVTD.MantisBladesAnimSwap.RandomChoice", mixAnims)
end


local function SetupMeleeTakedowns()
    -- Set up new interaction at same interaction layer as Grapple, using Choice2 (Grapple uses Choice1)
    TweakDB:CloneRecord("Interactions.Kv_MeleeTakedown", "Interactions.Takedown")
    TweakDB:SetFlat("Interactions.Kv_MeleeTakedown.action", "Choice2")
    TweakDB:SetFlat("Interactions.Kv_MeleeTakedown.name", "Kv_MeleeTakedown")

    -- Create new Takedown record and link to new interaction
    TweakDB:CloneRecord("Takedown.Kv_MeleeTakedown", "Takedown.Grapple")
    TweakDB:SetFlat("Takedown.Kv_MeleeTakedown.objectActionUI", "Interactions.Kv_MeleeTakedown")
    TweakDB:SetFlat("Takedown.Kv_MeleeTakedown.actionName", "Kv_MeleeTakedown")

    -- Make takedown prompt only show when a weapon is held
    if ZKV_Takedowns.config["Takedowns_OnlyWithMeleeWeaponHeld"] then
        local instigatorPrereqs = TweakDB:GetFlat("Takedown.Kv_MeleeTakedown.instigatorPrereqs")
        table.insert(instigatorPrereqs, "Prereqs.MeleeWeaponHeldPrereq")
        TweakDB:SetFlat("Takedown.Kv_MeleeTakedown.instigatorPrereqs", instigatorPrereqs)
    end

    local takedownAnims = ZKV_Takedowns.config["takedownAnims"]
    if takedownAnims == nil then
        ZKV_Takedowns.print("ERROR: nil takedownAnims table!")
        takedownAnims = {}
    end

    for weapon_key, animTable in pairs(takedownAnims) do
        ZKV_Takedowns.print("ZKVTD ===================================== ")
        local takedownsCount = #animTable
        ZKV_Takedowns.print("ZKVTD", weapon_key, takedownsCount)

        local takedownsCountFlatKey = "ZKVTD.MeleeTakedownAnims." .. weapon_key .. ".count"
        TweakDB:SetFlat(takedownsCountFlatKey, tostring(takedownsCount))

        for idx_key, anim in ipairs(animTable) do
            -- local flatKey = "ZKVTD.MeleeTakedownAnims." .. weapon_key .. ".takedown" .. idx_key-1
            local flatKey = "ZKVTD.MeleeTakedownAnims." .. weapon_key .. idx_key-1
            TweakDB:SetFlat(flatKey, anim)
        end
        ZKV_Takedowns.print("ZKVTD", weapon_key, takedownsCount)
        -- e.g.;
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.count_finishers -> "3"
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.count_takedowns -> "2"
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.finisher0
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.finisher1
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.finisher2
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.takedown0
        -- ZKVTD.MeleeTakedownAnims.Wea_Katana.takedown1

    end

end


local function onInit()
    ZKV_Takedowns.print("Init")
    SetupConfig()
    SetupMeleeTakedowns()
    SetupMantisAnimSwap()
    ZKV_Takedowns.print("Fully Loaded!")
end

function ZKV_Takedowns:New()
    registerForEvent("onInit", onInit)
end


return ZKV_Takedowns:New()
