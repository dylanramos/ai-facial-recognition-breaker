= Sites de vérification d'identité

== Création de comptes

J'utilise des alias pour chaque compte pour les adresses email.

Observations : avec un alias on demande souvent de remplir un captcha, peut-être utiliser un compte google?

== Tests avec les réseaux sociaux

J'ai fait des tests avec les réseaux sociaux car la plupart n'ont pas de vérification d'identité, contrairement aux services sensibles comme les banques.

Légende :

#table(
  columns: (auto, auto),
  [*Couleur*], [*Signification*],
  table.cell(fill: red)[], [Aucune vérification d'identité demandée.],
  table.cell(fill: yellow)[], [Vérification d'identité sous certaines conditions],
  table.cell(fill: green)[], [Vérification d'identité demandée.],
)

=== TikTok

Une vérification est nécessaire (18 ans) si on veut lancer un live mais il faut avoir au moins 1000 followers. Difficile à tester.

#text(fill: red)[
  *Sans VPN*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#text(fill: red)[
  *Avec VPN en France*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#grid(
  columns: (1fr, 1fr),
  [

    #text(fill: red)[
      *Avec VPN en Australie*
      - Sur PC
      - Navigation privée
      - Inscription avec email + mot de passe
    ]
  ],
  grid.cell(
    align: right,
    image("../images/b-sites-enregistrement/tiktok-australie.png", width: 80%),
  ),
)

=== Facebook

#text(fill: green)[*Résultat : * demande un selfie pour vérifier que je suis humain.]

=== Instagram

#text(fill: red)[
  *Sans VPN*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#grid(
  columns: (1fr, 1fr),
  [
    #text(fill: yellow)[
      *Avec VPN en France*

      - Sur PC
      - Navigation privée
      - Inscription avec email + mot de passe
      - Demande de remplir un captcha puis un numéro de téléphone.
    ]
  ],
  grid.cell(
    align: right,
    image("../images/b-sites-enregistrement/instagram-france.png", width: 80%),
  ),
)

#grid(
  columns: (1fr, 1fr),
  [
    #text(fill: yellow)[
      *Meta Verified (sans VPN)*

      - Vérification des documents d'identité (photo)
      - Payant
    ]
  ],
  grid.cell(
    align: right,
    image("../images/b-sites-enregistrement/instagram-verified.png", width: 60%),
  ),
)

=== Snapchat

#text(fill: red)[
  *Sans VPN*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#text(fill: red)[
  *Avec VPN en France*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#text(fill: red)[
  *Avec VPN en Australie*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

=== LinkedIn

#text(fill: red)[
  *Création d'un compte*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#text(fill: yellow)[
  *Badge*

  - Vérification si on veut obtenir le badge mais il y a une liste d'attente.
]

=== Discord

#text(fill: red)[
  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#text(fill: yellow)[
  *Info*

  - Vérification des mineurs dès mars 2026.
]

=== Youtube

#text(fill: red)[
  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

#text(fill: yellow)[
  *Info*

  - Vérification uniquement si détecté comme mineur.
]

=== X

#grid(
  columns: (1fr, 1fr),
  [
    #text(fill: red)[
      *Avec un alias*

      - Sur PC
      - Navigation privée
      - Inscription avec email + mot de passe
    ]
  ],
  grid.cell(
    align: right,
    image("../images/b-sites-enregistrement/x.png", width: 60%),
  ),
)

#text(fill: red)[
  *Avec un compte google*

  - Sur PC
  - Navigation privée
  - Inscription avec email + mot de passe
]

== Remarques

Vérification du numéro de téléphone complique l'automatisation.

=== Swissborg

Mon numéro de téléphone a déjà été utilisé pour créer un compte, je ne peux pas le réutiliser.

=== Portail Etat de Vaud

Je dois mettre un numéro AVS valide.

=== Lotterie Romande

#image("../images/b-sites-enregistrement/loro.jpg", width: 20%)

=== Casino777

#image("../images/b-sites-enregistrement/casino777.png", width: 30%)

=== Bet365

#image("../images/b-sites-enregistrement/bet365.png", width: 40%)

=== Binance

#image("../images/b-sites-enregistrement/binance.png", width: 40%)

=== Bybit

#image("../images/b-sites-enregistrement/bybit.png", width: 40%)

=== Kraken

#image("../images/b-sites-enregistrement/kraken.png", width: 40%)

=== Okx

#image("../images/b-sites-enregistrement/okx.png", width: 40%)

=== Tea Dating Safety for Women

#image("../images/b-sites-enregistrement/tea.png", width: 40%)

