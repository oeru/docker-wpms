FROM php:jessie
MAINTAINER Dave Lane <dave@oerfoundation.org> (@lightweight)

# Install PHP extensions
RUN apt-get update && apt-get install -y net-tools vim dnsutils
# install cron and msmtp for outgoing email
RUN apt-get install -y cron msmtp
RUN rm -rf /var/lib/apt/lists/*

VOLUME /etc/cron.d

CMD ['cron','-f']
