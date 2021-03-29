FROM oeru/php74-fpm
MAINTAINER Dave Lane <dave@oerfoundation.org> (@lightweight)

# note: cron is already installed.

# set up cron tasks
RUN set -ex \
    && { \
        echo '# cron jobs for Multisite Wordpress - dave@oerfoundation.org'; \
        echo 'PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'; \
        echo 'OUT=/var/log/cron.log'; \
        echo '# cron every 5 minutes'; \
        echo '*/5 * * * * www-data php /var/www/html/wp-cron.php >> $OUT'; \
        echo '# Just testing'; \
        echo '*/5 * * * * www-data echo "Running cron at $(date)" >> $OUT '; \
        echo '# empty line'; \
    } | tee /etc/cron.d/wpms-cron

RUN touch 0644 /var/log/cron.log

CMD cron && tail -f /var/log/cron.log
