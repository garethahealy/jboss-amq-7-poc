#!/usr/bin/env bash

set -x

# ulimits values need to be higher for this process
ulimit -u 4096
ulimit -n 4096

# Unzip AMQ
cd /opt/rh &&
    unzip amq-7.0.0.Alpha-bin.zip

# Open firewall for web/amqp
sudo systemctl restart firewalld

sudo firewall-cmd --zone=public --add-port=8161/tcp --permanent     #web
sudo firewall-cmd --zone=public --add-port=5672/tcp --permanent     #amqp
sudo firewall-cmd --zone=public --add-port=61616/tcp --permanent    #openwire
sudo firewall-cmd --zone=public --change-interface=enp0s8
sudo firewall-cmd --reload

firewall-cmd --get-active-zones
firewall-cmd --zone=public --list-ports
