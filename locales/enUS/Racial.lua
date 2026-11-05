-- SPDX-License-Identifier: CC-BY-SA-4.0
local _, addon = ...
local voices = {
    DWARF = {
        D = { "By my ancestors, faith holds even without a helm.", "*taps the sacred symbol with stout knuckles*", "*murmurs a rough prayer through clenched teeth*" },
        H = { "The mountain is still. The Light in me is not.", "*taps the sacred symbol with stout knuckles*", "*murmurs a rough prayer through clenched teeth*" },
        S = { "Those who know the deep need not fear shadows.", "*taps the sacred symbol with stout knuckles*", "*murmurs a rough prayer through clenched teeth*" },
    },
    GNOME = {
        D = { "I measured the miracle. It defies every equation.", "*adjusts the goggles and studies a glowing sketch*", "*writes down a decidedly unexplainable observation*" },
        H = { "A little healing, a little field research.", "*adjusts the goggles and studies a glowing sketch*", "*writes down a decidedly unexplainable observation*" },
        S = { "Even darkness has measurable limits. Probably.", "*adjusts the goggles and studies a glowing sketch*", "*writes down a decidedly unexplainable observation*" },
    },
    HUMAN = {
        D = { "An oath is only as strong as the deed that follows.", "*places a hand over the crest by the heart*", "*bows the head briefly and gathers courage*" },
        H = { "I pray not for glory, but for a safe return.", "*places a hand over the crest by the heart*", "*bows the head briefly and gathers courage*" },
        S = { "Where fear rules, we owe each other courage.", "*places a hand over the crest by the heart*", "*bows the head briefly and gathers courage*" },
    },
    NIGHTELF = {
        D = { "Under Elune's stars, even silence is prayer.", "*traces a crescent in the air*", "*listens to the wind through the leaves*" },
        H = { "The moon gives light without asking a word.", "*traces a crescent in the air*", "*listens to the wind through the leaves*" },
        S = { "Even the longest shadow travels with the seasons.", "*traces a crescent in the air*", "*listens to the wind through the leaves*" },
    },
    DRAENEI = {
        D = { "The naaru taught patience. They forgot to mention how hard it is.", "*touches a crystal sewn into the robe*", "*bows reverently to a distant chime*" },
        H = { "I have seen worlds fall and kept hope alive.", "*touches a crystal sewn into the robe*", "*bows reverently to a distant chime*" },
        S = { "A shadow is no ending. It reminds us where to look.", "*touches a crystal sewn into the robe*", "*bows reverently to a distant chime*" },
    },
    ORC = {
        D = { "Honor is not only the blade, but the hand that lowers it.", "*presses a fist to the chest in salute to the ancestors*", "*stands quietly and unbowed*" },
        H = { "Even warriors need someone to tend their wounds.", "*presses a fist to the chest in salute to the ancestors*", "*stands quietly and unbowed*" },
        S = { "Ancestors whisper in darkness, and I listen.", "*presses a fist to the chest in salute to the ancestors*", "*stands quietly and unbowed*" },
    },
    TROLL = {
        D = { "The loa seldom laugh at the same things we do.", "*shakes a small pouch of offerings*", "*dances a crooked symbol into the dust*" },
        H = { "I know a blessing, but the loa wants a story.", "*shakes a small pouch of offerings*", "*dances a crooked symbol into the dust*" },
        S = { "A shadow has teeth. Best not ask why.", "*shakes a small pouch of offerings*", "*dances a crooked symbol into the dust*" },
    },
    TAUREN = {
        D = { "The Earth Mother bears those who have lost their way.", "*touches the earth with an open palm*", "*breathes deeply and listens to the distant plains*" },
        H = { "Healing grows slowly, like grass after frost.", "*touches the earth with an open palm*", "*breathes deeply and listens to the distant plains*" },
        S = { "A cloud's shadow is no judgment on the sun.", "*touches the earth with an open palm*", "*breathes deeply and listens to the distant plains*" },
    },
    UNDEAD = {
        D = { "My faith outlived my pulse. Quite an achievement.", "*checks with dry humor whether the heart still beats*", "*straightens a frayed stole with grim solemnity*" },
        H = { "Healing is tricky when your anatomy is contradictory.", "*checks with dry humor whether the heart still beats*", "*straightens a frayed stole with grim solemnity*" },
        S = { "The shadows are old acquaintances. Dreadfully chatty.", "*checks with dry humor whether the heart still beats*", "*straightens a frayed stole with grim solemnity*" },
    },
    BLOODELF = {
        D = { "Dignity means keeping your poise through doubt.", "*smooths a fold in an elegant robe*", "*studies an arcane reflection with cool attention*" },
        H = { "A precise blessing is an art form.", "*smooths a fold in an elegant robe*", "*studies an arcane reflection with cool attention*" },
        S = { "Shadows reveal those who merely imitate the Light.", "*smooths a fold in an elegant robe*", "*studies an arcane reflection with cool attention*" },
    },
    HIGH_ELF = {
        D = { "Even in exile, the Light finds a way.", "*lifts a modest amulet engraved in silver*", "*lingers a breath with an ancient memory*" },
        H = { "A steady hand heals more than a shouted oath.", "*lifts a modest amulet engraved in silver*", "*lingers a breath with an ancient memory*" },
        S = { "Memories cast long shadows, even after centuries.", "*lifts a modest amulet engraved in silver*", "*lingers a breath with an ancient memory*" },
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
addon.localeData.enUS.racial = pools
