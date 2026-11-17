#!/bin/bash
#SBATCH --job-name=NameExpe
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-node=1
#SBATCH --mem=2G
#SBATCH --time=0:02:00


echo "My first sbatch script!"
#Ajouter le programme que vous voulez lancer



[TP] Usage de slurm et du serveur de calcul Joyeux par Yanis Labrak.

Pour ceux qui souhaite exécuté leurs TP3 sur une machine GPU de l'université, vous pouvez accéder à la machine du laboratoire nommé Joyeux. Pour ce faire:

Étape 1: Connection SSH au serveur de calcul avec le port 22 et l'identifiant uapvXXXXX@joyeux.univ-avignon.fr

Étape 2: Aller sur sont espace personnel et écrire le code du TP.

Étape 3: Compiler le programme CUDA avec nvcc.

Étape 4: Créer un script (code dessous) permettant à l'ordonnanceur SLURM de lancer votre code sur une machine doté d'un GPU Nvidia. N'oublier pas de créer le dossier ./logs/ pour réceptionner les sorties écran de votre script ainsi que les érreurs de compilation. PS: Il n'est pas possible d'exécuté du code GPU directement sur la machine sans passer par un "JOB" de l'ordonnanceur SLURM.

Fichier start.sh:

#!/bin/bash
#SBATCH --job-name=TP3
#SBATCH --ntasks=1             # Nombre total de processus MPI
#SBATCH --ntasks-per-node=1    # Nombre de processus MPI par noeud
#SBATCH --hint=nomultithread   # 1 processus MPI par coeur physique (pas d'hyperthreading)
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --gpus-per-node=1
#SBATCH --partition=gpu
#SBATCH --time=00:03:00
#SBATCH --output=./logs/%x_%A_%a.out
#SBATCH --error=./logs/%x_%A_%a.err

srun ./exo3


Étape 5: Mettre votre code dans la queue SLURM avec sbatch start.sh

Étape 6: Se rendre dans le dossier ./logs/ et observer les sorties OUT et ERR