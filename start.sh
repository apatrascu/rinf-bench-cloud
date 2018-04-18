#!/bin/bash

cp /index.php /var/www/html
/usr/sbin/httpd -D FOREGROUND &