FROM romeoz/docker-nginx-php:5.5

WORKDIR /var/www/app/

RUN apt-get update -y && apt-get install -y \ 
      php-mysql\
      mysql-client \
      git 

COPY ./script.sh /var/www/app

RUN chmod 777 script.sh

EXPOSE 80
