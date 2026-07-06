#!/bin/bash

##############################################
#        USERLAND — CENTRE OPÉRATIONNEL      #
#        VERSION 3.0-MIL ULTIMATE            #
##############################################

LOG="/tmp/userland.log"

# ====== COULEURS MILITAIRES ======
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

# ====== LOGGING AMÉLIORÉ ======
log() {
    echo -e "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG"
}

# ====== CHECK COMMAND ======
need() {
    command -v "$1" >/dev/null 2>&1 || {
        echo -e "${RED}[ERREUR] Commande manquante : $1${RESET}"
        echo "Installe-la via : sudo apt install $1"
        exit 1
    }
}

# ====== DÉTECTION OS ======
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$NAME
    else
        DISTRO="Inconnue"
    fi
}

# ====== MODULE RECON ======
module_recon() {
    clear
    echo -e "${CYAN}=== MODULE RECONNAISSANCE ===${RESET}"
    log "Reconnaissance système lancée"

    need ip
    need ss

    echo -e "${YELLOW}[*] Adresse IP :${RESET}"
    ip -4 a | grep inet

    echo -e "${YELLOW}[*] Ports ouverts (top 10) :${RESET}"
    ss -tulnp | head

    echo -e "${YELLOW}[*] DNS :${RESET}"
    grep nameserver /etc/resolv.conf

    log "Recon terminée"
    read -p "Appuyer sur Entrée pour revenir..."
}

# ====== MODULE SYSTEM ======
module_system() {
    clear
    echo -e "${CYAN}=== MODULE SYSTEME ===${RESET}"
    log "Diagnostic système lancé"

    echo -e "${YELLOW}[*] Espace disque :${RESET}"
    df -h | grep -E "Filesystem|/"

    echo -e "${YELLOW}[*] Mémoire :${RESET}"
    free -h

    echo -e "${YELLOW}[*] Processus principaux :${RESET}"
    ps aux --sort=-%cpu | head

    log "Diagnostic terminé"
    read -p "Appuyer sur Entrée pour revenir..."
}

# ====== MODULE NETWORK ======
module_network() {
    clear
    echo -e "${CYAN}=== MODULE RESEAU ===${RESET}"
    log "Analyse réseau lancée"

    echo -e "${YELLOW}[*] Test ping Google :${RESET}"
    if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        echo -e "${GREEN}[OK] Réseau opérationnel${RESET}"
    else
        echo -e "${RED}[ALERTE] Pas de réseau${RESET}"
    fi

    echo -e "${YELLOW}[*] Route :${RESET}"
    ip route

    log "Analyse réseau terminée"
    read -p "Appuyer sur Entrée pour revenir..."
}

# ====== MISE À JOUR ======
module_update() {
    clear
    echo -e "${CYAN}=== MISE À JOUR DU SYSTÈME ===${RESET}"
    log "Mise à jour du système"

    sudo apt update && sudo apt upgrade -y
    log "Mise à jour terminée"

    read -p "Appuyer sur Entrée pour revenir..."
}

# ====== INTERFACE PRINCIPALE ======
detect_os
clear

echo -e "${GREEN}========================================${RESET}"
echo -e "${GREEN}   🪖 USERLAND — VERSION 3.0 MILITAIRE   ${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "   Opérateur : ${CYAN}$(whoami)${RESET}"
echo -e "   Distribution : ${CYAN}$DISTRO${RESET}"
echo -e "   Journal : ${CYAN}$LOG${RESET}"
echo -e "${GREEN}----------------------------------------${RESET}"

while true; do
    echo ""
    echo -e "${YELLOW}1) Reconnaissance${RESET}"
    echo -e "${YELLOW}2) Diagnostic système${RESET}"
    echo -e "${YELLOW}3) Analyse réseau${RESET}"
    echo -e "${YELLOW}4) Mise à jour du système${RESET}"
    echo -e "${RED}5) Quitter${RESET}"
    echo ""

    read -p "Sélection (1-5) : " choix

    case $choix in
        1) module_recon ;;
        2) module_system ;;
        3) module_network ;;
        4) module_update ;;
        5)
            log "Fermeture du module militaire"
            echo -e "${RED}Garde à vous. Fin d'opération.${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}[ERREUR] Sélection invalide.${RESET}"
            ;;
    esac
done
