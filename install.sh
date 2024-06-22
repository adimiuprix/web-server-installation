#!/bin/bash
clear

HOSTNAME=$(hostname)
IP_ADDRESS=$(dig +short $HOSTNAME | head -n 1)

yes Y | sudo apt update && yes Y | sudo apt upgrade
yes Y | sudo apt install composer -y 
yes Y | sudo apt-get install ca-certificates apt-transport-https software-properties-common
echo | sudo add-apt-repository ppa:ondrej/php
yes Y | apt-get install php8.3
php8.3 --version
sleep 5s
yes Y | apt install libapache2-mod-php8.3
systemctl restart apache2
yes Y | apt install php8.3-mysql php8.3-imap php8.3-ldap php8.3-bcmath php8.3-xml php8.3-curl php8.3-mbstring php8.3-zip php8.3-sqlite3
yes Y | sudo apt install mysql-server

# Secure MySQL installation (optional, interactive)
# sudo mysql_secure_installation

# Set MySQL root password (replace 'your_password' with your desired root password)
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password'; FLUSH PRIVILEGES;"

# Create a new MySQL user and password (replace 'newuser' and 'newpassword' with your desired values)
MYSQL_USER='newuser'
MYSQL_PASSWORD='newpassword'
MYSQL_DATABASE='newdatabase'

sudo mysql -e "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'localhost' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create a new database (replace 'newdatabase' with your desired database name)
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

echo "MySQL installation and configuration completed."
echo "Root user password: your_password"
echo "New user created: $MYSQL_USER with password: $MYSQL_PASSWORD"
echo "New database created: $MYSQL_DATABASE"
