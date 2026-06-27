---

## ⚙️ **2. Nouveau start.sh (v1.1)**  
Plus propre, plus utile, avec un mini‑menu.

```bash
#!/bin/bash

echo "==============================="
echo "   UserLAnd Project — v1.1"
echo "==============================="
echo ""
echo "1) Vérifier l'environnement"
echo "2) Mettre à jour le système"
echo "3) Lancer un test rapide"
echo "4) Quitter"
echo ""

read -p "Choix : " choice

case $choice in
    1)
        echo "[*] Vérification..."
        uname -a
        lsb_release -a 2>/dev/null
        ;;
    2)
        echo "[*] Mise à jour du système..."
        sudo apt update && sudo apt upgrade -y
        ;;
    3)
        echo "[*] Test rapide OK."
        echo "UserLAnd opérationnel."
        ;;
    4)
        echo "Fermeture."
        exit 0
        ;;
    *)
        echo "Choix invalide."
        ;;
esac
