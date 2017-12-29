#!/bin/bash

# Apache

apt-get install -y apache2

a2enmod rewrite expires headers proxy proxy_http proxy_fcgi actions alias ssl


# Activate vhost
a2dissite 000-default

chmod -R a+rX /var/log/apache2
sed -i 's/640/666/' /etc/logrotate.d/apache2

# Documentroot detection
if [ -d /vagrant/public_html ]; then
  DocumentRoot="/public_html"
elif [ -d /vagrant/public ]; then
  DocumentRoot="/public"
elif [ -d /vagrant/web ]; then
  DocumentRoot="/web"
elif [ -d /vagrant/htdocs/web ]; then
  DocumentRoot="/htdocs/web"
elif [ -d /vagrant/htdocs/public ]; then
  DocumentRoot="/htdocs/public"
elif [ -d /vagrant/htdocs/public_html ]; then
DocumentRoot="/htdocs/public_html"
elif [ -d /vagrant/htdocs ]; then
  DocumentRoot="/htdocs"
elif [ -d /vagrant/app ]; then
DocumentRoot="/app"
else
  DocumentRoot=""
fi

cat ${CONFIG_PATH}/apache/app.vhost.conf > /etc/apache2/sites-available/${APP_DOMAIN}.conf
sed -i "s#/vagrant/htdocs#/vagrant${DocumentRoot}#g" /etc/apache2/sites-available/${APP_DOMAIN}.conf
sed -i "s#APP_DOMAIN#${APP_DOMAIN}#g" /etc/apache2/sites-available/${APP_DOMAIN}.conf

a2ensite ${APP_DOMAIN}.conf
service apache2 restart
