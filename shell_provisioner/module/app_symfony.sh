#!/bin/bash

# Symfony application

cd /vagrant/htdocs

# Install vendors
composer.phar install

# Build frontend
cd web
yarn
gulp build

cd -
