# CERIBot Assistive — Progress checklist

> Projet Pepper / CERI — Master 1 Informatique, AMS Projet 1
> Binôme : Latifa El Hadj M'Barek · Younes Ben Dhiab
> Dernière mise à jour : 2026-11-17

**Documents de référence du projet :**
[cahier des charges](projet/cahier_de_charge_pepper.pdf) ·
[objectifs du binôme](<projet/objectifs_par binômes.md>) ·
[énoncé CERIBot](sujet/03-sujet-ceribot.md) ·
[synthèse des sources](notes/ceribot-course-sources-summary-v2.md)

## Jalons

| Période | Jalon | Statut |
|---|---|---|
| Sept. → déc. 2026 (S1) | Prise en main de Pepper, état de l'art, faisabilité, périmètre | En cours |
| **Fin déc. 2026** | **Présentation du premier prototype de faisabilité (PoC)** | À venir |
| Févr. → mai 2027 (S2) | Développement, intégration, évaluation, rédaction de l'article | À venir |
| Mai 2027 | Soutenance finale et démonstration | À venir |

## Répartition des rôles

D'après le [cahier des charges](projet/cahier_de_charge_pepper.pdf) (§8) et les [objectifs du binôme](<projet/objectifs_par binômes.md>). La répartition est indicative : l'intégration et les décisions techniques sont communes.

| Activité | Responsable |
|---|---|
| 1. Comportement embarqué Pepper (Choregraphe, navigation, capteurs, `monrobotparlant`) | Latifa |
| 2. Passerelle IA (FastAPI / Rasa / vLLM sur GPU LIA : ASR, LSF, résumés) | Latifa |
| 3. Intégration de l'API Emploi du Temps du CERI | Younes |
| 4. Interface tablette & restitution (affichage, QR codes, retour utilisateur) | Younes |
| Tests techniques | Latifa |
| Tests utilisateurs et analyse des résultats | Younes |

---

## 0. Démarrage immédiat

- [ ] Lire le [cahier des charges](projet/cahier_de_charge_pepper.pdf)
- [ ] Lire l'[énoncé du sujet CERIBot](sujet/03-sujet-ceribot.md)
- [ ] Lire le [support de formation Choregraphe (ERM)](docs/pepper/support_formation.pdf) et le [guide Pepper](docs/pepper/Guide_Pepper_VF.pdf)
- [ ] Lire la [charte design B2B Pepper](docs/pepper/Pepper_B2BD_guidelines_Sept_V1.5.pdf) (SIGN / FEEDBACK / FALLBACK)
- [ ] Confirmer l'accès à un robot Pepper et noter son adresse IP (1 appui sec sur le bouton du torse)
- [ ] Installer Choregraphe Suite **2.5.10** et vérifier que `Choregraphe.app` se lance sur le Mac
- [ ] Vérifier que Rosetta 2 est disponible si le Mac est Apple Silicon
- [ ] Obtenir une licence Choregraphe valide (clé fournie par le cours)
- [ ] Installer le SDK Python NAOqi ([`pynaoqi-python2.7-2.5.5.5-mac64.tar.gz`](ressources/pynaoqi-python2.7-2.5.5.5-mac64.tar.gz))
- [ ] Identifier le tuteur et fixer un premier point de suivi
- [ ] Créer une liste des contraintes connues : réseau, serveur GPU, caméra, audio, batterie

## 1. Cadrage du projet

