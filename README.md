Docker PHP 7.0 Image
====================

Suitable a WordPress Multisite

Includes Nginx configuration, Composer, Outgoing Authenticated SMTP email, and Cron capabilities.

# License

This Docker Recipe is distributed under the GPL v3 license.

# How to use this image

1. you need a Docker host configured to use both a current Docker and Docker Compose with network access and git installed.  

1. make sure you have a MySQL or MariaDB running either on your Docker host, or in a container

1. clone this repo:
`git clone git@github.com:oeru/docker-wpms.git`
which will, by default, create a directory called 'docker-mautic'

1. create a local docker-compose.yml by copying docker-compose.yml-sample:
`cd docker-wpms`
`cp docker-compose.yml-sample docker-compose.yml`
and the edit the file to specify the details of your MySQL or MariaDB database. You need to specify a user who has the ability to create a database. Also you can tweak the ports assignments to make it publicly visible (I encourage defaulting to SSL!).

1. Copy the appropriate nginx-proxy.conf sample into your /etc/nginx/sites-available directory as, say a file named after YOUR_DOMAIN,

1. edit that YOUR_DOMAIN file to substitute in your variable values (for YOUR_DOMAIN, etc.) and add it to your sites-enabled variable (making relevant substitutions)
```
sudo cd /etc/nginx/sites-enabled
sudo ln -sf /etc/nginx/sites-available/YOUR_DOMAIN .
```

1. test your nginx instance to make sure it's happy: `nginx -t`

1. if you're setting up Let's Encrypt certs you'll might need to comment out all the secure stuff to get NGINX to restart properly with your new configuration (it'll complain about the missing cert files otherwise) and then run the `letsencrypt certonly --webroot -w /var/www/letsencrypt -d YOUR_DOMAIN`. If that finishes with a "Congratulations!" then uncomment the SSL-related configuration and reload nginx.

1. you also need to create a directory on your Docker host for your WordPress code, and reference it in the yml file.

1. Run `docker-compose up -d && docker-compose logs -f`, wait for it to initialize completely (you'll be shown the debugging information spat out by the containers - hit CTRL-C to get out of the logging - this won't shut down your containers - use `docker-compose stop` to do that), and visit `http://YOUR_DOMAIN` or `http://localhost:8080`.

# Supported Docker versions

This has been tested on Docker 1.13.1 on Ubuntu Linux 16.04 and requires Docker 1.10.x or better.

# User Feedback


## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/oeru/docker-wpms/issues). We will endeavour to assist, although we're doing this through enlightened self-interest, so can't provide any guarantees!

## References
https://github.com/emcniece/docker-wordpress
https://easyengine.io/wordpress-nginx/tutorials/multisite/subdomains/fastcgi-cache-with-purging/
