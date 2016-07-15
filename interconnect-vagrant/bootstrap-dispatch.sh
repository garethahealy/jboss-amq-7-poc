#!/usr/bin/env bash

set -x

# Install QPid from EPEL Testing, as its not on EPEL/RHEL yet, only v0.5 is and we want v0.6
sudo yum update -y epel-release &&
    sudo yum install -y qpid-dispatch-router qpid-dispatch-tools qpid-dispatch-docs --enablerepo=epel-testing &&
    sudo yum install python-qpid-proton python-qpid-proton-docs --enablerepo=epel-testing &&
    sudo systemctl enable qdrouterd.service &&
    sudo systemctl start qdrouterd.service &&
    sudo systemctl status qdrouterd.service &&
    which qdrouterd &&
    ll /usr/share/proton-0.13.0/examples/python

# Open firewall for amqp
sudo systemctl restart firewalld
sudo firewall-cmd --zone=public --add-port=5672/tcp --permanent     #amqp
sudo firewall-cmd --zone=public --change-interface=enp0s8
sudo firewall-cmd --reload

firewall-cmd --get-active-zones
firewall-cmd --zone=public --list-ports