- [ ] Définir la version minimale fonctionnelle (MVP) à présenter au PoC de fin décembre
- [ ] Prioriser les modules pour le premier prototype
- [ ] Définir le vocabulaire LSF initial
- [ ] Définir les salles et trajets prédéfinis du guidage
- [ ] Définir le format d'une fiche de transcription/résumé
- [ ] Décider quelles données sont conservées et combien de temps
- [ ] Définir les règles de supervision et de sécurité pendant les essais
- [ ] Clarifier avec l'encadrant si la comparaison **version de base / version améliorée** est obligatoire (exigée par l'[énoncé](sujet/03-sujet-ceribot.md#5-évaluation-du-système), optionnelle dans le cahier des charges)
- [ ] Mettre à jour le cahier des charges (V0 → V1) après validation du périmètre

## 2. Prise en main Pepper — *Latifa*

- [ ] Démarrer Pepper et vérifier son état général
- [ ] Désactiver la Vie Autonome pendant le développement (2 appuis sur le torse)
- [ ] Tester la connexion réseau entre le poste et Pepper
- [ ] Tester une commande vocale simple
- [ ] Tester la synthèse vocale
- [ ] Tester l'affichage sur la tablette
- [ ] Tester les capteurs et la détection d'obstacles
- [ ] Parcourir les [exemples Choregraphe](ressources/choregraphe/exemples-pepper/) (séquence, événements, dialogue, HTML)
- [ ] Ouvrir et comprendre le projet `monrobotparlant` ([archive](ressources/projet_monrobotparlant.zip))
- [ ] Créer un premier comportement de test reproductible
- [ ] Documenter les commandes utiles et les erreurs rencontrées

## 3. Serveur de dialogue et reconnaissance vocale — *Latifa*

Exigé par l'énoncé ([§1](sujet/03-sujet-ceribot.md#1-serveur-dialogue) et [§3](sujet/03-sujet-ceribot.md#3-connexion-robot-serveur)).

- [ ] Choisir la solution de dialogue : Rasa / Rasa-X ou LLM (vLLM + FastAPI)
- [ ] Déployer une version rudimentaire du bot ([guide vLLM](docs/llm-vllm/Guide_Installation_LLM_vLLM.pdf))
- [ ] Tester le bot en serveur REST (`curl -X POST ...`)
- [ ] Mettre en place la reconnaissance vocale externe (Google Cloud Speech, Whisper ou autre)
- [ ] Remplacer les adresses IP dans les boîtes `RasaCall` et `SpeechRecognition` de `monrobotparlant`
- [ ] Connecter le comportement Pepper au serveur et tester un échange complet

## 4. Architecture technique — *les deux*

- [ ] Dessiner le flux Pepper → API → services IA → Pepper (schéma d'architecture, livrable)
- [ ] Définir les endpoints REST et les formats JSON
- [ ] Définir les messages d'erreur et le mode dégradé local
- [ ] Vérifier l'accès au serveur GPU du LIA ([guide d'usage](docs/serveurs-gpu/innovation_usage_serveurs.pdf), [script Slurm](docs/serveurs-gpu/script_slurm.sh))
- [ ] Choisir les technologies après les tests de compatibilité
- [ ] Prévoir des journaux techniques sans données personnelles

## 5. Intégration de l'API Emploi du Temps — *Younes*

