#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Welcome to E-Commerce App</h1>" > /var/www/html/index.html
sudo systemctl restart nginx
