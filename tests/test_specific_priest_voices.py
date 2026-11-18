"""Static checks for individually authored priest racial spell voices."""
import json
from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[1]
LOCALES = ("deDE", "enUS", "frFR")
RACES = ("DWARF", "GNOME", "UNDEAD")
SPELLS = ("POWER_WORD_SHIELD", "RENEW", "SHADOW_WORD_PAIN", "RESURRECTION")
ENTRY = re.compile(r'^        ([A-Z][A-Z0-9_]+) = \{ (.*?) \},$', re.M)
QUOTED = re.compile(r'"(?:\\.|[^"\\])*"')


class SpecificPriestVoicesTests(unittest.TestCase):
    def test_school_fallback_and_overrides_are_compatible(self):
        init = (ROOT / "locales" / "Init.lua").read_text(encoding="utf-8")
        for spell in SPELLS:
            self.assertIn(spell + ' = "', init)
        for locale in LOCALES:
            with self.subTest(locale=locale):
                src = (ROOT / "locales" / locale / "Racial.lua").read_text(encoding="utf-8")
                self.assertIn("for key, school in pairs(addon.spellGroups)", src)
                self.assertIn("abilities[key] = groups[school]", src)
                self.assertIn("local specificVoices = {", src)
                self.assertIn("abilities[key] = variants", src)
                # Overrides must be applied after the shared fallback pools are built.
                self.assertLess(src.index("abilities[key] = groups[school]"),
                                src.index("abilities[key] = variants"))
                tail = src.split("local specificVoices = {", 1)[1]
                self.assertEqual(len(re.findall(r'^    (?:DWARF|GNOME|UNDEAD) = \{$', tail, re.M)), 3)
                matches = ENTRY.findall(tail)
                self.assertEqual(len(matches), 12)
                self.assertEqual({name for name, _ in matches}, set(SPELLS))
                for race in RACES:
                    region = tail.split("    " + race + " = {", 1)[1].split("\n    },", 1)[0]
                    keys = [key for key, _ in ENTRY.findall(region)]
                    self.assertEqual(set(keys), set(SPELLS), race)
                    self.assertEqual(len(keys), 4, race)

    def test_text_and_emote_contract(self):
        for locale in LOCALES:
            with self.subTest(locale=locale):
                src = (ROOT / "locales" / locale / "Racial.lua").read_text(encoding="utf-8")
                tail = src.split("local specificVoices = {", 1)[1]
                for key, raw in ENTRY.findall(tail):
                    variants = [json.loads(m.group()) for m in QUOTED.finditer(raw)]
                    self.assertEqual(len(variants), 4, key)
                    self.assertEqual(len(set(variants)), 4, key)
                    self.assertEqual(sum(s.startswith("*") for s in variants), 2, key)
                    for s in variants:
                        self.assertTrue(s.strip())
                        self.assertLessEqual(len(s.encode("utf-8")), 255)
                        self.assertNotIn("%s", s)
                        self.assertNotIn("|", s)
                        self.assertNotIn("\n", s)
                        self.assertNotIn("\r", s)
                        self.assertEqual(s.startswith("*"), s.endswith("*"))
                        if s.startswith("*"):
                            self.assertEqual(s.count("*"), 2)


if __name__ == "__main__":
    unittest.main()
