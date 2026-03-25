// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Sites de vérification d'identité"
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
#align(center, text(weight: "bold", size: 14pt)[Rapport de recherche])
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

= Introduction

Plusieurs sites demandent aujourd'hui une vérification d'identité, que ce soit pour créer un compte ou pour accéder à certaines fonctionnalités. L'objectif est de trouver des sites qui demandent une vérification d'identité et d'analyser comment ils vérifient l'identité des utilisateurs.

= Recherches

Plusieurs catégories de sites ont été testées, les réseaux sociaux, les banques, les casinos en ligne, les plateformes de trading, les sites de rencontre, etc. Certains sites demandent obligatoirement une vérification d'identité, tandis que d'autres ne le font pas ou seulement dans certaines conditions. Les méthodes de vérification varient également, certaines demandent une photo du visage ou d'un document d'identité, d'autres demandent une vidéo de la personne, cela dépend de la sensibilité du service proposé par le site.

== Tableau récapitulatif <tableau>

Les critères ci-dessous ont été analysés pour chaque site, ceux-ci permettront par la suite d'établir une échelle de difficulté pour les attaques :

- *Type* : vérification par photo ou vidéo.
- *Interlocuteur humain* : présence d'un interlocuteur humain pour guider l'utilisateur.
- *Documents d'identité* : nécessité de fournir des documents d'identité.
- *Uniquement via smartphone* : obligation d'utiliser un smartphone.
- *Vérification* : vérification de l'adresse e-mail ou du numéro de téléphone.

*Légende :*

#table(
  columns: (auto, auto),
  [*Couleur*], [*Signification*],
  table.cell(fill: red)[], [Aucune vérification d'identité demandée.],
  table.cell(fill: yellow)[], [Vérification d'identité sous certaines conditions],
  table.cell(fill: green)[], [Vérification d'identité demandée.],
)

#set par(justify: false)

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: horizon + center,
  [*Site*],
  [*Type*],
  [*Interlocuteur humain*],
  [*Documents d'identité*],
  [*Uniquement via smartphone*],
  [*Vérification*],

  table.cell(fill: red)[*TikTok*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Facebook*], [Photo], [?], [Non], [Non], [E-mail],
  table.cell(fill: red)[*Instagram*], [-], [-], [-], [-], [-],
  table.cell(fill: red)[*Snapchat*], [-], [-], [-], [-], [-],
  table.cell(fill: yellow)[*LinkedIn*], [-], [-], [-], [-], [-],
  table.cell(fill: yellow)[*Discord*], [-], [-], [-], [-], [-],
  table.cell(fill: yellow)[*Youtube*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Migros Bank*], [Vidéo], [Non], [Oui], [Non], [?],
  table.cell(fill: green)[*Neon Bank*], [Vidéo], [Oui], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*Swissquote*], [Photo], [Non], [Oui], [Non], [E-mail + n° de téléphone],
  table.cell(fill: red)[*E-ID*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Revolut*], [Vidéo], [Oui], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Yuh*], [Vidéo], [Oui], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*UBS*], [Photo], [?], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Coinbase*], [Vidéo], [Non], [Oui], [Non], [N° de téléphone],
  table.cell(fill: green)[*Swissborg*], [Photo], [?], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Zak Cler*], [Photo et vidéo], [Non], [Oui], [Oui], [E-mail],
  table.cell(fill: red)[*X*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Portail Etat de Vaud*], [Vidéo], [Oui], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Lotterie Romande*], [Photo], [?], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*Mycasino*], [Photo], [?], [Oui], [Non], [-],
  table.cell(fill: green)[*Swiss Casinos*], [Vidéo], [Non], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Casino777*], [Photo], [?], [Oui], [Non], [-],
  table.cell(fill: red)[*Polymarket*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Bet365*], [Photo], [?], [Oui], [Non], [N° de téléphone],
  table.cell(fill: green)[*Binance*], [Vidéo], [?], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Bybit*], [Photo], [?], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Kraken*], [Vidéo], [?], [Oui], [Oui], [E-mail],
  table.cell(fill: green)[*Okx*], [Vidéo], [?], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*Tea Dating Safety for Women*], [Photo], [?], [Non], [Non], [-],
  table.cell(fill: yellow)[*Upwork*], [Photo ou vidéo], [?], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Roblox*], [Vidéo], [?], [Non], [Non], [-],
  table.cell(fill: green)[*Parship*], [Vidéo], [?], [Non], [Non], [-],
  table.cell(fill: red)[*Tinder*], [-], [-], [-], [-], [-],
  table.cell(fill: red)[*Grindr*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*OkCupid*], [Photo], [?], [Non], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Google*], [Photo], [?], [Non], [Non], [-],
)

#set par(justify: true)

= Sites sans vérification d'identité

