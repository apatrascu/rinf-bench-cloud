#!/bin/bash


########################################################################################################################
# Storage Cloud
########################################################################################################################
mkdir -p /dataroot/storagecloud
chmod 777 /dataroot/storagecloud
rm -rf /var/www/html
ln -s /dataroot/storagecloud /var/www/html


########################################################################################################################
# Vagrant Cloud
########################################################################################################################
mkdir -p /dataroot/vagrantcloud
chmod 777 /dataroot/vagrantcloud
ln -s /dataroot/vagrantcloud /data

cp /index.php /var/www/html
/usr/sbin/httpd -D FOREGROUND &
nohup /vagrancy &


########################################################################################################################
# Docker Registry
########################################################################################################################
mv /ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
ln -s /lib/ld-musl-x86_64.so.1 /lib/libc.musl-x86_64.so.1

mkdir -p /dataroot/dockerregistry
chmod 777 /dataroot/dockerregistry
rm -rf /var/lib/registry
ln -s /dataroot/dockerregistry /var/lib/registry

nohup /registry-entrypoint.sh /etc/docker/registry/config.yml &


########################################################################################################################
# Docker Repo
########################################################################################################################
if [ ! -d /dataroot/gitbucket ]; then
    mv /gitbucket_data /dataroot/gitbucket
fi
chmod 777 /dataroot/gitbucket
ln -s /dataroot/gitbucket /root/.gitbucket
nohup /opt/gitbucket.sh &


########################################################################################################################
# Samba share
########################################################################################################################
if [[ $USE_SAMBA = "True" ]]; then
    mkdir -p /dataroot/samba
    chmod 777 -R /dataroot/samba
    nohup /usr/bin/samba.sh &
fi


########################################################################################################################
# Docker Registry Frontend
########################################################################################################################
cd /ui
nohup python3 frontend.py -p 7777 config.json &


########################################################################################################################
# MariaDB
########################################################################################################################
nohup /mariadb.sh &


# This must be the last thing being ran
/fix-permissions.sh /dataroot