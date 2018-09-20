#!/bin/bash

# PHP

# Add deb.sury.org repository
wget -O- https://packages.sury.org/php/apt.gpg | apt-key add -

cat << EOF >/etc/apt/sources.list.d/sury.list
deb https://packages.sury.org/php/ jessie main
EOF

# Sync package index files
apt-get update

apt-get -y install php7.2 php7.2-cli php7.2-fpm php7.2-dev php7.2-curl php7.2-intl \
    php7.2-mysql php7.2-sqlite3 php7.2-gd php7.2-mbstring php7.2-xml php7.2-soap php7.2-zip php7.2-apcu php7.2-xdebug

# PHP config
sed -i 's/;date.timezone.*/date.timezone = Europe\/Brussels/' /etc/php/7.2/cli/php.ini
sed -i 's/;date.timezone.*/date.timezone = Europe\/Brussels/' /etc/php/7.2/fpm/php.ini
sed -i 's/upload_max_filesize = .*/upload_max_filesize = 20M/' /etc/php/7.2/fpm/php.ini
sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/7.2/fpm/php.ini
sed -i 's/post_max_size = .*/post_max_size = 24M/' /etc/php/7.2/fpm/php.ini
sed -i 's/^user = www-data/user = vagrant/' /etc/php/7.2/fpm/pool.d/www.conf
sed -i 's/^group = www-data/group = vagrant/' /etc/php/7.2/fpm/pool.d/www.conf

# Install APCu
# printf "\n" | pecl install apcu

#cat << EOF >>/etc/php/7.2/mods-available/apcu.ini
#extension=apcu.so
#EOF

#ln -s /etc/php/7.2/mods-available/apcu.ini /etc/php/7.2/cli/conf.d/20-apcu.ini
#ln -s /etc/php/7.2/mods-available/apcu.ini /etc/php/7.2/fpm/conf.d/20-apcu.ini

# Install Xdebug
# pecl install xdebug

cat << EOF >>/etc/php/7.2/mods-available/xdebug.ini
xdebug.remote_enable=1
xdebug.remote_autostart=1
xdebug.remote_host=192.168.33.1
xdebug.max_nesting_level=256
; xdebug.profiler_enable=1
; xdebug.profiler_output_dir=/vagrant/dumps
EOF

#PHP_API=`php -i | grep "PHP API => " | cut -d' ' -f4`

# ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/cli/conf.d/10-xdebug.ini
# ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/fpm/conf.d/10-xdebug.ini

# Reload FPM
service php7.2-fpm restart

# composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
ln -s /usr/bin/composer.phar /usr/bin/composer

# phpunit
wget -P /usr/bin https://phar.phpunit.de/phpunit.phar
chmod +x /usr/bin/phpunit.phar
ln -s /usr/bin/phpunit.phar /usr/bin/phpunit

