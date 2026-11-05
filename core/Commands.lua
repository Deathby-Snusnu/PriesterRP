-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
SLASH_PRIESTERRP1 = "/prrp"
SLASH_PRIESTERRP2 = "/priester"

local function notify(message)
    print("|cffffaa55PriesterRP:|r " .. tostring(message))
end
addon.Notify = notify
local languages = {de="deDE", en="enUS", fr="frFR", dede="deDE", enus="enUS", frfr="frFR"}
local channels = {SAY=true, YELL=true, AUTO=true, PARTY=true, RAID=true, INSTANCE_CHAT=true}

local function integer(value, maximum, minimum)
    if type(value) ~= "string" or not value:match("^%d+$") then return nil end
    local n = tonumber(value)
    if not n or n ~= math.floor(n) or n < (minimum or 0) or n > maximum then return nil end
    return n
end

local function listKeys(mode)
    if mode ~= "" and mode ~= "racial" and mode ~= "all" then
        notify("Benutzung: /prrp list [racial|all]")
        return
    end
    local found = {}
    local lang = addon.availableLocales[addon.db.outputLanguage] and addon.db.outputLanguage or "deDE"
    local _, rawRace = UnitRace("player")
    local race = addon.NormalizeRace(rawRace)
    local function add(key, origin)
        if type(key) ~= "string" or not key:match("^[A-Z][A-Z0-9_]*$") then return end
        if not found[key] then found[key] = {} end
        found[key][origin] = true
    end
    local function flat(data, origin)
        if type(data) ~= "table" then return end
        for key, lines in pairs(data) do
            if type(lines) == "table" then add(key, origin) end
        end
    end
    for _, locale in ipairs({lang, "deDE"}) do
        local data = addon.localeData[locale]
        if type(data) == "table" then
            if mode ~= "racial" then flat(data.texts, "Faehigkeit") end
            if type(data.racial) == "table" then
                if mode == "all" then
                    for raceKey, pool in pairs(data.racial) do flat(pool, "Volk:" .. raceKey) end
                else
                    flat(data.racial[race], "Volk:" .. race)
                end
            end
        end
    end
    local names = {}
    for key in pairs(found) do names[#names + 1] = key end
    table.sort(names)
    notify("Schluessel (" .. (mode == "" and "aktuell" or mode) .. "): " .. #names)
    if #names == 0 then return end
    -- Split into bounded chat lines rather than printing a huge list.
    for i = 1, #names, 6 do
        local chunk = {}
        for j = i, math.min(i + 5, #names) do
            local key = names[j]
            if mode == "all" then
                local races = 0
                local ability = false
                for source in pairs(found[key]) do
                    if source == "Faehigkeit" then ability = true
                    elseif source:sub(1, 5) == "Volk:" then races = races + 1 end
                end
                chunk[#chunk + 1] = key ..
                    " [" .. (ability and "F" or "") .. (races > 0 and ("/V" .. races) or "") .. "]"
            else
                chunk[#chunk + 1] = key
            end
        end
        notify(table.concat(chunk, ", "))
    end
end

local function status()
    local db = addon.db
    notify("Text " .. db.textChance .. "% | Cooldown " .. db.cooldown ..
        "s | Volkstexte " .. db.racialTextChance .. "%")
    notify("Sprache " .. db.outputLanguage .. " | Kanal " .. db.chatChannel)
    notify("Ambient " .. (db.ambientEnabled and "an" or "aus") ..
        " | Chance " .. db.ambientChance .. "% | Intervall " ..
        db.ambientMinInterval .. "-" .. db.ambientMaxInterval .. "s" ..
        " | Kampf " .. (db.ambientInCombat and "an" or "aus"))
end

local function debug()
    local _, class = UnitClass("player")
    local _, race = UnitRace("player")
    local data = addon.localeData[addon.db.outputLanguage] or addon.localeData.deDE
    local count = 0
    for key in pairs((data and data.texts) or {}) do count = count + 1 end
    notify("Bereit=" .. tostring(addon.ready) ..
        " | Klasse=" .. tostring(class) .. " | Volk=" .. tostring(race))
    notify("Katalog=" .. count .. " | DB=" .. type(addon.db) ..
        " | RPChatMod=" .. tostring(type(_G.RPChatMod) == "table") ..
        " | Ambient vorgemerkt=" .. tostring(addon.HasPendingAmbient and addon.HasPendingAmbient()))
    notify("Cooldown verbleibend=" .. math.floor(addon.CooldownRemaining() or 0) .. "s")
end

local function ambient(arguments)
    local action, tail = arguments:match("^(%S+)%s*(.-)$")
    action = action and action:lower() or "test"
    tail = tail or ""
    if action == "test" and tail == "" then
        if not addon.TryAmbient(nil, true) then
            notify("Ambient derzeit blockiert (Klasse, Kampf, Cooldown oder Textchance).")
        end
    elseif (action == "on" or action == "off") and tail == "" then
        addon.db.ambientEnabled = action == "on"
        addon.ResetAmbientTimer()
        notify("Automatisches Ambient: " .. (addon.db.ambientEnabled and "an" or "aus"))
    elseif action == "status" and tail == "" then
        status()
    elseif action == "chance" then
        local n = integer(tail, 100)
        if not n then notify("Benutzung: /prrp ambient chance 0-100"); return end
        addon.db.ambientChance = n
        notify("Ambient-Chance: " .. n .. "%")
    elseif action == "combat" and (tail == "on" or tail == "off") then
        addon.db.ambientInCombat = tail == "on"
        notify("Ambient im Kampf: " .. tail)
    elseif action == "interval" then
        local a, b = tail:match("^(%d+)%s+(%d+)$")
        local min, max = integer(a, 7200, 30), integer(b, 7200, 30)
        if not min or not max or min > max then
            notify("Benutzung: /prrp ambient interval MIN MAX (30-7200s)")
            return
        end
        addon.db.ambientMinInterval, addon.db.ambientMaxInterval = min, max
        addon.ResetAmbientTimer()
        notify("Ambient-Intervall: " .. min .. "-" .. max .. "s")
    else
        notify("/prrp ambient [test|on|off|status|chance 0-100|combat on/off|interval MIN MAX]")
    end
end

local function help()
    notify("/prrp help | status | debug | list [racial|all]")
    notify("/prrp <SCHLUESSEL> (z.B. POWER_WORD_SHIELD), /prrp ambient [test|on|off|status]")
    notify("/prrp chance 0-100 | cooldown 0-3600 | racial 0-100")
    notify("/prrp ambient chance 0-100 | combat on/off | interval MIN MAX")
    notify("/prrp language deDE|enUS|frFR")
    notify("/prrp channel SAY|YELL|AUTO|PARTY|RAID|INSTANCE_CHAT")
    notify("*...* sind /me-Emotes. Passive Talenttexte nur per /prrp, nicht per /cast.")
end

SlashCmdList["PRIESTERRP"] = function(message)
    local input = (message or ""):match("^%s*(.-)%s*$")
    local command, arg = input:match("^(%S+)%s*(.-)%s*$")
    command, arg = command and command:lower() or "help", arg or ""
    if not addon.ready or type(addon.db) ~= "table" then notify("Noch nicht initialisiert."); return end
    if command == "help" or command == "?" then help()
    elseif command == "status" then status()
    elseif command == "debug" then debug()
    elseif command == "list" then listKeys(arg:lower())
    elseif command == "ambient" then ambient(arg)
    elseif command == "language" then
        local lang = languages[arg:lower()]
        if not lang then notify("Benutzung: /prrp language deDE|enUS|frFR"); return end
        addon.db.outputLanguage = lang
        notify("Textsprache: " .. lang)
    elseif command == "channel" then
        local ch = arg:upper()
        if not channels[ch] then notify("Ungueltiger Kanal."); return end
        addon.db.chatChannel = ch
        notify("Kanal: " .. ch .. " (Emotes bleiben /me)")
    elseif command == "chance" or command == "cooldown" or command == "racial" then
        local limit = command == "cooldown" and 3600 or 100
        local n = integer(arg, limit)
        if not n then notify("Benutzung: /prrp " .. command .. " 0-" .. limit); return end
        local field = command == "chance" and "textChance" or
            (command == "cooldown" and "cooldown" or "racialTextChance")
        addon.db[field] = n
        if field == "textChance" and n == 0 then addon.ResetAmbientTimer() end
        notify(field .. ": " .. n)
    else
        local key = input:upper()
        if not (addon.localeData.deDE.texts or {})[key] then
            notify("Unbekannter Faehigkeits-Schluessel: " .. key .. " (/prrp list)")
            return
        end
        addon.TryText(key)
    end
end
