CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
CREATE DATABASE db_wordpress;
GRANT ALL PRIVILEGES ON db_wordpress.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
