-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
function addon.InitializeDatabase()
    if type(PriesterRP_CharacterDB) ~= "table" then
        PriesterRP_CharacterDB = {}
    end
    addon.db = PriesterRP_CharacterDB
    for key, default in pairs(addon.defaults) do
        if addon.db[key] == nil then addon.db[key] = default end
    end
    for _, key in ipairs({"textChance", "racialTextChance", "ambientChance"}) do
        local value = addon.db[key]
        if type(value) ~= "number" or value ~= value then value = addon.defaults[key] end
        addon.db[key] = math.max(0, math.min(100, math.floor(value)))
    end
    for _, key in ipairs({"ambientEnabled", "ambientInCombat"}) do
        if type(addon.db[key]) ~= "boolean" then addon.db[key] = addon.defaults[key] end
    end
    for _, key in ipairs({"ambientMinInterval", "ambientMaxInterval"}) do
        local value = addon.db[key]
        if type(value) ~= "number" or value ~= math.floor(value) or value < 30 or value > 7200 then
            addon.db[key] = addon.defaults[key]
        end
    end
    if addon.db.ambientMaxInterval < addon.db.ambientMinInterval then
        addon.db.ambientMaxInterval = addon.db.ambientMinInterval
    end
    local cd = addon.db.cooldown
    if type(cd) ~= "number" or cd ~= cd or cd ~= math.floor(cd) or cd < 0 or cd > 3600 then
        addon.db.cooldown = addon.defaults.cooldown
    end
    if not addon.availableLocales[addon.db.outputLanguage] then addon.db.outputLanguage = "deDE" end
    if not ({SAY=true, YELL=true, AUTO=true, PARTY=true, RAID=true, INSTANCE_CHAT=true})[addon.db.chatChannel] then
        addon.db.chatChannel = "SAY"
    end
end

function addon.NormalizeRace(race)
    race = (race or ""):upper():gsub("[^A-Z_]", "")
    if race == "SCOURGE" then return "UNDEAD" end
    if race == "HIGHELF" then return "HIGH_ELF" end
    if race == "BLOODELF" then return "BLOODELF" end
    if race == "SKYBORNE" then return "NIGHTELF" end
    return race
end
