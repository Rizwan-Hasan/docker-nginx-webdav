FROM debian:bookworm

LABEL maintainer="maltokyo"

RUN apt update
RUN apt upgrade -y
RUN apt install -y \
    nginx-full \
    nginx-extras \
    apache2-utils \
    libnginx-mod-http-fancyindex
RUN apt clean

COPY webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*

RUN mkdir -p "/media/data"

RUN chown -R www-data:www-data "/media/data"

VOLUME /media/data

COPY entrypoint.sh /

RUN chmod +x entrypoint.sh
CMD /entrypoint.sh && nginx -g "daemon off;"