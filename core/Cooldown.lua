-- SPDX-License-Identifier: MPL-2.0
-- Shared text cooldown: only successful chat output starts it.
local _, addon = ...
local nextAllowed = 0

function addon.CooldownReady()
    return addon.ready and addon.db and GetTime() >= nextAllowed
end

function addon.StartCooldown()
    nextAllowed = GetTime() + (addon.db.cooldown or 0)
end

function addon.CooldownRemaining()
    return math.max(0, nextAllowed - GetTime())
end
