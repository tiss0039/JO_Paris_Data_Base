"""Génère les graphiques du README à partir des fichiers CSV de resultats_reels/donnees/.

Outil de documentation uniquement (non nécessaire pour utiliser la base).
Dépendance : matplotlib (pip install matplotlib).

Usage :
    python3 resultats_reels/scripts/graphiques.py

Les valeurs représentées sont les mêmes que celles des requêtes A1, A2 et A6
de sql/04_analyses.sql (agrégations identiques, recalculées à partir des CSV).
"""
import csv
import os
from collections import Counter, defaultdict

import matplotlib

matplotlib.use('Agg')
import matplotlib.pyplot as plt  # noqa: E402

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DONNEES = os.path.join(RACINE, 'donnees')
SORTIE = os.path.join(RACINE, 'graphiques')

# Palette catégorielle validée (contraste daltonisme) et couleurs de texte.
SURFACE = '#fcfcfb'
TEXTE = '#0b0b0b'
TEXTE_SECONDAIRE = '#52514e'
GRILLE = '#e4e3df'
COULEURS = {'Or': '#2a78d6', 'Argent': '#eb6834', 'Bronze': '#1baf7a'}
SOURCE = ('Source : Wikipédia (CC BY-SA 4.0), JO de Paris 2024 – données dérivées de Wikipédia, '
          'non officielles (CIO)')

plt.rcParams.update({
    'font.family': 'DejaVu Sans', 'font.size': 10, 'text.color': TEXTE,
    'axes.edgecolor': GRILLE, 'axes.labelcolor': TEXTE_SECONDAIRE,
    'xtick.color': TEXTE_SECONDAIRE, 'ytick.color': TEXTE,
    'figure.facecolor': SURFACE, 'axes.facecolor': SURFACE, 'savefig.facecolor': SURFACE,
})


def lire(nom):
    with open(os.path.join(DONNEES, nom), encoding='utf-8') as fichier:
        return list(csv.DictReader(fichier))


def preparer_axes(ax, titre, sous_titre):
    ax.set_title(titre, loc='left', fontsize=13, fontweight='bold', pad=26)
    ax.text(0, 1.02, sous_titre, transform=ax.transAxes, fontsize=9.5, color=TEXTE_SECONDAIRE)
    for cote in ('top', 'right', 'left'):
        ax.spines[cote].set_visible(False)
    ax.tick_params(axis='y', length=0)
    ax.grid(axis='x', color=GRILLE, linewidth=0.8)
    ax.set_axisbelow(True)


def barres_empilees(ax, libelles, valeurs):
    """Barres horizontales empilées or / argent / bronze, avec le total en bout de barre."""
    gauche = [0] * len(libelles)
    for medaille in ('Or', 'Argent', 'Bronze'):
        largeurs = [v[medaille] for v in valeurs]
        ax.barh(libelles, largeurs, left=gauche, height=0.68, color=COULEURS[medaille],
                edgecolor=SURFACE, linewidth=1.5, label=medaille)
        gauche = [g + l for g, l in zip(gauche, largeurs)]
    for y, total in enumerate(gauche):
        ax.text(total + max(gauche) * 0.01, y, str(total), va='center', fontsize=9, color=TEXTE_SECONDAIRE)
    ax.invert_yaxis()
    ax.legend(ncols=3, loc='lower right', frameon=False, bbox_to_anchor=(1, 1.0), fontsize=9)


def note_source(fig):
    fig.text(0.01, 0.01, SOURCE, fontsize=8, color=TEXTE_SECONDAIRE)


