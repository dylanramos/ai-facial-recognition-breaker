#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Génération d'images et de vidéos IA"
#let location_and_date = [Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")]
#let academic_year = "2025-2026"

// Page de garde

#grid(
  columns: (1fr, 2fr),
  align: (left, right),
  image("../images/logo-heig-vd.png", width: 3cm),
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

= Introduction

Pour qu'un attaquant puisse modifier la photo d'une personne sur un document d'identité ou générer une vidéo d'une personne effectuant un selfie vidéo, il doit utiliser des modèles de génération d'images et de vidéos IA. Les modèles sont en constante évolution, il est donc impossible de choisir un modèle de manière définitive car celui-ci risque de très vite être dépassé par de nouveaux modèles ou des modèles d'autres fournisseurs.

Ainsi, plutôt que de souscrire à chaque fournisseur de manière individuelle et de devoir s'adapter à chaque API, il est possible de passer par un service aggrégateur comme #link("https://kie.ai/")[#underline("KIE AI")]. KIE AI est une plateforme qui regroupe les APIs des différents fournisseurs de modèles d'IA et met à disposition une API unique qui permet de les utiliser de manière centralisée et moins coûteuse que chez les fournisseurs directement.

#figure(
  rect(image("../images/03-generation-ia/kieai.png", width: 80%), stroke: 0.1pt),
  caption: "Architecture d'une application utilisant KIE AI.",
)

= KIE AI

KIE AI a été choisi pour sa large gamme de modèles, sa simplicité d'utilisation, sa documentation claire et son prix compétitif. De plus, il propose un "bac à sable" permettant de tester les APIs des modèles gratuitement et offre 80 (0.40\$) crédits lors de l'inscription. C'est donc sur cette plateforme que vont se baser les chapitres suivants.

#figure(
  rect(image("../images/03-generation-ia/kieai-features.png", width: 40%), stroke: 0.1pt),
  caption: "Catégories de modèles proposées par KIE AI.",
)

Les catégories utiles à ce projet sont "Video Generation" et "Image Generation", mais la catégorie "Chat" reste intéressante si un générateur de prompt automatique vient à être nécessaire.

== Exemple d'utilisation de l'API pour générer une vidéo <api-generation>

L'exemple de code ci-dessous montre comment générer une vidéo avec le modèle *Kling 3.0*. La vidéo part d'une image de début et termine par une image de fin fournies en paramètre. À noter que la vidéo est générée de manière asynchrone, cela signifie que la requête retourne un `taskId` qui devra par la suite être utilisé pour vérifier l'état de la génération de la vidéo et récupérer le résultat une fois la vidéo générée.

#pagebreak()

#figure(
  sourcecode[```python
  # Source : https://kie.ai/kling-3-0
  def generate_video_kling(prompt: str, image_url: str) -> str:
      url = "https://api.kie.ai/api/v1/jobs/createTask"
      payload = {
          "model": "kling-3.0/video",
          "input": {
              "mode": "std",
              "image_urls": [
                  image_url,
                  image_url
              ],
              "sound": False,
              "duration": "3",
              "aspect_ratio": "9:16",
              "multi_shots": False,
              "prompt": prompt,
          }
      }

      response = requests.post(url, headers=HEADERS, json=payload)
      data = response.json()

      if data["code"] != 200:
          print(f"Failed to generate video: {data['msg']}")
          sys.exit(1)

      return data["data"]["taskId"]

  ```],
  caption: "Exemple de code pour générer une vidéo avec le modèle kling 3.0 sur KIE AI.",
)

== Exemple d'utilisation de l'API pour récupérer une vidéo générée

L'exemple de code ci-dessous montre comment récupérer une vidéo générée après avoir lancé la génération (voir #underline()[@api-generation]). Cette fonction utilise le polling pour vérifier l'état de la génération de la vidéo en envoyant des requêtes à intervalles croissants. Si la vidéo est générée avec succès, la fonction retourne l'URL de la vidéo.

#pagebreak()

