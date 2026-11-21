-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Original RP voice texts, with musical inspiration metadata only.
local _, addon = ...
addon.musicRP = { deDE = {}, enUS = {}, frFR = {} }
addon.musicRPReferences = {}
addon.musicRPReferences.RENEW = { artist = "Alphaville", song = "Forever Young" }
addon.musicRP.deDE.RENEW = { "Ewige Jugend verspreche ich nicht. Aber einen neuen Morgen.", "*lässt einen warmen Lichtschimmer langsam über die Wunde ziehen.*" }
addon.musicRP.enUS.RENEW = { "I cannot promise eternal youth. But perhaps another morning.", "*lets a warm shimmer of light drift across the wound.*" }
addon.musicRP.frFR.RENEW = { "Je ne promets pas la jeunesse éternelle. Mais un nouveau matin.", "*laisse une douce lumière glisser sur la blessure.*" }
addon.musicRPReferences.RESURRECTION = { artist = "Guns N' Roses", song = "Coma" }
addon.musicRP.deDE.RESURRECTION = { "Falls Ihr mich hört, ist Eure Geschichte noch nicht zu Ende.", "*kniet still und wartet auf den ersten Atemzug.*" }
addon.musicRP.enUS.RESURRECTION = { "If you can hear me, your story is not over.", "*kneels silently, waiting for the first breath.*" }
addon.musicRP.frFR.RESURRECTION = { "Si vous m'entendez, votre histoire n'est pas finie.", "*s'agenouille en silence et attend le premier souffle.*" }
addon.musicRPReferences.POWER_WORD_SHIELD = { artist = "U2", song = "One" }
addon.musicRP.deDE.POWER_WORD_SHIELD = { "Wir müssen nicht dieselben Wege gehen, um einander beizustehen.", "*zeichnet einen ruhigen Kreis aus schützendem Licht.*" }
addon.musicRP.enUS.POWER_WORD_SHIELD = { "We need not walk identical roads to stand together.", "*draws a quiet circle of protective light.*" }
addon.musicRP.frFR.POWER_WORD_SHIELD = { "Nos chemins peuvent différer et nos mains rester unies.", "*trace un cercle paisible de lumière protectrice.*" }
addon.musicRPReferences.SHADOW_WORD_PAIN = { artist = "Black Sabbath", song = "Paranoid" }
addon.musicRP.deDE.SHADOW_WORD_PAIN = { "Nicht jedes Grauen kommt von außen.", "*lässt einen schmalen Schatten zwischen den Fingern fließen.*" }
addon.musicRP.enUS.SHADOW_WORD_PAIN = { "Not every terror comes from outside.", "*lets a narrow shadow slip between the fingers.*" }
addon.musicRP.frFR.SHADOW_WORD_PAIN = { "Toutes les terreurs ne viennent pas de l'extérieur.", "*laisse une fine ombre couler entre ses doigts.*" }
addon.musicRPReferences.CONFESSION = { artist = "Annie Lennox", song = "Why" }
addon.musicRP.deDE.CONFESSION = { "Es gibt Fragen, die wir erst stellen können, wenn jemand zuhört.", "*senkt den Blick und wartet geduldig auf eine Antwort.*" }
addon.musicRP.enUS.CONFESSION = { "Some questions can only be asked when someone listens.", "*lowers the gaze and waits patiently for an answer.*" }
addon.musicRP.frFR.CONFESSION = { "Certaines questions exigent d'abord une oreille attentive.", "*baisse les yeux et attend patiemment une réponse.*" }
addon.musicRPReferences.MEDITATION = { artist = "Pink Floyd", song = "Time" }
addon.musicRP.deDE.MEDITATION = { "Die Zeit lehrt uns nicht von selbst. Wir müssen auch zuhören.", "*legt die Hände ruhig auf die Knie und atmet langsam.*" }
addon.musicRP.enUS.MEDITATION = { "Time does not teach us by itself. We must also listen.", "*rests both hands on the knees and breathes slowly.*" }
addon.musicRP.frFR.MEDITATION = { "Le temps ne nous instruit pas seul. Il faut aussi l'écouter.", "*pose les mains sur les genoux et respire lentement.*" }

function addon.ChooseMusicText(key)
    local db = addon.db
    if not db or not db.musicEnabled or (db.musicChance or 0) <= 0 then return nil end
    if math.random(100) > db.musicChance then return nil end
    local language = db.outputLanguage or "deDE"
    local texts = addon.musicRP[language] and addon.musicRP[language][key]
    if not texts then texts = addon.musicRP.deDE[key] end
    if type(texts) ~= "table" or #texts == 0 then return nil end
    return texts[math.random(#texts)]
end
