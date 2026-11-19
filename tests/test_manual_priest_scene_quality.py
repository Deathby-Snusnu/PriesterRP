"""Check manual priest RP scenes without imposing combat spell target shapes."""
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LOCALES = ("deDE", "enUS", "frFR")
MANUAL = ("BEDSIDE_PRAYER", "SHRINE_VIGIL", "CONFESSION",
          "LAST_RITES", "MEDITATION", "SHADOW_REFLECTION")
WITH_TARGET = ("BEDSIDE_PRAYER", "CONFESSION", "LAST_RITES")
ROW = re.compile(
    r'^    ([A-Z][A-Z0-9_]+) = \{ gruppe = \{ (.*?) \}'
    r'(?:, ziel = \{ (.*?) \})?, \},$', re.M
)
STRING = re.compile(r'"(?:\\.|[^"\\])*"')


def parse(raw):
    return [json.loads(match.group()) for match in STRING.finditer(raw)]


class ManualPriestSceneTests(unittest.TestCase):
    def test_manual_scene_structure_in_all_locales(self):
        for lang in LOCALES:
            with self.subTest(lang=lang):
                source = (ROOT / "locales" / lang / "Texts.lua").read_text(encoding="utf-8")
                rows = {key: (parse(group), parse(target) if target else None)
                        for key, group, target in ROW.findall(source)}
                self.assertEqual(len(rows), 62)
                second_lines = []
                emotes = []
                for key in MANUAL:
                    group, target = rows[key]
                    self.assertEqual(len(group), 4, key)
                    self.assertEqual(len(set(group)), 4, key)
                    self.assertEqual(sum(v.startswith("*") for v in group), 2, key)
                    second_lines.append(group[1])
                    emotes.extend(group[2:])
                    if key in WITH_TARGET:
                        # Manual roleplay scenes intentionally have one target
                        # line rather than the four variants of a spell pool.
                        self.assertIsNotNone(target, key)
                        self.assertEqual(len(target), 1, key)
                        self.assertEqual(target[0].count("%s"), 1, key)
                    else:
                        self.assertIsNone(target, key)
                    for value in group + (target or []):
                        self.assertTrue(value)
                        self.assertLessEqual(len(value.encode("utf-8")), 255, key)
                        self.assertNotIn("|", value, key)
                        self.assertEqual(value.startswith("*"), value.endswith("*"))
                        if value.startswith("*"):
                            self.assertEqual(value.count("*"), 2)
                            self.assertNotIn("%s", value)
                self.assertEqual(len(set(second_lines)), len(MANUAL))
                self.assertEqual(len(set(emotes)), 2 * len(MANUAL))


if __name__ == "__main__":
    unittest.main()
