#!/bin/bash -v
sudo apt update
sudo apt install -y mariadb-server
sudo touch /var/log/mariadb/mariadb.log
sudo chown mysql:mysql /var/log/mariadb/mariadb.log
sudo sed -i 's/.*bind-address/#&/' /etc/mysql/mariadb.conf.d/50-server.cnf 
sudo systemctl start mariadb.service

# Setup MySQL root password and create a user
sudo mysqladmin -u root password $db_rootpassword
cat << EOF | sudo mysql -u root --password=$db_rootpassword
CREATE DATABASE $db_name;
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%'
IDENTIFIED BY '$db_password';
FLUSH PRIVILEGES;
EXIT
EOF
sudo service mysql restart