#figure(
  sourcecode[```python
  # Source : https://docs.kie.ai/market/common/get-task-detail
  def get_video_url(task_id: str) -> str:
      url = "https://api.kie.ai/api/v1/jobs/recordInfo"
      params = { "taskId": task_id }
      start_time = time.time()
      max_duration = 15 * 60 # 15 minutes

      while True:
          elapsed_time = time.time() - start_time

          if elapsed_time > max_duration:
              print("Video generation timed out after 15 minutes.")
              sys.exit(1)

          response = requests.get(url, headers=HEADERS, params=params)
          data = response.json()

          if data["data"]["state"] == "success":
              result_json = json.loads(data["data"]["resultJson"])
              return result_json["resultUrls"][0]

          if data["data"]["state"] == "fail":
              print(f"Video generation failed: {data['data']['failMsg']}")
              sys.exit(1)

          # Recommended polling interval
          if elapsed_time < 30:
              wait = 3
          elif elapsed_time < 120:
              wait = 10
          else:
              wait = 30

          time.sleep(wait)
  ```],
  caption: "Exemple de code pour récupérer l'URL d'une vidéo générée sur KIE AI.",
)

= Génération d'images

Les modèles de génération d'images doivent être capables de modifier des images existantes, par exemple, vieillir une personne, modifier une photo d'identité, etc. Il en existe deux catégories :
- Text-to-Image
- Image-to-Image

== Text-to-Image

Les modèles de type Text-to-Image analysent le prompt et créent eux-mêmes les visuels à partir de zéro. Ils sont utiles pour générer des images de personnes fictives mais ne sont pas adaptés pour modifier des images existantes.

== Image-to-Image

Les modèles de type Image-to-Image (édition d'images) partent d'une image fournie et la modifient en fonction du prompt. Ils sont utiles pour modifier des images existantes contrairement aux modèles de type Text-to-Image.

== Modification d'une carte d'identité

Plusieurs modèles de type Image-to-Image ont été testés pour vérifier leur capacité à modifier une photo d'identité de manière réaliste. L'objectif était de modifier un exemple de carte d'identité suisse trouvée sur internet #footnote[https://media.lematin.ch/4/image/2025/11/12/d10f8b1e-512b-4e61-9ccb-6a391f05621f.jpg?auto=format%2Ccompress%2Cenhance&fit=max&w=1200&h=1200&rect=0%2C0%2C1024%2C640&fp-x=0.2265625&fp-y=0.44375&s=5c24eb000b8b1c27d35d5c4e9d79d9bd] pour en faire la carte d'identité d'une personne fictive en changeant :
- La photo d'identité par une autre photo générée.
- Le nom "de Maienfeld Muster" par "Teste".
- Le prénom "Lara Sample" par "Alice".
- La date de naissance "01 08 1991" par "07 02 2000"
- La signature "Signature" par "A. Teste".

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Exemple de carte d'identité suisse trouvée sur internet.",
  ),
  [#figure(
    rect(image("../images/03-generation-ia/face.png", width: 63%), stroke: 0.1pt),
    caption: "Nouvelle photo d'identité générée.",
  )<face>],
)

La photo d'identité de la #underline[@face] a été générée à l'aide d'un modèle de type Text-to-Image de la manière suivante :
- Modèle : `nano-banana-2`
- Prompt : `A headshot portrait of a young woman in her early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography.`
- Format d'image : `auto`
- Résolution : `1k`

À noter que pour chaque tests ci-dessous, le même prompt a été utilisé pour tous les modèles, celui-ci est le suivant :

`Modify the ID card by replacing the name 'de Maienfeld Muste' by 'Teste', the name 'Lara Sample' by 'Alice', the date of birth '01 08 1991' by '07 02 2000' and the signature 'Signature' by 'A. Teste'. Replace the pictures on the ID card by the woman on the second image. The pictures should keep their black and white color and the triangles at the end of the names should not be removed.`

=== Nano Banana 2

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../images/03-generation-ia/nano-banana-2.jpeg"), stroke: 0.1pt),
    caption: "Résultat du modèle Nano Banana 2.",
  ),
)

La modification de la carte d'identité est plutôt bien réussie, tous les changements demandés ont été effectués et les motifs de la carte sont conservés, notamment sur les photos. Par contre les petits triangles à la fin du nom et du prénom ont considérablement été agrandis.

=== GPT Image 2

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../images/03-generation-ia/gpt-image-2.png"), stroke: 0.1pt),
    caption: "Résultat du modèle GPT Image 2.",
  ),
)

