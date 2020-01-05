#!/usr/bin/env bash 
service mysql start
service php7.3-fpm start

#log into my sql as root en inputant le fichier config
mysql -u root -p < /etc/config.sql

#pour que nginx ne quitte pqs et que le conteneur reste ouvert
service nginx start
#nginx -g 'daemon off;'
sleep infinity & wait

