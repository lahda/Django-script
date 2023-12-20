#!/bin/bash
sudo apt update && sudo apt upgrade
sudo apt install apache2 -y
sudo systemctl enable apache2
systemctl status apache2
sudo apt install -y php php-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl}
php -v
sudo apt install mariadb-server mariadb-client
sudo systemctl enable --now mariadb
systemctl status mariadb
sudo mysql_secure_installation
sudo mysql -u root -p
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'your_password';
CREATE DATABASE new_db;
GRANT ALL PRIVILEGES ON new_db.* TO 'new_user'@'localhost';
FLUSH PRIVILEGES;
Exit;
sudo apt install wget unzip
wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv wordpress/ /var/www/html/
sudo rm latest.zip
sudo chown www-data:www-data -R /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress/
sudo nano /etc/apache2/sites-available/wordpress.conf
# <VirtualHost *:80>

# ServerAdmin admin@example.com
# DocumentRoot /var/www/html/wordpress
# ServerName example.com
# ServerAlias www.example.com

# <Directory /var/www/html/wordpress/>

# Options FollowSymLinks
# AllowOverride All
# Require all granted

# </Directory>

# ErrorLog ${APACHE_LOG_DIR}/error.log
# CustomLog ${APACHE_LOG_DIR}/access.log combined

# </VirtualHost>
sudo a2ensite wordpress.conf
sudo a2enmod rewrite
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

quit
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/Tentee237/' /srv/www/wordpress/wp-config.php
sudo -u www-data nano /srv/www/wordpress/wp-config.php
#replace the old with the following lines...
#define('AUTH_KEY',         './Y==d-_5VUy-m#x3 W!pK{cab4,^zc-H|xu4&|]e?y9N1%0KkgH]]a*k[7:?+ry');
#define('SECURE_AUTH_KEY',  'Xx=1n+uM|_,mQoUi_V>g7(#~-nb*sMtQI=exo-U]txb[yTQIhUGfU[ cF[<sLSmo');
#define('LOGGED_IN_KEY',    '6kE*r+di|o#4Qrb)o2p?c&hu(|WY$JlZbIj6]A 5u+;-<UUW{#%wp4HmVxo-,rmC');
#define('NONCE_KEY',        'BF:(hDnH/n4Y:+}^[?fQC|QS;&~cF2@|-4.Dp`-er8e.m?PX|V(Jv>7J_o-+<d9`');
#define('AUTH_SALT',        'Uy00k7_+TFgx(7%6o*m~Xw9eh.ueT&]il-7^_p+Ca+K22ym!;+gorK(Z:QeZk9i?');
#define('SECURE_AUTH_SALT', 'd$ OLQy:oBT .`VArn9),BOQqJ3Exrftp8CKhOwWF1<Q[zbR<-z= ,zbI;&X2,5_');
#define('LOGGED_IN_SALT',   'F)m!vyF t>K}w:P.Kb<m|4_mJwK/;iBWOBmH75cy:Vvbti*n7|eeT-9^vT&PCiR6');
#define('NONCE_SALT',       '/2!`vG$X@<T=FMp|0DNkch,mZO%P_N &EoKpx5iOmCfbhRWTM,*>Ec4bK$j70yr)');
