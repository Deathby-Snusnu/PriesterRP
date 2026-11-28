-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additive, original priest spell and ambient voices; no event handlers.
local _, addon = ...
local root = addon.localeData.enUS
local function add(existing, texts)
    if type(existing) ~= "table" then return end
    for _, line in ipairs(texts) do
        local found = false
        for _, old in ipairs(existing) do if old == line then found = true; break end end
        if not found then existing[#existing + 1] = line end
    end
end
add(root.texts.RESURRECTION.gruppe, { "The Light does not make farewell easy. Let us try once more.", "*kneels and holds both hands calmly above the fallen form.*" })
add(root.texts.RENEW.gruppe, { "Healing is sometimes not a storm, but a patient drop of rain.", "*draws a gentle circle of Light that lingers for a moment.*" })
add(root.texts.POWER_WORD_SHIELD.gruppe, { "For this one moment, may danger not reach you.", "*spreads both hands until a shimmering ward takes shape.*" })
add(root.texts.SHADOW_WORD_PAIN.gruppe, { "Even shadows have memory. They forget no vow.", "*whispers a dark syllable whose echo presses against the Light.*" })
add(root.texts.FADE.gruppe, { "Not every shadow calls for a fight. Sometimes silence will do.", "*lowers the gaze until the silhouette blends into dusk.*" })
add(root.ambient.DWARF, { "By my ancestors, a prayer lasts longer than the finest helmet.", "*places a holy symbol carefully beside a weathered stone.*" })
add(root.ambient.NIGHTELF, { "Elune does not speak louder just because we fear the dark.", "*watches the moonlight until thoughts grow quiet.*" })
add(root.ambient.UNDEAD, { "Faith has warm words. My hands, unfortunately, do not.", "*straightens a crooked candle and studies its little flame.*" })
