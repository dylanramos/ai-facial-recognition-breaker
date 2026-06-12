// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Attaque du site Roblox"
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
#align(center, text(weight: "bold", size: 14pt)[rapport détaillé])
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

#outline(title: "Table des matières")

#pagebreak()

#outline(title: "Table des figures", target: figure)

#pagebreak()

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

= Mise en place

En allant sur le site #underline(link("https://www.roblox.com")) nous arrivons sur la page ci-dessous.

#figure(
  rect(image("images/roblox/roblox-1.png"), stroke: 0.1pt),
  caption: "Page d'inscription.",
)

Nous pouvons voir que toutes les informations demandées sur cette page peuvent être faussées et qu'aucune vérification d'email ou de numéro de téléphone n'est demandée. Une fois le formulaire rempli et soumis, nous pouvons aller dans "Paramètres", puis "Infos sur le compte" pour accéder à la page permettant de confirmer son âge.

#figure(
  rect(image("images/roblox/roblox-2.png", width: 70%), stroke: 0.1pt),
  caption: "Page permettant de confirmer son âge.",
)

En cliquant sur "Continuer avec la caméra" puis "Continuer", le site nous demande de scanner un code QR pour commencer la vérification d'identité sur notre téléphone.

#figure(
  rect(image("images/roblox/roblox-3.png", width: 30%), stroke: 0.1pt),
  caption: "Code QR pour commencer la vérification d'identité.",
)

= Contournement

Étant donné qu'un téléphone est nécessaire, nous allons utiliser un émulateur Android, Genymotion dans cet exemple. Mais au lieu de scanner le code QR, nous copions le lien juste en dessous et accédons à ce lien depuis le navigateur de l'émulateur.

#figure(
  rect(image("images/roblox/roblox-4.png", width: 37%), stroke: 0.1pt),
  caption: "Page de vérification d'identité sur l'émulateur Android.",
)

Les actions demandées pour cette vérification d'âge sont simples : montrer son visage de face, tourner la tête à gauche, puis à droite. Ainsi, pour tromper cette vérification, il suffit de diffuser une image statique sur la caméra virtuelle à chaque mouvement demandé. Mais avant cela, il faut configurer la caméra de l'émulateur pour qu'elle utilise la caméra virtuelle de la machine hôte en allant dans "Media injection" (icône de caméra sur la barre d'outils à droite), puis en sélectionnant "AIFRB Virtual Camera" comme source.

#figure(
  rect(image("images/roblox/roblox-5.png"), stroke: 0.1pt),
  caption: "Configuration de la caméra de l'émulateur.",
)

D'autre part, il faut veiller à diffuser une image en mode portrait et à sélectionner l'option "Resize" pour que le visage soit centré et bien formé dans la caméra.

#figure(
  rect(image("images/roblox/roblox-6.png", width: 37%), stroke: 0.1pt),
  caption: "Diffusion d'une image statique centrée et bien formée sur l'émulateur.",
)

Enfin, en utilisant le CLI avec les templates fournis dans le projet, *la vérification d'âge est contournée avec succès*.

Résultat : #underline[#link("videos/roblox/roblox-result.mp4")[roblox-result.mp4]].

= Remarques

- Les visages qui ne regardent pas la caméra ne fonctionnent pas.
- Une vidéo qui tourne en boucle plutôt que des images statiques ne laisse pas le temps à la vérification de se faire correctement.
