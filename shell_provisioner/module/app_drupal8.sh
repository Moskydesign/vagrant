#!/bin/bash

# Drupal application
cd /vagrant/htdocs
cp development.htaccess .htaccess
cp sites/default/_snippets/services.development.yml sites/default/services.yml
cp sites/default/_snippets/settings.development.php sites/default/settings.local.php
cp sites/default/_snippets/settings.private.php sites/default/settings.private.php
sed -i 's/YOUR_DATABASE/'${APP_DBNAME}'/' sites/default/settings.private.php
sed -i 's/YOUR_USERNAME/'${APP_DBUSER}'/' sites/default/settings.private.php
sed -i 's/YOUR_PASSWORD/'${APP_DBPASSWORD}'/' sites/default/settings.private.php

composer install

# Build frontend
cd themes/itr_theme
yarn
gulp build

cd -
