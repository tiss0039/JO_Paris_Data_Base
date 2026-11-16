"""Extraction des médailles des Jeux olympiques de Paris 2024 depuis Wikipédia (anglais).

Ce script n'est pas nécessaire pour utiliser la base : les fichiers produits
(donnees/*.csv et sql/02_donnees.sql) sont versionnés. Il documente et permet
de reproduire la constitution du jeu de données.

Étapes :
1. téléchargement (ou lecture du cache) de deux pages Wikipédia à une révision fixée ;
2. extraction du tableau des médailles officiel et des médaillés de chaque épreuve ;
3. contrôles : 329 épreuves, une seule médaille d'or par épreuve, et totaux
   or/argent/bronze de chaque nation identiques au tableau des médailles ;
4. écriture des fichiers CSV et du script SQL d'insertion.

Bibliothèque standard Python uniquement (Python 3.9+).

Usage :
    python3 resultats_reels/scripts/extraire_wikipedia.py [--cache DOSSIER]

Licence des données produites : CC BY-SA 4.0 (voir resultats_reels/SOURCES.md).
"""
import argparse
import csv
import html
import json
import os
import re
import sys
import time
import urllib.parse
import unicodedata
import urllib.request
from html.parser import HTMLParser

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

API = 'https://en.wikipedia.org/w/api.php'
USER_AGENT = 'olympics-sql-analytics-script/1.0 (educational data analysis; low request rate)'

# Révisions figées des pages sources.
PAGE_TABLEAU = ('2024 Summer Olympics medal table', 1377825167)
PAGE_MEDAILLES = ('List of 2024 Summer Olympics medal winners', 1254728662)

NB_EPREUVES = 329
LIEN_NATION = re.compile(r'^/wiki/(.+)_at_the_2024_Summer_Olympics$')
MEDAILLES = {'Gold': 'Or', 'Silver': 'Argent', 'Bronze': 'Bronze'}

SPORTS_FR = {
    'Archery': "Tir à l'arc", 'Artistic swimming': 'Natation artistique', 'Athletics': 'Athlétisme',
    'Badminton': 'Badminton', 'Basketball': 'Basketball', 'Boxing': 'Boxe', 'Breaking': 'Breaking',
    'Canoeing': 'Canoë-kayak', 'Cycling': 'Cyclisme', 'Diving': 'Plongeon',
    'Equestrian events': 'Sports équestres', 'Fencing': 'Escrime', 'Field hockey': 'Hockey sur gazon',
    'Football': 'Football', 'Golf': 'Golf', 'Gymnastics': 'Gymnastique', 'Handball': 'Handball',
    'Judo': 'Judo', 'Modern pentathlon': 'Pentathlon moderne', 'Rowing': 'Aviron',
    'Rugby sevens': 'Rugby à sept', 'Sailing': 'Voile', 'Shooting': 'Tir', 'Skateboarding': 'Skateboard',
    'Sport climbing': 'Escalade', 'Surfing': 'Surf', 'Swimming': 'Natation', 'Table tennis': 'Tennis de table',
    'Taekwondo': 'Taekwondo', 'Tennis': 'Tennis', 'Triathlon': 'Triathlon', 'Volleyball': 'Volleyball',
    'Water polo': 'Water-polo', 'Weightlifting': 'Haltérophilie', 'Wrestling': 'Lutte',
}

# Intertitres de la page source : catégorie (Hommes, Femmes, Mixte) et/ou discipline.
INTERTITRES = {
    "Men's events": ('Hommes', None), "Women's events": ('Femmes', None), 'Mixed events': ('Mixte', None),
    "Men's": ('Hommes', None), "Women's": ('Femmes', None), 'Men': ('Hommes', None), 'Women': ('Femmes', None),
    "Men's freestyle": ('Hommes', 'Freestyle'), "Women's freestyle": ('Femmes', 'Freestyle'),
    "Men's Greco-Roman": ('Hommes', 'Greco-Roman'),
}
INTERTITRES_SANS_INFO = {'Medalists', 'Events', 'Medal table'}

