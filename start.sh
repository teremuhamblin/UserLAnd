---

# ⚙️ **start.sh — v2.0‑MIL (COMPLET)**  
**Version avancée, robuste, militaire.**

```bash
#!/bin/bash

LOG="/tmp/userland.log"

log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG"
}

detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$NAME
    else
        DISTRO="Inconnue"
    fi
}

module_recon() {
    clear
    echo "=== MODULE RECONNAISSANCE ==="
    log "Reconnaissance système lancée"

    echo "[*] Adresse IP :"
    ip a | grep inet

    echo "[*] Ports ouverts (top 10) :"
    ss -tulnp | head

    echo "[*] DNS :"
    cat /etc/resolv.conf

    log "Recon terminée"
    read -p "Appuyer sur Entrée pour revenir"
}

module_system() {
    clear
    echo "=== MODULE SYSTEME ==="
    log "Diagnostic système lancé"

    echo "[*] Espace disque :"
    df -h

    echo "[*] Mémoire :"
    free -h

    echo "[*] Processus principaux :"
    ps aux --sort=-%cpu | head

    log "Diagnostic terminé"
    read -p "Appuyer sur Entrée pour revenir"
}

module_network() {
    clear
    echo "=== MODULE RESEAU ==="
    log "Analyse réseau lancée"

    echo "[*] Test ping Google :"
    ping -c 1 8.8.8.8 >/dev/null && echo "[OK] Réseau opérationnel" || echo "[ALERTE] Pas de réseau"

    echo "[*] Route :"
    ip route

    log "Analyse réseau terminée"
    read -p "Appuyer sur Entrée pour revenir"
}

# ================================
#   INTERFACE PRINCIPALE
# ================================

detect_os
clear

echo "========================================"
echo "   🪖 USERLAND — VERSION 2.0 MILITAIRE"
echo "========================================"
echo "   Opérateur : $(whoami)"
echo "   Distribution : $DISTRO"
echo "   Journal : $LOG"
echo "----------------------------------------"

while true; do
    echo ""
    echo "1) Reconnaissance"
    echo "2) Diagnostic système"
    echo "3) Analyse réseau"
    echo "4) Mise à jour du système"
    echo "5) Quitter"
    echo ""

    read -p "Sélection (1-5) : " choix

    case $choix in
        1) module_recon ;;
        2) module_system ;;
        3) module_network ;;
        4)
            log "Mise à jour du système"
            sudo apt update && sudo apt upgrade -y
            log "Mise à jour terminée"
            ;;
        5)
            log "Fermeture du module militaire"
            echo "Garde à vous. Fin d'opération."
            exit 0
            ;;
        *)
            echo "[ERREUR] Sélection invalide."
            ;;
    esac
done
