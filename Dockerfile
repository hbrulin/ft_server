FROM debian:10

#update repo and software package
RUN apt-get update \
&& apt-get upgrade 

#install nginx, curl, wget on debian 10
RUN apt-get install -y nginx wget curl apt-utils

#Php-FPM is dedicated fastcgi process manager for php that can interface or connect with any compatible webserver and manage php processes to process php requests. FastCGI est une technique permettant la communication entre un serveur HTTP et un logiciel indépendant
RUN apt-get install -y php7.3-fpm php7.3-common php7.3-mysql php7.3-xml php7.3-xmlrpc php7.3-curl php7.3-gd php7.3-imagick php7.3-cli php7.3-dev php7.3-imap php7.3-mbstring php7.3-soap php7.3-zip php7.3-bcmath
#install mysql
RUN apt-get install -y default-mysql-server

#copy wordpress files, dans lequel j'ai deja modif le fichier wp-config avec infos sur base de donnees
COPY srcs/wordpress var/www/html/wordpress
#on change le proprietaire pour www-data et on recupere les droits pour lui
RUN chown -R www-data /var/www/html/wordpress && chmod -R 755 /var/www/html/wordpress

#phpmyadmin
COPY srcs/phpmyadmin /var/www/html/phpmyadmin
RUN chown -R www-data /var/www/html/phpmyadmin && chmod -R 755 /var/www/html/phpmyadmin

#ssl

#donner les droits d’accès et de modification à l’utilisateur www-data (utilisateur par défaut dans Nginx)
RUN chown www-data -R /var/www/website/
RUN chown -R www-data /var/log/nginx/website/

# configure nginx vhost
COPY srcs/default /etc/nginx/sites-available/default
#faut-il symlink to sites enabled?
RUN ln -s /etc/nginx/sites-available/default/ etc/nginx/sites-enabled/default 

#ecoute port 80
EXPOSE 80
#EXPOSE 443

COPY srcs/entrypoint.sh /etc/entrypoint.sh
COPY srcs/config.sql /etc/config.sql

#necessaire?
RUN chmod +x /etc/entrypoint.sh

#entrypoint comme cmd, sauf que CMD est remplace si on passe a docker run un argument
ENTRYPOINT ["/etc/entrypoint.sh"]