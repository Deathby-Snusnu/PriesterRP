# PriesterRP 0.1.0
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
