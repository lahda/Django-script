#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod headers
cd /etc/apache2/sites-available/
sudo vim jenkins.conf
#<Virtualhost *:80>
    #ServerName        your-domain-name.com
   # ProxyRequests     Off
   # ProxyPreserveHost On
    #AllowEncodedSlashes NoDecode
 
    #<Proxy http://localhost:8080/*>
      #Order deny,allow
     # Allow from all
    #</Proxy>
 
   # ProxyPass         /  http://localhost:8080/ nocanon
   # ProxyPassReverse  /  http://localhost:8080/
    #ProxyPassReverse  /  http://your-domain-name.com/
#</Virtualhost>
sudo a2ensite jenkins
sudo systemctl restart apache2
sudo systemctl restart jenkins
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
ufw enable