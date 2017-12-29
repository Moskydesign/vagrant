#!/bin/bash

# Shell provisioner

# Set environment variables
source /vagrant/shell_provisioner/set_vars.sh

# Adding an entry here executes the corresponding .sh file in MODULE_PATH
DEPENDENCIES=(
    debian
    tools
    vim
    mysql
    php
    apache
    phpmyadmin
    yarn
    mailhog
    frontend
    bash
    #blackfire
    #elasticsearch
    #drush
    #app_drupal8
    #app_symfony
    #app_laravel
)

for MODULE in ${DEPENDENCIES[@]}; do
	echo ""
	echo ""
	echo "##################################"
	echo "####"
	echo "####  Working on ${MODULE}"
	echo "####"
	echo "##################################"
    source ${MODULE_PATH}/${MODULE}.sh
done

echo "cd /vagrant/htdocs" >> /home/vagrant/.bashrc