Comme le montre le tableau du #underline()[@tableau], les sites en rouge ne demandent aucune vérification d'identité, c'est notamment le cas pour les réseaux sociaux. En sachant qu'en Australie une récente loi oblige les plateformes à vérifier l'âge de leurs utilisateurs #footnote[https://www.oaic.gov.au/__data/assets/pdf_file/0025/257515/SMMA-Fact-Sheets-General.pdf], des tests ont été effectués avec un VPN pour voir s'il y avait bien une demande de vérification d'identité. Mais impossible de le savoir, car ces sites ne fonctionnent plus lorsque le VPN est activé, comme le démontrent les images ci-dessous.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("images/tiktok-australie.png"), stroke: 1pt),
    caption: "Erreur lors de la création d'un compte TikTok.",
  ),
  figure(rect(image("images/x.png"), stroke: 1pt), caption: "Erreur lors de la création d'un compte X."),
)

= Sites avec vérification d'identité sous certaines conditions

Ci-dessous, les conditions de vérification d'identité pour les sites en jaune dans le tableau de la #underline()[@tableau].

- LinkedIn : vérification d'identité pour obtenir un badge de vérification, mais il y a une liste d'attente.
- Discord : vérification d'identité si le compte est suspecté d'être utilisé par un mineur.
- Youtube : vérification d'identité si le compte est suspecté d'être utilisé par un mineur.
- Upwork : vérification d'identité pour obtenir un badge de vérification, mais il faut avoir 35 "connects" (en payant).

= Sites avec vérification d'identité

Les sites en vert dans le tableau du #underline()[@tableau] demandent une vérification d'identité obligatoire, c'est sur ceux-ci que les attaques vont se concentrer. Certains semblent plus faciles à attaquer que d'autres, par exemple, ceux qui ne demandent qu'une photo et qui ne vérifient ni adresse e-mail ni numéro de téléphone.

== Classement des sites par difficulté d'attaque

En fonction des critères établis au #underline()[@tableau], il est possible de classer les sites par difficulté d'attaque, par exemple :

- Le site le plus facile à attaquer :
  - Vérifie une photo.
  - N'a pas d'interlocuteur humain.
  - Ne demande pas de documents d'identité.
  - N'oblige pas d'utiliser un smartphone.
  - Ne vérifie pas l'adresse e-mail ni le numéro de téléphone.

- Le site le plus difficile à attaquer :
  - Vérifie une vidéo.
  - A un interlocuteur humain.
  - Demande des documents d'identité.
  - N'autorise pas la création de compte sur ordinateur.
  - Vérifie l'adresse e-mail et le numéro de téléphone.

Ci-dessous, les sites sont classés par difficulté d'attaque, allant du plus facile au plus difficile :

=== Vérification par photo

#emph[Sans vérification du numéro de téléphone et de l'adresse e-mail :]

1. Tea Dating Safety for Women
2. Google
3. Mycasino
4. Casino777


#emph[Avec vérification de l'adresse e-mail :]

5. Facebook
6. Bybit

#emph[Avec vérification du numéro de téléphone :]

7. Bet365

#emph[Avec vérification du numéro de téléphone et de l'adresse e-mail :]

8. Swissquote

#emph[Uniquement via smartphone et avec vérification du numéro de téléphone :]

9. UBS
10. Swissborg
11. OkCupid

#emph[Uniquement via smartphone et avec vérification du numéro de téléphone et de l'adresse e-mail :]

12. Lotterie Romande

=== Vérification par vidéo

#emph[Sans vérification du numéro de téléphone et de l'adresse e-mail :]

13. Migros Bank
14. Roblox
15. Parship

#emph[Avec vérification de l'adresse e-mail :]

16. Portail Etat de Vaud
17. Swiss Casinos
18. Binance

#emph[Avec vérification du numéro de téléphone :]

19. Coinbase

#emph[Uniquement via smartphone et avec vérification de l'adresse e-mail :]

20. Zak Cler
21. Kraken

#emph[Uniquement via smartphone et avec vérification du numéro de téléphone :]

22. Revolut

#emph[Uniquement via smartphone et avec vérification du numéro de téléphone et de l'adresse e-mail :]

23. Neon Bank
24. Yuh
25. Okx

== Captures d'écran

Des captures d'écran de ce qui est demandé pour la vérification d'identité ont été prises pour certains sites lorsque cela était possible.

#grid(
  columns: (1fr, 1fr, 1fr),
  inset: 3pt,
  figure(rect(image("images/loro.jpg"), stroke: 1pt), caption: "Lotterie Romande."),
  figure(rect(image("images/casino777.png"), stroke: 1pt), caption: "Casino777."),
  figure(rect(image("images/bet365.png"), stroke: 1pt), caption: "Bet365."),

  figure(rect(image("images/binance.png"), stroke: 1pt), caption: "Binance."),
  figure(rect(image("images/bybit.png"), stroke: 1pt), caption: "Bybit."),
  figure(rect(image("images/kraken.png"), stroke: 1pt), caption: "Kraken."),

  figure(rect(image("images/okx.png"), stroke: 1pt), caption: "Okx."),
  figure(rect(image("images/tea.png"), stroke: 1pt), caption: "Tea Dating Safety for Women."),
  figure(rect(image("images/roblox.png"), stroke: 1pt), caption: "Roblox."),

  figure(rect(image("images/parship.png"), stroke: 1pt), caption: "Parship."),
  figure(rect(image("images/google.png"), stroke: 1pt), caption: "Google."),
)
