#!/bin/bash

git clone https://github.com/caroarbiza/simple-ecomme
cp -Ra simple-ecomme/. /var/www/app/ 
rm -rf simple-ecomme 
sed "s/localhost/webappdb.cuwqgdxx6gtj.us-east-1.rds.amazonaws.com/g" config.php > configbkp.php 
sed "s/'DB_USER', 'root'/'DB_USER', 'obl'/g" configbkp.php > config.php 
sed "s/'DB_PASSWORD', 'root'/'DB_PASSWORD', 'obli1234'/g" config.php > configbkp.php 
cat configbkp.php > config.php 
chmod 777 /var/www/app/img/. 
mysql -u obl -pobli1234 -h webappdb.cuwqgdxx6gtj.us-east-1.rds.amazonaws.com -P 3306 idukan < /var/www/app/dump.sql
/usr/bin/supervisord
