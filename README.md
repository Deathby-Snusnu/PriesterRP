## 0.1.3: Mehrsprachige Zauber- und Ambient-Stimmen (Entwurf)

In der nächsten Entwicklungsstufe der RP-AddOn-Familie ergänzt `locales/<Sprache>/VoicesExpansion.lua` die bestehenden Textpools **additiv** in `deDE`, `enUS` und `frFR`. Die neue Datei wird erst nach `Texts.lua` und `Ambient.lua` geladen, damit die Tabellen bereits existieren. Eigene Textänderungen bleiben erhalten.

- Fünf Kernfähigkeiten: `RESURRECTION`, `RENEW`, `POWER_WORD_SHIELD`, `SHADOW_WORD_PAIN`, `FADE`. Je Fähigkeit kommen eine gesprochene Variante und eine beschreibende `*...*`-Geste pro Sprache hinzu.
- Drei charakteristische Volk-Ambient-Pools: Zwerge, Nachtelfen, Untote. Je Volk eine neue gesprochene Variante und ein `*...*`-Emote pro Sprache.
- Insgesamt 16 neue Originalzeilen pro Sprache beziehungsweise 48 über die drei Sprachfassungen.
- Keine neuen Event-Listener, keine automatischen Buff-Danksagungen, keine geschützten WoW-UI-Funktionen. Die bestehende Entscheidung über `/say` und `/me` bleibt beim jeweiligen Klassen-AddOn.
- Test: `tests/test_voices_expansion_20261128.py` prüft Schlüssel, Laden, Rassen, Sprachparität und Textlängen. Vor Ingame-Veröffentlichung CI und praktische Tests ausführen.

**Versionspflege:** Die TOC ist für diese Entwicklung auf `0.1.3` gestellt. Dies ist noch kein Release; RPTextStudio und RPAddOns müssen beim späteren Merge/Update die neuen Dateien und diese Version berücksichtigen.

## MusicRP 0.1.2 und kreative Textüberarbeitung

Sechs optional abrufbare Songmotive und vier zusätzliche allgemeine Fähigkeiten-Pools mit selbst verfassten `/say`- und `/me`-Varianten in **deDE**, **enUS**, **frFR**. Songtitel sind nur interne Inspirations-Metadaten, keine reproduzierten Lyrics. Persönliche Texte, vorhandene Rassen- und Standardpools werden nicht überschrieben.

```text
/prrp music on
/prrp music chance 15
/prrp music status
/prrp music off
```

MusicRP ist standardmäßig deaktiviert. Die bestehenden Cooldown- und Chatregeln bleiben wirksam. Die TOC enthält die neue Versionsnummer **0.1.2** sowie die Runtime-Dateien `music/CreativeVoices.lua` und `music/MusicRP.lua`. RPTextStudio erkennt neuere Versionen im Development-Kanal nach Merge auf `main`; für Stable muss ein GitHub-Release `v0.1.2` mit passender TOC veröffentlicht werden. Vor Updates lokale Textanpassungen sichern und die Vorschau prüfen.

# PriesterRP 0.1.1

## Neue manuelle RP-Aktionen (0.1.1)

6 ergänzende Textaktionen sind in DE/EN/FR verfügbar:
- `BEDSIDE_PRAYER`
- `SHRINE_VIGIL`
- `CONFESSION`
- `LAST_RITES`
- `MEDITATION`
- `SHADOW_REFLECTION`

Die vorhandenen Fähigkeiten und Völkervarianten bleiben unverändert;
die neuen Schlüssel sind ausdrücklich manuelle Rollenspielaktionen und
werden nicht automatisch durch Spielereignisse ausgelöst.

Eigenständiges WoW-Forever-Rollenspiel-AddOn für Priesterinnen und Priester. Dieses Repository wird als eigenständige Quelle für das RPAddOns-Submodul geführt.

