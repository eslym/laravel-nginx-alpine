FROM alpine:3.9

COPY launch.sh /usr/local/bin/launch.sh
COPY extras /extras

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf &&\
    chmod +x /usr/local/bin/launch.sh &&\
    apk update &&\
    apk add --no-cache \
	nginx \
	php7 \
	php7-fpm \
	php7-json \
	php7-phar \
	php7-ftp \
	php7-xdebug \
	php7-mcrypt \
	php7-mbstring \
	php7-soap \
	php7-gmp \
	php7-pdo_odbc \
	php7-dom \
	php7-pdo \
	php7-zip \
	php7-mysqli \
	php7-sqlite3 \
	php7-pdo_pgsql \
	php7-bcmath \
	php7-gd \
	php7-odbc \
	php7-pdo_mysql \
	php7-pdo_sqlite \
	php7-gettext \
	php7-xmlreader \
	php7-xmlwriter \
	php7-tokenizer \
	php7-xmlrpc \
	php7-bz2 \
	php7-pdo_dblib \
	php7-curl \
	php7-ctype \
	php7-session \
	php7-redis \
	php7-exif \
	php7-gd \
	php7-simplexml \
	php7-pecl-mcrypt \
	php7-fileinfo \
	php7-iconv \
	tzdata &&\
    rm -f /var/cache/apk/* &&\
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer &&\
    rm composer-setup.php &&\
    rm -rf /var/www &&\
    mkdir -p /var/www/html &&\
    mkdir -p /run/nginx &&\
    chown -R nginx:nginx /var/www &&\
    chmod +x /extras/* &&\
    sed -i 's/access_log.*;/access_log \/dev\/stdout;/' /etc/nginx/nginx.conf &&\
    echo "daemon off;" >> /etc/nginx/nginx.conf

COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["/usr/local/bin/launch.sh"]
