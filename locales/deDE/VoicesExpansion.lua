-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additive, original priest spell and ambient voices; no event handlers.
local _, addon = ...
local root = addon.localeData.deDE
local function add(existing, texts)
    if type(existing) ~= "table" then return end
    for _, line in ipairs(texts) do
        local found = false
        for _, old in ipairs(existing) do if old == line then found = true; break end end
        if not found then existing[#existing + 1] = line end
    end
end
add(root.texts.RESURRECTION.gruppe, { "Das Licht kennt keinen leichten Abschied. Wir versuchen es noch einmal.", "*kniet nieder und legt beide Hände ruhig über die gefallene Gestalt.*" })
add(root.texts.RENEW.gruppe, { "Heilung ist manchmal kein Sturm, sondern ein beharrlicher Tropfen.", "*zeichnet einen sanften Kreis aus Licht, der noch einen Augenblick nachglimmt.*" })
add(root.texts.POWER_WORD_SHIELD.gruppe, { "Für diesen Augenblick soll Euch die Gefahr nicht erreichen.", "*breitet die Hände aus, bis eine schimmernde Schutzschicht Form annimmt.*" })
add(root.texts.SHADOW_WORD_PAIN.gruppe, { "Auch Schatten kennen ein Gedächtnis. Sie vergessen keinen Schwur.", "*flüstert eine dunkle Silbe, deren Echo gegen das Licht drängt.*" })
add(root.texts.FADE.gruppe, { "Nicht jeder Schatten verlangt einen Kampf. Manchmal genügt Stille.", "*senkt den Blick, bis die eigene Silhouette mit dem Halbdunkel verschmilzt.*" })
add(root.ambient.DWARF, { "Bei meinen Ahnen, ein Gebet hält länger als der schönste Helm.", "*legt das heilige Zeichen behutsam neben einen abgegriffenen Stein.*" })
add(root.ambient.NIGHTELF, { "Elune spricht nicht lauter, nur weil wir ängstlich sind.", "*beobachtet das Mondlicht, bis die Gedanken ruhiger werden.*" })
add(root.ambient.UNDEAD, { "Der Glaube hat warme Worte. Meine Hände leider nicht.", "*richtet eine schiefe Kerze auf und betrachtet die kleine Flamme.*" })
