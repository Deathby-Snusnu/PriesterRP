"""Regression checks for the first editorial cleanup of generic priest spell texts."""
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LOCALES = ("deDE", "enUS", "frFR")
SPELLS = (
    "POWER_WORD_SHIELD", "DISPEL_MAGIC", "INNER_FOCUS", "POWER_INFUSION",
    "RENEW", "RESURRECTION", "FLASH_HEAL", "HOLY_FIRE",
    "SHADOW_WORD_PAIN", "MIND_BLAST", "PSYCHIC_SCREAM", "SHADOWFORM",
    "POWER_WORD_FORTITUDE", "INNER_FIRE", "MANA_BURN", "LEVITATE",
    "LESSER_HEAL", "SMITE", "HEAL", "FEAR_WARD", "HOLY_NOVA",
    "PRAYER_OF_HEALING",
    "CONFOUNDING_FLASH", "STARSHARDS", "CONTINGENCY_PLAN", "ELUNES_GRACE",
    "FEEDBACK", "SHACKLE_UNDEAD", "DIVINE_SPIRIT", "PENANCE",
    "PRAYER_OF_FORTITUDE", "PRAYER_OF_SPIRIT",
    "FADE", "HEX_OF_WEAKNESS", "TOUCH_OF_WEAKNESS", "DEVOURING_PLAGUE",
    "MIND_FLAY", "MIND_SOOTHE", "SHADOWGUARD", "MIND_VISION",
    "MIND_CONTROL", "SILENCE",
    "DESPERATE_PRAYER", "DIVINE_GRACE", "CURE_DISEASE", "GREATER_HEAL",
    "PRAYER_OF_MENDING", "DARK_SACRIFICE", "SHADOW_PROTECTION",
    "SHADOW_WORD_DEATH", "PRAYER_OF_SHADOW_PROTECTION", "VAMPIRIC_EMBRACE",
)
TARGETED = {
    "POWER_WORD_SHIELD", "POWER_INFUSION", "RENEW", "RESURRECTION",
    "FLASH_HEAL", "HOLY_FIRE", "SHADOW_WORD_PAIN", "MIND_BLAST",
    "POWER_WORD_FORTITUDE", "MANA_BURN", "LESSER_HEAL", "SMITE",
    "HEAL", "FEAR_WARD", "STARSHARDS", "CONTINGENCY_PLAN",
    "SHACKLE_UNDEAD", "DIVINE_SPIRIT", "HEX_OF_WEAKNESS",
    "DEVOURING_PLAGUE", "MIND_FLAY", "MIND_SOOTHE",
    "MIND_VISION", "MIND_CONTROL", "SILENCE",
    "DIVINE_GRACE", "CURE_DISEASE", "GREATER_HEAL",
    "PRAYER_OF_MENDING", "SHADOW_PROTECTION", "SHADOW_WORD_DEATH",
    "VAMPIRIC_EMBRACE",
}
ROW = re.compile(
    r'^    ([A-Z][A-Z0-9_]+) = \{ gruppe = \{ (.*?) \}'
    r'(?:, ziel = \{ (.*?) \})?, \},$', re.M
)
STRING = re.compile(r'"(?:\\.|[^"\\])*"')


def strings(data):
    return [json.loads(m.group()) for m in STRING.finditer(data)]


class GenericPriestSpellVoicesTests(unittest.TestCase):
    def test_distinct_speech_emotes_and_target_format(self):
        for locale in LOCALES:
            with self.subTest(locale=locale):
                path = ROOT / "locales" / locale / "Texts.lua"
                rows = {
                    key: (strings(gruppe), strings(ziel) if ziel else None)
                    for key, gruppe, ziel in ROW.findall(path.read_text(encoding="utf-8"))
                }
                self.assertEqual(len(rows), 62)
                group_second, emotes = [], []
                for key in SPELLS:
                    self.assertIn(key, rows)
                    gruppe, ziel = rows[key]
                    self.assertEqual(len(gruppe), 4, key)
                    self.assertEqual(len(set(gruppe)), 4, key)
                    self.assertEqual(sum(s.startswith("*") for s in gruppe), 2, key)
                    group_second.append(gruppe[1])
                    emotes.extend(gruppe[2:])
                    if key in TARGETED:
                        self.assertIsNotNone(ziel, key)
                        self.assertEqual(len(ziel), 4, key)
                        self.assertEqual(ziel[2:], gruppe[2:], key)
                        self.assertEqual(ziel[1].count("%s"), 1, key)
                        self.assertNotIn("%s", gruppe[1], key)
                    else:
                        self.assertIsNone(ziel, key)
                    for line in gruppe + (ziel or []):
                        self.assertTrue(line.strip(), key)
                        self.assertLessEqual(len(line.encode("utf-8")), 255, key)
                        self.assertNotIn("|", line, key)
                        self.assertEqual(line.startswith("*"), line.endswith("*"), key)
                        if line.startswith("*"):
                            self.assertEqual(line.count("*"), 2, key)
                            self.assertNotIn("%s", line, key)
                self.assertEqual(len(set(group_second)), len(SPELLS))
                self.assertEqual(len(set(emotes)), 2 * len(SPELLS))


if __name__ == "__main__":
    unittest.main()
