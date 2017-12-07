#!/bin/bash

set -e

# if CREATE_DB is set, then we probably want to create a DB
if [ -v CREATE_DB ] ; then
    # If the DB user is 'root' then use the MySQL root password env var
    : ${DB_USER:=root}
    if [ "$DB_USER" = 'root' ]; then
        : ${DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
    fi
    : ${DB_NAME:=wordpress}

    if [ -z "$DB_PASSWORD" ]; then
        echo >&2 "error: missing required DB_PASSWORD environment variable"
        echo >&2 "  Did you forget to -e DB_PASSWORD=... ?"
        echo >&2
        echo >&2 "  (Also of interest might be DB_USER and DB_NAME.)"
        exit 1
    fi
else
    echo >&2 "Assuming no database, or that any required databases already exist..."
fi

# pick a few variable based on the flavour of site this is going to run, currently
# choose from: drupal, moodle, silverstripe, or wordpress
if [ -v FLAVOUR ] ; then
    echo >&2 "This is a $FLAVOUR implementation!"
    CRON=${FLAVOUR}-cron
    echo >&2 "picking $CRON"
    cp /tmp/cron.d/$CRON /etc/cron.d

    # check if the cron daemon is running. If not, start it.
#    CRON_STATUS=`service cron status | grep -c "not running"`
#    echo >&2 "CRON_STATUS = $CRON_STATUS"
#    if [ $CRON_STATUS == 1 ] ; then
#        echo >&2 "firing up cron daemon"
#        RES=`service cron start`
#        echo >&2 "RES = $RES"
#        CRON_STATUS2=`service cron status | grep -c "not running"`
#        echo >&2 "CRON_STATUS2 = $CRON_STATUS2"
#        if [ $CRON_STATUS2 == 0 ]; then
#            echo >&2 "cron now running..."
#        else
#            echo >&2 "cron failed to start!"
#        fi
#    else
#        echo >&2 "cron already running!"
#    fi

#    cron && tail -f /tmp/cron.log
else
    echo >&2 "not starting cron - pick a valid FLAVOUR to enable this!"
fi

# set up authenticating SMTP...
if [ -v SMTP_HOST ] ; then
    if ! [ -e /etc/msmtprc ] ; then
        echo >&2 "writing /etc/msmtprc"
        tee <<EOF > /etc/msmtprc
#
# This was generated by a template in the entrypoint.sh script
# to create a valid msmtprc configuration with environment
# variables set in your docker-compose.yml file.
#
# For more quirky configurations, this might require some
# manual tweaking.
#
# easy docker container outgoing mail
defaults
logfile /tmp/msmtp.log

# this assumes that the SMTP server has TLS... which
# any modern server should...
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account RemoteHost

# server details
host $SMTP_HOST
from $SMTP_REPLYTO_EMAIL
port $SMTP_PORT

# SMTP authentication details
auth on
user $SMTP_AUTH_USER
password $SMTP_AUTH_PASSWORD
account default : RemoteHost
EOF
    else
        echo >&2 "/etc/msmtprc already in place! Not overwriting."
    fi
else
    echo >&2 "not configuring MSMTP - set SMTP_HOST and related environment values to enable."
fi

# run composer to set up dependencies if not already there...
if ! [ -e vendor/autoload.php ]; then
    echo >&2 "installing dependencies with Composer"
    if ! [ -e /usr/local/bin/composer ]; then
        echo >&2 "first getting Composer"
        # Get Composer
        curl -S https://getcomposer.org/installer | php
        chmod a+x composer.phar
        mv composer.phar /usr/local/bin/composer
    fi
#    if ! [ -e .git/hooks ]; then
#        echo >&2 "creating a .git/hooks dir to avoid errors"
#        mkdir -p .git/hooks
#    fi
#    composer install
else
    echo >&2 "vendor dependencies already in place."
fi

exec "$@"
