#import "@preview/codelst:2.0.2": sourcecode

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Génération d'images et de vidéos IA

== Introduction

Pour qu'un attaquant puisse modifier la photo d'une personne sur un document d'identité ou générer une vidéo d'une personne effectuant un selfie vidéo, il doit utiliser des modèles de génération d'images et de vidéos IA. Les modèles sont en constante évolution, il est donc impossible de choisir un modèle de manière définitive car celui-ci risque de très vite être dépassé par de nouveaux modèles ou des modèles d'autres fournisseurs.

Ainsi, plutôt que de souscrire à chaque fournisseur de manière individuelle et de devoir s'adapter à chaque API, il est possible de passer par un service aggrégateur comme #link("https://kie.ai/")[#underline("KIE AI")]. KIE AI est une plateforme qui regroupe les APIs des différents fournisseurs de modèles d'IA et met à disposition une API unique qui permet de les utiliser de manière centralisée et moins coûteuse que chez les fournisseurs directement.

#figure(
  rect(image("../../images/03-generation-ia/kieai.png", width: 71%), stroke: 0.1pt),
  caption: "Architecture d'une application utilisant KIE AI.",
)

== KIE AI

KIE AI a été choisi pour sa large gamme de modèles, sa simplicité d'utilisation, sa documentation claire et son prix compétitif. De plus, il propose un "bac à sable" permettant de tester les APIs des modèles gratuitement et offre 80 (0.40\$) crédits lors de l'inscription. C'est donc sur cette plateforme que vont se baser les chapitres suivants.

#figure(
  rect(image("../../images/03-generation-ia/kieai-features.png", width: 33%), stroke: 0.1pt),
  caption: "Catégories de modèles proposées par KIE AI.",
)

Les catégories utiles à ce projet sont *Video Generation* et *Image Generation*, mais la catégorie *Chat* reste intéressante si un générateur de prompt automatique vient à être nécessaire.

=== Exemple d'utilisation de l'API pour générer une vidéo <generate-video>

L'exemple de code ci-dessous montre comment générer une vidéo avec le modèle *Kling 3.0*. La vidéo part d'une image de début et termine par une image de fin fournies en paramètre. À noter que la vidéo est générée de manière asynchrone, cela signifie que la requête retourne un `taskId` qui devra par la suite être utilisé pour vérifier l'état de la génération de la vidéo et récupérer le résultat une fois la vidéo générée.

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

=== Exemple d'utilisation de l'API pour récupérer une vidéo générée

L'exemple de code ci-dessous montre comment récupérer une vidéo générée après avoir lancé la génération (voir #underline()[@generate-video]). Cette fonction utilise le polling pour vérifier l'état de la génération de la vidéo en envoyant des requêtes à intervalles croissants. Si la vidéo est générée avec succès, la fonction retourne l'URL de la vidéo.

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

== Génération d'images

Les modèles de génération d'images doivent être capables de modifier des images existantes, par exemple, vieillir une personne, modifier une photo d'identité, etc. Il en existe deux catégories :
- Text-to-Image
- Image-to-Image

=== Text-to-Image

Les modèles de type Text-to-Image analysent le prompt et créent eux-mêmes les visuels à partir de zéro. Ils sont utiles pour générer des images de personnes fictives mais ne sont pas adaptés pour modifier des images existantes.

=== Image-to-Image

Les modèles de type Image-to-Image (édition d'images) partent d'une image fournie et la modifient en fonction du prompt. Ils sont utiles pour modifier des images existantes contrairement aux modèles de type Text-to-Image.

=== Modification d'une carte d'identité

Plusieurs modèles de type Image-to-Image ont été testés pour vérifier leur capacité à modifier une photo d'identité de manière réaliste. L'objectif était de modifier un exemple de carte d'identité suisse trouvée sur internet @swiss-id-template pour en faire la carte d'identité d'une personne fictive en changeant :
- La photo d'identité par une autre photo générée.
- Le nom "de Maienfeld Muster" par "Teste".
- Le prénom "Lara Sample" par "Alice".
- La date de naissance "01 08 1991" par "07 02 2000"
- La signature "Signature" par "A. Teste".

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Exemple de carte d'identité suisse trouvée sur internet.",
  ),
  [#figure(
    rect(image("../../images/03-generation-ia/face.png", width: 63%), stroke: 0.1pt),
    caption: "Nouvelle photo d'identité générée.",
  )<face>],
)

Les modèles testés sont les suivants :
- Nano Banana 2
- GPT Image 2
- Grok Imagine
- Wan 2.7
- Seedream 4.5

Le modèle qui s'est avéré être le plus réaliste pour modifier une carte d'identité est *Nano Banana 2*.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../../images/03-generation-ia/nano-banana-2.jpeg"), stroke: 0.1pt),
    caption: "Résultat du modèle Nano Banana 2.",
  ),
)

En effet, ce modèle a effectué tous les changements demandés tout en conservant les motifs de la carte, notamment sur les photos. Par contre les petits triangles à la fin du nom et du prénom ont considérablement été agrandis.

Les résultats obtenus avec les autres modèles sont disponibles dans le chapitre 3.3 du rapport de recherche #link("../rapports-de-recherche/generation-ia.pdf")[#underline("generation-ia.pdf")].

=== Comparaison des modèles de type Image-to-Image

