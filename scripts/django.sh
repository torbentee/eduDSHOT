#!/bin/bash -v
sudo apt update
sudo apt install -y python python-pip mysql-client libmysqlclient-dev crudini
cd /home/ubuntu
git clone https://github.com/torbentee/eduDSExample.git
cd eduDSExample
crudini --set secrets.ini DB SECRET_KEY $db_password
crudini --set secrets.ini DB DBHOST $db_ipaddress
crudini --set secrets.ini DB DBNAME $db_name
crudini --set secrets.ini DB DBUSER $db_user
crudini --set secrets.ini DB DBPW $db_password

sudo pip install -r requirements.txt
# todo ändern der sercret.txt um datenbank verbindung per script einzustellen
sudo python manage.py makemigrations
sudo python manage.py migrate

sudo su
cat << EOF >> /etc/systemd/system/django.service
[Unit]
Description=Django webapp start script

[Service]
Environment="PATH=/home/ubuntu/eduDSExample:/usr/bin"
ExecStart=/usr/bin/python /home/ubuntu/eduDSExample/manage.py runserver 0.0.0.0:8000
Type=simple
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable django.service
