FROM oeru/php72-fpm
MAINTAINER Dave Lane <dave@oerfoundation.org> (@lightweight)

RUN pecl install xdebug-2.7.1 && docker-php-ext-enable xdebug

 RUN set -ex \
     && { \
#         echo 'catch_workers_output = no'; \
         echo 'opcache.enable = 0'; \
         echo 'xdebug.collect_params = 1'; \
         echo 'xdebug.idekey = xdebug-atom'; \
#         echo 'xdebug.remote_autostart = 1'; \
         echo 'xdebug.remote_enable = 1'; \
         echo 'xdebug.remote_timeout = 600'; \
         echo 'xdebug.remote_port = 9001'; \
     } | tee /usr/local/etc/php/conf.d/xdebug.ini;


EXPOSE 9001

# Copy init scripts and custom .htaccess
CMD ["php-fpm"]
