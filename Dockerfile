FROM debian:10

#update repo and software package
RUN apt-get update \
&& apt-get upgrade 

#install nginx, curl, wget on debian 10
RUN apt-get install -y nginx wget curl
RUN apt-get install dialog apt-utils -y

#Php-FPM is dedicated fastcgi process manager for php that can interface or connect with any compatible webserver and manage php processes to process php requests. FastCGI est une technique permettant la communication entre un serveur HTTP et un logiciel indépendant
RUN apt-get install -y php7.3-fpm php7.3-common php7.3-mysql php7.3-xml php7.3-xmlrpc php7.3-curl php7.3-gd php7.3-imagick php7.3-cli php7.3-dev php7.3-imap php7.3-mbstring php7.3-soap php7.3-zip php7.3-bcmath
#install mysql
RUN apt-get install -y default-mysql-server

#copy wordpress files, dans lequel j'ai deja modif le fichier wp-config avec infos sur base de donnees
COPY srcs/wordpress var/www/html/wordpress
#on change le proprietaire pour www-data (utilisateur par defaut dans nginx) et on recupere les droits pour lui
RUN chown -R www-data /var/www/html/wordpress && chmod -R 755 /var/www/html/wordpress

#phpmyadmin
COPY srcs/phpmyadmin /var/www/html/phpmyadmin
RUN chown -R www-data /var/www/html/phpmyadmin && chmod -R 755 /var/www/html/phpmyadmin

#ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=FR/ST=75/L=Paris/O=42/CN=ncolomer' \
	-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

# configure nginx vhost
COPY srcs/default /etc/nginx/sites-available/default
COPY srcs/index.html /var/www/html

#ecoute ports
EXPOSE 80
EXPOSE 443
EXPOSE 3306

COPY srcs/entry.sh /etc/entry.sh
COPY srcs/config.sql /etc/config.sql

#necessaire?
RUN chmod +x /etc/entry.sh

#entrypoint comme cmd, sauf que CMD est remplace si on passe a docker run un argument
ENTRYPOINT ["/etc/entry.sh"]
