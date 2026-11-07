"""Check manual RP actions and locale parity."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
KEYS = ["BEDSIDE_PRAYER","SHRINE_VIGIL","CONFESSION","LAST_RITES","MEDITATION","SHADOW_REFLECTION"]
EXPECTED = 62
VERSION = "0.1.1"


class RpActionCoverage(unittest.TestCase):
    def test_toc_and_locale_keys(self):
        toc = (ROOT / "PriesterRP.toc").read_text(encoding="utf-8")
        self.assertIn("## Version: " + VERSION, toc)
        for lang in ("deDE", "enUS", "frFR"):
            with self.subTest(lang=lang):
                source = (ROOT / "locales" / lang / "Texts.lua").read_text(
                    encoding="utf-8"
                )
                all_keys = re.findall(r"\b([A-Z][A-Z0-9_]*)\s*=\s*\{", source)
                self.assertEqual(len(set(all_keys)), EXPECTED)
                for key in KEYS:
                    self.assertEqual(all_keys.count(key), 1, (lang, key))
                    offset = source.index("    " + key + " = {")
                    line = source[offset:source.find("\n", offset)]
                    self.assertIn("gruppe = {", line)
                    self.assertIn("*", line)
                self.assertNotIn("Neuer RP-Text", source)


if __name__ == "__main__":
    unittest.main()
