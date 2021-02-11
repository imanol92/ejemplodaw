#!/bin/bash

nombre=$(cat package.json | grep "name" | cut -d'"' -f4)

rm -rf c:/xampp/htdocs/CLASE/$nombre
mkdir c:/xampp/htdocs/CLASE/$nombre

cp -r dist/web/* c:/xampp/htdocs/CLASE/$nombre


rm -rf c:/xampp/php-server/$nombre
mkdir c:/xampp/php-server/$nombre

cp -r dist/php/* c:/xampp/php-server/$nombre

