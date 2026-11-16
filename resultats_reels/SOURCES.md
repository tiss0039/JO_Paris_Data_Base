# Sources et licence des données réelles

## Sources

Les données du dossier `resultats_reels/` proviennent de deux pages de Wikipédia en anglais, lues à une révision fixée :

| Page | Révision | Contenu utilisé |
|---|---|---|
| [2024 Summer Olympics medal table](https://en.wikipedia.org/w/index.php?title=2024_Summer_Olympics_medal_table&oldid=1377825167) | 1377825167 | Tableau des médailles par nation (rang, or, argent, bronze, total) |
| [List of 2024 Summer Olympics medal winners](https://en.wikipedia.org/w/index.php?title=List_of_2024_Summer_Olympics_medal_winners&oldid=1254728662) | 1254728662 | Médaillés de chaque épreuve (nation et athlètes) |

Auteurs : contributeurs de Wikipédia. L'historique de chaque page indique la liste des contributions :

- [historique du tableau des médailles](https://en.wikipedia.org/w/index.php?title=2024_Summer_Olympics_medal_table&action=history) ;
- [historique de la liste des médaillés](https://en.wikipedia.org/w/index.php?title=List_of_2024_Summer_Olympics_medal_winners&action=history).

La seconde page reprend des sections des 35 pages de sport nommées « *Sport* at the 2024 Summer Olympics », par exemple [Swimming at the 2024 Summer Olympics](https://en.wikipedia.org/wiki/Swimming_at_the_2024_Summer_Olympics). Leurs contributeurs, listés dans l'historique de chaque page, sont aussi auteurs des données. Ces sections ont été lues dans leur version du jour du téléchargement.

Les pages ont été téléchargées le 15 novembre 2026 avec l'API de Wikipédia (`action=parse`).

Il s'agit de données dérivées de Wikipédia : ce ne sont pas des données officielles du CIO.

## Licence

Le texte de Wikipédia est publié sous licence [Creative Commons Attribution – Partage dans les mêmes conditions 4.0 (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/deed.fr).

Les fichiers suivants sont des adaptations de ces données et sont donc diffusés sous la **même licence CC BY-SA 4.0** :

- `resultats_reels/donnees/*.csv` ;
- `resultats_reels/sql/02_donnees.sql` ;
- `resultats_reels/graphiques/*.png` : chaque image porte la mention « Source : Wikipédia (CC BY-SA 4.0) ».

Ces fichiers ne contiennent pas eux-mêmes toute l'attribution ; ce document la complète et doit les accompagner en cas de rediffusion. L'en-tête de `02_donnees.sql` rappelle les sources, les révisions et la licence.

## Modifications apportées

- Extraction des tableaux HTML et passage à un modèle relationnel (nations, sports, épreuves, médailles, athlètes), avec des identifiants numériques attribués dans l'ordre de la source.
- Une ligne par médaille attribuée : un ex aequo réuni dans une même cellule de la source donne deux lignes ; une mention « non attribuée » ne donne aucune ligne.
- Nettoyage des libellés : suppression du lien « details », des appels de note (par exemple « [6] ») et des symboles accolés aux noms de nations ; rang « – » (délégation non classée) remplacé par une valeur vide.
- Traduction des couleurs de médaille (Gold, Silver, Bronze → Or, Argent, Bronze).
- Ajout d'une catégorie d'épreuve (Hommes, Femmes, Mixte, Ouvert) et d'une discipline, déduites des intertitres et des noms d'épreuves.
- Traduction en français des noms de sports (les noms d'épreuves et de nations restent en anglais).
- Fusion de deux liens désignant la même athlète (Ancuța Bodnar, liée à deux pages différentes).
- Graphiques : agrégations calculées à partir des fichiers CSV (médailles par nation, part cumulée, médailles de la France par sport).
- Aucun résultat ni nombre de médailles n'a été ajouté ou corrigé à la main. En dehors de la fusion ci-dessus et des règles de catégorie, documentées dans le script, toutes les valeurs viennent de la source. Le contrôle de cohérence compare les médailles extraites au tableau des médailles publié sur la même source.

La méthode complète est décrite dans le [README](../README.md#partie-2--résultats-réels-des-jo-de-paris-2024) et dans `scripts/extraire_wikipedia.py`.
