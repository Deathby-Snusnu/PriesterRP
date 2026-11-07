-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
local manualFriendly = { BEDSIDE_PRAYER=true, CONFESSION=true, LAST_RITES=true }
local function targetName(key)
    local mode = manualFriendly[key] and "F" or addon.spellTargets[key]
    if not mode or type(UnitExists) ~= "function" or not UnitExists("target") or
        type(UnitName) ~= "function" then return nil end
    if mode == "A" then
        if type(UnitCanAttack) ~= "function" or not UnitCanAttack("player", "target") then return nil end
    elseif mode == "F" then
        if type(UnitCanAssist) ~= "function" or not UnitCanAssist("player", "target") then return nil end
    else return nil end
    return UnitName("target")
end
local function choose(pool)
    if type(pool) ~= "table" or #pool == 0 then return nil end
    return pool[math.random(#pool)]
end
function addon.BuildText(key)
    if type(key) ~= "string" then return nil end
    local lang = addon.db and addon.db.outputLanguage or "deDE"
    if not addon.availableLocales[lang] then lang = "deDE" end
    local localized = addon.localeData[lang] or addon.localeData.deDE
    local entry = (localized.texts and localized.texts[key]) or
        (addon.localeData.deDE.texts and addon.localeData.deDE.texts[key])
    if not entry then return nil end
    local target = targetName(key)
    local pool = target and entry.ziel or entry.gruppe
    if type(pool) ~= "table" or #pool == 0 then pool = entry.gruppe end
    local _, race = UnitRace("player")
    local racial = localized.racial or addon.localeData.deDE.racial
    local raceEntries = racial and racial[addon.NormalizeRace(race)]
    local racePool = raceEntries and raceEntries[key]
    if type(racePool) == "table" and #racePool > 0
        and math.random(100) <= (addon.db.racialTextChance or 40) then
        -- Racial motifs are deliberately target-neutral.
        pool = racePool
    end
    local line = choose(pool)
    if type(line) ~= "string" then return nil end
    return (line:gsub("%%([s%%])", function(token)
        if token == "%" then return "%" end
        return target or ""
    end))
end
function addon.BuildAmbient()
    local lang = addon.db and addon.db.outputLanguage or "deDE"
    if not addon.availableLocales[lang] then lang = "deDE" end
    local data = (addon.localeData[lang] or {}).ambient or addon.localeData.deDE.ambient
    if not data then return nil end
    local _, race = UnitRace("player")
    return choose(data[addon.NormalizeRace(race)] or data.NEUTRAL)
end
