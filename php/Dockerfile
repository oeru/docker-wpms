FROM php:7.2-fpm
MAINTAINER Dave Lane <dave@oerfoundation.org> (@lightweight)

ENV PHPREDIS_VERSION 4.3.0

# Install PHP extensions
RUN apt-get update && apt-get install -y apt-utils git less libbz2-dev libc-client-dev \
    libcurl4-gnutls-dev libicu-dev libkrb5-dev libmcrypt-dev libpng-dev \
    libpspell-dev libssl-dev libxml2-dev mariadb-client sudo telnet unzip zip
RUN apt-get install -y net-tools vim dnsutils
# install cron and msmtp for outgoing email
RUN apt-get install -y cron msmtp msmtp-mta mailutils
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos
RUN docker-php-ext-install bz2 curl gd imap intl mbstring mysqli \
    opcache pdo pdo_mysql pspell soap xmlrpc zip
# set up Redis support for php
#RUN docker-php-source extract \
#    && curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
#    && tar xfz /tmp/redis.tar.gz \
#    && rm -r /tmp/redis.tar.gz \
#    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
#    && docker-php-ext-install redis \
#    && docker-php-source delete \
#    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#    && chmod +x wp-cli.phar \
#    && mv wp-cli.phar /usr/local/bin/wp
RUN pecl install redis && docker-php-ext-enable redis
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# address app-specific config requirements
RUN set -ex \
    && { \
        echo 'log_errors = on'; \
        echo 'display_errors = off'; \
        echo 'always_populate_raw_post_data = -1'; \
        echo 'date.timezone = "Pacific/Auckland"'; \
        echo 'cgi.fix_pathinfo = 0'; \
        echo 'sendmail_path = /usr/bin/msmtp -t'; \
        echo 'upload_max_filesize = 100M'; \
        echo 'post_max_size = 150M'; \
        echo 'memory_limit = 250M'; \
        echo 'max_execution_time = 500'; \
        echo 'request_terminate_timeout = 500'; \
        echo '[opcache]'; \
        echo 'opcache.enable = 1'; \
        echo 'opcache.memory_consumption = 128'; \
        echo 'opcache.max_accelerated_files = 8000'; \
        echo 'opcache.revalidate_freq = 60'; \
        echo 'opcache.use_cwd = 1'; \
        echo 'opcache.validate_timestamps = 1'; \
        echo 'opcache.save_comments = 1'; \
        echo 'opcache.enable_file_override = 0'; \
    } | tee /usr/local/etc/php/conf.d/php.ini;
RUN set -ex \
    && { \
        echo '[global]'; \
        echo 'error_log = /proc/self/fd/2'; \
        echo '[www]'; \
        echo 'user = www-data'; \
        echo 'group = www-data'; \
        echo '; if we send this to /proc/self/fd/1, it never appears'; \
        echo 'access.log = /proc/self/fd/2'; \
        echo 'clear_env = no'; \
        echo 'catch_workers_output = yes'; \
        echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
        echo 'security.limit_extensions = .php'; \
        echo '; process management stuff'; \
        echo 'pm = ondemand'; \
        echo 'pm.max_children = 20'; \
        echo 'pm.start_servers = 2'; \
        echo 'pm.min_spare_servers = 1'; \
        echo 'pm.max_spare_servers = 3'; \
    } | tee /usr/local/etc/php-fpm.d/www.conf;

VOLUME /var/www/html

# Copy init scripts and custom .htaccess
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