# Sections où les épreuves hommes, femmes puis mixtes figurent dans des tableaux
# successifs sans intertitre : la catégorie est déduite de l'ordre des tableaux
# (vérifié sur les médaillés, voir le README).
ORDRE_TABLEAUX = {
    ('Swimming', 'Pool swimming'): ['Hommes', 'Femmes', 'Mixte'],
    ('Canoeing', 'Sprint'): ['Hommes', 'Femmes'],
}

# Épreuves dont ni le nom ni les intertitres n'indiquent la catégorie.
CATEGORIE_PAR_DEFAUT = {
    'Equestrian events': 'Ouvert',        # hommes et femmes concourent ensemble
    'Rhythmic gymnastics': 'Femmes',      # discipline exclusivement féminine aux JO
    ('Artistic swimming', 'Duet'): 'Femmes',
    ('Artistic swimming', 'Team'): 'Ouvert',  # règlement ouvert à deux hommes par équipe depuis 2024
}

# Une même personne liée à deux pages différentes (graphies avec et sans diacritiques).
ALIAS_ATHLETES = {
    '/wiki/Ancuta_Bodnar': ('/wiki/Ancuța_Bodnar', 'Ancuța Bodnar'),  # aviron, Roumanie
}

PREFIXES_CATEGORIE = [
    (re.compile(r"^(Men's|Men\b|B-Boys)"), 'Hommes'),
    (re.compile(r"^(Women's|Women\b|B-Girls)"), 'Femmes'),
    (re.compile(r'\bmixed\b', re.I), 'Mixte'),
]


# ---------------------------------------------------------------------------
# Téléchargement
# ---------------------------------------------------------------------------

def telecharger(titre, revision, cache):
    """Renvoie le HTML rendu d'une révision de page, en le mettant en cache."""
    chemin = os.path.join(cache, f'{revision}.json')
    if not os.path.exists(chemin):
        parametres = urllib.parse.urlencode({
            'action': 'parse', 'oldid': revision, 'prop': 'text', 'format': 'json',
            'formatversion': 2, 'maxlag': 5,
        })
        requete = urllib.request.Request(f'{API}?{parametres}', headers={
            'User-Agent': USER_AGENT, 'Api-User-Agent': USER_AGENT})
        for essai in range(4):
            try:
                with urllib.request.urlopen(requete, timeout=60) as reponse:
                    contenu = json.loads(reponse.read().decode('utf-8'))
                if 'parse' in contenu:
                    break
                raise RuntimeError(contenu.get('error', contenu))
            except Exception as erreur:  # limite de débit, maxlag, réseau
                if essai == 3:
                    raise
                attente = 60 * (essai + 1)
                print(f'  {titre} : {erreur} ; nouvel essai dans {attente} s', file=sys.stderr)
                time.sleep(attente)
        os.makedirs(cache, exist_ok=True)
        with open(chemin, 'w', encoding='utf-8') as fichier:
            json.dump(contenu, fichier)
        time.sleep(5)
    with open(chemin, encoding='utf-8') as fichier:
        contenu = json.load(fichier)
    assert contenu['parse']['title'] == titre, contenu['parse']['title']
    return contenu['parse']['text']


# ---------------------------------------------------------------------------
# Lecture du HTML
# ---------------------------------------------------------------------------

