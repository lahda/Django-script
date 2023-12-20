
#!/bin/bash
echo "Mise à jour des packets"
sudo apt update
echo "Téléchargement de nginix, Pip,VirtualEnv et curl"
sudo apt install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx curl
sudo -u postgres psql
CREATE DATABASE Wealthtechdb;
CREATE USER firstuser WITH PASSWORD 'tentee237';
ALTER ROLE firstuser SET client_encoding TO 'utf8';
ALTER ROLE firstuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE firstuser SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE Wealthtechdb TO firstuser;
\q
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv
mkdir Wealthtech
cd Wealthtech
virtualenv Wealthtechenv
source Wealthtechenv/bin/activate
pip install django gunicorn psycopg2-binary
django-admin startproject WealthtechProject ~/Wealthtech
nano ~/Wealthtech/WealthtechProject/settings.py
~/Wealthtech/manage.py makemigrations
~/Wealthtech/manage.py migrate
~/Wealthtech/manage.py createsuperuser
~/Wealthtech/manage.py collectstatic
sudo ufw allow 8000
~//Wealthtech/manage.py runserver 0.0.0.0:8000
cd ~/Wealthtech
gunicorn --bind 0.0.0.0:8000 WealthtechProject.wsgi
deactivate
sudo nano /etc/systemd/system/gunicorn.socket
sudo nano /etc/systemd/system/gunicorn.service
sudo systemctl start gunicorn.socket
sudo systemctl enable gunicorn.socket
sudo systemctl status gunicorn.socket
file /run/gunicorn.sock
sudo journalctl -u gunicorn.socket
sudo systemctl status gunicorn
curl --unix-socket /run/gunicorn.sock localhost
sudo systemctl status gunicorn
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
sudo nano /etc/nginx/sites-available/WealthtechProject
sudo ln -s /etc/nginx/sites-available/WealthtechProject /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx
sudo ufw delete allow 8000
sudo ufw allow 'Nginx Full'
