-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additive, original priest spell and ambient voices; no event handlers.
local _, addon = ...
local root = addon.localeData.frFR
local function add(existing, texts)
    if type(existing) ~= "table" then return end
    for _, line in ipairs(texts) do
        local found = false
        for _, old in ipairs(existing) do if old == line then found = true; break end end
        if not found then existing[#existing + 1] = line end
    end
end
add(root.texts.RESURRECTION.gruppe, { "La Lumière n'allège pas les adieux. Essayons encore une fois.", "*s'agenouille et tient calmement les mains au-dessus du corps tombé.*" })
add(root.texts.RENEW.gruppe, { "La guérison n'est parfois pas un orage, mais une pluie patiente.", "*dessine un doux cercle de Lumière qui persiste un instant.*" })
add(root.texts.POWER_WORD_SHIELD.gruppe, { "Pour cet instant, que le danger ne vous atteigne pas.", "*écarte les mains jusqu'à former une protection scintillante.*" })
add(root.texts.SHADOW_WORD_PAIN.gruppe, { "Même les ombres ont une mémoire. Elles n'oublient aucun serment.", "*murmure une sombre syllabe dont l'écho défie la Lumière.*" })
add(root.texts.FADE.gruppe, { "Toute ombre ne réclame pas un combat. Parfois, le silence suffit.", "*baisse les yeux jusqu'à fondre sa silhouette dans la pénombre.*" })
add(root.ambient.DWARF, { "Par mes ancêtres, une prière dure plus longtemps qu'un beau casque.", "*pose doucement son symbole sacré près d'une pierre usée.*" })
add(root.ambient.NIGHTELF, { "Élune ne parle pas plus fort simplement parce que nous avons peur.", "*observe la lune jusqu'à retrouver des pensées paisibles.*" })
add(root.ambient.UNDEAD, { "La foi a des paroles chaleureuses. Mes mains, malheureusement, non.", "*redresse une bougie de travers et contemple sa petite flamme.*" })