## Installation
`PriesterRP` (dieses Repository) nach `<WoW>/Interface/AddOns/PriesterRP` kopieren. Die Datei `PriesterRP.toc` muss unmittelbar im Ordner liegen. Die Interface-Angabe `16001` richtet sich an WoW Forever; die Ingame-Lauffähigkeit bleibt zu testen. KriegerRP und die anderen Klassen bleiben unabhängig.

## Befehle
- `/prrp help` oder `/priester help`: Anleitung
- `/prrp list`, `/prrp list racial`, `/prrp list all`: 56 Schlüssel bzw. Volkstexte anzeigen
- `/prrp RENEW`, `/prrp POWER_WORD_SHIELD`, `/prrp SHADOW_WORD_PAIN`: RP-Text für Fähigkeit
- `/prrp chance 0-100`, `/prrp cooldown 0-3600`, `/prrp racial 0-100`
- `/prrp language deDE|enUS|frFR`, `/prrp channel SAY|YELL|AUTO|PARTY|RAID|INSTANCE_CHAT`
- `/prrp ambient on|off|test|status`, `/prrp ambient chance 0-100`, `/prrp ambient combat on|off`, `/prrp ambient interval MIN MAX`

Die RP-Kommandos **wirken keine echten Zauber**. Für Makros `/cast <Zaubername>` und anschließend `/prrp <SCHLUESSEL>` verwenden. Texte bestätigen niemals den tatsächlichen Erfolg eines Casts. `LIGHTWELL_RENEW` ist kein direkt wirkbarer Priesterzauber, sondern ein gesonderter RP-Schlüssel.

## Sicherheit und Laufzeit
- Priester-Only: `UnitClass("player") == "PRIEST"`; Klassenwechsel/RP aus anderem AddOn beeinflussen sich nicht.
- Freundliche Ziele werden ausschließlich bei expliziten Heil-/Schutzschlüsseln eingesetzt; Gegner ausschließlich bei gerichteten Angriffen.
- Gesprochene Texte gehen über den gewählten Chatkanal; mit `*...*` markierte Handlungen ausschließlich als `/me`.
- Chatnachrichten sind auf 255 Bytes begrenzt und dürfen keine Zeilenumbrüche oder Chat-Markup enthalten.
- Während der Ambient-Timer läuft, wird **kein Chat** versendet. Er markiert nur einen möglichen Ambient-Text zur nächsten bewussten RP-Aktion.
- Neue Charaktere erhalten 30 % Textchance, 20 s Cooldown, 40 % Volkstexte und Ambient-Intervall 180–420 s. Bestehende gespeicherte Einstellungen bleiben erhalten.
- Kein externes AddOn zwingend notwendig. RPChatMod wird lediglich optional für Volkssprachen benutzt.

## Fähigkeiten
Die `locales/Init.lua` führt die 56 Keys aus Disziplin, Heilig und Schatten einschließlich klassenspezifischer Talente und Volksfähigkeiten. Die Einträge wurden mit dem Forever-Zauberbuch (Build 1.60.1.70790) abgeglichen: https://foreverchanges.pro/spellbook/priest . Die Verfügbarkeit eines bestimmten Talents oder Volkszaubers ist charakterabhängig. Texte bilden keine Cast-Erkennung.

## Entwicklung
`python -m unittest discover -s tests -p "test_*.py" -v` und `lua tests/test_runtime.lua` (Lua 5.1 oder 5.4). Ein manueller WoW-Clienttest der Slash-Befehle, Chat-Ausgabe, Ambient und SavedVariables ist erforderlich.

## Lizenz
Lua-Code und Tests MPL-2.0 (`LICENSE-CODE`); kreative RP-Texte CC BY-SA 4.0 (`LICENSE-TEXTS`). Siehe `LICENSING.md` und `NOTICE`.

## Repository-Einbindung

Dieses Repository liegt als eigenständiges Git-Submodul unter `RPAddOns/addons/PriesterRP`. Zum Abrufen aus dem Sammelprojekt: `git submodule update --init --recursive`. Das eigenständige Repository enthält ausschließlich die Quellen von PriesterRP.
