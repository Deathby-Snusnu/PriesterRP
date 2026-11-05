-- SPDX-License-Identifier: CC-BY-SA-4.0
local _, addon = ...
local voices = {
    DWARF = {
        D = { "Bei meinen Ahnen, der Glaube trägt auch ohne Helm.", "*klopft mit den Knöcheln gegen das heilige Symbol*", "*murmelt ein raues Gebet zwischen zusammengebissenen Zähnen*" },
        H = { "Der Berg steht still. Das Licht in mir nicht.", "*klopft mit den Knöcheln gegen das heilige Symbol*", "*murmelt ein raues Gebet zwischen zusammengebissenen Zähnen*" },
        S = { "Wer die Tiefe kennt, erschrickt nicht vor Schatten.", "*klopft mit den Knöcheln gegen das heilige Symbol*", "*murmelt ein raues Gebet zwischen zusammengebissenen Zähnen*" },
    },
    GNOME = {
        D = { "Ich habe das Wunder nachgemessen. Es widerspricht jeder Gleichung.", "*richtet seine Brille und prüft eine leuchtende Skizze*", "*notiert verwundert eine unerklärliche Beobachtung*" },
        H = { "Ein bisschen Heilung, ein bisschen Feldforschung.", "*richtet seine Brille und prüft eine leuchtende Skizze*", "*notiert verwundert eine unerklärliche Beobachtung*" },
        S = { "Selbst die Dunkelheit hat messbare Grenzen. Vermutlich.", "*richtet seine Brille und prüft eine leuchtende Skizze*", "*notiert verwundert eine unerklärliche Beobachtung*" },
    },
    HUMAN = {
        D = { "Ein Eid ist nur so stark wie die Tat danach.", "*legt die Hand auf das Wappen am Herzen*", "*senkt kurz den Kopf und fasst neuen Mut*" },
        H = { "Ich bete nicht für Ruhm, sondern für die Heimkehr.", "*legt die Hand auf das Wappen am Herzen*", "*senkt kurz den Kopf und fasst neuen Mut*" },
        S = { "Wo Angst regiert, schulden wir einander Mut.", "*legt die Hand auf das Wappen am Herzen*", "*senkt kurz den Kopf und fasst neuen Mut*" },
    },
    NIGHTELF = {
        D = { "Unter Elunes Sternen ist selbst Schweigen ein Gebet.", "*zeichnet eine Mondsichel in die Luft*", "*lauscht dem Wind zwischen den Blättern*" },
        H = { "Der Mond schenkt Licht, ohne ein Wort zu verlangen.", "*zeichnet eine Mondsichel in die Luft*", "*lauscht dem Wind zwischen den Blättern*" },
        S = { "Auch ein langer Schatten wandert mit den Jahreszeiten.", "*zeichnet eine Mondsichel in die Luft*", "*lauscht dem Wind zwischen den Blättern*" },
    },
    DRAENEI = {
        D = { "Die Naaru lehrten Geduld. Sie erwähnten nicht, wie schwer sie ist.", "*berührt behutsam einen Kristall am Gewand*", "*neigt ehrfürchtig das Haupt zu einem fernen Klang*" },
        H = { "Ich habe Welten fallen sehen und dennoch Hoffnung bewahrt.", "*berührt behutsam einen Kristall am Gewand*", "*neigt ehrfürchtig das Haupt zu einem fernen Klang*" },
        S = { "Ein Schatten ist kein Ende. Er erinnert uns nur an die Richtung.", "*berührt behutsam einen Kristall am Gewand*", "*neigt ehrfürchtig das Haupt zu einem fernen Klang*" },
    },
    ORC = {
        D = { "Ehre ist nicht nur die Klinge, sondern auch die Hand, die sie senkt.", "*drückt die Faust an die Brust und grüßt die Ahnen*", "*steht schweigend und unbeugsam da*" },
        H = { "Auch Krieger brauchen jemanden, der ihre Wunden sieht.", "*drückt die Faust an die Brust und grüßt die Ahnen*", "*steht schweigend und unbeugsam da*" },
        S = { "Die Ahnen flüstern im Dunkeln und ich höre zu.", "*drückt die Faust an die Brust und grüßt die Ahnen*", "*steht schweigend und unbeugsam da*" },
    },
    TROLL = {
        D = { "Die Loa lachen selten über dieselben Dinge wie wir.", "*schüttelt einen kleinen Beutel mit Opfergaben*", "*zeichnet tanzend ein schiefes Zeichen in den Staub*" },
        H = { "Ich kenne einen Segen, aber der Loa verlangt eine Geschichte.", "*schüttelt einen kleinen Beutel mit Opfergaben*", "*zeichnet tanzend ein schiefes Zeichen in den Staub*" },
        S = { "Ein Schatten hat Zähne. Frag besser nicht, woher.", "*schüttelt einen kleinen Beutel mit Opfergaben*", "*zeichnet tanzend ein schiefes Zeichen in den Staub*" },
    },
    TAUREN = {
        D = { "Die Erdenmutter trägt auch jene, die ihren Weg verloren haben.", "*berührt ehrfürchtig die Erde mit der Handfläche*", "*atmet tief ein und lauscht den fernen Ebenen*" },
        H = { "Heilung wächst langsam, wie Gras nach dem Frost.", "*berührt ehrfürchtig die Erde mit der Handfläche*", "*atmet tief ein und lauscht den fernen Ebenen*" },
        S = { "Der Schatten einer Wolke ist kein Urteil über die Sonne.", "*berührt ehrfürchtig die Erde mit der Handfläche*", "*atmet tief ein und lauscht den fernen Ebenen*" },
    },
    UNDEAD = {
        D = { "Mein Glaube hat meinen Puls überlebt. Eine bemerkenswerte Leistung.", "*prüft ironisch, ob das eigene Herz noch schlägt*", "*richtet mit makabrem Ernst eine zerfaserte Stola*" },
        H = { "Heilen ist schwierig, wenn man anatomisch widersprüchlich ist.", "*prüft ironisch, ob das eigene Herz noch schlägt*", "*richtet mit makabrem Ernst eine zerfaserte Stola*" },
        S = { "Die Schatten sind alte Bekannte. Unangenehm gesprächig.", "*prüft ironisch, ob das eigene Herz noch schlägt*", "*richtet mit makabrem Ernst eine zerfaserte Stola*" },
    },
    BLOODELF = {
        D = { "Würde bedeutet, auch im Zweifel Haltung zu bewahren.", "*glättet sorgfältig eine Falte des prächtigen Gewands*", "*betrachtet mit kühler Aufmerksamkeit eine arkane Reflexion*" },
        H = { "Ein präziser Segen ist eine Kunstform.", "*glättet sorgfältig eine Falte des prächtigen Gewands*", "*betrachtet mit kühler Aufmerksamkeit eine arkane Reflexion*" },
        S = { "Schatten verraten gern, wer das Licht nur nachahmt.", "*glättet sorgfältig eine Falte des prächtigen Gewands*", "*betrachtet mit kühler Aufmerksamkeit eine arkane Reflexion*" },
    },
    HIGH_ELF = {
        D = { "Selbst im Exil findet das Licht einen Weg.", "*hebt ein schlichtes Amulett mit feiner Gravur*", "*verweilt einen Atemzug lang bei einer alten Erinnerung*" },
        H = { "Eine ruhige Hand heilt mehr als ein lauter Schwur.", "*hebt ein schlichtes Amulett mit feiner Gravur*", "*verweilt einen Atemzug lang bei einer alten Erinnerung*" },
        S = { "Erinnerungen werfen lange Schatten, auch nach Jahrhunderten.", "*hebt ein schlichtes Amulett mit feiner Gravur*", "*verweilt einen Atemzug lang bei einer alten Erinnerung*" },
    },
}
local pools = {}
for race, groups in pairs(voices) do
    local abilities = {}
    for key, school in pairs(addon.spellGroups) do
        abilities[key] = groups[school]
    end
    pools[race] = abilities
end
addon.localeData.deDE.racial = pools
