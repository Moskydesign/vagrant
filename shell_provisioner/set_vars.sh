#!/bin/bash

# Set provisioning variables
export MODULE_PATH='/vagrant/shell_provisioner/module'
export CONFIG_PATH='/vagrant/shell_provisioner/config'

# IP for the vagrant VM
export GUEST_IP='192.168.33.60'

# Set the variables below for your project

# 1) Set to your app's local domainname
export APP_DOMAIN=$1

# 2) App DB name and credentials
export APP_DBNAME='app'
export APP_DBUSER='app'
export APP_DBPASSWORD='app'

# Hostname used by postfix
export POSTFIX_HOSTNAME='mail.$1'

# ElasticSearch nodes
export ELASTICSEARCH_NODE_1='app'

