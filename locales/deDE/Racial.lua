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

-- Editorial expansion: fewer repeated gestures, clearer dwarven priest voice.
for _, line in ipairs({
    "Ich habe schon Stollen abgestützt, die aussichtsloser waren. Haltet durch.",
    "*legt beide Hände um das heilige Symbol und spricht leise den Namen eines Ahnen.*",
    "Ein Gebet ist kein Werkzeug. Doch manchmal hält es länger als ein eiserner Nagel.",
}) do table.insert(voices.DWARF.H, line) end
for _, line in ipairs({
    "Licht im Herzen, Staub auf den Stiefeln. So dienen wir den Lebenden.",
    "*wischt die Hände am Mantel ab und richtet das schlichte Symbol an der Brust.*",
}) do table.insert(voices.DWARF.D, line) end
for _, line in ipairs({
    "Unter den Bergen liegt tiefe Finsternis. Ich bin ihr schon einmal begegnet.",
    "*verstummt, als wäre ein fernes Hämmern tief im Fels zu hören.*",
}) do table.insert(voices.DWARF.S, line) end

-- Spell-specific racial voices; school-based pools remain the fallback.
-- These entries are deliberately target-neutral and use *...* for /me.
local specificVoices = {
    DWARF = {
        POWER_WORD_SHIELD = { "Hinter diesem Schutz steht ein Zwerg. Das ist mehr wert als bloßer Stein.", "*zieht mit dem Daumen ein leuchtendes Schutzzeichen auf die Schildkante.*", "Der nächste Schlag gehört mir, nicht Euch.", "*stellt sich fest hin und lässt einen goldenen Schimmer über den Gefährten gleiten.*" },
        RENEW = { "Eine Wunde heilt nicht schneller, nur weil man sie anschreit.", "*wechselt den Verband und murmelt dabei einen alten Segensspruch.*", "Ganz ruhig. Selbst ein Berg wächst nicht an einem Tag.", "*legt die schwielige Hand vorsichtig auf die Schulter des Verletzten.*" },
        SHADOW_WORD_PAIN = { "Unter dem Berg gibt es Dunkelheit, die keine Fackel vertreibt.", "*reibt eine schwarze Staubspur zwischen Daumen und Zeigefinger.*", "Manche Worte wiegen schwerer als Erz.", "*spricht ein einziges raues Wort, während der eigene Schatten tiefer wird.*" },
        RESURRECTION = { "Ihr habt hier noch Freunde. Die Ahnen müssen warten.", "*kniet nieder und legt das heilige Symbol neben die reglose Hand.*", "Kommt zurück. Die Geschichte ist noch nicht zu Ende erzählt.", "*spricht die Namen der Ahnen, einen nach dem anderen, in das stille Licht.*" },
    },
    GNOME = {
        POWER_WORD_SHIELD = { "Schutzfeld stabil. Dass es aus Glauben besteht, ist eine technische Einzelheit.", "*zeichnet rasch einen Kreis und misst seine Leuchtkraft mit einer winzigen Linse.*", "Keine Sorge, die Konstruktion hält. Zumindest laut meiner Rechnung.", "*tippt auf ein kleines Messgerät, während eine schimmernde Hülle entsteht.*" },
        RENEW = { "Das ist keine Sofortreparatur. Das ist sorgfältige Wartung am lebenden Objekt.", "*beobachtet konzentriert, wie das Licht die Wundränder schließt.*", "Eine kleine Dosis Hoffnung, gleichmäßig verteilt.", "*zeichnet mehrere winzige Heilzeichen wie Punkte in einem Diagramm.*" },
        SHADOW_WORD_PAIN = { "Interessant. Der Schatten reagiert sogar auf schlechte Gedanken.", "*schreibt hastig ein Warnzeichen auf den Rand seiner Notizen.*", "Ich sollte diese Formel nicht laut vor dem Frühstück testen.", "*richtet die Brille und lässt ein dunkles Flimmern von der Fingerspitze gleiten.*" },
        RESURRECTION = { "Ein Neustart ist möglich. Diesmal bitte ohne unerwartetes Herunterfahren.", "*legt zwei Finger an die Stirn des Gefallenen und zählt leise mit.*", "Zurück ins Leben. Ich kann die Methode später erklären.", "*hält den Atem an, als der erste Lichtfunke die Stille durchbricht.*" },
    },
    UNDEAD = {
        POWER_WORD_SHIELD = { "Ich habe keinen Herzschlag mehr. Trotzdem schütze ich die Euren.", "*zieht mit knochigen Fingern einen hellen Kreis vor den Gefährten.*", "Das Licht und ich haben eine komplizierte Beziehung. Es hilft trotzdem.", "*betrachtet die goldene Schutzhaut mit einem trockenen Lächeln.*" },
        RENEW = { "Die Lebenden heilen so bereitwillig. Faszinierend.", "*legt zwei kühle Finger an die Wunde und beobachtet die Regeneration.*", "Behaltet Euren Puls. Er steht Euch ausgezeichnet.", "*zieht die ausgefranste Stola zurecht und spricht einen überraschend sanften Segen.*" },
        SHADOW_WORD_PAIN = { "Der Schatten kennt meinen Namen. Ich habe ihm Euren beigebracht.", "*öffnet die Hand, aus der ein dunkler Faden in die Luft steigt.*", "Ihr nennt es einen Fluch. Ich nenne es alte Bekanntschaft.", "*lauscht einen Moment einer Stimme, die sonst niemand hört.*" },
        RESURRECTION = { "Zurückkommen ist möglich. Glaubt mir, ich spreche aus Erfahrung.", "*kniet neben dem Gefallenen und sieht einen Moment auf die eigenen Hände.*", "Diesmal könnt Ihr Euch das Grab ersparen.", "*richtet das heilige Symbol auf und lässt warmes Licht über die Stille fallen.*" },
    },
}
for race, spells in pairs(specificVoices) do
    local abilities = pools[race]
    if abilities then
        for key, variants in pairs(spells) do
            if addon.spellGroups[key] then
                abilities[key] = variants
            end
        end
    end
end
