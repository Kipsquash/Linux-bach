#!/bin/bash

# Script de gestion administrative pour Linux
# Menu interactif pour la gestion des utilisateurs, groupes, mots de passe, permissions, services et processus

# Fonction pour afficher le menu principal
afficher_menu() {
    echo "=== Menu de Gestion Administrative ==="
    echo "1. Gestion des utilisateurs et groupes"
    echo "2. Gestion des mots de passe"
    echo "3. Gestion des permissions des dossiers/fichiers"
    echo "4. Gestion des services"
    echo "5. Gestion des processus"
    echo "6. Quitter"
    echo -n "Choisissez une option (1-6): "
}

# Fonction pour la gestion des utilisateurs et groupes
gestion_utilisateurs_groupes() {
    echo "=== Gestion des Utilisateurs et Groupes ==="
    echo "1. Créer un utilisateur"
    echo "2. Supprimer un utilisateur"
    echo "3. Créer un groupe"
    echo "4. Supprimer un groupe"
    echo "5. Retour au menu principal"
    echo -n "Choisissez une option (1-5): "
    read choix
    case $choix in
        1)
            echo -n "Nom de l'utilisateur à créer: "
            read username
            sudo useradd $username
            echo "Utilisateur $username créé."
            ;;
        2)
            echo -n "Nom de l'utilisateur à supprimer: "
            read username
            sudo userdel $username
            echo "Utilisateur $username supprimé."
            ;;
        3)
            echo -n "Nom du groupe à créer: "
            read groupname
            sudo groupadd $groupname
            echo "Groupe $groupname créé."
            ;;
        4)
            echo -n "Nom du groupe à supprimer: "
            read groupname
            sudo groupdel $groupname
            echo "Groupe $groupname supprimé."
            ;;
        5)
            return
            ;;
        *)
            echo "Option invalide."
            ;;
    esac
}

# Fonction pour la gestion des mots de passe
gestion_mots_de_passe() {
    echo "=== Gestion des Mots de Passe ==="
    echo "1. Réinitialiser le mot de passe d'un utilisateur"
    echo "2. Modifier le mot de passe d'un utilisateur"
    echo "3. Bloquer l'accès d'un utilisateur"
    echo "4. Retour au menu principal"
    echo -n "Choisissez une option (1-4): "
    read choix
    case $choix in
        1)
            echo -n "Nom de l'utilisateur: "
            read username
            sudo passwd -d $username
            echo "Mot de passe de $username réinitialisé."
            ;;
        2)
            echo -n "Nom de l'utilisateur: "
            read username
            sudo passwd $username
            ;;
        3)
            echo -n "Nom de l'utilisateur à bloquer: "
            read username
            sudo usermod -L $username
            echo "Accès de $username bloqué."
            ;;
        4)
            return
            ;;
        *)
            echo "Option invalide."
            ;;
    esac
}

# Fonction pour la gestion des permissions
gestion_permissions() {
    echo "=== Gestion des Permissions des Dossiers/Fichiers ==="
    echo -n "Chemin du fichier/dossier: "
    read path
    echo -n "Permissions (ex: 755): "
    read perms
    sudo chmod $perms $path
    echo "Permissions de $path changées à $perms."
}

# Fonction pour la gestion des services
gestion_services() {
    echo "=== Gestion des Services ==="
    echo -n "Nom du service: "
    read service
    echo "1. Vérifier le statut"
    echo "2. Activer/Démarrer le service"
    echo "3. Stopper le service"
    echo "4. Retour au menu principal"
    echo -n "Choisissez une option (1-4): "
    read choix
    case $choix in
        1)
            sudo systemctl status $service
            ;;
        2)
            sudo systemctl start $service
            echo "Service $service démarré."
            ;;
        3)
            sudo systemctl stop $service
            echo "Service $service stoppé."
            ;;
        4)
            return
            ;;
        *)
            echo "Option invalide."
            ;;
    esac
}

# Fonction pour la gestion des processus
gestion_processus() {
    echo "=== Gestion des Processus ==="
    echo "Processus en cours:"
    ps aux
    echo -n "PID du processus à arrêter (ou 0 pour retour): "
    read pid
    if [ "$pid" != "0" ]; then
        sudo kill $pid
        echo "Processus $pid arrêté."
    fi
}

# Boucle principale
while true; do
    afficher_menu
    read choix
    case $choix in
        1)
            gestion_utilisateurs_groupes
            ;;
        2)
            gestion_mots_de_passe
            ;;
        3)
            gestion_permissions
            ;;
        4)
            gestion_services
            ;;
        5)
            gestion_processus
            ;;
        6)
            echo "Au revoir!"
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez réessayer."
            ;;
    esac
done
