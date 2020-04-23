FROM ubuntu:16.04

MAINTAINER Amarin Boonkirt <amarin.ta@gmail.com>
# docker build -t amarinboonkirt/php7x-apache-xenial:latest -f Dockerfile ./

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Chicago
ARG LOCALE=en_US.UTF-8

WORKDIR "/var/www"

ARG WEB_UID=1000
ARG WEB_GID=1000

ENV TERM xterm
ENV TZ=${TZ}

RUN usermod -u ${WEB_UID} www-data
RUN groupmod -g ${WEB_GID} www-data

RUN apt-get update

RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y nano
RUN apt-get install -y curl

RUN apt-get install -y software-properties-common
RUN apt-get install -y language-pack-en-base
RUN apt-get install -y language-pack-th

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get install -y apache2
RUN a2enmod rewrite

# Install multiple php version
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt install -y php7.1
RUN apt install -y php7.2
RUN apt install -y php7.3
RUN apt install -y php7.4

RUN apt install -y php7.1-mysql php7.1-mbstring php7.1-xml php7.1-gd php7.1-curl
RUN apt install -y php7.2-mysql php7.2-mbstring php7.2-xml php7.2-gd php7.2-curl
RUN apt install -y php7.3-mysql php7.3-mbstring php7.3-xml php7.3-gd php7.3-curl
RUN apt install -y php7.4-mysql php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl

#patched
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#Install composer
RUN cd /tmp/;curl -sS https://getcomposer.org/installer -o composer-setup.php;php composer-setup.php --install-dir=/usr/bin --filename=composer

#Clean apt
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN chown -R ${WEB_GID}:${WEB_UID} /var/www

CMD ["/usr/local/bin/apache2-foreground"]