class Page(HTMLParser):
    """Liste, dans l'ordre du document, les intertitres h2/h3/h4 et les tableaux « wikitable »."""

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.elements = []  # ('titre', niveau, texte) ou ('tableau', lignes, légende)
        self.profondeur = 0
        self.titre = None
        self.lignes = self.ligne = self.cellule = self.lien = None
        self.legende = None

    def handle_starttag(self, balise, attributs):
        a = dict(attributs)
        if balise in ('h2', 'h3', 'h4') and self.profondeur == 0:
            self.titre = [balise, '']
        elif balise == 'table':
            self.profondeur += 1
            if self.profondeur == 1 and 'wikitable' in (a.get('class') or ''):
                self.lignes, self.legende = [], ''
        elif self.lignes is not None and self.profondeur == 1:
            if balise == 'caption':
                self.legende = ''
            elif balise == 'tr':
                self.ligne = []
            elif balise in ('td', 'th') and self.ligne is not None:
                self.cellule = {'texte': '', 'groupes': [[[]]],
                                'rowspan': int(a.get('rowspan', 1) or 1),
                                'colspan': int(a.get('colspan', 1) or 1)}
            elif self.cellule is not None:
                if balise == 'br':        # nouvelle ligne dans la cellule
                    self.cellule['groupes'][-1].append([])
                elif balise == 'hr':      # séparation entre ex aequo
                    self.cellule['groupes'].append([[]])
                elif balise == 'a':
                    self.lien = {'href': urllib.parse.unquote(a.get('href', '')), 'texte': ''}

    def handle_endtag(self, balise):
        if balise in ('h2', 'h3', 'h4') and self.titre and self.titre[0] == balise:
            self.elements.append(('titre', int(balise[1]), re.sub(r'\s+', ' ', self.titre[1]).strip()))
            self.titre = None
        elif balise == 'table':
            if self.profondeur == 1 and self.lignes is not None:
                self.elements.append(('tableau', self.lignes, self.legende.strip()))
                self.lignes = None
            self.profondeur -= 1
        elif self.lignes is not None and self.profondeur == 1:
            if balise == 'a' and self.lien is not None and self.cellule is not None:
                self.lien['texte'] = self.lien['texte'].strip()
                self.cellule['groupes'][-1][-1].append(self.lien)
                self.lien = None
            elif balise in ('td', 'th') and self.cellule is not None:
                self.cellule['texte'] = re.sub(r'\s+', ' ', self.cellule['texte']).strip()
                self.ligne.append(self.cellule)
                self.cellule = None
            elif balise == 'tr' and self.ligne is not None:
                self.lignes.append(self.ligne)
                self.ligne = None

    def handle_data(self, donnees):
        if self.titre is not None:
            self.titre[1] += donnees
        if self.legende is not None and self.lignes is not None and self.ligne is None:
            self.legende += donnees
        if self.cellule is not None:
            self.cellule['texte'] += donnees
        if self.lien is not None:
            self.lien['texte'] += donnees


def grille(lignes):
    """Développe les fusions de cellules (rowspan/colspan) en une grille rectangulaire."""
    resultat, en_attente = [], {}
    for ligne in lignes:
        sortie, colonne, cellules = [], 0, list(ligne)
        while cellules or colonne in en_attente:
            if colonne in en_attente:
                cellule, reste = en_attente.pop(colonne)
                if reste > 1:
                    en_attente[colonne] = (cellule, reste - 1)
                sortie.append(cellule)
                colonne += 1
                continue
            cellule = cellules.pop(0)
            for _ in range(cellule['colspan']):
                sortie.append(cellule)
                if cellule['rowspan'] > 1:
                    en_attente[colonne] = (cellule, cellule['rowspan'] - 1)
                colonne += 1
        resultat.append(sortie)
    return resultat


def nom_nation(lien):
    m = LIEN_NATION.match(lien['href'])
    return lien['texte'] or m.group(1).replace('_', ' ')


def est_athlete(lien):
    page = lien['href'][len('/wiki/'):]
    return (lien['href'].startswith('/wiki/') and ':' not in page and lien['texte']
            and lien['texte'] != 'details' and 'records' not in page.lower()
            and not LIEN_NATION.match(lien['href']))


def medailles_cellule(cellule):
    """Renvoie [(nation, page_nation, [(athlète, page_athlète)])] pour une cellule de médaille.

    Une cellule contient plusieurs entrées en cas d'ex aequo (séparées par <hr>)."""
    entrees = []
    for groupe in cellule['groupes']:
        nation, athletes = None, []
        for ligne in groupe:
            for lien in ligne:
                if LIEN_NATION.match(lien['href']):
                    if nation is not None:  # deuxième nation sans séparateur : nouvelle entrée
                        entrees.append((nation, athletes))
                        athletes = []
                    nation = (nom_nation(lien), lien['href'])
                elif est_athlete(lien):
                    athletes.append((lien['texte'], lien['href']))
        if nation is not None:
            entrees.append((nation, athletes))
    return [(n[0], n[1], a) for n, a in entrees]


