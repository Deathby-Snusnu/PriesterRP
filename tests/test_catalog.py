"""Static Priest addon contracts independent of the WoW client."""
from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[1]
LANGUAGES = ("deDE", "enUS", "frFR")
SPELLS = re.compile(r"^    ([A-Z][A-Z0-9_]+) = \{ gruppe = \{", re.M)
GROUPS = re.compile(r'^    ([A-Z][A-Z0-9_]+) = "([DHS])",$', re.M)
RACES = ("DWARF", "GNOME", "HUMAN", "NIGHTELF", "DRAENEI",
         "ORC", "TROLL", "TAUREN", "UNDEAD", "BLOODELF", "HIGH_ELF")


class PriestCatalogTests(unittest.TestCase):
    def test_toc_references_exist_in_order(self):
        toc = (ROOT / "PriesterRP.toc").read_text(encoding="utf-8")
        paths = [line.strip().replace("\\", "/") for line in toc.splitlines()
                 if line.strip() and not line.startswith("#")]
        self.assertEqual(len(paths), len(set(paths)))
        for file in paths:
            self.assertTrue((ROOT / file).is_file(), file)
        self.assertLess(paths.index("locales/Init.lua"), paths.index("locales/deDE/Texts.lua"))
        self.assertLess(paths.index("locales/deDE/Texts.lua"), paths.index("locales/deDE/Racial.lua"))
        self.assertIn("## OptionalDeps: RPChatMod", toc)
        self.assertIn("PriesterRP_CharacterDB", toc)

    def test_all_spell_keys_translated(self):
        init = (ROOT / "locales/Init.lua").read_text(encoding="utf-8")
        groups = dict(GROUPS.findall(init))
        self.assertEqual(len(groups), 56)
        self.assertEqual(tuple(sum(school == value for school in groups.values())
                               for value in "DHS"), (18, 19, 19))
        for lang in LANGUAGES:
            with self.subTest(lang=lang):
                text = (ROOT / "locales" / lang / "Texts.lua").read_text(encoding="utf-8")
                keys = SPELLS.findall(text)
                self.assertEqual(len(keys), 56)
                self.assertEqual(set(keys), set(groups))
                self.assertIn("ziel = {", text)
                racial = (ROOT / "locales" / lang / "Racial.lua").read_text(encoding="utf-8")
                self.assertIn("for key, school in pairs(addon.spellGroups)", racial)
                ambient = (ROOT / "locales" / lang / "Ambient.lua").read_text(encoding="utf-8")
                for race in RACES:
                    self.assertIn(race + " = {", racial)
                    self.assertIn(race + " = {", ambient)
                self.assertIn("NEUTRAL = {", ambient)

    def test_target_and_chat_safety(self):
        text = (ROOT / "core/Text.lua").read_text(encoding="utf-8")
        self.assertIn('UnitCanAttack("player", "target")', text)
        self.assertIn('UnitCanAssist("player", "target")', text)
        init = (ROOT / "locales/Init.lua").read_text(encoding="utf-8")
        self.assertIn('RENEW = "F"', init)
        self.assertIn('SHADOW_WORD_PAIN = "A"', init)
        self.assertNotIn('HOLY_NOVA = "A"', init)
        chat = (ROOT / "core/Chat.lua").read_text(encoding="utf-8")
        self.assertIn("#text > 255", chat)
        self.assertIn('destination == "SAY" or destination == "YELL"', chat)

    def test_ambient_is_deferred(self):
        ambient = (ROOT / "core/Ambient.lua").read_text(encoding="utf-8")
        self.assertIn("addon.QueueAmbient()", ambient)
        self.assertNotIn("addon.SendText(", ambient.split("function addon.ResetAmbientTimer()", 1)[1])
        commands = (ROOT / "core/Commands.lua").read_text(encoding="utf-8")
        self.assertIn('SLASH_PRIESTERRP1 = "/prrp"', commands)
        self.assertIn('SlashCmdList["PRIESTERRP"]', commands)


if __name__ == "__main__":
    unittest.main()