La modification de la carte d'identité n'est pas dutout réussie, le design de la carte a complètement été modifié et le modèle a explicitement indiqué sur la carte que celle-ci n'est pas valide.

=== Grok Imagine

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../images/03-generation-ia/grok-imagine.jpg"), stroke: 0.1pt),
    caption: "Résultat du modèle Grok Imagine.",
  ),
)

La modification de la carte d'identité est plutôt moyenne, les images n'ont pas été modifiées et les deux prénoms ont été mélangés. Par contre, les motifs de la carte sont conservés et la date de naissance ainsi que la signature ont correctement été modifiées.

=== Wan 2.7

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../images/03-generation-ia/wan2-7.png"), stroke: 0.1pt),
    caption: "Résultat du modèle Wan 2.7.",
  ),
)

La modification de la carte d'identité est plutôt mauvaise, les images ont été modifiées mais les motifs n'ont pas été conservés. De plus, le format de la carte a été modifié et les noms ainsi que la date de naissance sont malformés.

=== Seedream 4.5

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../images/03-generation-ia/seedream4-5.jpg"), stroke: 0.1pt),
    caption: "Résultat du modèle Seedream 4.5.",
  ),
)

La modification de la carte d'identité est plutôt mauvaise, le format de la carte a été modifié et les couleurs ont été altérées. De plus, le prénom "Alice" a été dupliqué et la petite photo à droite a été mélangée avec la photo de la carte initiale.

=== Synthèse des résultats

Le modèle qui semble le mieux fonctionner pour modifier une carte d'identité est *Nano Banana 2*. Il est le seul à avoir modifié les photos de la carte tout en conservant les motifs et le design de celle-ci. De plus, il a correctement modifié les noms, la date de naissance et la signature. Le modèle *Grok Imagine* peut probablement fonctionner aussi en retravaillant le prompt. Les trois autres modèles par contre, sont mauvais pour ce cas d'utilisation, particulièrement *GPT Image 2* qui a complètement changé le design de la carte et a indiqué que celle-ci n'était pas valide.

== Comparaison des modèles de type Image-to-Image

Le tableau ci-dessous résume les résultats obtenus au chapitre précédent en indiquant la résolution ainsi que le prix de l'image générée (paramètres par défaut).

#set par(justify: false)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Résultat lors des tests*], [*Résolution*], [*Prix*],

    [*Nano Banana 2*], [Bon], [1k], [0.04\$],
    [*GPT Image 2*], [Mauvais], [1k], [0.03\$],
    [*Grok Imagine*], [Moyen], [1k], [0.02\$],
    [*Wan 2.7*], [Mauvais], [1k], [0.024\$],
    [*Seedream 4.5*], [Mauvais], [2k], [0.0325\$],
  ),
  caption: "Comparaison des modèles de type Image-to-Image.",
)

#set par(justify: true)

= Génération de vidéos

Les modèles de génération de vidéos doivent permettre de générer des vidéos réalistes de personnes effectuant une vérification d'identité (regarder la caméra, tourner la tête, sourire, etc.), il en existe trois catégories :
- Text-to-Video
- Image-to-Video
- Video-to-Video

== Text-to-Video

Les modèles de type Text-to-Video analysent le prompt et créent eux-mêmes les visuels et les mouvements à partir de zéro. Cela leur laisse beaucoup de créativité mais rend plus difficile le contrôle du résultat final, ce qui peut être problématique pour la vérification d'identité.

== Image-to-Video

Les modèles de type Image-to-Video prennent généralement une image de début et une image de fin puis génèrent la séquence demandée dans le prompt. Ce type de modèle est plus contrôlable visuellement et est plus adapté à la vérification d'identité car il permet de faire correspondre le visage de la personne dans la vidéo avec celui sur les documents d'identité.

== Video-to-Video

Les modèles de type Video-to-Video (édition de vidéos) modifient une vidéo fournie en fonction du prompt et d'une image de référence. Ils sont particulièrement utiles car ils permettent d'enregistrer une vidéo au préalable puis de remplacer la vraie personne par une autre personne.

== Génération de selfies vidéo à partir d'une image <generation-selfie>

Plusieurs modèles de type Image-to-Video ont été testés pour vérifier leur capacité à effectuer un selfie vidéo de manière réaliste. L'objectif était de générer une vidéo à partir d'une image de référence, d'une personne face caméra qui tourne la tête à gauche, en haut, à droite puis revient au centre.

