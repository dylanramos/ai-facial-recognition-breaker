#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Installation du démonstrateur"
#let location_and_date = [Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")]
#let academic_year = "2025-2026"

// Page de garde

#grid(
  columns: (1fr, 2fr),
  align: (left, right),
  image("images/logo-heig-vd.png", width: 3cm),
  [
    Département des Technologies de l'information et de la communication (TIC) \
    Filière Informatique et systèmes de communication \
    Orientation Sécurité informatique
  ],
)

#v(4cm)
#align(center, text(weight: "bold", size: 14pt)[Guide d'installation])
#align(center, text(weight: "bold", size: 26pt)[#title])
#v(4cm)

#align(left, [#block(width: 70%, [
  #table(
    stroke: none,
    columns: (50%, 50%),
    [*Étudiant*], [*#author*],
    [*Enseignant responsable*], [#professor],
    [*Année académique*], [#academic_year],
  )
])])

#v(2cm)

#align(right, location_and_date)

#set page(
  margin: 2.5cm,
  header: context [
    #set text(size: 9pt)
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper(title), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), author,
      )
    }
  ],
  footer: context [
    #set text(size: 9pt)
    #let selector = selector(heading).before(here())
    #let headings = query(selector)
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        counter(page).display(), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), counter(page).display(),
      )
    }
  ],
)
#set par(justify: true)

// Configuration des titres

#set heading(numbering: "1.1")
#show heading.where(level: 1): it => {
  set text(size: 17pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.2cm)
}
#show heading.where(level: 2): it => {
  set text(size: 14pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.1cm)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Introduction

Ce document présente les étapes nécessaires pour installer et configurer le démonstrateur sous Linux et Windows. Les prérequis sont les suivants :

- Python 3.12 ou supérieur
- Clé API de #link("https://kie.ai/api-key")[#underline[kie.ai]]

= Installation sous Linux

*Étape 1 : installer le module v4l2loopback*

#sourcecode[```sh
sudo apt install v4l2loopback-dkms v4l2loopback-utils
```]

*Étape 2 : créer l'environnement virtuel et installer les dépendances*

#sourcecode[```sh
cd src
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```]

*Étape 3 : renseigner la variable d'environnement*

#sourcecode[```sh
cp .env.example .env
nano .env
# Remplacer xxx par la clé API de kie.ai
```]

*Étape 4 : lancer le démonstrateur*

#sourcecode[```sh
python3 main.py --help
```]

= Installation sous Windows

*Étape 1 : installer OBS Studio*

Télécharger et installer OBS Studio depuis #link("https://obsproject.com/download")[#underline[le site officiel]].

*Étape 2 : créer l'environnement virtuel et installer les dépendances*

#sourcecode[```sh
cd src
python -m venv venv
.\venv\Scripts\activate
pip install -r requirements.txt
```]

*Étape 3 : renseigner la variable d'environnement*

#sourcecode[```sh
copy .env.example .env
notepad .env
# Remplacer xxx par la clé API de kie.ai
```]

*Étape 4 : lancer le démonstrateur*

#sourcecode[```sh
python main.py --help
```]