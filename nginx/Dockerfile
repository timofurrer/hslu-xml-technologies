FROM nginx:1.12-alpine
MAINTAINER Roli Christen <roland.christen@hslu.ch>

ARG GID

# add config files
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

# install group and add user (volume permission issues)
RUN addgroup -g $GID www && adduser nginx www 
