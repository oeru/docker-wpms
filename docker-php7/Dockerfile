FROM php:7.0-fpm-jessie
MAINTAINER Dave Lane <dave@oerfoundation.org> (@lightweight)

# Install PHP extensions
RUN apt-get update && apt-get install -y apt-utils git less libbz2-dev libc-client-dev \
    libcurl4-gnutls-dev libicu-dev libkrb5-dev libmcrypt-dev libpng-dev \
    libpspell-dev libssl-dev libxml2-dev mariadb-client telnet unzip zip
RUN apt-get install -y net-tools vim dnsutils
# install cron and msmtp for outgoing email
RUN apt-get install -y cron msmtp
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos
RUN docker-php-ext-install bz2 curl gd imap intl mbstring mcrypt mysqli \
    opcache pdo pdo_mysql pspell soap xmlrpc zip
# address app-specific config requirements
RUN echo "log_errors = on" > /usr/local/etc/php/conf.d/php.ini
RUN echo "display_errors = off" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "always_populate_raw_post_data = -1" >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'date.timezone = "Pacific/Auckland"' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'cgi.fix_pathinfo = 0' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'sendmail_path = /usr/bin/msmtp -t' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'upload_max_filesize = 100M' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'post_max_size = 150M' >> /usr/local/etc/php/conf.d/php.ini
RUN echo '[opcache]' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.enable = 1' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.memory_consumption = 128' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.max_accelerated_files = 8000' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.revalidate_freq = 60' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.use_cwd = 1' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.validate_timestamps = 1' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.save_comments = 1' >> /usr/local/etc/php/conf.d/php.ini
RUN echo 'opcache.enable_file_override = 0' >> /usr/local/etc/php/conf.d/php.ini

# the PHP-fpm configuration
RUN echo 'security.limit_extensions = .php' >> /usr/local/etc/php-fpm.d/www.conf
RUN echo 'catch_workers_output = yes' >> /usr/local/etc/php-fpm.d/www.conf
RUN echo 'php_flag[display_errors] = off' >> /usr/local/etc/php-fpm.d/www.conf
RUN echo 'php_admin_value[error_log] = /usr/local/var/log/fpm-php.www.log' >> /usr/local/etc/php-fpm.d/www.conf
RUN echo 'php_admin_flag[log_errors] = on' >> /usr/local/etc/php-fpm.d/www.conf
RUN echo 'php_admin_value[memory_limit] = 120M' >> /usr/local/etc/php-fpm.d/www.conf

VOLUME /var/www/html

# Copy init scripts and custom .htaccess
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
