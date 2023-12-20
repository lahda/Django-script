#!/bin/bash
echo "installer le serveur apache"
sudo yum install -y httpd
echo "démarrer le serveur"
sudo service httpd start
echo "téléchargement de WordPress"
wget https://wordpress.org/latest.tar.gz
echo "afficher le répertoire"
ls
echo "dézippage de Wordpress"
tar -xzf latest.tar.gz
ls
latest.tar.gz  wordpress
echo "se positionner dans le repertoire wordpress"
cd wordpress
echo "création du fichier config worpress"
cp wp-config-sample.php wp-config.php
echo "ouverture du fichier wp-config"
nano wp-config.php
echo "installation des dépendances applicatives"
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
echo "acès au repertoire approprié"
cd /home/ec2-user
echo "copie des fichiers de l'application wordpress vers /var/wwww/html/"
sudo cp -r wordpress/* /var/www/html/
echo "redémarrage du serveur apache"
sudo service httpd restart