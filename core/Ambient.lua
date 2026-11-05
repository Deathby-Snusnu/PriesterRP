-- SPDX-License-Identifier: MPL-2.0
-- Timers only QUEUE ambient RP. Chat is sent on a player-triggered action.
local _, addon = ...
local generation = 0
local pending = false

local function isPriest()
    local _, class = UnitClass("player")
    return class == "PRIEST"
end

local function combatAllowed()
    return addon.db.ambientInCombat or type(UnitAffectingCombat) ~= "function"
        or not UnitAffectingCombat("player")
end

function addon.HasPendingAmbient()
    return pending
end

function addon.QueueAmbient()
    if not addon.ready or not addon.db or not isPriest() or not addon.db.ambientEnabled then
        return false
    end
    if addon.db.textChance <= 0 or not combatAllowed() or math.random(100) > addon.db.ambientChance then
        return false
    end
    pending = true
    return true
end

function addon.FlushPendingAmbient(chancePassed)
    if not pending or not addon.ready or not addon.db then return false end
    if not addon.db.ambientEnabled or addon.db.textChance <= 0 then
        pending = false
        return false
    end
    if not isPriest() or not combatAllowed() or not addon.CooldownReady() then
        return false
    end
    if not chancePassed then return false end
    -- Consume the pending event before sending: a failed send must not spam.
    pending = false
    local line = addon.BuildAmbient()
    if line and addon.SendText(line) then
        addon.StartCooldown()
        return true
    end
    return false
end

function addon.TryAmbient(_, force)
    -- Manual /prrp ambient is available even if automatic ambient is disabled.
    if force == nil then force = true end
    if not addon.ready or not addon.db or not isPriest() then return false end
    if not force then return addon.QueueAmbient() end
    if not combatAllowed() or not addon.CooldownReady() then return false end
    if math.random(100) > addon.db.textChance then return false end
    local line = addon.BuildAmbient()
    if line and addon.SendText(line) then
        addon.StartCooldown()
        return true
    end
    return false
end

function addon.ResetAmbientTimer()
    generation = generation + 1
    pending = false
    local token = generation
    if not addon.ready or not addon.db or not addon.db.ambientEnabled then return end
    if not C_Timer or type(C_Timer.After) ~= "function" then return end
    local min = math.floor(addon.db.ambientMinInterval or 180)
    local max = math.floor(addon.db.ambientMaxInterval or 420)
    if min < 30 then min = 30 end
    if max < min then max = min end

    local function schedule()
        local delay = math.random(min, max)
        C_Timer.After(delay, function()
            if token ~= generation or not addon.db.ambientEnabled then return end
            addon.QueueAmbient() -- Never SendChatMessage in a timer callback.
            if token == generation and addon.db.ambientEnabled then schedule() end
        end)
    end
    schedule()
end
