#!/bin/bash
sudo apt-get update
sudo apt install default-mysql-client -y
sudo apt-get install nodejs npm -y
cd /home/admin
sudo mkdir myapp
cd myapp
git clone https://github.com/FirmanShurdi/ETS-AWS.git
cd ETS-AWS

echo "DB_USER=${rds_username}" >> .env
echo "DB_PASS=${rds_password}" >> .env
echo "DB_NAME=${rds_db_name}" >> .env
echo "DB_HOST=${rds_address}" >> .env

sudo npm init -y
sudo npm install express
sudo npm install pm2 -g

sudo pm2 start server.js -u admin --watch
sudo pm2 save
pm2 startup