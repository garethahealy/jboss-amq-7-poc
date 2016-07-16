#!/usr/bin/env bash

set -x

# Create a broker and start it up
cd /opt/rh &&
    A-MQ7-7.0.0.ER7-redhat-1/bin/artemis create --allow-anonymous --user admin --password admin --role admin brokereu-master &&
    sed -i "s/localhost:8161/0.0.0.0:8161/" /opt/rh/brokereu-master/etc/bootstrap.xml &&
    mv eu-master-broker.xml brokereu-master/etc/broker.xml &&
    chmod 664 brokereu-master/etc/broker.xml &&
    sed -i "s/0.0.0.0/10.21.2.10/g" brokereu-master/etc/broker.xml &&
    brokereu-master/bin/artemis-service start

sudo yum install -y python-qpid-proton python-qpid-proton-docs --enablerepo=epel-testing

time_elapsed=0
has_started=0
while (( has_started <= 0 ))
do
    sleep 5
    time_elapsed=$((time_elapsed + 5))
    has_started=$(grep -c "Server is now live" /opt/rh/brokereu-master/log/artemis.log)
    if [[ $time_elapsed -ge 120 ]]; then
        echo "Waited $time_elapsed for startup. Exiting loop."
        break
    fi
done

cat /opt/rh/brokereu-master/log/artemis.log

if [[ $has_started == 1 ]]; then
    echo "Broker has started up."
fi
