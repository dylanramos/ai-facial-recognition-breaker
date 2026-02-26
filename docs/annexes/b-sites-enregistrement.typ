#let author = "Dylan Oliveira Ramos"

#set text(font: "New Computer Modern", size: 11pt)
#set page(
  margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm),
  numbering: "1",
  header: context [
    #set text(size: 9pt)
    #let selector = selector(heading).before(here())
    #let headings = query(selector).filter(it => it.level == 1)
    #let is_even = calc.even(counter(page).get().first())

    #if headings.len() == 0 and is_even {
      line(length: 100%, stroke: 0.5pt)
    } else if (is_even) {
      let current_heading = headings.last()

      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper(current_heading.body), line(length: 99%, stroke: 0.5pt),
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
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(2.5cm)
  text(size: 20pt)[Annexe B]
  v(0.3cm)
  text(size: 26pt)[#it.body]
  v(0.7cm)
}
#show heading.where(level: 2): it => {
  set text(size: 16pt)
  v(0.5cm)
  it
  v(0.5cm)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

= Sites d'enregistrement

== Critères de sélection

- *Type* : identification par photo, vidéo, ou les deux.
- *Interlocuteur humain* : présence ou non d'un interlocuteur humain pour guider l'utilisateur.
- *Documents d'identité* : nécessité ou non de fournir des documents d'identité.
- *Uniquement via smartphone* : certains sites ne permettent pas de créer un compte sur ordinateur.
- *Vérification* : email, numéro de téléphone, ou les deux. Bon à savoir dans le cas où l'on voudrait une automatisation totale.

#pagebreak()

== TikTok

Une vérification est nécessaire (18 ans) si on veut lancer un live mais il faut avoir au moins 1000 followers. Difficile à tester.

=== Sans VPN

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

=== Avec VPN en France

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

=== Avec VPN en Australie

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * impossible de s'inscrire. Probablement à cause du VPN.]

#image("../images/annexe_b/tiktok-australie.png", width: 50%)

== Facebook

=== Sans VPN

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: green)[*Résultat : * demande un selfie pour vérifier que je suis humain.]

== Instagram

=== Sans VPN

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

=== Avec VPN en France

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: yellow)[*Résultat : * demande de remplir un captcha puis un numéro de téléphone.]

#image("../images/annexe_b/instagram-france.png", width: 30%)

=== Meta Verified (sans VPN)

- Vérification des documents d'identité (photo)

#text(fill: yellow)[*Résultat : * page inaccessible, probablement car le compte n'est pas éligible.]

#image("../images/annexe_b/instagram-verified.png", width: 30%)

== Snapchat

=== Sans VPN

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

=== Avec VPN en France

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

=== Avec VPN en Australie

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

== LinkedIn

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée pour la création du compte.]

#text(fill: yellow)[*Badge : * vérification si on veut obtenir le badge mais il y a une liste d'attente.]

== Discord

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

#text(fill: yellow)[*Info : * vérification des mineurs dès mars 2026.]

== Youtube

- Sur PC
- Navigation privée
- Inscription avec email + mot de passe

#text(fill: red)[*Résultat : * aucune vérification demandée.]

#text(fill: yellow)[*Info : * vérification uniquement si détecté comme mineur.]

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

  [*TikTok*], [-], [-], [-], [-], [-],
  [*Facebook*], [-], [-], [-], [-], [-],
  [*Instagram*], [-], [-], [-], [-], [-],
  [*Snapchat*], [-], [-], [-], [-], [-],
  [*LinkedIn*], [-], [-], [-], [-], [-],
  [*Discord*], [-], [-], [-], [-], [-],
  [*Youtube*], [-], [-], [-], [-], [-],
  [*Migros Bank*], [Vidéo], [Non], [Oui], [Non], [?],
  [*Neon Bank*], [Vidéo], [Oui], [Oui], [Oui], [Email + n° de téléphone],
  [*Swissquote*], [Photo], [Non], [Oui], [Non], [Email + n° de téléphone],
  [*E-ID*], [-], [-], [-], [-], [-],
  [*Revolut*], [Vidéo], [Oui], [Oui], [Oui], [N° de téléphone],
  [*Yuh*], [Vidéo], [Oui], [Oui], [Oui], [Email + n° de téléphone],
  [*UBS*], [Photo ou vidéo], [Oui ou non], [Oui], [Oui], [N° de téléphone],
  [*Coinbase*], [Vidéo], [Non], [Oui], [Non], [N° de téléphone],
  [*Swissborg*], [?], [?], [Oui], [Oui], [?],
  [*Zak Cler*], [Photo et vidéo], [Non], [Oui], [Oui], [Email],
)
