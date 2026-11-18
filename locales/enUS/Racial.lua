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

-- Spell-specific racial voices; school-based pools remain the fallback.
-- These entries are deliberately target-neutral and use *...* for /me.
local specificVoices = {
    DWARF = {
        POWER_WORD_SHIELD = { "A dwarf stands behind this ward. That's worth more than mere stone.", "*draws a glowing ward on the shield rim with a thumb.*", "The next blow is mine to bear, not yours.", "*plants both feet as a golden shimmer settles over the companion.*" },
        RENEW = { "A wound won't heal faster just because you shout at it.", "*changes the bandage while murmuring an old blessing.*", "Easy now. Even a mountain doesn't grow in a day.", "*rests a calloused hand gently on the injured companion's shoulder.*" },
        SHADOW_WORD_PAIN = { "Beneath the mountain lies darkness no torch can drive away.", "*rubs a trace of black dust between thumb and forefinger.*", "Some words weigh more than ore.", "*speaks one harsh word as the shadow deepens beneath the feet.*" },
        RESURRECTION = { "You still have friends here. The ancestors must wait.", "*kneels and sets the holy symbol beside a motionless hand.*", "Come back. Your story has more chapters left.", "*speaks the ancestors' names one by one into the quiet Light.*" },
    },
    GNOME = {
        POWER_WORD_SHIELD = { "Protective field stable. That it's made of faith is a technical detail.", "*sketches a circle and measures its glow through a tiny lens.*", "Don't worry, the design holds. According to my calculations.", "*taps a pocket meter while a shimmering barrier takes shape.*" },
        RENEW = { "This isn't an instant fix. It's careful maintenance of a living subject.", "*watches closely as the Light closes the edges of a wound.*", "A small dose of hope, evenly distributed.", "*draws tiny healing marks like dots on a chart.*" },
        SHADOW_WORD_PAIN = { "Interesting. The shadow even responds to unpleasant thoughts.", "*hastily scribbles a warning symbol in the margin of the notes.*", "I really shouldn't test that formula aloud before breakfast.", "*adjusts the goggles and releases a dark shimmer from one fingertip.*" },
        RESURRECTION = { "A restart is possible. Let's avoid another unexpected shutdown.", "*places two fingers against the fallen companion's brow and counts softly.*", "Back to life. I can explain the procedure afterward.", "*holds a breath as the first spark of Light breaks the stillness.*" },
    },
    UNDEAD = {
        POWER_WORD_SHIELD = { "My heart no longer beats. I'll protect those that still do.", "*draws a bright circle before a companion with bony fingers.*", "The Light and I have a complicated relationship. It still helps.", "*studies the golden ward with a dry smile.*" },
        RENEW = { "The living heal so willingly. Fascinating.", "*places two cold fingers near a wound and watches it close.*", "Keep your pulse. It suits you rather well.", "*straightens a frayed stole and whispers a surprisingly gentle blessing.*" },
        SHADOW_WORD_PAIN = { "The shadow knows my name. I've taught it yours.", "*opens a hand and lets a dark thread rise into the air.*", "You call it a curse. I call it an old acquaintance.", "*listens briefly to a voice no one else can hear.*" },
        RESURRECTION = { "Coming back is possible. Believe me, I have experience.", "*kneels beside the fallen and studies the hands for a moment.*", "You can skip the grave this time.", "*raises the holy symbol and lets warm Light fall across the stillness.*" },
    },
    NIGHTELF = {
        POWER_WORD_SHIELD = { "Under Elune's gaze, you shall not stand unguarded.", "*traces a slender crescent before the companion.*", "Even the night has places where one may rest safely.", "*drapes the armour in a veil of silvery light.*" },
        RENEW = { "Healing grows quietly, like new shoots after rain.", "*rests fingertips near the wound as gentle moonlight appears.*", "Take your time. Even the forest does not heal overnight.", "*breathes out slowly and watches a glimmering leaf drift away.*" },
        SHADOW_WORD_PAIN = { "Night offers shelter. Yet it can also punish.", "*draws the shadow beneath the foe's feet upward.*", "Elune's light does not make me blind to darkness.", "*lowers the gaze as a narrow dark rune begins to glow.*" },
        RESURRECTION = { "May the stars accompany you through many more nights.", "*kneels and gently rests a hand over the still heart.*", "Return. The forest has not forgotten your name.", "*draws a shining crescent above the fallen companion.*" },
    },
    TROLL = {
        POWER_WORD_SHIELD = { "The loa are watching. I'm just giving them a hand.", "*shakes a small pouch of offerings and draws a warding sign.*", "Hey, while my blessing holds, they won't get you so easily!", "*taps the amulet twice as though checking its fit.*" },
        RENEW = { "Easy, friend. The loa don't care for hurried work.", "*rubs herbs between the fingers and whispers a blessing.*", "The body knows how to heal. It just needs reminding.", "*rests a hand on the bandage and waits for a warm glow.*" },
        SHADOW_WORD_PAIN = { "Your shadow asked me a question. You won't like the answer.", "*draws a crooked sign in the dust and chuckles softly.*", "Some loa whisper. Others bite.", "*turns a small amulet until its dark face points outward.*" },
        RESURRECTION = { "Hey, get up! Your loa hasn't called for you yet.", "*taps the ground beside the fallen companion and waits.*", "The spirits can carry on their feast without you a while longer.", "*raises a plain amulet as warm light falls upon the body.*" },
    },
    DRAENEI = {
        POWER_WORD_SHIELD = { "The naaru remind us that protection is also a promise.", "*touches a crystal whose light settles around the companion.*", "We have lost so many worlds. I will not give up on you.", "*turns a palm toward the companion and raises a clear glow.*" },
        RENEW = { "What has been broken can sometimes slowly become whole again.", "*lets soft light flow through the fingers across the wound.*", "Hope is not a miracle on command. It needs tending.", "*kneels beside the injured companion and speaks a quiet prayer.*" },
        SHADOW_WORD_PAIN = { "I have seen great darkness. I know where a whisper can lead.", "*holds the crystal tightly as a dark thread crosses the hand.*", "Do not underestimate shadow. I have seen its price.", "*lowers the voice until only a barely audible word remains.*" },
        RESURRECTION = { "Another homecoming is possible. Listen to my voice.", "*holds the crystal in both hands and kneels beside the fallen.*", "We have endured enough farewells. Not this one.", "*lets light travel slowly over the still body.*" },
    },
    HUMAN = {
        POWER_WORD_SHIELD = { "An oath protects no one unless we act upon it.", "*draws a crisp warding sigil before the companion with a practised hand.*", "As long as I stand, you shall not stand alone.", "*touches the crest and calls forth a warm glow.*" },
        RENEW = { "One step at a time. We'll get you back on your feet.", "*checks the bandage and passes a steady glow of Light over it.*", "Healing takes patience, even in the middle of battle.", "*speaks a brief prayer and gently withdraws the hand.*" },
        SHADOW_WORD_PAIN = { "A word can wound. I have chosen this one carefully.", "*lowers the voice and traces a thin dark line in the air.*", "I know the danger of this path. I do not tread it lightly.", "*closes the eyes for a moment before the shadow rises.*" },
        RESURRECTION = { "You made a promise. Come back and keep it.", "*kneels and places the holy symbol beside the resting hand.*", "There is still a way home. Listen to my voice.", "*speaks the fallen companion's name into a gentle Light.*" },
    },
    ORC = {
        POWER_WORD_SHIELD = { "Protect the one who fights beside you. That is the clan's duty.", "*strikes a fist to the chest and wraps an ally in a glowing ward.*", "This ward is stronger than a boast. Trust it.", "*plants both feet and keeps the warding hand raised.*" },
        RENEW = { "Even the strongest need rest before they fight again.", "*binds a wound with steady hands and calls down healing Light.*", "Bear the scar with honour. But let it heal first.", "*nods to the injured companion and holds a hand above the bandage.*" },
        SHADOW_WORD_PAIN = { "The ancestors know words that silence even warriors.", "*bows the head and lets a dark note rise from the throat.*", "I do not call the shadows for amusement.", "*opens a fist as a thin strand of shadow emerges.*" },
        RESURRECTION = { "The clan still counts you among its own. Return.", "*kneels beside the fallen and touches the brow with respect.*", "Your place at the fire is still open. Come and claim it.", "*speaks a name to the ancestors and waits in warm Light.*" },
    },
    TAUREN = {
        POWER_WORD_SHIELD = { "The Earth Mother carries you. I only turn the storm aside.", "*places one hand upon the earth and lifts the other to ward the companion.*", "Roots hold fast when the winds rise.", "*draws a bright circle above the ground with a calm gesture.*" },
        RENEW = { "Grass returns after frost. So will your strength.", "*touches the wound gently and breathes to the rhythm of a quiet prayer.*", "Healing does not hurry. It still finds its way.", "*holds an open palm until a gentle glow appears.*" },
        SHADOW_WORD_PAIN = { "Even beneath the sun, every warrior casts a shadow.", "*plants a hoof firmly as darkness rises from the ground.*", "I know the weight of quiet words.", "*lowers the horns and whispers a dark verse.*" },
        RESURRECTION = { "The Earth Mother has not yet called you from our circle.", "*kneels low and touches the earth with the fingertips.*", "Rise. The plains await your footsteps.", "*slowly raises both hands as warm Light surrounds the fallen.*" },
    },
    BLOODELF = {
        POWER_WORD_SHIELD = { "A flawless barrier. The difference lies in the execution.", "*draws a slender golden rune with perfect precision.*", "Elegance alone offers no protection. This spell does.", "*smooths a sleeve as a glowing ward seals into place.*" },
        RENEW = { "Healing is also the art of proper measure.", "*guides two fingers in a calm arc above the wound.*", "The radiance returns, and your strength with it.", "*watches fine strands of Light close the injury.*" },
        SHADOW_WORD_PAIN = { "Shadow exposes every careless move. You will not find mine.", "*aligns a dark rune with an almost imperceptible movement.*", "Power demands discipline. Even dark power.", "*spins a thin strand of shadow between two fingers.*" },
        RESURRECTION = { "The world is not ready to do without you.", "*places a finely engraved amulet upon the fallen companion's chest.*", "Return. A life such as yours should not remain unfinished.", "*closes the eyes and holds both hands still in golden Light.*" },
    },
    HIGH_ELF = {
        POWER_WORD_SHIELD = { "This ward carries the patience of many winters past.", "*touches a modest amulet and raises a silvery glow.*", "Some promises outlive kingdoms. This one is yours.", "*draws an ancient sign with a calm, steady hand.*" },
        RENEW = { "A long road teaches patience, even in healing.", "*guides a narrow stream of Light across the bandage.*", "Not every scar must vanish for hope to remain.", "*holds the fingers still above the injury and listens to the breathing.*" },
        SHADOW_WORD_PAIN = { "Memories cast shadows too. Some can be guided.", "*closes a hand around the amulet as darkness gathers.*", "I have learned not to speak dark words lightly.", "*slowly traces a dark line through the air.*" },
        RESURRECTION = { "Not every farewell must be the final one.", "*kneels and holds the amulet above the still heart.*", "Return. There are songs you have yet to hear.", "*speaks an ancient prayer as silvery Light touches the fallen.*" },
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
