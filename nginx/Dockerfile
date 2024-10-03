FROM debian

# Forked from:
# MAINTAINER Real Geeks "kevin@realgeeks.com"
# MAINTAINER Eric McNiece "hello@emc2innovation.com"
#MAINTAINER Dave Lane <dave@oerfoundation.org> @lightweight@mastodon.nzoss.nz

#ENV NGINX_VERSION=1.19.7
ENV NGINX_VERSION=1.26.2
ENV NGX_CACHE_PURGE_VERSION=2.3

# Install basic packages and build tools
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libssl-dev \
    libpcre3 \
    libpcre3-dev \
    zlib1g-dev\
    && apt-get clean

# Get sources
RUN cd /tmp && wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz http://labs.frickle.com/files/ngx_cache_purge-$NGX_CACHE_PURGE_VERSION.tar.gz && \
    tar -zxvf nginx-$NGINX_VERSION.tar.gz && mv nginx-$NGINX_VERSION nginx && rm nginx-$NGINX_VERSION.tar.gz && \
    tar -zxvf ngx_cache_purge-$NGX_CACHE_PURGE_VERSION.tar.gz && mv ngx_cache_purge-$NGX_CACHE_PURGE_VERSION ngx_cache_purge && rm ngx_cache_purge-$NGX_CACHE_PURGE_VERSION.tar.gz

# get build dependencies
RUN apt-get install -y \
    libgeoip-dev

# Configure and build software
RUN cd /tmp/nginx && ./configure \
    --user=www-data \
    --group=www-data \
    --sbin-path=/usr/local/sbin \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --with-compat \
    --with-file-aio \
    --with-http_addition_module \
    --with-http_gzip_static_module \
    --with-http_ssl_module \
	--with-http_geoip_module \
    --with-http_flv_module \
	--with-http_sub_module \
	--with-http_realip_module \
	--with-http_dav_module \
	--with-http_gunzip_module \
    --with-http_random_index_module \
	--with-http_secure_link_module \
    --with-http_auth_request_module \
	--without-http_ssi_module \
	--with-threads \
	--with-stream \
	--with-stream_ssl_module \
	--with-http_v2_module \
	--with-ipv6 \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic' \
    --add-module=/tmp/ngx_cache_purge && \
    make && make install
# userful resource https://gist.github.com/ealebed/a55170049830b75c0f339ea4e8d6d21b

# Install basic necessities
RUN apt-get install -y \
    less \
    dnsutils \
    vim \
    telnet \
    && apt-get clean

# Copy configuration files into /etc/nginx and clean up config file to point to
# correct root
RUN mkdir /var/www && \
    mv /usr/local/nginx/html /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    mkdir -p /etc/nginx/conf.d

# set up a known good nginx.conf 
COPY nginx.conf /etc/nginx/nginx.conf

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/etc/nginx/conf.d", "/var/www/html", "/var/cache/nginx"]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
