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
