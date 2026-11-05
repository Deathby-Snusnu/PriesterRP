-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
addon.defaults = {
    textChance = 30, cooldown = 20, racialTextChance = 40,
    outputLanguage = "deDE", chatChannel = "SAY",
    ambientChance = 70, ambientEnabled = true, ambientInCombat = false,
    ambientMinInterval = 180, ambientMaxInterval = 420,
}