# ---------------------------------------------------------------------------
# Extraction
# ---------------------------------------------------------------------------

def tableau_officiel(html_page):
    page = Page()
    page.feed(html_page)
    tableaux = [e for e in page.elements if e[0] == 'tableau'
                and re.sub(r'\[\w+\]', '', e[2]) == '2024 Summer Olympics medal table']
    assert len(tableaux) == 1, 'tableau des médailles introuvable'
    g = grille(tableaux[0][1])
    assert [c['texte'] for c in g[0]] == ['Rank', 'NOC', 'Gold', 'Silver', 'Bronze', 'Total'], g[0]
    lignes, totaux = [], None
    for ligne in g[1:]:
        textes = [c['texte'] for c in ligne]
        if textes[0].startswith('Totals'):
            totaux = [int(t.replace(',', '')) for t in textes[-4:]]
            continue
        liens = [l for groupe in ligne[1]['groupes'] for li in groupe for l in li if LIEN_NATION.match(l['href'])]
        assert len(liens) == 1, textes
        lignes.append({'nation': nom_nation(liens[0]), 'page': liens[0]['href'], 'rang': int(textes[0]) if textes[0].isdigit() else None,
                       'or': int(textes[2]), 'argent': int(textes[3]), 'bronze': int(textes[4]),
                       'total': int(textes[5])})
    assert totaux is not None
    return lignes, totaux


def categorie_et_discipline(sport, titres, nom, rang_tableau):
    """Déduit la catégorie (Hommes, Femmes, Mixte, Ouvert) et la discipline d'une épreuve."""
    categorie, discipline = None, None
    for titre in titres:
        if titre in INTERTITRES:
            cat, disc = INTERTITRES[titre]
            categorie = categorie or cat
            discipline = discipline or disc
        elif titre and titre not in INTERTITRES_SANS_INFO:
            discipline = titre
    if sport == 'Basketball':
        discipline = '3x3' if '3x3' in nom else '5x5'
    for motif, cat in PREFIXES_CATEGORIE:
        if motif.search(nom):
            return cat, discipline
    if categorie:
        return categorie, discipline
    if (sport, discipline) in ORDRE_TABLEAUX:
        return ORDRE_TABLEAUX[(sport, discipline)][rang_tableau], discipline
    for cle in (sport, discipline, (sport, nom)):
        if cle in CATEGORIE_PAR_DEFAUT:
            return CATEGORIE_PAR_DEFAUT[cle], discipline
    raise ValueError(f'catégorie inconnue : {sport} / {titres} / {nom}')


def medailles_par_epreuve(html_page):
    page = Page()
    page.feed(html_page)
    sport, h3, h4 = None, None, None
    rangs = {}  # nombre de tableaux déjà vus par (sport, h3, h4)
    resultats = []
    for element in page.elements:
        if element[0] == 'titre':
            _, niveau, texte = element
            if niveau == 2:
                sport, h3, h4 = texte, None, None
            elif niveau == 3:
                h3, h4 = texte, None
            else:
                h4 = texte
            continue
        lignes = element[1]
        if not lignes or [c['texte'] for c in lignes[0]][:1] not in (['Event'], ['Games']):
            continue  # tableaux des médailles par sport, records, etc.
        contexte = (sport, h3, h4)
        rang_tableau = rangs.get(contexte, 0)
        rangs[contexte] = rang_tableau + 1
        g = grille(lignes)
        entete = [c['texte'] for c in g[0]]
        colonnes = {m: entete.index(m) for m in MEDAILLES}
        vues = set()
        for ligne in g[1:]:
            nom = re.sub(r'\[\w+\]', '', ligne[0]['texte'])
            nom = re.sub(r'\s*details\s*$', '', nom).strip()
            if not nom:
                continue  # ligne de séparation
            categorie, discipline = categorie_et_discipline(sport, [h3, h4], nom, rang_tableau)
            for medaille, i in colonnes.items():
                cellule = ligne[i] if i < len(ligne) else None
                if cellule is None or id(cellule) in vues:
                    continue
                vues.add(id(cellule))
                for nation, page_nation, athletes in medailles_cellule(cellule):
                    resultats.append({'sport': sport, 'discipline': discipline, 'categorie': categorie,
                                      'epreuve': nom, 'medaille': MEDAILLES[medaille], 'nation': nation,
                                      'page_nation': page_nation, 'athletes': athletes})
    return resultats


