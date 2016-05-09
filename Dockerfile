FROM php:7.0.5-fpm

RUN apt-get update
RUN apt-get install -y \
	build-essential \
	pkg-config \
	git-core \
	autoconf \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng12-dev \
	libcurl4-openssl-dev \
	libpq-dev \
	libmemcached-dev \
	libmemcached11 \
	libsqlite3-dev \
	vim \
	netcat

RUN docker-php-ext-install iconv
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install opcache
RUN docker-php-ext-install curl
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_sqlite

WORKDIR /tmp

# install memcached
RUN git clone https://github.com/php-memcached-dev/php-memcached
WORKDIR /tmp/php-memcached
RUN git checkout -b php7 origin/php7
RUN phpize
RUN ./configure
RUN make
RUN make install
RUN rm -rf /tmp/php-memcached

RUN echo 'extension=memcached.so' > /usr/local/etc/php/conf.d/docker-php-ext-memcached.ini


# clean up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf

# for osx
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

WORKDIR /var/www/

COPY entrypoint /opt/entrypoint
RUN chmod 755 /opt/entrypoint

ENTRYPOINT ["/opt/entrypoint"]

CMD ["php-fpm"]
