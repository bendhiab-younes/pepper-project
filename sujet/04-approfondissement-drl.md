# Approfondissement : Apprentissage par renforcement profond pour le dialogue

> Cette partie est encore temporaire et sera complétée au cours des séances pour vous accompagner dans votre découverte de l'apprentissage par renforcement profond.

## Apprentissage par renforcement profond pour le dialogue

Nous ne chercherons pas ici à étudier de façon profonde l'ensemble des techniques de DRL (Deep Reinforcement Learning) appliquées au système de dialogue humain-machine. Ce sujet est complexe et très riche. Il s'agit juste de mettre en oeuvre une solution (la plus simple possible) pour appréhender les concepts sous-jacents de manière pratique.

Quelques ressources pour se familiariser avec les concepts du Deep RL :

- DeepRL Bootcamp
- Neptune.ai
- TheMedium

Il en existe beaucoup d'autres de grandes qualités. Il ne s'agit pas d'apprendre en détail le domaine mais de se familiariser avec les concepts. Ne passez donc pas trop de temps dans ces lectures, tant que vous n'avez pas défini vos objectifs précis avec les éléments ci-dessous.

## Plusieurs options

Deux options se présentent pour appliquer cette technique dans le contexte de RASA :

1. modifier RASA-X de l'intérieur ;
2. sortir les données de RASA-X et les manipuler de façon indépendante.

La première option semble plus pertinente en terme de développement : intégrée a RASA-X elle permet notamment d'utiliser immédiatement la stratégie apprise lors des tests !

## Annotation des récompenses

Dans les deux cas un enjeu principal est l'annotation en récompense des dialogues. En effet dans sa version actuelle RASA n'intègre des données exemples qu'en les considérant comme correctes : dialogues présentant un déroulement acceptable.

Pour un apprentissage par renforcement, il est utile de connaitre aussi les cas incorrects. Pour cela le principe est d'attribuer des récompenses (*rewards*) lors du déroulement des séquences de dialogue. Par exemple :

- un dialogue réussi/correct reçoit une récompense finale (globale) de **+10**, un échec de **+0**
- chaque tour de parole reçoit une récompense (pénalité dans ce cas) de **-1**, ceci afin de pénaliser les dialogues trop longs. Mais si la longueur n'est pas un critère négatif, cette récompense peut être omise.

Donc dans tous les cas, le premier travail important est donc de pouvoir associer ces récompenses aux données collectées. L'idéal étant de le faire à partir de l'interface RASA-X Annotation. De la même façon que RASA-X permet d'éditer des conversations pour modifier les intents et actions il faut ajouter la possibilité de saisir le statut du dialogue : réussi ou échoué (afin que les récompenses puissent être calculées ensuite lors de l'apprentissage).

Sinon il est nécessaire de le faire à l'extérieur. Par exemple directement dans le fichier `stories.md`, en ajoutant des champs au contenu YAML.

## Apprentissage de la strategie

### Approche intégrée

Le principes ici est que la policy `TEDPolicy` est deja basée sur un apprentissage supervisé d'un réseaux de neurones à partir des données collectées par RASA-X. Elle doit être dupliquée en `DRLPolicy` (Attention à toutes les dépendances listant les stratégies possibles qui doivent être modifiées en conséquence).

Plusieurs éléments sont alors à modifier :

- la récupération des récompenses parmi les données collectées auprès des utilisateurs
- la structure du réseau de neurones. Par exemple suivre l'exemple Keras DDPG sur <https://keras.io/examples/rl/>
- la fonction objective du réseau de neurone. Par exemple l'exemple Keras DDPG sur <https://keras.io/examples/rl/>

### Approche externe

Sortir les données et manipuler dans un outil externe.

- **Outils possibles :** toute librairie DL avec du RL. KerasRL/TensorFlow ou SpinningUp/OpenAI semblent les meilleures candidates
- **Principale difficulté :** à partir du fichier des données il faut produire une représentation en état/action/récompense utilisable par votre algorithme

## Utilisation de la stratégie

### Approche intégrée

Avec une approche intégrée il suffit maintenant d'activer la stratégie `DRLPolicy`. Puis de vérifier qu'elle sera bien utilisée par RASA durant les tests : l'activation de l'option de debug et l'accès aux logs doit permettre de vérifier cela de manière précise.

### Approche externe

Avec une approche externalisée, on pourra prévoir une génération la plus exhaustive possible des états de dialogues possibles et analyser les actions décidées par la stratégie pour les mettre en relation avec les propositions des autres stratégies disponibles dans RASA. La aussi : l'activation de l'option de debug et l'accès aux logs doit permettre de récupérer ces informations.

> **ATTENTION :** l'approche par DRL est très gourmande en données pour fonctionner correctement. Par exemple plusieurs milliers d'exemples de dialogue ! Il est donc vraisemblable que vos expériences ne permettent juste que d'approcher les possibilités offerte par la technique, sans pouvoir démontrer de vraie variation de performance. Toutefois il doit être possible de construire des cas « jouets » permettant de montrer l'intérêt de l'approche même avec peu de données.

---

© Fabrice Lefèvre, 2023
