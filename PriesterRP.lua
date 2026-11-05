-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
_G.PriesterRP = addon
addon.ready = false

local function isPriest()
    local _, class = UnitClass("player")
    return class == "PRIEST"
end

function addon.TryText(key)
    if not addon.ready or not addon.db or not isPriest() then return false end
    if type(key) ~= "string" or key == "" then return false end
    if not addon.CooldownReady() then return false end
    local chancePassed = addon.db.textChance > 0
        and math.random(100) <= addon.db.textChance
    -- An ambient reminder never sends from the timer. The next player
    -- RP action can send it instead of the requested ability line.
    if addon.FlushPendingAmbient and addon.FlushPendingAmbient(chancePassed) then return true end
    if not chancePassed then return false end
    local line = addon.BuildText(key:upper())
    if not line or not addon.SendText(line) then return false end
    addon.StartCooldown()
    return true
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    addon.InitializeDatabase()
    addon.ready = true
    if addon.ResetAmbientTimer then addon.ResetAmbientTimer() end
    print("|cffffaa55PriesterRP 0.1.0 geladen.|r /prrp help")
end)
