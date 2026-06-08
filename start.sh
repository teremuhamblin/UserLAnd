mkdir userland-project && cd userland-project

# README minimal
cat > README.md << 'EOF'
# UserLAnd Project
Projet minimal compatible Ubuntu/Debian/Kali sous UserLAnd.
Prêt pour GitHub et pour exécuter des scripts Linux.
EOF

# Script principal
cat > start.sh << 'EOF'
#!/bin/bash
echo "Projet UserLAnd opérationnel."
EOF
chmod +x start.sh

# Gitignore minimal
cat > .gitignore << 'EOF'
*.log
*.tmp
*.bak
__pycache__/
*.pyc
EOF

# Initialisation Git
git init
git add .
git commit -m "Initialisation du projet UserLAnd ultra-rapide"
