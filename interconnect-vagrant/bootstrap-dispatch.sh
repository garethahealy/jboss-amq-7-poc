#!/usr/bin/env bash

set -x

# Install QPid from EPEL Testing, as its not on EPEL/RHEL yet, only v0.5 is and we want v0.6
sudo yum update -y epel-release &&
    sudo yum install -y qpid-dispatch-router qpid-dispatch-tools qpid-dispatch-docs --enablerepo=epel-testing &&
    sudo yum install -y python-qpid-proton python-qpid-proton-docs --enablerepo=epel-testing &&
    sudo systemctl enable qdrouterd.service &&
    sudo systemctl start qdrouterd.service &&
    sudo systemctl status qdrouterd.service

# Print out some helpful info for developer
which qdrouterd &&
    ls -lrt /usr/share/proton-0.13.0/examples/python &&
    cat /etc/qpid-dispatch/qdrouterd.conf &&
    qdstat -a

# Open firewall for amqp
sudo systemctl restart firewalld
sudo firewall-cmd --zone=public --add-port=5672/tcp --permanent     #amqp
sudo firewall-cmd --zone=public --change-interface=enp0s8
sudo firewall-cmd --reload

firewall-cmd --get-active-zones
firewall-cmd --zone=public --list-ports

## Example command to receive/send a single message
# python /usr/share/proton-0.13.0/examples/python/simple_recv.py -a /jms.queue.first -m 1
# python /usr/share/proton-0.13.0/examples/python/simple_send.py -a /jms.queue.first -m 1



