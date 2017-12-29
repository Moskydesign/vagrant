#!/bin/bash

# Install Java 8
apt-get install -y -t jessie-backports openjdk-8-jre-headless ca-certificates-java

# Add ElasticSearch key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Add Elastic repo
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" > /etc/apt/sources.list.d/elastic.list

# Update sources
apt-get update

# Install ElasticSearch and Kibana
apt-get install -y elasticsearch kibana

# Change Elasticsearch RAM needed to 1GB
sed -i 's/-Xms2g/-Xms512m/g' /etc/elasticsearch/jvm.options
sed -i 's/-Xmx2g/-Xmx512m/g' /etc/elasticsearch/jvm.options

# ElasticSearch configuration
cat << EOF >>/etc/elasticsearch/elasticsearch.yml

# Configuration set on vagrant provisioning
cluster.name: intracto
node.name: "${ELASTICSEARCH_NODE_1}"
network.bind_host: localhost
network.publish_host: 0.0.0.0
network.host: 0.0.0.0
script.inline: on
EOF

# Kibana configuration
cat << EOF >>/etc/kibana/kibana.yml

# Configuration set on vagrant provisioning
server.host: 0.0.0.0
EOF

# Create and start the service
systemctl enable elasticsearch
systemctl enable kibana
systemctl start elasticsearch
systemctl start kibana

