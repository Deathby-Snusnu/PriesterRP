-- SPDX-License-Identifier: CC-BY-SA-4.0
local _, addon = ...
local voices = {
    DWARF = {
        D = { "Par mes ancêtres, la foi tient même sans heaume.", "*tapote son symbole sacré de ses jointures*", "*murmure une prière bourrue entre ses dents*" },
        H = { "La montagne est immobile. Pas la Lumière en moi.", "*tapote son symbole sacré de ses jointures*", "*murmure une prière bourrue entre ses dents*" },
        S = { "Qui connaît les profondeurs ne craint pas les ombres.", "*tapote son symbole sacré de ses jointures*", "*murmure une prière bourrue entre ses dents*" },
    },
    GNOME = {
        D = { "J'ai mesuré le miracle. Il contredit toute équation.", "*ajuste ses lunettes devant un croquis lumineux*", "*note une observation décidément inexplicable*" },
        H = { "Un peu de guérison, un peu de recherche.", "*ajuste ses lunettes devant un croquis lumineux*", "*note une observation décidément inexplicable*" },
        S = { "Même les ténèbres ont des limites mesurables. En théorie.", "*ajuste ses lunettes devant un croquis lumineux*", "*note une observation décidément inexplicable*" },
    },
    HUMAN = {
        D = { "Un serment ne vaut que par l'acte qui le suit.", "*pose une main sur l'écusson de son cœur*", "*baisse brièvement la tête et reprend courage*" },
        H = { "Je prie pour le retour, non pour la gloire.", "*pose une main sur l'écusson de son cœur*", "*baisse brièvement la tête et reprend courage*" },
        S = { "Là où règne la peur, nous nous devons du courage.", "*pose une main sur l'écusson de son cœur*", "*baisse brièvement la tête et reprend courage*" },
    },
    NIGHTELF = {
        D = { "Sous les étoiles d'Élune, même le silence est prière.", "*dessine un croissant dans l'air*", "*écoute le vent dans les feuilles*" },
        H = { "La lune offre sa lumière sans rien demander.", "*dessine un croissant dans l'air*", "*écoute le vent dans les feuilles*" },
        S = { "Même la plus longue ombre suit les saisons.", "*dessine un croissant dans l'air*", "*écoute le vent dans les feuilles*" },
    },
    DRAENEI = {
        D = { "Les naaru enseignent la patience. Ils oublient sa difficulté.", "*effleure un cristal cousu à la robe*", "*incline la tête devant un carillon lointain*" },
        H = { "J'ai vu tomber des mondes et gardé l'espoir.", "*effleure un cristal cousu à la robe*", "*incline la tête devant un carillon lointain*" },
        S = { "L'ombre n'est pas la fin. Elle indique où regarder.", "*effleure un cristal cousu à la robe*", "*incline la tête devant un carillon lointain*" },
    },
    ORC = {
        D = { "L'honneur n'est pas la lame, mais aussi la main qui l'abaisse.", "*frappe sa poitrine du poing en saluant les ancêtres*", "*se tient en silence, inflexible*" },
        H = { "Même les guerriers ont besoin qu'on voie leurs blessures.", "*frappe sa poitrine du poing en saluant les ancêtres*", "*se tient en silence, inflexible*" },
        S = { "Les ancêtres chuchotent dans le noir et j'écoute.", "*frappe sa poitrine du poing en saluant les ancêtres*", "*se tient en silence, inflexible*" },
    },
    TROLL = {
        D = { "Les loa ne rient pas toujours des mêmes choses que nous.", "*secoue une petite bourse d'offrandes*", "*trace un signe étrange en dansant sur la poussière*" },
        H = { "Je connais une bénédiction, mais le loa veut une histoire.", "*secoue une petite bourse d'offrandes*", "*trace un signe étrange en dansant sur la poussière*" },
        S = { "Une ombre a des dents. Mieux vaut ne pas demander.", "*secoue une petite bourse d'offrandes*", "*trace un signe étrange en dansant sur la poussière*" },
    },
    TAUREN = {
        D = { "La Terre-Mère porte aussi ceux qui ont perdu leur chemin.", "*effleure le sol de sa paume ouverte*", "*respire profondément en écoutant les plaines lointaines*" },
        H = { "La guérison pousse lentement comme l'herbe après le gel.", "*effleure le sol de sa paume ouverte*", "*respire profondément en écoutant les plaines lointaines*" },
        S = { "L'ombre d'un nuage ne condamne pas le soleil.", "*effleure le sol de sa paume ouverte*", "*respire profondément en écoutant les plaines lointaines*" },
    },
    UNDEAD = {
        D = { "Ma foi a survécu à mon pouls. Un bel exploit.", "*vérifie ironiquement si son cœur bat encore*", "*redresse une étole effilochée avec gravité*" },
        H = { "Guérir est compliqué quand l'anatomie se contredit.", "*vérifie ironiquement si son cœur bat encore*", "*redresse une étole effilochée avec gravité*" },
        S = { "Les ombres sont de vieilles connaissances. Trop bavardes.", "*vérifie ironiquement si son cœur bat encore*", "*redresse une étole effilochée avec gravité*" },
    },
    BLOODELF = {
        D = { "La dignité, c'est garder son maintien dans le doute.", "*lisse un pli de sa robe élégante*", "*observe un reflet arcanique avec une froide attention*" },
        H = { "Une bénédiction précise est un art.", "*lisse un pli de sa robe élégante*", "*observe un reflet arcanique avec une froide attention*" },
        S = { "Les ombres révèlent ceux qui imitent la Lumière.", "*lisse un pli de sa robe élégante*", "*observe un reflet arcanique avec une froide attention*" },
    },
    HIGH_ELF = {
        D = { "Même en exil, la Lumière trouve son chemin.", "*soulève une modeste amulette gravée*", "*s'attarde un instant sur un vieux souvenir*" },
        H = { "Une main calme soigne mieux qu'un serment crié.", "*soulève une modeste amulette gravée*", "*s'attarde un instant sur un vieux souvenir*" },
        S = { "Les souvenirs projettent de longues ombres.", "*soulève une modeste amulette gravée*", "*s'attarde un instant sur un vieux souvenir*" },
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
addon.localeData.frFR.racial = pools

-- Spell-specific racial voices; school-based pools remain the fallback.
-- These entries are deliberately target-neutral and use *...* for /me.
local specificVoices = {
    DWARF = {
        POWER_WORD_SHIELD = { "Un nain veille derrière cette protection. Cela vaut plus que la pierre.", "*trace du pouce une rune lumineuse sur le bord du bouclier.*", "Le prochain coup sera pour moi, pas pour vous.", "*campe solidement ses pieds tandis qu'une lueur dorée enveloppe son compagnon.*" },
        RENEW = { "Une plaie ne guérit pas plus vite si on lui crie dessus.", "*change le bandage en murmurant une ancienne bénédiction.*", "Doucement. Même une montagne ne grandit pas en un jour.", "*pose doucement sa main calleuse sur l'épaule du blessé.*" },
        SHADOW_WORD_PAIN = { "Sous la montagne, il est des ténèbres qu'aucune torche ne chasse.", "*frotte une trace de poussière noire entre le pouce et l'index.*", "Certains mots pèsent plus lourd que le minerai.", "*prononce un mot rauque tandis que son ombre s'assombrit.*" },
        RESURRECTION = { "Vous avez encore des amis ici. Les ancêtres devront attendre.", "*s'agenouille et pose son symbole sacré près de la main immobile.*", "Revenez. Votre histoire n'est pas terminée.", "*prononce les noms des ancêtres, un à un, dans la Lumière silencieuse.*" },
    },
    GNOME = {
        POWER_WORD_SHIELD = { "Champ protecteur stable. Qu'il soit fait de foi est un détail technique.", "*dessine un cercle et mesure son éclat avec une minuscule lentille.*", "Ne craignez rien, la structure tient. D'après mes calculs.", "*tapote un appareil de mesure tandis qu'une barrière apparaît.*" },
        RENEW = { "Ce n'est pas une réparation express, mais un entretien minutieux du vivant.", "*observe attentivement la Lumière refermer les bords d'une plaie.*", "Une petite dose d'espoir, répartie avec précision.", "*dessine de minuscules signes de soin comme les points d'un graphique.*" },
        SHADOW_WORD_PAIN = { "Intéressant. L'ombre réagit même aux mauvaises pensées.", "*griffonne à la hâte un avertissement dans la marge de ses notes.*", "Je ne devrais pas tester cette formule à voix haute avant le déjeuner.", "*ajuste ses lunettes et laisse filer une ombre depuis le bout d'un doigt.*" },
        RESURRECTION = { "Un redémarrage est possible. Évitons cette fois l'arrêt imprévu.", "*pose deux doigts sur le front du défunt et compte à voix basse.*", "Retour à la vie. J'expliquerai la méthode plus tard.", "*retient son souffle quand une étincelle de Lumière perce le silence.*" },
    },
    UNDEAD = {
        POWER_WORD_SHIELD = { "Mon cœur ne bat plus. Je protégerai ceux qui battent encore.", "*dessine un cercle lumineux devant son compagnon de ses doigts osseux.*", "La Lumière et moi avons une relation compliquée. Elle aide quand même.", "*observe la protection dorée avec un sourire sec.*" },
        RENEW = { "Les vivants guérissent si volontiers. Fascinant.", "*pose deux doigts glacés près d'une plaie et la regarde se refermer.*", "Gardez votre pouls. Il vous va très bien.", "*redresse son étole effilochée et murmure une bénédiction étonnamment douce.*" },
        SHADOW_WORD_PAIN = { "L'ombre connaît mon nom. Je lui ai appris le vôtre.", "*ouvre la main et laisse monter un fil d'obscurité.*", "Vous appelez cela une malédiction. Moi, une vieille connaissance.", "*écoute un instant une voix que nul autre n'entend.*" },
        RESURRECTION = { "Revenir est possible. Croyez-moi, je parle d'expérience.", "*s'agenouille près du défunt et contemple un instant ses propres mains.*", "Cette fois, vous pouvez éviter la tombe.", "*soulève le symbole sacré et répand une douce Lumière sur le silence.*" },
    },
    NIGHTELF = {
        POWER_WORD_SHIELD = { "Sous le regard d'Élune, vous ne resterez pas sans protection.", "*trace un fin croissant devant son compagnon.*", "Même la nuit possède des refuges où se reposer.", "*dépose sur l'armure un voile de lumière argentée.*" },
        RENEW = { "La guérison pousse en silence, comme les jeunes pousses après la pluie.", "*approche les doigts de la plaie tandis qu'une douce clarté lunaire paraît.*", "Prenez votre temps. Même la forêt ne guérit pas en une nuit.", "*expire lentement en suivant une feuille lumineuse du regard.*" },
        SHADOW_WORD_PAIN = { "La nuit offre un refuge. Mais elle sait aussi punir.", "*fait monter l'ombre sous les pieds de l'ennemi.*", "La lumière d'Élune ne m'aveugle pas face aux ténèbres.", "*baisse le regard tandis qu'une fine rune sombre s'illumine.*" },
        RESURRECTION = { "Que les étoiles vous accompagnent encore bien des nuits.", "*s'agenouille et pose doucement une main au-dessus du cœur immobile.*", "Revenez. La forêt n'a pas oublié votre nom.", "*dessine un croissant lumineux au-dessus de son compagnon tombé.*" },
    },
    TROLL = {
        POWER_WORD_SHIELD = { "Les Loa veillent. Je leur donne juste un coup de main.", "*secoue une bourse d'offrandes et trace un signe protecteur.*", "Hé, tant que ma bénédiction tient, ils ne t'auront pas facilement !", "*tapote deux fois son amulette pour vérifier qu'elle tient bien.*" },
        RENEW = { "Doucement, camarade. Les Loa n'aiment pas le travail bâclé.", "*frotte des herbes entre ses doigts et murmure une bénédiction.*", "Le corps sait guérir. Il faut seulement le lui rappeler.", "*pose la main sur le bandage et attend une lueur chaleureuse.*" },
        SHADOW_WORD_PAIN = { "Ton ombre m'a posé une question. La réponse ne va pas te plaire.", "*dessine un signe tordu dans la poussière et ricane doucement.*", "Certains Loa murmurent. D'autres mordent.", "*retourne une amulette pour en montrer la face sombre.*" },
        RESURRECTION = { "Hé, debout ! Ton Loa ne t'a pas encore appelé.", "*tapote le sol près de son compagnon tombé et attend.*", "Les esprits peuvent continuer la fête sans toi un moment.", "*lève une simple amulette tandis qu'une douce lumière éclaire le corps.*" },
    },
    DRAENEI = {
        POWER_WORD_SHIELD = { "Les naaru nous rappellent que protéger, c'est aussi promettre.", "*effleure un cristal dont la lumière enveloppe son compagnon.*", "Nous avons perdu tant de mondes. Je ne vous abandonnerai pas.", "*tend la paume vers son compagnon et fait naître une clarté limpide.*" },
        RENEW = { "Ce qui fut brisé peut parfois lentement se réparer.", "*laisse glisser une douce lumière de ses doigts sur la plaie.*", "L'espoir n'est pas un miracle sur commande. Il se cultive.", "*s'agenouille près du blessé et récite une prière paisible.*" },
        SHADOW_WORD_PAIN = { "J'ai vu de grandes ténèbres. Je sais où mène un murmure.", "*serre son cristal tandis qu'un fil sombre traverse sa main.*", "Ne sous-estimez pas l'ombre. J'en connais le prix.", "*baisse la voix jusqu'à ne laisser qu'un mot presque inaudible.*" },
        RESURRECTION = { "Un nouveau retour est possible. Écoutez ma voix.", "*serre son cristal à deux mains et s'agenouille près du défunt.*", "Nous avons connu assez d'adieux. Pas celui-ci.", "*laisse la lumière parcourir lentement le corps immobile.*" },
    },
    HUMAN = {
        POWER_WORD_SHIELD = { "Un serment ne protège personne si nous n'agissons pas.", "*trace d'une main exercée un signe protecteur devant son compagnon.*", "Tant que je tiendrai, vous ne serez pas seul.", "*touche son blason et fait naître une douce lumière.*" },
        RENEW = { "Un pas après l'autre. Nous vous remettrons sur pied.", "*vérifie le bandage et y fait glisser une douce lumière.*", "Guérir exige de la patience, même au cœur du combat.", "*murmure une courte prière et retire doucement la main.*" },
        SHADOW_WORD_PAIN = { "Un mot peut blesser. Celui-ci, je l'ai choisi avec soin.", "*baisse la voix et trace un mince trait sombre dans l'air.*", "Je connais les dangers de cette voie. Je ne la prends pas à la légère.", "*ferme un instant les yeux avant que l'ombre ne s'élève.*" },
        RESURRECTION = { "Vous avez fait une promesse. Revenez la tenir.", "*s'agenouille et pose le symbole sacré près de la main immobile.*", "Le chemin du retour existe encore. Écoutez ma voix.", "*prononce le nom de son compagnon dans une douce lumière.*" },
    },
    ORC = {
        POWER_WORD_SHIELD = { "Protégez celui qui combat à vos côtés. C'est le devoir du clan.", "*frappe sa poitrine du poing et entoure son allié d'une protection lumineuse.*", "Cette protection vaut mieux que de vaines paroles.", "*ancre ses pieds au sol et garde la main protectrice levée.*" },
        RENEW = { "Même les plus forts ont besoin de repos avant de reprendre le combat.", "*bande une plaie de mains fermes et invoque une lumière guérisseuse.*", "Portez votre cicatrice avec honneur. Mais laissez-la guérir d'abord.", "*hoche la tête et tient la main au-dessus du bandage.*" },
        SHADOW_WORD_PAIN = { "Les ancêtres connaissent des mots qui font taire même les guerriers.", "*baisse la tête et laisse monter une note sombre de sa gorge.*", "Je n'appelle pas les ombres par plaisir.", "*ouvre le poing et laisse échapper un mince fil d'ombre.*" },
        RESURRECTION = { "Le clan vous compte encore parmi les siens. Revenez.", "*s'agenouille près du défunt et touche son front avec respect.*", "Votre place près du feu est toujours libre. Reprenez-la.", "*confie un nom aux ancêtres et attend dans une douce lumière.*" },
    },
    TAUREN = {
        POWER_WORD_SHIELD = { "La Terre-Mère vous porte. Je ne fais qu'écarter la tempête.", "*pose une main sur la terre et lève l'autre pour protéger son compagnon.*", "Les racines tiennent bon quand le vent se lève.", "*dessine calmement un cercle lumineux au-dessus du sol.*" },
        RENEW = { "L'herbe repousse après le gel. Vos forces reviendront aussi.", "*effleure la plaie et respire au rythme d'une prière silencieuse.*", "La guérison ne se presse pas. Elle trouve pourtant son chemin.", "*tend la paume jusqu'à ce qu'une douce lueur apparaisse.*" },
        SHADOW_WORD_PAIN = { "Même sous le soleil, chaque guerrier projette une ombre.", "*plante fermement un sabot tandis que l'obscurité monte du sol.*", "Je connais le poids des mots murmurés.", "*baisse les cornes et chuchote un sombre vers.*" },
        RESURRECTION = { "La Terre-Mère ne vous a pas encore appelé hors de notre cercle.", "*s'agenouille et effleure le sol du bout des doigts.*", "Levez-vous. Les plaines attendent vos pas.", "*lève lentement les mains tandis qu'une douce lumière entoure le défunt.*" },
    },
    BLOODELF = {
        POWER_WORD_SHIELD = { "Une barrière impeccable. Tout est dans l'exécution.", "*trace une fine rune dorée avec une précision parfaite.*", "L'élégance ne suffit pas à protéger. Ce sort, si.", "*lisse sa manche tandis qu'une protection lumineuse se referme.*" },
        RENEW = { "Guérir, c'est aussi maîtriser la juste mesure.", "*dessine un arc paisible de deux doigts au-dessus de la plaie.*", "L'éclat revient, et avec lui votre force.", "*observe de fins fils de lumière refermer la blessure.*" },
        SHADOW_WORD_PAIN = { "L'ombre révèle la moindre imprudence. Vous ne trouverez pas la mienne.", "*aligne une rune sombre d'un geste presque imperceptible.*", "Le pouvoir exige de la discipline. Même le plus obscur.", "*fait tournoyer un mince fil d'ombre entre deux doigts.*" },
        RESURRECTION = { "Le monde n'est pas prêt à se passer de vous.", "*pose une amulette finement gravée sur la poitrine du défunt.*", "Revenez. Une telle vie ne doit pas rester inachevée.", "*ferme les yeux et garde les mains immobiles dans une lueur dorée.*" },
    },
    HIGH_ELF = {
        POWER_WORD_SHIELD = { "Cette protection porte la patience de bien des hivers passés.", "*touche une simple amulette et fait naître une lueur argentée.*", "Certaines promesses survivent aux royaumes. Celle-ci est pour vous.", "*trace un signe ancien d'une main calme et sûre.*" },
        RENEW = { "Une longue route enseigne la patience, même pour guérir.", "*fait glisser un mince filet de lumière sur le bandage.*", "Toute cicatrice n'a pas besoin de disparaître pour laisser place à l'espoir.", "*immobilise ses doigts au-dessus de la blessure et écoute le souffle.*" },
        SHADOW_WORD_PAIN = { "Les souvenirs aussi projettent des ombres. Certaines se guident.", "*referme la main sur son amulette tandis que l'obscurité s'amasse.*", "J'ai appris à ne pas prononcer légèrement les mots sombres.", "*trace lentement une ligne obscure dans l'air.*" },
        RESURRECTION = { "Tous les adieux ne sont pas définitifs.", "*s'agenouille et tient l'amulette au-dessus du cœur immobile.*", "Revenez. Il reste des chants que vous n'avez pas entendus.", "*récite une prière ancienne tandis qu'une lueur argentée touche le défunt.*" },
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
