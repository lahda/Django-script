#!/bin/bash
echo "mise à jour système"
sudo apt-get update

echo "installing docker & docker-compose"
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "affichage version docker"
sudo docker --version
sudo docker compose version

echo "exécuter docker comme un utilisateur ubuntu normal"
sudo usermod -a -G docker ubuntu

echo "configuration de docker"
sudo chown docker:ubuntu -R .

echo "téléchargement du code sur git"
git clone https://github.com/Igornovic21/j2l-print.git

echo "lister le contenu"
ls -l
cd j2l-print

echo "builder l'image docker"
sudo docker compose up -d --build

echo "migrations & fichiers statiques"
sudo docker compose exec web python manage.py makemigrations
sudo docker compose exec web python manage.py migrate
sudo docker compose exec web python manage.py collectstatic

