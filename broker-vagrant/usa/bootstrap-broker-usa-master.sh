#!/usr/bin/env bash

set -x

# Create a broker and start it up
cd /opt/rh &&
    A-MQ7-7.0.0.ER7-redhat-1/bin/artemis create --allow-anonymous --user admin --password admin --role admin brokerusa-master &&
    sed -i "s/localhost:8161/0.0.0.0:8161/" /opt/rh/brokerusa-master/etc/bootstrap.xml &&
    mv usa-master-broker.xml brokerusa-master/etc/broker.xml &&
    chmod 664 brokerusa-master/etc/broker.xml &&
    sed -i "s/0.0.0.0/10.21.1.10/g" brokerusa-master/etc/broker.xml &&
    brokerusa-master/bin/artemis-service start

sudo yum install -y python-qpid-proton python-qpid-proton-docs --enablerepo=epel-testing

time_elapsed=0
has_started=0
while (( has_started <= 0 ))
do
    sleep 5
    time_elapsed=$((time_elapsed + 5))
    has_started=$(grep -c "Server is now live" /opt/rh/brokerusa-master/log/artemis.log)
    if [[ $time_elapsed -ge 120 ]]; then
        echo "Waited $time_elapsed for startup. Exiting loop."
        break
    fi
done

cat /opt/rh/brokerusa-master/log/artemis.log

if [[ $has_started == 1 ]]; then
    echo "Broker has started up."
fi
