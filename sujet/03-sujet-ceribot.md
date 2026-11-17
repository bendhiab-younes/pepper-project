# Sujet d'application « CERIBot », robot d'accueil

Le principe de l'application consiste à connecter un robot humanoïde (genre Pepper ou NAO) avec un serveur en ligne de dialogue vocal. Il s'agit donc d'une part de mettre place une solution d'agent dialogique en ligne (avec un serveur API REST) et d'autre part d'adapter un programme du robot client capable de se connecter à cette solution pour réaliser une tâche particulière.

> **Conseil :** la tâche visée sera simple dans un premier temps (avant d'avoir réussi à mettre en place l'infrastructure complète) et même suivre les possibilités offertes dans les tutoriaux du système de dialogue d'un coté et du robot de l'autre. On pourra donc rester sur la partie réalisée lors du TP défi.

## Sommaire

1. [Serveur dialogue](#1-serveur-dialogue)
2. [Programmation robot](#2-programmation-robot)
3. [Connexion robot-serveur](#3-connexion-robot-serveur)
4. [Nouvelle tâche ou apprentissage](#4-nouvelle-tâche-ou-apprentissage)
5. [Évaluation du système](#5-évaluation-du-système)
6. [Évaluation de votre travail](#évaluation-de-votre-travail)

---

## 1. Serveur dialogue

Deux solutions principales pourront être envisagées :

### 1.1 RASA

Pour l'API de dialogue, on pourra rester sur la plateforme RASA qui présente toutes les caractéristiques nécessaires. A travers RASA-X, la gestion des composants de base de RASA est simplifiée. Et notamment la mise à disposition sous forme d'une API REST du bot développé est complétement prise en charge.

> **Attention :** il est aussi possible de recourir à une interface de type socket.io. Les modifications à apporter dans ce cas sont données dans la doc RASA, et portent surtout sur le fichier de configuration `endpoints.yml`.

**A faire :**

- si ca n'a pas été fait lors de l'atelier : installer RASA-X et compléter une version rudimentaire du bot
- vérifier son fonctionnement de base (à l'aide du tutorial) associé, avec les UI fournies par RASA-X
  > **Conseil :** pas besoin de comprendre en détails les composants, mais le principe de l'architecture générale simplement
- tester la version agent en serveur REST (avec par exemple la chrome App « Advanced Rest Client », sur <https://apitester.com>, ou avec `curl -X POST -data...`)

### 1.2 Solution LLM (comme ChatGPT)

Des libraires permettent de s'interfacer rapidement avec des modèles pré-entraînés (et « parlant » plusieur langues). On vous conseille **FastChat** ou **LangChain**, qui disposent de leur github. Elles permettent de créer en Python des web-services avec des modèles compétitifs comme LLama-3, ou Vicuna (<https://lmsys.org/blog/2023-03-30-vicuna/>)...

**A faire :**

- installer la librairie choisie et compléter une version rudimentaire du bot. Dans ce cas il va principalement falloir régler le « prompt » qui est utiliser pour « interroger » le LLM, qui devra intégrer l'historique de la conversation
- tester la version agent en serveur REST (avec par exemple la chrome App « Advanced Rest Client », sur <https://apitester.com>, ou avec `curl -X POST -data...`)
- un exemple de mise en oeuvre (mais on peut mieux faire et surtout gratuitement, sans OpenAI) : <http://www.diva-portal.org/smash/get/diva2:1744270/FULLTEXT01.pdf>

---

## 2. Programmation robot

L'objectif de l'application est la mise au point d'un Pepper. Pour des raisons pratiques, des NAO pourront aussi être utilisés durant les phases de test. Pour la programmation du robot, l'outil « Choregraphe Suite » est mis à disposition par SoftBank.

**A faire :**

- installer « Choregraphe Suite »
  > **Attention :** Différentes versions sont disponibles ci-dessous, la clé est fournie. Après vérification, la version **2.5.10** fonctionne très bien avec les Pepper et NAO du CERI.
- programmer un comportement de base en version graphique à partir de quelques fonctionnalités disponibles. Des documents liés à la programmation des robots Pepper et NAO sont disponibles après ce sujet
- le tester dans le simulateur
- le tester sur un robot
  > **Attention :** pour les séances les robots ont été connectés sur le réseau local en Wifi en stat1. Pour connaître leur IP il faut appuyer sur le bouton ventral 1 coup sec. Ensuite l'IP devra être saisie dans la boîte de dialogue de connexion dans Choregraphe (le protocole 'Bonjour' pour la découverte automatique ne passe pas à travers le routeur wifi...).

---

## 3. Connexion robot-serveur

Une fois un chabot accessible avec une API REST disponible et un robot programmable, ayant accès au réseau, il s'agit de connecter les deux. En pratique, les caractéristiques du chatbot font qu'il ne sera pas possible d'utiliser les capacités de reconnaissance de la parole (conversion du son capté par les microphone en séquence de mots) du robot. Il sera donc nécessaire d'insérer une solution externe réalisant cette opération avant d'accéder au chatbot. Dans notre application nous proposons d'utiliser la fonction Speech du Google Cloud (mais d'autres sont possibles, par exemple Mozilla DeepSpeech en local).

**A faire :**

- utiliser le comportement de base de l'archive [`projet_monrobotparlant.zip`](../ressources/projet_monrobotparlant.zip) (voir fichier NAO-RASA après le sujet) pour permettre de gérer les entrées-sorties du robot
  > **Attention :** dans un premier temps on peut vouloir utiliser les fonctions reconnaissance et synthèse de parole disponibles sur le robot. Mais quand cela s'avère impraticable (solution « petit vocabulaire ») on a donc recours à un serveur en ligne (solution Google en l'occurrence)
- connecter votre comportement robot avec le serveur RASA et le tester. Les 2 Peppers (et les 3 NAO si besoin) du CERI sont mis à votre disposition durant les séances.
  > **Attention :** Pour un accès hors séances faîtes-nous un mail avec la plage horaire souhaitée et vous aurez accès aux robots au labo.

  > **Attention :** Il faut modifier les adresses IP des serveurs dans plusieurs boîtes du comportement fourni dans l'archive

> **Conseil :** Des exemples de projets extérieurs comparables permettant connection des robots avec des services cloud sont disponibles comme *pepperspeechrecognition* ou *pepperchat*, et peuvent servir d'inspiration pour aller plus loin que le projet `monrobotparlant` proposé plus haut.

---

## 4. Nouvelle tâche ou apprentissage

Une fois les étapes précédentes réalisées, il vous est demandé de :

1. **de personnaliser votre application dans les directions suivantes :**
   - **modification de la tâche de dialogue** pour intégrer toutes les fonctions utiles pour un robot d'accueil complet. Parmi les fonctions possibles on retiendra en priorité :
     - **consultation d'emploi du temps étudiant**
       - connexion à l'API Partage, ou une BD factice
       - requête par formation/groupe/enseignant/salle
       - retourne les cours suivant dans la 1/2 journée entamée avec affichage
     - **consultation occupation salles libre-service**
       - connexion à l'API Partage, ou une BD factice
       - requête optionnelle par date/heure
       - retourne une salle sans cours affecté pour la date/heure demandée, sinon maintenant
     - **orientation batiment**
       - connexion à BD : liste des salles avec descriptif (dont un plan d'accès)
       - requête par salle
       - retourne la route depuis le hall de la salle avec affichage du plan correspondant
     - **texter prof**
       - connexion à BD : liste des enseignants avec contacts
       - requête par nom/cours
       - retourne confirmation envoi d'un sms avec le message dicté
     - **socialisation**
       - état mental (« Comment allez-vous ? »)
       - consultation météo
       - blagues
     - ...
   - **modification du comportement du robot** : de base le robot est programmé uniquement pour échanger des tours de parole avec l'usager. On peut vouloir intégrer des comportements plus fins, par exemple des « mimiques gestuelles » dans certaines situations, ou encore l'utilisation de l'analyse vidéo (reconnaissance de visage, d'émotions...).
2. **[Avancé] d'étudier le problème d'apprentissage automatique du modèle de dialogue.** Cela concerne le module de gestion du dialogue, qui définit la stratégie (*policy*) de dialogue. Chacun des modules de RASA propose une version à base de règles (qui est utilisée par défaut) et un ensemble d'outils permettant de passer ensuite à des modules appris. L'objectif ici sera de permettre l'analyse des conversations enregistrées avec une approche d'apprentissage. Deux approches sont proposées :
   - étudier le fonctionnement de l'approche `TEDPolicy` fournie avec RASA, vérifier comment la prise en compte de nouvelles données d'apprentissage va modifier son comportement ;
   - utiliser une solution extérieure d'apprentissage par renforcement. Par exemple de type Actor-Critic avec Keras/TensorFlow. L'objectif est alors de mettre en forme les données d'apprentissage enregistrée avec RASA-X pour les fournir en entrées du réseau de neurones, permettant son apprentissage. Ensuite il est possible d'interpréter la policy apprise (sortie 'action' du 'model' dans Keras) pour déterminer la meilleure action pour tout état d'entrée. Et ainsi de revoir les choix actuellement faits par la stratégie utilisée par RASA.

> **Attention :** la description de cette partie est complétée dans le fichier ci-dessous [« Approfondissement : Apprentissage par renforcement profond pour le dialogue »](04-approfondissement-drl.md)

> **Attention :** Toutes les tâches à réaliser dans cette partie sont données à titre indicatif. Il n'est pas attendu que tout puisse être fait de manière complète et optimale. Aussi vous aurez à préciser vos propres objectifs (en fonction de vos compétences, de vos envies, de vos intuitions...). Et toute combinaison qui vous paraît pertinente à étudier pourra être envisagée tant qu'elle consiste à associer robot et capacités de dialogue vocal, et que vos encadrants l'auront validée.

---

## 5. Évaluation du système

Pour finir une évaluation devra montrer l'intérêt des améliorations proposées au point 4 ci-dessus. Pour cela vous devrez conserver au moins **2 versions du système (base et améliorée)** et faire tester ces versions par un certain nombre de collègues (**idéalement 4-5**).

Vous leur fournirez un objectif pré-défini pour chaque dialogue (ce qu'ils cherchent à obtenir du système) et ils devront remplir à l'issue de chaque test une fiche avec des questions sur les différents aspects du systèmes en proposant une échelle d'évaluation de la satisfaction sur 5 points (échelle de Lickert, de « pas du tout » à « très » satisfait) pour chacun.

Exemple de questions :

- avez-vous obtenu le résultat attendu ?
- avez-vous bien compris le système ?
- pensez-vous que le système vous a bien compris ?
- comment qualifier votre impression générale de l'interaction ?
- ...

Cette évaluation devra être analysée, pour extraire des informations sur le fonctionnement général et ensuite l'influence des versions étudiées, et mise en forme dans votre rapport scientifique (cf Evaluation de votre travail ci-dessous).

## Évaluation de votre travail

Elle sera commune à toutes les applications et vous sera présentée en détails par le responsable de l'UE (cf la section Evaluation dédiée, en bas du module).

---

© Fabrice Lefèvre, 2024
