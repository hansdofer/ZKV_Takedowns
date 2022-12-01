local ZKVTD = GetMod("ZKV_Takedowns")
-- ====================================================================================================================
-- ZKV_Takedowns for CP2077 by Kvalyr
-- Native Settings UI
-- ====================================================================================================================
local strlower = string.lower
local strupper = string.upper
-- ====================================================================================================================

local utils = {}
ZKVTD.utils = utils


function utils.IsStrValid(inputStr, allowEmpty)
    if not allowEmpty and inputStr == "" then
        return false
    end
    return inputStr ~= nil
end

function utils.strsplit(inputStr, sep)
    if sep == nil then
        sep = "%s"
    end
    local tab = {}
    for str in string.gmatch(inputStr, "([^"..sep.."]+)") do
        table.insert(tab, str)
    end
    return tab
end


function utils.firstToUpper(inputStr)
    return (inputStr:gsub("^%l", strupper))
end


function utils.firstOnlyToUpper(inputStr)
    return utils.firstToUpper(strlower(inputStr))
end


local function tchelper(first, rest)
    return first:upper()..rest:lower()
end
function utils.strTitleCase(inputStr)
    -- http://lua-users.org/wiki/StringRecipes
     return inputStr:gsub("(%a)([%w_']*)", tchelper)
end


return utils
