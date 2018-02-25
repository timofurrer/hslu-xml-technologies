FROM php:7-fpm
MAINTAINER Roland Christen <roland.christen@hslu.ch>

ARG GID

# add extension for XSLT
RUN apt-get update && \ 
    apt-get install -y libxslt-dev && \
    docker-php-ext-install xsl && \
    docker-php-ext-configure xsl 

# add customized config
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

# install group and add user (volume permission issues)
RUN addgroup -gid $GID www && adduser www-data www 
