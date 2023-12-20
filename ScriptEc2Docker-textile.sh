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
rm -rf j2ltextile
git clone https://Igornovic@bitbucket.org/tenteeglobal/j2ltextile.git

echo "lister le contenu"
ls -l
cd j2ltextile

echo "builder l'image docker"
sudo docker build -t j2lprint .
sudo docker run -d --rm -p 80:8000 j2lprint 