#!/usr/bin/env bash

set -x

# ulimits values need to be higher for this process
ulimit -u 4096
ulimit -n 4096
exit 0

cd /tmp &&
    sudo yum install -y cmake &&
    git clone --depth=1 https://github.com/apache/qpid-proton.git &&
    cd qpid-proton &&
    sudo mkdir -p /home/vagrant/.m2/repository &&
    sudo chown -R vagrant:vagrant /home/vagrant/ &&
    mvn clean install -DskipTests &&
    mkdir build &&
    cd build &&
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr &&
    make all &&
    sudo make install &&
    ll /usr/share/proton-0.14.0/examples/python

# Install pre-reqs and dispatch router
## https://www.rpmfind.net/linux/rpm2html/search.php?query=libqpid-proton.so.7*&submit=Search+...&system=&arch=
cd /opt/rh &&
    wget ftp://195.220.108.108/linux/epel/testing/7/x86_64/q/qpid-proton-c-0.13.0-1.el7.x86_64.rpm &&
    sudo yum install -y qpid-proton-c-0.13.0-1.el7.x86_64.rpm &&
    sudo yum install -y qpid-dispatch-router-0.6.0-6.el7.x86_64.rpm &&
    sudo systemctl enable qdrouterd.service &&
    sudo systemctl start qdrouterd.service

# Open firewall for amqp
sudo systemctl stop firewalld

sudo firewall-cmd --zone=public --add-port=5672/tcp --permanent     #amqp
sudo firewall-cmd --zone=public --change-interface=enp0s8
sudo firewall-cmd --reload

firewall-cmd --get-active-zones
firewall-cmd --zone=public --list-ports


python /usr/share/proton-0.14.0/examples/python/simple_recv.py -a /my_address -m 5

