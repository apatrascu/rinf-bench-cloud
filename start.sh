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
nohup /vagrancy &


##################################
# Docker Registry
##################################
mv /ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
ln -s /lib/ld-musl-x86_64.so.1 /lib/libc.musl-x86_64.so.1

mkdir -p /dataroot/dockerregistry
chmod 777 /dataroot/dockerregistry
rm -rf /var/lib/registry
ln -s /dataroot/dockerregistry /var/lib/registry

nohup /entrypoint.sh /etc/docker/registry/config.yml &