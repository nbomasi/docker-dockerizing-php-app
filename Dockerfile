FROM php:7-apache
LABEL Owner="Bomasi"

WORKDIR /

#ENV MYSQL_IP="172.18.0.2"
#ENV MYSQL_USER="boma"
#ENV MYSQL_PASS="Password1"
#ENV MYSQL_DBNAME="toolingdb"
#RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*
#RUN apt-get update && apt-get install -y netcat
RUN docker-php-ext-install mysqli
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
COPY start-apache /usr/local/bin
RUN a2enmod rewrite

# Copy application source
COPY html /var/www
COPY .env /var/www
RUN chown -R www-data:www-data /var/www

CMD ["start-apache"]