def main():
    os.makedirs(SORTIE, exist_ok=True)
    nations = {n['id_nation']: n['nom'] for n in lire('nation.csv')}
    officiel = lire('tableau_officiel.csv')
    epreuves = {e['id_epreuve']: e for e in lire('epreuve.csv')}
    sports = {s['id_sport']: s['nom_fr'] for s in lire('sport.csv')}
    medailles = lire('medaille.csv')

    # 1. Les 15 premières nations du tableau officiel (classement à l'or).
    top = sorted((o for o in officiel if o['rang']), key=lambda o: int(o['rang']))[:15]
    fig, ax = plt.subplots(figsize=(9, 6.2))
    barres_empilees(ax, [f"{o['rang']}. {nations[o['id_nation']]}" for o in top],
                    [{'Or': int(o['nb_or']), 'Argent': int(o['nb_argent']), 'Bronze': int(o['nb_bronze'])}
                     for o in top])
    preparer_axes(ax, 'Les 15 premières nations du tableau des médailles',
                  "Classées à l'or ; total des médailles en bout de barre")
    ax.set_xlabel('Nombre de médailles')
    note_source(fig)
    fig.tight_layout(rect=(0, 0.03, 1, 1))
    fig.savefig(os.path.join(SORTIE, 'top15_nations.png'), dpi=150)
    plt.close(fig)

    # 2. Concentration : part cumulée des médailles selon le nombre de nations.
    totaux = sorted(Counter(m['id_nation'] for m in medailles).values(), reverse=True)
    cumul, somme = [], 0
    for t in totaux:
        somme += t
        cumul.append(100 * somme / sum(totaux))
    x = list(range(1, len(totaux) + 1))
    fig, ax = plt.subplots(figsize=(9, 5))
    ax.plot(x, cumul, color=COULEURS['Or'], linewidth=2)
    for seuil in (50, 75, 90):
        n = next(i for i, c in zip(x, cumul) if c >= seuil)
        ax.plot([n], [cumul[n - 1]], 'o', markersize=7, color=COULEURS['Or'],
                markeredgecolor=SURFACE, markeredgewidth=2)
        ax.annotate(f'{seuil} % des médailles\n→ {n} nations sur {len(totaux)}', (n, cumul[n - 1]),
                    xytext=(10, -26), textcoords='offset points', fontsize=9, color=TEXTE)
    preparer_axes(ax, 'Concentration des médailles',
                  'Part cumulée des 1 044 médailles, nations triées par nombre de médailles')
    ax.grid(axis='y', color=GRILLE, linewidth=0.8)
    ax.set_xlim(0, len(totaux) + 1)
    ax.set_ylim(0, 102)
    ax.set_xlabel('Nombre de nations (de la plus médaillée à la moins médaillée)')
    ax.set_ylabel('Part cumulée des médailles (%)')
    ax.tick_params(axis='y', colors=TEXTE_SECONDAIRE)
    note_source(fig)
    fig.tight_layout(rect=(0, 0.03, 1, 1))
    fig.savefig(os.path.join(SORTIE, 'concentration_medailles.png'), dpi=150)
    plt.close(fig)

    # 3. La France par sport.
    id_france = next(i for i, nom in nations.items() if nom == 'France')
    par_sport = defaultdict(Counter)
    for m in medailles:
        if m['id_nation'] == id_france:
            par_sport[sports[epreuves[m['id_epreuve']]['id_sport']]][m['type_medaille']] += 1
    ordre = sorted(par_sport, key=lambda s: (-sum(par_sport[s].values()), -par_sport[s]['Or'], s))
    fig, ax = plt.subplots(figsize=(9, 6.6))
    barres_empilees(ax, ordre, [par_sport[s] for s in ordre])
    total_france = sum(sum(c.values()) for c in par_sport.values())
    preparer_axes(ax, f'Les {total_france} médailles de la France, pays hôte, par sport',
                  f'{len(ordre)} sports médaillés ; total par sport en bout de barre')
    ax.set_xlabel('Nombre de médailles')
    note_source(fig)
    fig.tight_layout(rect=(0, 0.03, 1, 1))
    fig.savefig(os.path.join(SORTIE, 'france_par_sport.png'), dpi=150)
    plt.close(fig)
    print('Graphiques écrits dans', SORTIE)


if __name__ == '__main__':
    main()
