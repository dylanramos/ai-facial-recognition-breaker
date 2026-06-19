= Mécanismes de défense

== Introduction

Les chapitres précédents ont mis en évidence que certains systèmes de vérification d'identité résistent aux attaques même lorsque le contenu généré est visuellement convaincant. Ce chapitre examine les mécanismes qui expliquent ces résistances : la détection des attaques par présentation (PAD), la détection des attaques par injection (IAD), puis les hypothèses formulées à partir des tests effectués pour comprendre pourquoi les attaques contre Facebook, Parship et Google n'ont pas abouti.

== Détection des attaques par présentation (PAD)

Comme vu précédemment dans le #underline[@07-ia-necessaire], une attaque par présentation consiste à tenter de tromper un système de vérification d'identité en présentant à une caméra physique un élément autre qu'une personne réelle et vivante. Pour détecter ce type d'attaque, les systèmes analysent les signaux qui permettent de distinguer un visage réel comme la microtexture de la peau (par opposition à celle du papier ou d'un écran), les indices de profondeur liés à l'éclairage et aux ombres, la façon dont la lumière se reflète sur une surface ainsi que les micro-mouvements biologiques (micro-clignements des yeux, mouvements respiratoires, etc.) @didit.

== Détection des attaques par injection (IAD)

Une attaque par injection consiste à insérer un flux vidéo synthétique ou préenregistré directement dans le processus de capture du logiciel. Cette attaque intercepte les données transitant entre la caméra physique et l'application de vérification avant que tout modèle de détection de présence ne soit exécuté @didit. Pour détecter ce type d'attaque, les systèmes analysent les sources multimédias afin de déterminer si une pile d'émulation est utilisée pour présenter un appareil virtuel @biometricupdate. D'autre part, les systèmes surveillent également les appels SDK susceptibles d'être interceptés et rejoués avec une vidéo substituée. Ainsi, la détection des attaques par injection permet de protéger la chaîne d'authentification, c'est-à-dire préserver l'intégrité de la capture vidéo contre les données injectées ou altérées.

== Hypothèses concernant les attaques échouées

Pour des raisons de sécurité, les systèmes de vérification d'identité ne divulguent généralement pas les détails de leur implémentation, nous ne pouvons donc pas savoir pourquoi exactement les attaques du #underline[@08-attaques-echouees] ont échoué. Néanmoins, nous pouvons émettre des hypothèses basées sur les tests effectués et les mécanismes de défense mentionnés précédemment.

=== Détection de l'utilisation d'IA

La plupart des systèmes de vérification d'identité utilisent des modèles d'IA entraînés sur des exemples de contenus réels pour détecter des contenus synthétiques. Pour du contenu multimédia par exemple, les modèles tentent de détecter la présence de flous anormaux, d'incohérences dans l'éclairage ou d'expressions faciales incohérentes d'une image, notamment en analysant des patterns de pixels predictibles, répétitifs et structurés @aivideodetector.

Ainsi, il est fort probable que les systèmes de vérification des sites Facebook et Parship aient été entraînés pour détecter les artefacts spécifiques générés par les modèles d'IA utilisés dans les chapitres précédents, ce qui expliquerait pourquoi ces attaques ont échoué.

=== Détection d'appareils virtuels

Une caméra physique produit du bruit de capteur et des variations naturelles de luminosité, peut-être que l'ajout de bruit artificiel effectué au #underline[@08-noise] n'était pas assez réaliste pour tromper les systèmes de vérification. En effet, un flux injecté à partir d'une vidéo préenregistrée risque de présenter une absence de bruit cohérent, des artefacts de recompression ou encore un framerate trop régulier, ce qui peut faciliter la détection d'une caméra virtuelle @emergentmind.

Lors de la tentative de contournement sur Google au #underline[@08-google-title], le système de vérification a probablement détecté l'utilisation d'un appareil Android émulé. En effet, les vrais téléphones Android disposent généralement d'une clé matérielle permettant de signer cryptographiquement une attestation que le système d'exploitation tourne sur un appareil certifié non modifié, notamment graĉe à l'API Play Integrity @playintegrity.

=== Device fingerprinting

Le device fingerprinting consiste à identifier un appareil en collectant des attributs uniques de son matériel et de son logiciel @stytch. En plus de détecter les attaques par présentation et par injection, les plateformes utilisent peut-être également le device fingerprinting en analysant la réputation de l'adresse IP (création de plusieurs comptes à partir de la même adresse), l'historique du navigateur et les signaux comportementaux (mouvements de souris, changements de fenêtre, etc.).

=== Incohérence entre les tentatives

Comme vu dans le #underline[@08-facebook], il est impossible de connaître les mouvements qui seront demandés par le système de vérification de Facebook à l'avance. Ainsi, il est probable que le système compare les tentatives entre elles pour détecter les incohérences. Par exemple, si lors de la première tentative, la personne ne bouge pas ou effectue des mouvements complètement différents de ceux demandés, le système peut conclure que la personne n'est pas réelle et ce, même si la seconde tentative est correcte.

== Conclusion

Les systèmes de vérification d'identité modernes ne se limitent pas à analyser le contenu visuel, ils opèrent sur plusieurs couches défensives simultanément. C'est cette combinaison de mécanismes qui explique l'échec des attaques sur Facebook, Parship et Google, malgré la qualité du contenu généré par IA.

Ces observations montrent que la robustesse d'un système dépend autant de la qualité de son intégration et de la mise à jour régulière de son SDK que des capacités de la solution de vérification. Un fournisseur solide dont le SDK est obsolète, comme dans le cas de Tea for Women, reste vulnérable.
