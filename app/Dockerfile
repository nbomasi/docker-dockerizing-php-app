FROM php:7-apache
LABEL Owner="Bomasi"
WORKDIR /

# ENV MYSQL_USER="bomasi-toolingdb"
# ENV MYSQL_PASS="123456789"
# ENV MYSQL_DBNAME="toolingdb"

RUN apt update && apt install git -y && git clone https://github.com/nbomasi/docker-dockerizing-php-app.git 
RUN docker-php-ext-install mysqli
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN cd docker-dockerizing-php-app && cp apache-config.conf /etc/apache2/sites-available/000-default.conf \
    && cp start-apache /usr/local/bin && cp -r html/. /var/www && cp -f .env /var/www

RUN a2enmod rewrite

# Changing ownership of /var/www dirctory
RUN chown -R www-data:www-data /var/www

CMD ["start-apache"]