# ---------------------------------------------------------------------------
# Contrôles et écriture
# ---------------------------------------------------------------------------

def controler(officiel, totaux, medailles):
    erreurs = []
    epreuves = {}
    for m in medailles:
        cle = (m['sport'], m['discipline'], m['categorie'], m['epreuve'])
        epreuves.setdefault(cle, []).append(m['medaille'])
    if len(epreuves) != NB_EPREUVES:
        erreurs.append(f'{len(epreuves)} épreuves au lieu de {NB_EPREUVES}')
    erreurs += [f"{cle} : {v.count('Or')} médaille(s) d'or" for cle, v in epreuves.items() if v.count('Or') != 1]
    if sum(l['or'] for l in officiel) != totaux[0] or len(officiel) == 0:
        erreurs.append('tableau officiel incohérent avec sa ligne de totaux')
    calcule = {}
    for m in medailles:
        compte = calcule.setdefault(m['nation'], {'Or': 0, 'Argent': 0, 'Bronze': 0})
        compte[m['medaille']] += 1
    attendu = {l['nation']: {'Or': l['or'], 'Argent': l['argent'], 'Bronze': l['bronze']} for l in officiel}
    for nation in sorted(set(calcule) | set(attendu)):
        if calcule.get(nation) != attendu.get(nation):
            erreurs.append(f'{nation} : extrait {calcule.get(nation)}, officiel {attendu.get(nation)}')
    sans_athlete = [m for m in medailles if not m['athletes']]
    erreurs += [f"médaille sans athlète : {m['epreuve']} {m['medaille']} {m['nation']}" for m in sans_athlete]
    return erreurs


def homonymes_a_verifier(tables):
    """Athlètes distincts dont les noms ne diffèrent que par les accents, la casse ou les tirets."""
    groupes = {}
    for _, nom, page in tables['athlete'][1]:
        cle = ''.join(c for c in unicodedata.normalize('NFKD', nom.lower().replace('-', ' '))
                      if not unicodedata.combining(c))
        groupes.setdefault(cle, []).append(page.rsplit('/', 1)[1])
    return {cle: pages for cle, pages in groupes.items() if len(pages) > 1}


def ecrire_csv(nom, colonnes, lignes):
    chemin = os.path.join(RACINE, 'donnees', nom)
    with open(chemin, 'w', encoding='utf-8', newline='') as fichier:
        ecrivain = csv.writer(fichier, lineterminator='\n')
        ecrivain.writerow(colonnes)
        ecrivain.writerows(lignes)


def sql_valeur(v):
    if v is None:
        return 'NULL'
    if isinstance(v, int):
        return str(v)
    return "'" + str(v).replace('\\', '\\\\').replace("'", "''") + "'"


