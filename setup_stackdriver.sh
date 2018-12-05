#!/bin/bash

cd /opt/stackdriver/collectd/etc/collectd.d/ 
curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/mongodb.conf

hostname=$(hostname)
sed -i 's/Hostname ""/Hostname "'$hostname'"/g' /etc/stackdriver/collectd.conf

sed -i 's/#User "STATS_USER"/User "'$MONGO_INITDB_ROOT_USERNAME'"/g' mongodb.conf
sed -i 's/#Password "STATS_PASS"/Password "'$MONGO_INITDB_ROOT_PASSWORD'"/g' mongodb.conf

service stackdriver-agent restart