#figure(
  rect(image("../images/03-generation-ia/face.png", width: 35%), stroke: 0.1pt),
  caption: "Image de référence utilisée pour la génération de selfies vidéo.",
)<image-ref>

À noter que pour chaque tests ci-dessous, le même prompt a été utilisé pour tous les modèles, celui-ci est le suivant :

`This woman is facing the camera. She turns her head left, then up, then right and then faces the camera again.`

=== Grok Imagine Video 1.5

- Vidéo : #underline[#link("../videos/03-generation-ia/grok-imagine-video-1-5.mp4")[grok-imagine-video-1-5.mp4]]

Le résultat est bon, la personne effectue les actions demandées et les caractéristiques de l'image de référence sont préservées. Les mouvements sont un peu rapides, mais cela est dû à la durée de la vidéo qui est de 5 secondes.

=== HappyHorse 1.0

- Vidéo : #underline[#link("../videos/03-generation-ia/happyhorse-1-0.mp4")[happyhorse-1-0.mp4]]

Le résultat est plutôt moyen, la personne effectue les actions demandées mais en une seule fois (rotation de la tête de gauche à droite), de plus, les cheveux de la personne sont beaucoup trop brillants, ce qui rend la vidéo peu réaliste. Néanmoins, l'image de référence est préservée.

=== Kling 3.0

- Vidéo : #underline[#link("../videos/03-generation-ia/kling-3-0.mp4")[kling-3-0.mp4]]

Le résultat est plutôt mauvais, la personne effectue les mouvements haut et droite en même temps et les cheuveux sont trop brillants comme pour le modèle HappyHorse 1.0, ce qui rend la vidéo peu réaliste. De plus, l'ordre des mouvements n'est pas respecté.

=== Veo 3.1

- Vidéo : #underline[#link("../videos/03-generation-ia/veo-3-1.mp4")[veo-3-1.mp4]]

Le résultat est mauvais, la personne n'est pas entièrement visible et elle n'effectue pas tous les mouvements demandés.

=== Wan 2.7

- Vidéo : #underline[#link("../videos/03-generation-ia/wan-2-7.mp4")[wan-2-7.mp4]]

Le résultat est plutôt mauvais, la personne effectue une rotation plutôt que de tourner dans les directions demandées, de plus, elle n'effectue pas le mouvement vers la droite.

=== Sora 2

Au début de ce travail, le modèle populaire Sora 2 de OpenAI était disponible sur KIE AI, cependant, il a récemment été retiré de la plateforme pour des raisons inconnues. Ce modèle n'a donc pas pu être testé.

#figure(
  rect(image("../images/03-generation-ia/sora2.png"), stroke: 0.1pt),
  caption: "Absence du modèle Sora 2 sur KIE AI.",
)

=== Synthèse des résultats

Le modèle qui semble le mieux fonctionner pour générer des selfies vidéo est *Grok Imagine Video 1.5*. C'est le seul modèle à avoir respecté les mouvements demandés tout en préservant les caractéristiques de l'image de référence. Les autres modèles peuvent probablement également fonctionner en retravaillant le prompt, à l'exception du modèle *Veo 3.1* qui déforme l'image de référence.

== Comparaison des modèles de type Image-to-Video

Le tableau ci-dessous résume les résultats obtenus au chapitre précédent en indiquant la résolution, la durée ainsi que le prix de la vidéo générée (paramètres par défaut).

#set par(justify: false)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Résultat lors des tests*], [*Résolution*], [*Durée*], [*Prix*],

    [*Grok Imagine Video 1.5*], [Bon], [480p], [5s], [0.3725\$],
    [*HappyHorse 1.0*], [Moyen], [720p], [5s], [0.70\$],
    [*Kling 3.0*], [Mauvais], [720p], [5s], [0.35\$],
    [*Veo 3.1*], [Mauvais], [720p], [4s], [0.30\$],
    [*Wan 2.7*], [Mauvais], [720p], [5s], [0.40\$],
  ),
  caption: "Comparaison des modèles de type Image-to-Video.",
)

#set par(justify: true)

== Génération de selfies vidéo à partir d'une vidéo

