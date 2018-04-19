#!/bin/bash


##################################
# Storage Cloud
##################################
mkdir -p /dataroot/storagecloud
chmod 777 /dataroot/storagecloud
rm -rf /var/www/html
ln -s /dataroot/storagecloud /var/www/html

#################################
# Vagrant Cloud
#################################
mkdir -p /dataroot/vagrantcloud
chmod 777 /dataroot/vagrantcloud
ln -s /dataroot/vagrantcloud /data

cp /index.php /var/www/html
/usr/sbin/httpd -D FOREGROUND &