Voir la [documentation de l'API EDT](<docs/api-edt/Before you start  CERI-EDT-API-Docs.pdf>).

- [ ] Confirmer l'accès à l'API de l'emploi du temps du CERI
- [ ] Tester `GET api/salles` et `GET api/salles/disponibilite` (paramètres `site`, `duree`, `debut`, `date`)
- [ ] Gérer les erreurs renvoyées en HTTP 200 et les valeurs `null`
- [ ] Exposer un endpoint de la passerelle pour la recherche de salle libre
- [ ] Brancher la recherche de salle libre sur le guidage vocal (orientation dynamique)
- [ ] Prévoir une BD factice si l'accès n'est pas confirmé

## 6. Module 1 — Guidage vocal

- [ ] Choisir un premier trajet contrôlé (ex. hall → C028)
- [ ] Écrire les étapes et les indications vocales
- [ ] Implémenter la demande de salle
- [ ] Implémenter la réponse vocale étape par étape
- [ ] Ajouter la détection des obstacles proches
- [ ] Ajouter la confirmation ou répétition d'une instruction
- [ ] Ajouter un message clair en cas d'échec
- [ ] Tester uniquement sous supervision humaine

## 7. Module 2 — Aide à la communication en LSF

- [ ] Sélectionner un petit vocabulaire de signes/phrases
- [ ] Préparer les exemples d'entraînement et de validation
- [ ] Évaluer OpenCV et MediaPipe sur le matériel disponible
- [ ] Implémenter la capture contrôlée des gestes (vidéo 640×480 envoyée au serveur GPU)
- [ ] Afficher le résultat reconnu sur la tablette
- [ ] Lire le résultat à voix haute lorsque possible
- [ ] Permettre une réponse écrite sur la tablette
- [ ] Afficher un avertissement quand le signe est incertain
- [ ] Mesurer le taux de reconnaissance par signe

## 8. Module 3 — Transcription et résumé

- [ ] Définir la durée maximale d'un extrait (5 minutes maximum)
- [ ] Tester l'enregistrement audio sur Pepper
- [ ] Implémenter l'envoi sécurisé vers le service de transcription
- [ ] Mesurer le WER dans des conditions calmes
- [ ] Générer un résumé structuré
- [ ] Afficher la transcription et le résumé sur la tablette
- [ ] Générer une fiche récupérable par QR code
- [ ] Ajouter la suppression des fichiers temporaires
- [ ] Tester le comportement en cas de réseau indisponible

## 9. Interface tablette et accessibilité — *Younes*

- [ ] Uniformiser les interactions vocales
- [ ] Uniformiser les écrans tablette (même libellé et même ordre qu'à l'oral)
- [ ] Stopper les mouvements de Pepper quand l'utilisateur touche la tablette
- [ ] Ajouter une confirmation avant les actions importantes
- [ ] Prévoir répétition, annulation et retour arrière
- [ ] Prévoir des boutons de secours quand la voix n'est pas comprise (FALLBACK)
- [ ] Gérer les résultats vides, lents ou incorrects
- [ ] Ajouter un moyen de signaler un résultat incorrect
- [ ] Vérifier lisibilité, contraste et taille des textes
- [ ] Vérifier que l'utilisateur sait toujours ce que fait le robot

## 10. Tests et évaluation

**Validation technique — *Latifa***

- [ ] Mesurer la latence globale Pepper → passerelle FastAPI → serveur GPU
- [ ] Mesurer le temps de réponse des interactions simples
- [ ] Mesurer le WER de transcription
- [ ] Mesurer la reconnaissance du vocabulaire LSF

**Tests utilisateurs — *Younes***

- [ ] Écrire les scénarios de test des trois modules
- [ ] Préparer une grille d'observation
- [ ] Préparer le questionnaire Likert à 5 niveaux (facilité, compréhension, fiabilité, temps d'attente, satisfaction, commentaire libre)
- [ ] Conserver une version de base et une version améliorée pour la comparaison
- [ ] Réaliser les tests exploratoires avec 2 à 3 personnes
- [ ] Corriger les problèmes bloquants
- [ ] Réaliser l'évaluation avec 4 à 5 participants
- [ ] Mesurer le taux de réussite des tâches
- [ ] Calculer la satisfaction moyenne
- [ ] Analyser les commentaires et prioriser les améliorations

### Objectifs initiaux

| Indicateur | Cible |
|---|---:|
| Tâches réalisées correctement | ≥ 80 % |
| Réponse d'une interaction simple | < 3 s |
| WER en environnement calme | < 15 % |
| Reconnaissance des signes | mesurée sur le vocabulaire retenu |
| Satisfaction moyenne | ≥ 4/5 |

## 11. Livrables

D'après le [cahier des charges](projet/cahier_de_charge_pepper.pdf) (§7.2).

- [ ] Cahier des charges mis à jour et schéma d'architecture
- [ ] Premier PoC présenté à la fin du premier semestre (déc. 2026)
- [ ] Prototype final intégré à Pepper et son interface tablette
- [ ] Code source avec sa documentation d'installation et d'utilisation
- [ ] Protocole de test, grille d'évaluation, questionnaire utilisateur et résultats
- [ ] Article scientifique en anglais, rédigé en LaTeX (dont l'analyse des limites et des risques)
- [ ] Support de soutenance au format PDF
- [ ] Démonstration du prototype lors de la soutenance finale

## Risques à suivre

| Risque | Mesure prévue |
|---|---|
| Bruit perturbant la reconnaissance vocale | Commandes sur la tablette, boutons de secours |
| Connexion réseau instable | Message d'erreur et mode simple en local |
| Serveur GPU indisponible ou saturé | Version allégée des traitements |
| Éclairage ou visibilité insuffisante pour la LSF | Vocabulaire limité et mesure des erreurs |
| Guidage potentiellement dangereux | Trajets contrôlés et supervision humaine |
| Batterie limitant les essais (≈ 4 h, pas de déplacement sur secteur) | Planifier les sessions de test |
| Collecte de données audio/vidéo sensibles | Collecte limitée et participants informés |
| Périmètre trop large par rapport au temps disponible | Priorisation et version minimale fonctionnelle |
| Accès à l'API EDT non confirmé | BD factice |

## Journal de progression

| Date | Progression / décision | Prochaine action | Blocage |
|---|---|---|---|
| 2026-11-17 | Checklist initiale créée | Valider le MVP et l'accès à Pepper | À confirmer |
| 2026-11-17 | Dossier réorganisé ; checklist alignée sur le cahier des charges et les objectifs du binôme | Préparer le PoC de fin décembre | — |
