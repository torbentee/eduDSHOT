#!/bin/bash -v

sudo apt install -y python python-pip mysql-client libmysqlclient-dev
cd /home/ubuntu
git clone https://github.com/torbentee/eduDSExample.git
cd eduDSExample


sudo pip install -r requirements.txt
# todo ändern der sercret.txt um datenbank verbindung per script einzustellen
sudo python manage.py makemigrations
sudo python manage.py migrate