Les trois modèles de type Video-to-Video disponibles sur KIE AI ont été testés pour vérifier leur capacité à remplacer une personne dans une vidéo par une autre personne de manière réaliste. L'objectif était de remplacer ma personne dans une vidéo par une autre personne à partir d'une vidéo de référence de ma personne face caméra qui tourne la tête à droite, en haut, à droite puis à gauche. L'image de référence utilisée est la même que pour le #underline[@generation-selfie], à savoir la #underline[@image-ref]. Pour des questions de vie privée, la vidéo de référence de ma personne n'est pas publiée sur GitHub et n'est donc pas disponible dans ce rapport.

Le prompt utilisé pour HappyHorse 1.0 et Wan 2.7 (Kling Motion Control 3.0 est un peu particulier, voir #underline[@kling-motion-control]) est le suivant :

`Replace the person on the video by the person on the image.`

=== HappyHorse 1.0

Vidéo : #underline[#link("../videos/03-generation-ia/happyhorse-1-0-edit.mp4")[happyhorse-1-0-edit.mp4]]

Le résultat est plutôt moyen, nous pouvons voir à la seconde 1 qu'il y a un léger clignement d'œil alors que je ne cligne des yeux à aucun moment dans la vidéo. De plus, les cheveux de la personne sont trop brillants et le linge en arrière-plan à complètement changé de texture. Néanmoins, les mouvements de la personne sont corrects et le cadrage de la vidéo est respecté.

=== Wan 2.7

Vidéo : #underline[#link("../videos/03-generation-ia/wan-2-7-edit.mp4")[wan-2-7-edit.mp4]]

Le résultat est plutôt moyen, la caméra est tremblante et la machoîre change de forme au début de la vidéo. Néanmoins, les mouvements de la personne sont corrects et les cheveux sont réalistes.

=== Kling Motion Control 3.0 <kling-motion-control>

La manière de remplacer une personne dans une vidéo avec le modèle Kling Motion Control 3.0 est différente des deux autres modèles. En effet, le prompt est facultatif, d'autre part, ce n'est pas l'image qui s'insère dans la vidéo mais l'inverse, la vidéo de référence se réplique sur l'image fournie. Ainsi, avant de générer la vidéo, il faut que la nouvelle personne soit déjà dans le même environnement que la personne dans la vidéo, comme le montre l'image ci-dessous.

#figure(
  rect(image("../images/03-generation-ia/kling-ref.jpeg", width: 80%), stroke: 0.1pt),
  caption: "Nouvelle personne dans le même environnement que la vidéo de référence.",
)

Vidéo : #underline[#link("../videos/03-generation-ia/kling-3-0-edit.mp4")[kling-3-0-edit.mp4]]

Le résultat est plutôt bon, l'arrière-plan est préservé, les mouvements sont corrects et l'aspect général de la personne est réaliste. Par contre, contrairement aux vidéos précédentes, le bras qui tient la caméra n'est plus présent, c'est normal car la personne sur l'image de référence n'avait pas exactement la même posture que ma personne dans la vidéo de référence. De plus, la position des yeux à la toute dernière seconde de la vidéo est un peu étrange, mais cela reste un détail.

=== Synthèse des résultats

Le modèle qui semble le mieux fonctionner pour remplacer une personne dans une vidéo par une autre personne est *Kling Motion Control 3.0*. En effet, il arrive à bien préserver l'arrière-plan de la vidéo et surtout à générer une personne réaliste. Les deux autres modèles, bien que fonctionnels, font quelques erreurs qui risquent d'être détectées par les systèmes de vérification.

== Comparaison des modèles de type Video-to-Video

Le tableau ci-dessous résume les résultats obtenus au chapitre précédent pour une vidéo d'environ 8 secondes en indiquant la résolution ainsi que le prix de la vidéo générée (paramètres par défaut).

#set par(justify: false)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Résultat lors des tests*], [*Résolution*], [*Prix*],

    [*Kling Motion Control 3.0*], [Bon], [720p], [0.80\$ + 0.04\$ (pour l'image)],
    [*HappyHorse 1.0*], [Moyen], [720p], [2.38\$],
    [*Wan 2.7*], [Moyen], [720p], [0.64\$],
  ),
  caption: "Comparaison des modèles de type Video-to-Video.",
)
