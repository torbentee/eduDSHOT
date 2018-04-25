#!/bin/bash -v
sudo apt update
sudo apt install -y python python-pip mysql-client libmysqlclient-dev crudini
cd /home/ubuntu
git clone https://github.com/torbentee/eduDSExample.git
cd eduDSExample
crudini --set secret.ini DB SECRET_KEY $db_password
crudini --set secret.ini DB DBHOST $db_ipaddress
crudini --set secret.ini DB DBNAME $db_name
crudini --set secret.ini DB DBUSER $db_user
crudini --set secret.ini DB DBPW $db_password

sudo pip install -r requirements.txt
# todo ändern der sercret.txt um datenbank verbindung per script einzustellen
sudo python manage.py makemigrations
sudo python manage.py migrate

