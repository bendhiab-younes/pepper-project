# Objectifs à réaliser (par binômes)

## 1. Décrire en 2-3 phrases max ce que vous comptez faire dans l'appli

Application d'aide au handicap sur le robot Pepper au CERI.

3 fonctions principales :

- **guidage vocal** pour les aveugles ;
- **traduction de la langue des signes (LSF)** pour les sourds ;
- **résumé automatique des cours** pour ceux qui ne peuvent pas écrire.

## 2. Donner les éléments principaux à mettre en oeuvre pour atteindre vos objectifs

1. **Développement du comportement embarqué Pepper (Choregraphe)** : Gestion de la navigation sécurisée (sonars/lasers), des capteurs tactiles et des échanges vocaux via le comportement `monrobotparlant`.
2. **Déploiement de la passerelle IA (FastAPI / Rasa / vLLM sur GPU LIA)** : Traitement de la reconnaissance vocale (ASR), de l'extraction de la squelettisation vidéo LSF (MediaPipe/PoseNet) et de la génération automatique de résumés de cours.
3. **Intégration de l'API Emploi du Temps du CERI** : Requêtes REST pour l'orientation dynamique vers les salles de cours libres et la consultation des plannings.
4. **Interface Tablette & Restitution** : Affichage textuel synchronisé, génération de QR Codes pour le téléchargement des fiches de cours et module de retour utilisateur.

## 3. Pour la liste de la question précédente, donner les étudiants affectés prioritairement à chaque activité

| Activité | Étudiant·e |
|---|---|
| Activité 1 | Latifa El Hadj M’barek |
| Activité 2 | Latifa El Hadj M’barek |
| Activité 3 | Younes Ben Dhiab |
| Activité 4 | Younes Ben Dhiab |

## 4. Décrivez les étapes prévues de la validation expérimentale de votre dispositif final

1. **Validation technique unitaire** : Vérification des temps de réponse réseau et de la latence globale entre le robot Pepper, la passerelle FastAPI et le serveur GPU du LIA.
2. **Campagne de tests en situation réelle** : Réalisation de tests modérés dans le hall du CERI avec 4 à 5 testeurs réalisant 3 scénarios cibles (guidage vocal sans écran, traduction d'une phrase signée LSF, génération d'une fiche de cours).
3. **Évaluation comparative & Échelle de Likert** : Analyse comparative de la version de base vs la version IA améliorée via un questionnaire de satisfaction évalué sur une échelle de Likert à 5 points.

## 5. Est-ce que vous entrevoyez des difficultés particulières pour l'instant ?

- **Vidéo LSF** : Le processeur de Pepper étant trop faible, la vidéo est limitée à 640×480 (VGA) et envoyée au serveur GPU du LIA pour rester fluide.
- **Microphone** : Le bruit et l'écho du hall du CERI gênent l'écoute ; la tablette prend le relais (boutons de secours) si le robot ne comprend pas.
- **Batterie** : 4 heures d'autonomie, et Pepper ne peut pas rouler lorsqu'il est branché sur secteur.