=== Upwork

Il faut une vérification pour obtenir un badge mais il faut avoir 35 connects (en achetant)

=== Roblox

#image("../images/b-sites-enregistrement/roblox.png", width: 40%)

=== Riot Games

Corée du Sud mais il faut un numéro coréen.

=== Parship

#image("../images/b-sites-enregistrement/parship.png", width: 40%)

=== Compte Google

Vérification pour changer son âge (de mineur à majeur).

#image("../images/b-sites-enregistrement/google.png", width: 40%)

== Critères de sélection

- *Type* : identification par photo, vidéo, ou les deux.
- *Interlocuteur humain* : présence ou non d'un interlocuteur humain pour guider l'utilisateur.
- *Documents d'identité* : nécessité ou non de fournir des documents d'identité.
- *Uniquement via smartphone* : certains sites ne permettent pas de créer un compte sur ordinateur.
- *Vérification* : email, numéro de téléphone, ou les deux. Bon à savoir dans le cas où l'on voudrait une automatisation totale.

#set page(flipped: true)

== Tableau comparatif des sites

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
  table.cell(fill: green)[*Facebook*], [Photo], [?], [Non], [Non], [Email],
  table.cell(fill: yellow)[*Instagram*], [-], [-], [-], [-], [-],
  table.cell(fill: red)[*Snapchat*], [-], [-], [-], [-], [-],
  table.cell(fill: yellow)[*LinkedIn*], [-], [-], [-], [-], [-],
  table.cell(fill: yellow)[*Discord*], [-], [-], [-], [-], [-],
  table.cell(fill: yellow)[*Youtube*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Migros Bank*], [Vidéo], [Non], [Oui], [Non], [?],
  table.cell(fill: green)[*Neon Bank*], [Vidéo], [Oui], [Oui], [Oui], [Email + n° de téléphone],
  table.cell(fill: green)[*Swissquote*], [Photo], [Non], [Oui], [Non], [Email + n° de téléphone],
  table.cell(fill: red)[*E-ID*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Revolut*], [Vidéo], [Oui], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Yuh*], [Vidéo], [Oui], [Oui], [Oui], [Email + n° de téléphone],
  table.cell(fill: green)[*UBS*], [Photo ou vidéo], [Oui ou non], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Coinbase*], [Vidéo], [Non], [Oui], [Non], [N° de téléphone],
  table.cell(fill: green)[*Swissborg*], [?], [?], [Oui], [Oui], [?],
  table.cell(fill: green)[*Zak Cler*], [Photo et vidéo], [Non], [Oui], [Oui], [Email],
  table.cell(fill: red)[*X*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Portail Etat de Vaud*], [Vidéo], [Oui], [Oui], [Non], [Email],
  table.cell(fill: green)[*Lotterie Romande*], [Photo], [?], [Oui], [Oui], [Email + n° de téléphone],
  table.cell(fill: green)[*Mycasino*], [Photo], [?], [Oui], [Non], [-],
  table.cell(fill: green)[*Swiss Casinos*], [Vidéo], [Non], [Oui], [Non], [Email],
  table.cell(fill: green)[*Casino777*], [Photo], [?], [Oui], [Non], [-],
  table.cell(fill: red)[*Polymarket*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*Bet365*], [Photo], [?], [Oui], [Non], [N° de téléphone],
  table.cell(fill: green)[*Binance*], [Vidéo], [?], [Oui], [Non], [Email],
  table.cell(fill: green)[*Bybit*], [Photo], [?], [Oui], [Non], [Email],
  table.cell(fill: green)[*Kraken*], [Vidéo], [?], [Oui], [Oui], [Email],
  table.cell(fill: green)[*Okx*], [Vidéo], [?], [Oui], [Oui], [Email + n° de téléphone],
  table.cell(fill: green)[*Tea Dating Safety for Women*], [Photo], [?], [Non], [Non], [-],
  table.cell(fill: yellow)[*Upwork*], [Photo ou vidéo], [?], [Oui], [Non], [Email],
  table.cell(fill: green)[*Roblox*], [Vidéo], [?], [Non], [Non], [-],
  table.cell(fill: green)[*Parship*], [Vidéo], [?], [Non], [Non], [-],
  table.cell(fill: red)[*Tinder*], [-], [-], [-], [-], [-],
  table.cell(fill: red)[*Grindr*], [-], [-], [-], [-], [-],
  table.cell(fill: green)[*OkCupid*], [Photo], [?], [Non], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Google*], [Photo], [?], [Non], [Non], [-],
)
