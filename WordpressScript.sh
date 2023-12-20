#!/bin/bash
echo "Mise à jour système"
apt update -y
echo "Installation d'Apache2"
sudo apt install apache2 -y
echo "Vérification de la liste des profils qui ont besoin d'accès"
sudo ufw app list
echo "Usage d'Apache Full access"
sudo ufw allow 'Apache Full'
echo "Vérification de status de traffic sur le port 80 et 443"
sudo ufw app info "Apache Full"
echo "Vérification de status de service Apache2"
sudo systemctl status apache2
echo "Installation du serveur MySQL"
echo "Installation de PHP"
sudo apt install php php-mysql php-gd php-cli php-common -y
echo "installation de mysql server & sécurisation"
sudo apt install mysql-server -y
echo "Sécurisation du serveur MySQL dans Apache"
sudo mysql_secure_installation
y
echo "création d'une base de donnée MySQL et un utilisateur"
sudo mysql -u root 
echo "Création d'une base de donnée Utilisateur"
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Tentee237';
CREATE USER 'Wordpress'@'localhost' IDENTIFIED BY 'Tentee237';
echo "Donner la permission à un utilisateur"
mysql> GRANT ALL PRIVILEGES ON *.* TO 'Wordpress'@'localhost';
echo "Recharger tous les privilèges"
mysql> FLUSH PRIVILEGES;
echo "Créer une base de données MySQL"
create database wordpressdb;
echo "voir la base de données"
show databases
echo "Vérification de status de service MySQL"
systemctl status mysql.service
echo "Configuratin de dir.conf"
sudo vi /etc/apache2/mods-enabled/dir.conf
echo "Redémarrage du serveur Apache"
sudo service apache2 restart
echo "Installation de PhpMyAdmin"
sudo apt install phpmyadmin
echo "Installation de Wordpress"
sudo apt install wget unzip -y
echo "téléchargement de WordPress"
sudo wget https://wordpress.org/latest.tar.gz
echo "dézippage de Wordpress"
sudo tar -xzf latest.tar.gz
echo "copie des fichiers de l'application wordpress vers /var/wwww/html/"
sudo cp -r wordpress/* /var/www/html/
echo "Vérification des droits d'écriture dans www-data"
sudo chown www-data:www-data -R /var/www/html/
echo "Suppression de index.html dans /var/www/html"
sudo rm -rf index.html