def construire(officiel, medailles):
    """Attribue les identifiants et renvoie les tables sous forme de listes de tuples."""
    nations = {}
    for l in officiel:  # ordre du tableau officiel
        nations[l['nation']] = (len(nations) + 1, l['nation'], 'https://en.wikipedia.org' + l['page'])
    sports, epreuves, athletes = {}, {}, {}
    table_medailles, liens = [], []
    ordre = {'Or': 1, 'Argent': 2, 'Bronze': 3}
    for m in medailles:
        if m['sport'] not in sports:
            sports[m['sport']] = (len(sports) + 1, m['sport'], SPORTS_FR[m['sport']])
        cle = (m['sport'], m['discipline'], m['categorie'], m['epreuve'])
        if cle not in epreuves:
            epreuves[cle] = (len(epreuves) + 1, sports[m['sport']][0], m['discipline'], m['categorie'], m['epreuve'])
        id_medaille = len(table_medailles) + 1
        table_medailles.append((id_medaille, epreuves[cle][0], nations[m['nation']][0], m['medaille'],
                                ordre[m['medaille']]))
        for nom, page in m['athletes']:
            page, nom = ALIAS_ATHLETES.get(page, (page, nom))
            if page not in athletes:
                athletes[page] = (len(athletes) + 1, nom, 'https://en.wikipedia.org' + page)
            lien = (id_medaille, athletes[page][0])
            if lien not in liens:
                liens.append(lien)
    officiel_ids = [(nations[l['nation']][0], l['rang'], l['or'], l['argent'], l['bronze'], l['total'])
                    for l in officiel]
    return {
        'nation': (['id_nation', 'nom', 'page_wikipedia'], list(nations.values())),
        'tableau_officiel': (['id_nation', 'rang', 'nb_or', 'nb_argent', 'nb_bronze', 'nb_total'], officiel_ids),
        'sport': (['id_sport', 'nom', 'nom_fr'], list(sports.values())),
        'epreuve': (['id_epreuve', 'id_sport', 'discipline', 'categorie', 'nom'], list(epreuves.values())),
        'medaille': (['id_medaille', 'id_epreuve', 'id_nation', 'type_medaille', 'rang_medaille'], table_medailles),
        'athlete': (['id_athlete', 'nom', 'page_wikipedia'], list(athletes.values())),
        'medaille_athlete': (['id_medaille', 'id_athlete'], liens),
    }


def ecrire_sql(tables):
    chemin = os.path.join(RACINE, 'sql', '02_donnees.sql')
    with open(chemin, 'w', encoding='utf-8', newline='\n') as f:
        f.write('-- Données réelles des JO de Paris 2024 : médailles par épreuve.\n')
        f.write('-- Fichier généré par scripts/extraire_wikipedia.py : ne pas modifier à la main.\n')
        f.write(f'-- Sources : Wikipédia (en), « {PAGE_TABLEAU[0]} » (révision {PAGE_TABLEAU[1]}) et\n')
        f.write(f'-- « {PAGE_MEDAILLES[0]} » (révision {PAGE_MEDAILLES[1]}).\n')
        f.write('-- Licence : CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/), voir SOURCES.md.\n\n')
        f.write('SET NAMES utf8mb4;\nSTART TRANSACTION;\n\n')
        for table in ('nation', 'tableau_officiel', 'sport', 'epreuve', 'medaille', 'athlete', 'medaille_athlete'):
            colonnes, lignes = tables[table]
            for debut in range(0, len(lignes), 200):
                f.write(f"INSERT INTO {table} ({', '.join(colonnes)}) VALUES\n")
                f.write(',\n'.join('(' + ', '.join(sql_valeur(v) for v in l) + ')'
                                   for l in lignes[debut:debut + 200]))
                f.write(';\n\n')
        f.write('COMMIT;\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    parser.add_argument('--cache', default=os.path.join(RACINE, '.cache'),
                        help='dossier des pages téléchargées (défaut : resultats_reels/.cache)')
    args = parser.parse_args()

    officiel, totaux = tableau_officiel(telecharger(*PAGE_TABLEAU, args.cache))
    medailles = medailles_par_epreuve(telecharger(*PAGE_MEDAILLES, args.cache))
    erreurs = controler(officiel, totaux, medailles)
    if erreurs:
        print('Contrôles en échec :', *erreurs, sep='\n  ', file=sys.stderr)
        sys.exit(1)

    tables = construire(officiel, medailles)
    for table, (colonnes, lignes) in tables.items():
        ecrire_csv(f'{table}.csv', colonnes, lignes)
    ecrire_sql(tables)
    for cle, pages in homonymes_a_verifier(tables).items():
        print(f'À vérifier (même nom, pages différentes) : {cle} -> {pages}')
    print(f"Contrôles réussis : {len(tables['epreuve'][1])} épreuves, {len(tables['medaille'][1])} médailles "
          f"({totaux[0]} or, {totaux[1]} argent, {totaux[2]} bronze), {len(tables['nation'][1])} nations, "
          f"{len(tables['athlete'][1])} athlètes.")


if __name__ == '__main__':
    main()
