FROM debian:jessie
MAINTAINER Dave Lane <dave@oerfoundation.org> (@lightweight)

# Install PHP extensions
RUN apt-get update && apt-get install -y net-tools vim dnsutils
# install cron and msmtp for outgoing email
RUN apt-get install -y cron
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*
RUN touch 0644 /var/log/cron.log

VOLUME /etc/cron.d

CMD cron && tail -f /var/log/cron.log
