#!/bin/bash

echo "🚀 Starte die Einrichtung der KI-Trading-Web-App!"

# 1️⃣ System aktualisieren
echo "🔹 System-Updates..."
apt update && apt upgrade -y

# 2️⃣ Fehlende Pakete installieren
echo "🔹 Installiere Nginx, PHP, MySQL, Python & KI-Abhängigkeiten..."
apt install -y nginx php8.3-fpm php8.3-mysql mariadb-server python3 python3-pip python3-venv git

# 3️⃣ MySQL-Datenbank einrichten
echo "🔹 MySQL-Datenbank erstellen..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ki_webapp;"
mysql -u root -e "CREATE USER IF NOT EXISTS 'ki_user'@'localhost' IDENTIFIED BY 'ki_pass';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ki_webapp.* TO 'ki_user'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# 4️⃣ Web-App-Verzeichnis erstellen
echo "🔹 Erstelle Verzeichnisse für die Web-App..."
mkdir -p /var/www/html/ki_webapp/{public,includes,api,models,scripts,config}

# 5️⃣ Basis-Webseite & PHP-Skripte erstellen
echo "<?php echo '<h1>🚀 Willkommen in der KI-Trading-Web-App!</h1>'; ?>" > /var/www/html/ki_webapp/public/index.php
echo "<?php echo '<header>📊 KI Trading</header>'; ?>" > /var/www/html/ki_webapp/includes/header.php
echo "<?php echo '<footer>© 2025 KI Web-App</footer>'; ?>" > /var/www/html/ki_webapp/includes/footer.php
echo "<?php \$conn = new mysqli('localhost', 'ki_user', 'ki_pass', 'ki_webapp'); ?>" > /var/www/html/ki_webapp/includes/db.php
echo "<?php echo json_encode(['prediction' => rand(0,1)]); ?>" > /var/www/html/ki_webapp/api/predict.php

# 6️⃣ Python KI-Modell vorbereiten
echo "import numpy as np" > /var/www/html/ki_webapp/models/train_model.py

# 7️⃣ Konfigurationsdateien
echo "DATABASE_NAME=ki_webapp" > /var/www/html/ki_webapp/config/config.php
echo "{}" > /var/www/html/ki_webapp/config/settings.json

# 8️⃣ Python Requirements
echo "tensorflow\nnumpy\npandas\nFlask\nrequests" > /var/www/html/ki_webapp/requirements.txt

# 9️⃣ .gitignore
echo "/venv\n__pycache__/\n*.log\nki_model.h5\n.env\ndatabase.sqlite" > /var/www/html/ki_webapp/.gitignore

# 🔟 README Datei
echo "# KI Trading Web-App\nDies ist eine KI-gestützte Trading Web-App." > /var/www/html/ki_webapp/README.md

# 🔥 Berechtigungen setzen
echo "🔹 Setze Berechtigungen..."
chown -R www-data:www-data /var/www/html/ki_webapp/
chmod -R 755 /var/www/html/ki_webapp/
# 🔥 Git einrichten & pushen
cd /var/www/html/ki_webapp
git init
git remote add origin https://$GITHUB_PAT@github.com/Mahmut5566/Trading-app.git
git add .
git commit -m "Automatische Web-App Erstellung"
git branch -M main
git push -u origin main

# 🔥 Dienste neustarten
echo "🔹 Neustart der Web-Dienste..."
systemctl restart nginx php8.3-fpm mariadb

echo "✅ **ALLES ERLEDIGT!** Deine KI-Web-App ist jetzt bereit & auf GitHub hochgeladen!"
echo "➡️ http://188.245.254.226/"
