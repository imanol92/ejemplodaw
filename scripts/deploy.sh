#!/bin/bash

# Copiar el código de src a dist
sudo rm -rf dist
sudo mkdir dist
sudo mkdir dist
sudo mkdir dist
sudo cp -r src/* dist

# Compilar en dist el código SASS
sudo sass ./dist/scss/main.scss ./dist/css/main.css

# Borrar los contenedores de Docker que vaya a crear (por si ya existen), que son "apache_tuNombre" y "mariadb_tuNombre"
sudo docker container stop apache_imanol
sudo docker container rm apache_imanol
sudo docker container stop mariadb_imanol
sudo docker container rm mariadb_imanol

# Copiar el contenido de la carpeta dist a /opt/tuNombre/docker/apache
sudo rm -r /opt/imanol_delgado/docker/apache/*
sudo cp -a ./dist/* /opt/imanol_delgado/docker/apache

# Crear el contenedor de Docker del servidor Web "apache_tuNombre"
sudo sh /opt/imanol_delgado/scripts/apache-contenedor.sh
sudo sh /opt/imanol_delgado/scripts/mariadb-contenedor.sh

# Crear el contenedor de Docker de la base de datos "mariadb_tuNombre"
sudo docker container exec -it apache_imanol docker-php-ext-install pdo pdo_mysql
sudo docker container exec -it apache_imanol a2enmod rewrite
sudo docker container restart apache_imanol
