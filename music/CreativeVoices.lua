-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additional original, non-music class dialogue and emotes.
local _, addon = ...
local entries = {
    RENEW = { deDE = { "Ich kann nicht jeden Schmerz nehmen. Aber ich kann ein wenig Hoffnung lassen.", "*legt die Hand auf die Wunde und wartet auf ruhigeres Atmen.*" }, enUS = { "I cannot take every pain away. But I can leave a little hope.", "*rests a hand on the wound and waits for calmer breathing.*" }, frFR = { "Je ne peux ôter toute douleur. Mais je peux laisser un peu d'espoir.", "*pose la main sur la blessure et attend un souffle plus calme.*" } },
    RESURRECTION = { deDE = { "Noch ist ein Platz am Feuer für Euch frei.", "*hält die Hand offen, als erwarte er eine Antwort.*" }, enUS = { "There is still a place by the fire for you.", "*holds out an open hand, waiting for an answer.*" }, frFR = { "Une place près du feu vous attend encore.", "*tend la main ouverte dans l'attente d'une réponse.*" } },
    SHADOW_WORD_PAIN = { deDE = { "Wer zu lange in Schatten schaut, erkennt irgendwann die eigenen.", "*zeichnet eine dunkle Linie in die Luft und lässt sie verschwinden.*" }, enUS = { "Look into shadows long enough and you will find your own.", "*draws a dark line in the air and lets it fade.*" }, frFR = { "À trop fixer les ombres, on finit par voir la sienne.", "*trace une ligne sombre dans l'air et la laisse disparaître.*" } },
    CONFESSION = { deDE = { "Ich bin hier, um zuzuhören. Nicht, um Eure Geschichte umzuschreiben.", "*rückt einen Stuhl näher und schweigt aufmerksam.*" }, enUS = { "I am here to listen, not rewrite your story.", "*draws a chair closer and listens in silence.*" }, frFR = { "Je suis là pour écouter, pas pour réécrire votre histoire.", "*rapproche une chaise et écoute en silence.*" } },
}
for key, translations in pairs(entries) do
    for _, language in ipairs({"deDE","enUS","frFR"}) do
        local locale = addon.localeData and addon.localeData[language]
        local source = locale and locale.texts and locale.texts[key]
        local pool = source and source.gruppe
        if type(pool) == "table" then
            for _, line in ipairs(translations[language]) do
                local exists = false
                for _, old in ipairs(pool) do if old == line then exists = true; break end end
                if not exists then pool[#pool+1] = line end
            end
        end
    end
end
