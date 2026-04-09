#!/bin/bash
sudo apt-get update
sudo apt-get install nodejs npm -y
cd /home/admin
sudo mkdir myapp
cd myapp
git clone https://github.com/ainur090405/Project.WAKA.git
cd Project.WAKA
sudo npm init -y
sudo npm install express
sudo npm install pm2 -g
pm2 startup
sudo pm2 start server.js -u admin --watch