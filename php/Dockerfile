FROM php:7.2-fpm

RUN apt-get update \
&& apt-get install -y libbz2-dev zlib1g-dev \
&& rm -rf /var/lib/apt/lists/* \
&& docker-php-ext-install bz2 zip pdo_mysql sockets \
&& docker-php-ext-enable opcache \
&& apt-get clean \
# -------- redis -------- #
&& curl http://pecl.php.net/get/redis -o /tmp/redis-latest.tgz \
&& cd /tmp \
&& pecl install redis-latest.tgz \
&& rm -f redis-latest.tgz \
&& docker-php-ext-enable redis \
# -------- xdebug ------- #
&& curl http://pecl.php.net/get/xdebug -o /tmp/xdebug-latest.tgz \
&& cd /tmp \
&& pecl install xdebug-latest.tgz \
&& rm -f xdebug-latest.tgz \
&& docker-php-ext-enable xdebug
