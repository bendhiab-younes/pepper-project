# CERIBot Assistive — Progress checklist

> Projet Pepper / CERI — suivi de démarrage  
> Dernière mise à jour : 2026-11-17

## 0. Démarrage immédiat

- [ ] Lire le [cahier des charges](projet/cahier_de_charge_pepper.pdf)
- [ ] Lire le [support de formation Choregraphe (ERM)](docs/pepper/support_formation.pdf)
- [ ] Confirmer l'accès à un robot Pepper et noter son adresse IP
- [ ] Vérifier que le Mac peut lancer `Choregraphe.app`
- [ ] Vérifier que Rosetta 2 est disponible si le Mac est Apple Silicon
- [ ] Obtenir une licence Choregraphe valide, si Choregraphe est nécessaire
- [ ] Identifier le tuteur et fixer un premier point de suivi
- [ ] Créer une liste des contraintes connues : réseau, serveur GPU, caméra, audio, batterie

## 1. Cadrage du projet

- [ ] Définir la version minimale fonctionnelle (MVP)
- [ ] Prioriser les modules pour le premier prototype
- [ ] Définir le vocabulaire LSF initial
- [ ] Définir les salles et trajets prédéfinis du guidage
- [ ] Définir le format d'une fiche de transcription/résumé
- [ ] Décider quelles données sont conservées et combien de temps
- [ ] Définir les règles de supervision et de sécurité pendant les essais

## 2. Prise en main Pepper

- [ ] Démarrer Pepper et vérifier son état général
- [ ] Tester la connexion réseau entre le poste et Pepper
- [ ] Tester une commande vocale simple
- [ ] Tester la synthèse vocale
- [ ] Tester l'affichage sur la tablette
- [ ] Tester les capteurs et la détection d'obstacles
- [ ] Ouvrir et comprendre le projet `monrobotparlant`
- [ ] Créer un premier comportement de test reproductible
- [ ] Documenter les commandes utiles et les erreurs rencontrées

## 3. Architecture technique

- [ ] Dessiner le flux Pepper → API → services IA → Pepper
- [ ] Définir les endpoints REST et les formats JSON
- [ ] Définir les messages d'erreur et le mode dégradé local
- [ ] Vérifier l'accès au serveur GPU du LIA
- [ ] Vérifier l'accès éventuel à l'API de l'emploi du temps du CERI
- [ ] Choisir les technologies après les tests de compatibilité
- [ ] Prévoir des journaux techniques sans données personnelles

## 4. Module 1 — Guidage vocal

- [ ] Choisir un premier trajet contrôlé (ex. hall → C028)
- [ ] Écrire les étapes et les indications vocales
- [ ] Implémenter la demande de salle
- [ ] Implémenter la réponse vocale étape par étape
- [ ] Ajouter la détection des obstacles proches
- [ ] Ajouter la confirmation ou répétition d'une instruction
- [ ] Ajouter un message clair en cas d'échec
- [ ] Tester uniquement sous supervision humaine

## 5. Module 2 — Aide à la communication en LSF

- [ ] Sélectionner un petit vocabulaire de signes/phrases
- [ ] Préparer les exemples d'entraînement et de validation
- [ ] Évaluer OpenCV et MediaPipe sur le matériel disponible
- [ ] Implémenter la capture contrôlée des gestes
- [ ] Afficher le résultat reconnu sur la tablette
- [ ] Lire le résultat à voix haute lorsque possible
- [ ] Permettre une réponse écrite sur la tablette
- [ ] Afficher un avertissement quand le signe est incertain
- [ ] Mesurer le taux de reconnaissance par signe

## 6. Module 3 — Transcription et résumé

- [ ] Définir la durée maximale d'un extrait (5 minutes maximum)
- [ ] Tester l'enregistrement audio sur Pepper
- [ ] Implémenter l'envoi sécurisé vers le service de transcription
- [ ] Mesurer le WER dans des conditions calmes
- [ ] Générer un résumé structuré
- [ ] Afficher la transcription et le résumé sur la tablette
- [ ] Générer une fiche récupérable par QR code
- [ ] Ajouter la suppression des fichiers temporaires
- [ ] Tester le comportement en cas de réseau indisponible

## 7. Fonctions communes et accessibilité

- [ ] Uniformiser les interactions vocales
- [ ] Uniformiser les écrans tablette
- [ ] Ajouter une confirmation avant les actions importantes
- [ ] Prévoir répétition, annulation et retour arrière
- [ ] Gérer les résultats vides, lents ou incorrects
- [ ] Ajouter un moyen de signaler un résultat incorrect
- [ ] Vérifier lisibilité, contraste et taille des textes
- [ ] Vérifier que l'utilisateur sait toujours ce que fait le robot

## 8. Tests et évaluation

- [ ] Écrire les scénarios de test des trois modules
- [ ] Préparer une grille d'observation
- [ ] Préparer le questionnaire de satisfaction sur 5
- [ ] Réaliser les tests exploratoires avec 2 à 3 personnes
- [ ] Corriger les problèmes bloquants
- [ ] Réaliser l'évaluation avec 4 à 5 participants
- [ ] Mesurer le taux de réussite des tâches
- [ ] Mesurer le temps de réponse des interactions simples
- [ ] Mesurer le WER de transcription
- [ ] Mesurer la reconnaissance du vocabulaire LSF
- [ ] Calculer la satisfaction moyenne
- [ ] Analyser les commentaires et prioriser les améliorations

### Objectifs initiaux

| Indicateur | Cible |
|---|---:|
| Tâches réalisées correctement | ≥ 80 % |
| Réponse d'une interaction simple | < 3 s |
| WER en environnement calme | < 15 % |
| Satisfaction moyenne | ≥ 4/5 |

## 9. Livrables

- [ ] Prototype de faisabilité (PoC)
- [ ] Prototype Pepper intégrant les modules retenus
- [ ] Documentation d'installation et d'utilisation
- [ ] Description de l'architecture
- [ ] Scénarios et résultats des tests
- [ ] Analyse des limites et des risques
- [ ] Rapport final
- [ ] Présentation / démonstration finale

## Risques à suivre

- [ ] Bruit perturbant la reconnaissance vocale
- [ ] Connexion réseau instable
- [ ] Serveur GPU indisponible ou saturé
- [ ] Éclairage ou visibilité insuffisante pour la LSF
- [ ] Guidage potentiellement dangereux
- [ ] Batterie limitant les essais
- [ ] Collecte de données audio/vidéo sensibles
- [ ] Périmètre trop large par rapport au temps disponible

## Journal de progression

| Date | Progression / décision | Prochaine action | Blocage |
|---|---|---|---|
| 2026-11-17 | Checklist initiale créée | Valider le MVP et l'accès à Pepper | À confirmer |

