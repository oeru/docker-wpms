FROM oeru/php7.0-fpm-jessie
MAINTAINER Dave Lane <dave@oerfoundation.org> (@lightweight)

# install cron and msmtp for outgoing email
RUN apt-get install -y cron
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*

# set up cron tasks
RUN echo '# cron jobs for Multisite Wordpress - dave@oerfoundation.org' > /etc/cron.d/wpms-cron
RUN echo '# see https://mautic.org/docs/en/setup/cron_jobs.html for details' >> /etc/cron.d/wpms-cron
RUN echo 'PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' >> /etc/cron.d/wpms-cron
RUN echo 'OUT=/var/log/cron.log' >> /etc/cron.d/wpms-cron
RUN echo '# Run cron every 5 minutes' >> /etc/cron.d/wpms-cron
RUN echo '*/5 * * * * www-data php /var/www/html/wp-cron.php >> $OUT' >> /etc/cron.d/wpms-cron
RUN echo '# Just testing' >> /etc/cron.d/wpms-cron
RUN echo '*/5 * * * * www-data echo "Running cron at $(date)" >> $OUT ' >> /etc/cron.d/wpms-cron
RUN echo '# empty line' >> /etc/cron.d/wpms-cron

RUN touch 0644 /var/log/cron.log

CMD cron && tail -f /var/log/cron.log
