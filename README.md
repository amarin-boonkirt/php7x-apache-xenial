# php7x-apache-xenial
Multiple php version php7.1 php7.2 php7.3 php7.4


# switch php version
~~~
a2dismod php7*
a2enmod php7.3
update-alternatives --set php /usr/bin/php7.3
service apache2 restart
~~~
