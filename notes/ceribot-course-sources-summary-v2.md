# Synthèse Complète des Documents du Cours CERIBot & Interactions Vocales Homme-Robot

## TL;DR

Ce document rassemble la synthèse intégrale et structurée des 11 documents composant le cours **Interactions Vocales Homme-Robot & Projet CERIBot** (Université d'Avignon - CERI / LIA).
L'objectif central du projet **CERIBot** est de connecter un robot humanoïde (SoftBank Pepper / NAO) à une infrastructure distante de dialogue intelligent (Rasa / Rasa-X ou LLM open-source via vLLM) et d'interfacer l'ensemble avec des API métier (API Emploi du Temps du CERI) pour réaliser des tâches d'accueil, d'orientation, de consultation d'agenda et d'animation interactive dans le hall du bâtiment.

### Points Clés à Retenir :

* **IHM Vocale & Architecture de Dialogue (`defiIV_FL_20.pdf`)** : La parole humaine (~150 mots/min) est le canal d'interaction le plus rapide. L'architecture classique repose sur une chaîne séquentielle : ASR (Reconnaissance) -> NLU (Compréhension) -> Dialogue Manager (Estimateur d'état & Politique) -> Génération -> TTS (Synthèse).
* **Matériel & Robotique Pepper (`Guide_Pepper_VF.pdf`, `support_formation.pdf`)** : Robot humanoïde de 121 cm et 29 kg, équipé de 17 moteurs (précision 0,1°), 4 microphones, 2 caméras HD, 1 capteur 3D Asus Xtion, 2 sonars, lasers, bumpers, et une tablette tactile 10,1". Autonomie d'environ 4 heures. Identifiants système par défaut documentés dans le support ERM. La Vie Autonome se bascule par 2 appuis consécutifs sur le torse.
* **Directives Design B2B (`Pepper_B2BD_guidelines_Sept_V1.5.pdf`)** : Règle fondamentale : *"Pepper ne parle pas seul"*. La voix est le canal principal, la tablette est secondaire. Garantie d'ergonomie via le triptyque **SIGN** (guidage préalable), **FEEDBACK** (confirmation) et **FALLBACK** (solution de secours). Pepper doit stopper ses mouvements lorsqu'un utilisateur touche sa tablette.
* **API Emploi du Temps du CERI (`Before you start CERI-EDT-API-Docs.pdf`)** : Point d'accès principal de l'API emploi du temps. Permet la recherche des salles libres via l'endpoint dédié avec les paramètres `site`, `duree`, `debut`, `date`. *Attention* : certaines erreurs sont renvoyées sous HTTP 200 et des catégories existent sous la valeur `null`.
* **Serveur de Dialogue Rasa & LLM (`RASA_ebook-v3.pdf`, `Guide_Installation_LLM_vLLM.pdf`, `ReadMe.md`)** :
  * **Rasa** : Classification NLU (intentions/entités) et gestion de dialogue multi-tour via **TEDPolicy** (*Transformer Embedding Dialogue Policy*).
  * **vLLM / FastAPI** : Inférence haute performance avec l'algorithme **PagedAttention**, connectée via un webhook FastAPI sur le port 5000.
  * **Projet NAO-Rasa (`ReadMe.md`)** : Nécessite impérativement la vraie adresse IP des serveurs dans la configuration (placeholders et adresses locales proscrits).
* **Infrastructures de Calcul LIA (`innovation_usage_serveurs.pdf`)** : Serveurs hybrides *Achille* et *Heracles* équipés de GPUs Nvidia Tesla P100 (16 Go VRAM) et d'environnements Anaconda isolés. Règle absolue : programmer localement, exécuter à distance et surveiller l'usage VRAM via `nvidia-smi` / `htop`.
* **Projet CERIBot & Évaluation (`Sujet d'application _CERIBot_, robot d'accueil.pdf`, `Squelette exemple du cahier des charges.pdf`)** : Déploiement du comportement client `monrobotparlant` dans Choregraphe. Évaluation comparative entre la version de base et la version améliorée auprès de 4 à 5 testeurs sur une **échelle de Likert à 5 points**.

---

## Sommaire

1. [Conférence & Concepts d'IHM Vocale (`defiIV_FL_20.pdf`)](#1-conférence--concepts-dihm-vocale-defiiv_fl_20pdf)
2. [Spécifications Matérielles & Maintenance du Robot Pepper (`Guide_Pepper_VF.pdf`)](#2-spécifications-matérielles--maintenance-du-robot-pepper-guide_pepper_vfpdf)
3. [Guide Technique ERM & Programmation Choregraphe (`support_formation.pdf`)](#3-guide-technique-erm--programmation-choregraphe-support_formationpdf)
4. [Directives Ergonomiques & Charte Design B2B SoftBank (`Pepper_B2BD_guidelines_Sept_V1.5.pdf`)](#4-directives-ergonomiques--charte-design-b2b-softbank-pepper_b2bd_guidelines_sept_v15pdf)
5. [Documentation de l'API Emploi du Temps du CERI (`Before you start CERI-EDT-API-Docs.pdf`)](#5-documentation-de-lapi-emploi-du-temps-du-ceri-before-you-start-ceri-edt-api-docspdf)
6. [Manuel complet du Framework Rasa & Architecture Rasa Core (`RASA_ebook-v3.pdf`)](#6-manuel-complet-du-framework-rasa--architecture-rasa-core-rasa_ebook-v3pdf)
7. [Guide d'Installation et Configuration Projet NAO-Rasa (`ReadMe.md`)](#7-guide-dinstallation-et-configuration-projet-nao-rasa-readmemd)
8. [Déploiement Chatbot LLM Open Source avec vLLM & FastAPI (`Guide_Installation_LLM_vLLM.pdf`)](#8-déploiement-chatbot-llm-open-source-avec-vllm--fastapi-guide_installation_llm_vllmpdf)
9. [Guide d'Usage des Serveurs Mutualisés du LIA (`innovation_usage_serveurs.pdf`)](#9-guide-dusage-des-serveurs-mutualisés-du-lia-innovation_usage_serveurspdf)
10. [Sujet de Projet d'Application CERIBot (`Sujet d'application _CERIBot_, robot d'accueil.pdf`)](#10-sujet-de-projet-dapplication-ceribot-sujet-dapplication-_ceribot_-robot-daccueilpdf)
11. [Squelette et Canevas de Cahier des Charges (`Squelette exemple du cahier des charges.pdf`)](#11-squelette-et-canevas-de-cahier-des-charges-squelette-exemple-du-cahier-des-chargespdf)

---

## 1. Conférence & Concepts d'IHM Vocale (`defiIV_FL_20.pdf`)

Ce document retrace l'évolution technologique des interactions vocales homme-machine (IHM vocale), analysant les avantages comparatifs de la voix et posant l'architecture de référence des systèmes de dialogue oral.

### 1.1 Vitesse de Communication

La parole naturelle offre une vitesse d'expression nettement supérieure aux modes de saisie manuels classiques :

* **Production orale** : environ **150 mots par minute**.
* **Saisie clavier** : environ **20 mots par minute**.
* **Écriture manuscrite** : environ **24 mots par minute**.

### 1.2 Pipeline Architecture des Systèmes de Dialogue

L'architecture classique d'un assistant vocal repose sur une chaîne modulaire séquentielle :

| Composant | Intitulé Anglais | Rôle & Traitement Entrée / Sortie |
| :--- | :--- | :--- |
| **Reconnaissance Vocale** | *Speech Recognizer* (ASR) | Reçoit le signal acoustique brut et produit une chaîne de mots (*word string*). |
| **Compréhension** | *Speech Understanding* (NLU) | Analyse la chaîne de mots et extrait l'intention de l'utilisateur (*user act*). |
| **Gestion de Dialogue** | *Dialogue Manager* (DM) | Maintient l'état/croyance (*Belief*) et applique la politique (*Policy*) pour déterminer l'action système (*machine act*). |
| **Génération Texte** | *Speech Generation* | Transforme l'action système en phrase textuelle structurée. |
| **Synthèse Vocale** | *Speech Synthesis* (TTS) | Convertit le texte généré en signal audio restitué par les haut-parleurs. |

### 1.3 Optimisation par Apprentissage par Renforcement

Pour dépasser les limites des systèmes rigides basés sur des règles écrites à la main, le gestionnaire de dialogue (*Dialogue Manager*) fait appel à l'**apprentissage par renforcement (*Reinforcement Learning*)**. L'agent apprend à optimiser sa politique d'action (*Policy*) en maximisant un cumul de récompenses (*rewards*) associées à la résolution efficace de la tâche. Ces modèles sont qualifiés de *"data-hungry"* en raison du volume d'interactions requis pour converger.

---

## 2. Spécifications Matérielles & Maintenance du Robot Pepper (`Guide_Pepper_VF.pdf`)

Ce manuel utilisateur officiel décrit les procédures opérationnelles, la gestion de l'énergie et la sécurité lors du maniement du robot Pepper.

### 2.1 Alimentation, Batterie & Déplacements

* **Autonomie de batterie** : environ **4 heures** en fonctionnement normal.
* **Règle absolue de déplacement** : La trappe d'alimentation située en bas du robot doit impérativement être fermée pour que Pepper puisse rouler. Pepper ne peut pas se déplacer lorsqu'il est branché au secteur.
* **Mise en veille (Mode repos)** : Poser la main pendant 3 secondes sur la tête (paume sur la caméra du front, doigts sur les capteurs tactiles). Les LEDs des yeux deviennent violets.

### 2.2 Fermeture d'Activité & Voyants d'Écran

* **Arrêter une activité en cours** : Poser la main 1 seconde sur la tête. Les LEDs des yeux et des épaules deviennent vertes, et le robot émet le son *"BLOP"*.
* **Codes couleurs des LEDs d'épaules** :
  * **Vert** : Action en cours ou notification d'état normal.
  * **Orange** : Avertissement système / dysfonctionnement nécessitant une intervention.

### 2.3 Programmation des Boîtes Choregraphe

* **Animated Say** : Intègre trois modes de mouvements de parole (*Speaking movement mode*) : `Disabled`, `Random` et `Contextual`.
* **Boîtes Choice vs Choice (light)** : La boîte `Choice (light)` est une version allégée sans animations automatiques intégrées.
* **Précautions Timeline** : Espacer les marques de temps (*keyframes*) et tester des gestes simples sur le robot réel pour éviter que le robot ne perde l'équilibre.

---

## 3. Guide Technique ERM & Programmation Choregraphe (`support_formation.pdf`)

Ce support de formation rédigé par ERM Automatismes détaille l'architecture matérielle, le système OpenNAO, le réseau et le langage QiChat.

### 3.1 Fiche Technique du Robot Pepper

* **Gabarit & Poids** : Hauteur de **121 cm**, profondeur de 425 mm, largeur de 485 mm, poids total de **29 kg**.
* **Batterie** : Lithium-Ion 24V / 30Ah.
* **Unité de calcul** : CPU Intel Atom E3845 Quad-Core (1,91 GHz), 4 Go RAM DDR3, stockage Flash 8 Go + MicroSD 16 Go.
* **Système d'exploitation** : OpenNAO (basé sur Linux Gentoo) + Middleware NAOqi.
* **Moteurs & Articulations** : **17 moteurs articulés**, tous équipés de capteurs de position à effet Hall d'une précision de **0,1°**.
* **Capteurs & Équipements** :
  * **Audio** : 4 microphones sur la tête, 2 haut-parleurs dans les oreilles.
  * **Vision** : 2 caméras HD (jusqu'à 2560x1920 @1fps), 1 capteur 3D Asus Xtion (1280x1024).
  * **Navigation & Sol** : 2 sonars (obstacles en hauteur), capteurs lasers au sol, capteurs infrarouges, 3 bumpers au niveau des roues.
  * **LEDs** : 8 LEDs RGB par œil, 10 LEDs bleues par oreille, 2 LEDs RGB par épaule.

### 3.2 Accès Réseau & Identifiants

* **Connexion SSH et FTP** :
  * Identifiants SSH et FTP par défaut fournis dans la documentation d'origine.
  * *Note* : L'accès compte `root` n'est pas fourni.

### 3.3 Gestion de la Vie Autonome (*Autonomous Life*)

La Vie Autonome comprend 3 états : `Disabled`, `Solitary` (attente dynamique) et `Interactive` (exécution d'application).

* **Bascule manuelle** : Effectuer **2 appuis consécutifs sur le bouton du torse**.
* **Avertissement développement** : Lors du lancement d'un comportement via Choregraphe, la Vie Autonome reste en mode *Solitary* et peut entrer en conflit avec le programme. Il est vivement recommandé de la désactiver pendant les phases de dev.

### 3.4 Boîtes Vocales & QiChat (`.top`)

* **`Say` vs `SayText`** : `Say` utilise une chaîne fixe configurée dans les paramètres de la boîte. `SayText` reçoit le texte dynamique sur son entrée `onStart`.
* **Syntaxe QiChat** :
  * `[]` : Liste de choix / substitution de mots.
  * `{}` : Mots ou expressions facultatifs.
  * `^nextProposal` : Passe à la proposition suivante du fichier de dialogue.
  * `^goto(tag)` : Saute vers une proposition marquée par un tag `%tag`.

---

## 4. Directives Ergonomiques & Charte Design B2B SoftBank (`Pepper_B2BD_guidelines_Sept_V1.5.pdf`)

Ce document édité par SoftBank Robotics fixe les standards indispensables pour concevoir des expériences utilisateur (UX) professionnelles avec Pepper.

### 4.1 Identité & Principes Fondamentaux

* **Taille B2B** : 47 inches (~120 cm).
* **Règle d'or absolue** : *"Pepper ne parle pas seul"* (*Pepper does not talk alone*). Le robot ne doit jamais émettre de monologue sans présence ou contexte humain.
* **Interdiction visuelle** : Ne jamais allumer les LEDs des yeux en **rouge** (associé à la colère/effroi).

### 4.2 Rôle de la Tablette & Synchronisation

* **Canal principal vs secondaire** : La voix est le moyen de communication numéro 1. La tablette est uniquement un outil de soutien visuel (*support tool*).
* **Inhibition des mouvements (*Pepper is aware of the tablet*)** : Dès que l'utilisateur touche l'écran tactile, Pepper **doit impérativement stopper ses mouvements de corps et de bras** pour stabiliser la tablette et éviter de frapper l'utilisateur.
* **Synchronisation stricte** :
  * Utiliser le **même libellé (*wording*)** à l'oral et sur l'écran.
  * Lister les éléments sur l'écran dans le **même ordre** que la liste énoncée vocalement.

### 4.3 Structure du Flux Utilisateur (*User Flow*)

Toute interaction applicative doit respecter le triptyque :

1. **SIGN** : Guidage visuel/vocal *avant* la saisie (ex: suggérer les phrases à prononcer entre guillemets `"..."`).
2. **FEEDBACK** : Validation visuelle/sonore *après* l'action de l'utilisateur (ex: changement de couleur du bouton).
3. **FALLBACK** : Solution de repli si l'utilisateur ne répond pas après un délai imparti (ex: basculer sur des boutons tactiles).

---

## 5. Documentation de l'API Emploi du Temps du CERI (`Before you start CERI-EDT-API-Docs.pdf`)

Ce document de référence décrit l'architecture de l'API REST fournissant l'emploi du temps et la disponibilité des salles du campus CERI.

### 5.1 Configuration de Base & Pièges JSON

* **URL de base (`base_url`)** : Point d'accès officiel de l'API EDT du CERI.
* **Format des réponses** : Objet JSON contenant la clé racine `results`.
* **Avertissements d'implémentation** :
  * Des codes d'erreur métier sont parfois transmis sous un statut HTTP 200.
  * Certaines promotions/classes sont répertoriées sous la valeur `null`.

### 5.2 Endpoints Principaux & Recommandations

```
GET api/salles
GET api/salles/disponibilite?site=CERI&duree=3&debut=10.30&date=2020-11-13
GET api/elements
GET api/matieres/UE
```

#### Requête de Disponibilité des Salles :

Pour connaître les salles libres, les 4 paramètres GET ci-dessous sont obligatoires :

* `site` : Chaîne identifiant le site (ex: `CERI`, `AGROSCIENCES`, `Centre-ville`, `IUT`).
* `duree` : Durée en heures (ex: `3` pour 3 heures, `1.30` pour 1h30).
* `debut` : Heure de début au format décimal (ex: `10.30` pour 10h30).
* `date` : Date au format `YYYY-MM-DD` (ex: `2020-11-13`).

---

## 6. Manuel complet du Framework Rasa & Architecture Rasa Core (`RASA_ebook-v3.pdf`)

Ce manuel de référence traite de l'installation, de la conception NLU, de la gestion de dialogue et du déploiement d'assistants IA avec Rasa.

### 6.1 Commandes CLI Usuelles

* `rasa init` : Génère l'arborescence et le projet modèle de départ.
* `rasa train` : Entraîne les modèles NLU et Core.
* `rasa run actions` : Lance le serveur d'actions personnalisées (`actions.py` défini dans `endpoints.yml`).
* `rasa shell` : Ouvre une console d'échange interactif pour tester le modèle.

### 6.2 Pipelines NLU

* `supervised_embeddings` : Entraîne le modèle à partir de zéro (*from scratch*) sur vos propres données. Recommandé pour le vocabulaire métier spécifique.
* `pretrained_embeddings_spacy` : Utilise des représentations vectorielles pré-entraînées et le classifieur `SklearnIntentClassifier`.

### 6.3 Dialogue Policies (Exécution Parallèle & Priorités)

Contrairement aux composants NLU qui s'exécutent en séquence, les **politiques de dialogue s'exécutent en parallèle**. Chaque politique prédit l'action suivante avec un score de confiance. En cas d'égalité, Rasa applique l'échelle de priorité stricte suivante :

1. **Priorité 5** : `FormPolicy` (gestion des formulaires)
2. **Priorité 4** : `FallbackPolicy` / `TwoStageFallbackPolicy` (gestion de l'incertitude)
3. **Priorité 3** : `MemoizationPolicy` (recherche de fragments d'histoires exacts)
4. **Priorité 2** : `MappingPolicy` (association directe intention -> action)
5. **Priorité 1** : Politiques ML (`TEDPolicy`, `KerasPolicy`)

### 6.4 Focus sur la `TEDPolicy` (*Transformer Embedding Dialogue Policy*)

Modèle basé sur une architecture Transformer qui concatène l'intention/entités utilisateur (*User Intent & Entities*), l'action système précédente (*Previous System Action*) et les *Slots* enregistrés pour calculer la similarité d'embedding avec les actions possibles.

---

## 7. Guide d'Installation et Configuration Projet NAO-Rasa (`ReadMe.md`)

Ce guide technique explique comment lier le comportement du robot NAO/Pepper développé sous Choregraphe avec les serveurs de dialogue Rasa et de reconnaissance vocal Google.

### 7.1 Architecture & Adressage IP

* **Règle impérative** : Il faut obligatoirement configurer les **vraies adresses IP distantes** des serveurs dans l'ensemble des fichiers de configuration. L'utilisation de placeholders ou d'adresses virtuelles provoque l'échec des communications REST du robot.

### 7.2 Configuration du Client Choregraphe

* Ouvrir le projet `NaoRasaProject/NaoRasa.pml` dans Choregraphe.
* Modifier les paramètres d'adresse IP dans les boîtes `RasaCall` et `SpeechRecognition`.
* Déployer le projet sur le robot via la touche `F5`.

---

## 8. Déploiement Chatbot LLM Open Source avec vLLM & FastAPI (`Guide_Installation_LLM_vLLM.pdf`)

Ce manuel décrit la procédure complète pour auto-héberger un modèle de langage (ex: Mistral 7B) avec accélération GPU, créer une passerelle Webhook et l'exposer sur Internet.

### 8.1 Inférence vLLM & Commande de Lancement

vLLM exploite l'architecture **PagedAttention** pour optimiser l'allocation de la VRAM GPU.

```bash
# Activation venv & Lancement vLLM
source vllm_env/bin/activate
vllm serve mistralai/Mistral-7B-Instruct-v0.3 --port 8000 --gpu-memory-utilization 0.90
```

Le serveur met à disposition un point d'accès OpenAI local compatible.

### 8.2 Passerelle FastAPI (`webhook_server.py`)

vLLM assurant uniquement l'inférence brute, une passerelle Python FastAPI sur le port 5000 intercepte les requêtes JSON externes, extrait le champ texte, formate le prompt et interroge vLLM sur le port 8000.

```bash
uvicorn webhook_server:app --host 0.0.0.0 --port 5000
```

---

## 9. Guide d'Usage des Serveurs Mutualisés du LIA (`innovation_usage_serveurs.pdf`)

Ce document établit les règles d'éthique et d'exploitation des serveurs de calcul partagés de l'Université d'Avignon.

### 9.1 Matériel Disponible & Accès SSH

* **Machines** : Serveurs hybrides *Achille* et *Heracles*.
* **Équipement** : Bi-CPU Intel Xeon, 128 Go RAM DDR4 ECC, 2 cartes GPU **Nvidia Tesla P100 (16 Go VRAM)** par serveur.
* **Accès SSH** : Connexion via le compte LDAP de l'université.

### 9.2 Règles de Workflow & Bonnes Pratiques

1. **Développement local / Exécution distante** : Programmer sur sa machine personnelle et transférer le script sur le serveur uniquement au moment du lancement.
2. **Gestion d'environnement Anaconda** : Isolement des bibliothèques via `conda create --name {envname}`.
3. **Surveillance GPU obligatoire** : Lancer impérativement `nvidia-smi` ou `htop` **avant et après** le lancement d'un script pour s'assurer que le GPU n'est pas saturé.
4. **Sélection de GPU spécifique** : `CUDA_VISIBLE_DEVICES=0 python monscript.py`.

---

## 10. Sujet de Projet d'Application CERIBot (`Sujet d'application _CERIBot_, robot d'accueil.pdf`)

Ce cahier de projet définit le travail pratique d'intégration du robot d'accueil Pepper dans le bâtiment du CERI.

### 10.1 Composants de l'Architecture

* **Client Robot** : Comportement Choregraphe `monrobotparlant` gérant l'acquisition audio/vidéo et l'animation du corps.
* **Serveur de Dialogue** : Agent Rasa-X ou serveur LLM (FastChat / LangChain avec Mistral-7B / Llama-3).
* **Reconnaissance vocale distante** : Moteur Google Cloud Speech ou DeepSpeech pour contourner la limitation du dictionnaire local du robot.

### 10.2 Tâches d'Accueil Attendues

* **Occupation des salles libres** : Consultation dynamique de l'API EDT du CERI.
* **Orientation dans le bâtiment** : Recherche de la route et affichage de la carte/plan d'accès sur la tablette.
* **SMS Enseignant** : Envoi de message texte à un professeur.
* **Socialisation** : Météo, état mental, blagues.

### 10.3 Approfondissement & Évaluation

* **Deep RL / TEDPolicy** : Analyse des logs de dialogue et apprentissage de politique par renforcement (Actor-Critic / DDPG).
* **Évaluation expérimentale** : Comparaison entre la version de base et la version améliorée auprès de **4 à 5 testeurs** utilisant une **échelle de Likert à 5 points**.

---

## 11. Squelette et Canevas de Cahier des Charges (`Squelette exemple du cahier des charges.pdf`)

Ce document fournit le modèle type de cahier des charges pour les projets informatiques M1 avec évaluation ergonomique.

### 11.1 Structure Canonique des Sections

1. **Contexte et Objectifs du Projet** (besoins, UX, tests utilisateurs).
2. **Périmètre du Projet** (fonctionnalités attendues, stack technique).
3. **Public Cible** (profil utilisateur, échantillon de testeurs).
4. **Scénarios de Tests Utilisateurs** (méthodologie modérée/non modérée, tâches cibles).
5. **Critères de Réussite et Évaluations** (KPI : taux de réussite >85%, temps d'accomplissement <2 min, échelle de Likert >4/5).
6. **Contraintes et Risques** (bruit acoustique, débit vidéo, autonomie batterie).
7. **Planning Prévisionnel & Livrables** (conception, dev, tests, rapport).
8. **Équipe du Projet & Annexes** (questionnaires Likert, diagrammes).
