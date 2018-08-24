FROM php:7.2-fpm

RUN \
docker-php-ext-install pdo_mysql sockets \
&& docker-php-ext-enable opcache \
# -------- redis -------- #
&& curl 'http://pecl.php.net/get/redis' -o /tmp/redis-latest.tgz \
&& cd /tmp \
&& pecl install redis-latest.tgz \
&& rm -rf redis-latest.tgz \
&& docker-php-ext-enable redis \
# -------- xdebug ------- #
&& curl 'http://pecl.php.net/get/xdebug' -o /tmp/xdebug-latest.tgz \
&& cd /tmp \
&& pecl install xdebug-latest.tgz \
&& rm -rf xdebug-latest.tgz \
&& docker-php-ext-enable xdebug