Le tableau ci-dessous résume les résultats obtenus lors des tests en indiquant pour chaque modèle, la résolution ainsi que le prix de l'image générée.

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

== Génération de vidéos

Les modèles de génération de vidéos doivent permettre de générer des vidéos réalistes de personnes effectuant une vérification d'identité (regarder la caméra, tourner la tête, sourire, etc.), il en existe trois catégories :
- Text-to-Video
- Image-to-Video
- Video-to-Video

=== Text-to-Video

Les modèles de type Text-to-Video analysent le prompt et créent eux-mêmes les visuels et les mouvements à partir de zéro. Cela leur laisse beaucoup de créativité mais rend plus difficile le contrôle du résultat final, ce qui peut être problématique pour la vérification d'identité.

=== Image-to-Video

Les modèles de type Image-to-Video prennent généralement une image de début et une image de fin puis génèrent la séquence demandée dans le prompt. Ce type de modèle est plus contrôlable visuellement et est plus adapté à la vérification d'identité car il permet de faire correspondre le visage de la personne dans la vidéo avec celui sur les documents d'identité.

=== Video-to-Video

Les modèles de type Video-to-Video (édition de vidéos) modifient une vidéo fournie en fonction du prompt et d'une image de référence. Ils sont particulièrement utiles car ils permettent d'enregistrer une vidéo au préalable puis de remplacer la vraie personne par une autre personne.

=== Génération de selfies vidéo à partir d'une image <generation-selfie>

Plusieurs modèles de type Image-to-Video ont été testés pour vérifier leur capacité à effectuer un selfie vidéo de manière réaliste. L'objectif était de générer une vidéo à partir d'une image de référence, d'une personne face caméra qui tourne la tête à gauche, en haut, à droite puis revient au centre.

#figure(
  rect(image("../../images/03-generation-ia/face.png", width: 35%), stroke: 0.1pt),
  caption: "Image de référence utilisée pour la génération de selfies vidéo.",
)<image-ref>

Les modèles testés sont les suivants :
- Grok Imagine Video 1.5
- HappyHorse 1.0
- Kling 3.0
- Veo 3.1
- Wan 2.7

Le modèle qui s'est avéré être le plus réaliste pour générer des selfies vidéo à partir d'une image est *Grok Imagine Video 1.5*.

- Vidéo : #underline[#link("../videos/03-generation-ia/grok-imagine-video-1-5.mp4")[grok-imagine-video-1-5.mp4]]

En effet, la personne effectue les actions demandées et les caractéristiques de l'image de référence sont préservées. Les mouvements sont un peu rapides, mais cela est dû à la durée de la vidéo qui est de 5 secondes.

Les résultats obtenus avec les autres modèles sont disponibles dans le chapitre 4.4 du rapport de recherche #link("../rapports-de-recherche/generation-ia.pdf")[#underline("generation-ia.pdf")].

=== Comparaison des modèles de type Image-to-Video

Le tableau ci-dessous résume les résultats obtenus lors des tests en indiquant pour chaque modèle, la résolution, la durée ainsi que le prix de la vidéo générée.

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

=== Génération de selfies vidéo à partir d'une vidéo

Les trois modèles de type Video-to-Video disponibles sur KIE AI ont été testés pour vérifier leur capacité à remplacer une personne dans une vidéo par une autre personne de manière réaliste. Ces modèles sont :

- HappyHorse 1.0
- Wan 2.7
- Kling Motion Control 3.0

L'objectif était de remplacer ma personne dans une vidéo par une autre personne à partir d'une vidéo de référence de ma personne face caméra qui tourne la tête à droite, en haut, à droite puis à gauche. L'image de référence utilisée est la même que pour le #underline[@generation-selfie], à savoir la #underline[@image-ref]. Pour des questions de vie privée, la vidéo de référence de ma personne n'est pas publiée sur GitHub et n'est donc pas disponible dans ce rapport.

Le modèle qui s'est avéré être le plus réaliste pour générer des selfies vidéo à partir d'une vidéo est *Kling Motion Control 3.0*.

Vidéo : #underline[#link("../videos/03-generation-ia/kling-3-0-edit.mp4")[kling-3-0-edit.mp4]]

En effet, l'arrière-plan est préservé, les mouvements sont corrects et l'aspect général de la personne est réaliste. Par contre, la position des yeux à la toute dernière seconde de la vidéo est un peu étrange, mais cela reste un détail.

=== Comparaison des modèles de type Video-to-Video

Le tableau ci-dessous résume les résultats obtenus lors des tests pour une vidéo d'environ 8 secondes en indiquant pour chaque modèle, la résolution ainsi que le prix de la vidéo générée.

#set par(justify: false)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Résultat lors des tests*], [*Résolution*], [*Prix*],

    [*Kling Motion Control 3.0*], [Bon], [720p], [0.84\$],
    [*HappyHorse 1.0*], [Moyen], [720p], [2.38\$],
    [*Wan 2.7*], [Moyen], [720p], [0.64\$],
  ),
  caption: "Comparaison des modèles de type Video-to-Video.",
)

Les résultats obtenus avec les autres modèles sont disponibles dans le chapitre 4.6 du rapport de recherche #link("../rapports-de-recherche/generation-ia.pdf")[#underline("generation-ia.pdf")].
