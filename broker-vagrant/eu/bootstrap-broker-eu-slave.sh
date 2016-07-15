#!/usr/bin/env bash

set -x

# Create a broker and start it up
cd /opt/rh &&
    A-MQ7-7.0.0.ER7-redhat-1/bin/artemis create --allow-anonymous --user admin --password admin --role admin brokereu-slave &&
    sed -i "s/localhost:8161/0.0.0.0:8161/" /opt/rh/brokereu-slave/etc/bootstrap.xml &&
    mv eu-slave-broker.xml brokereu-slave/etc/broker.xml &&
    chmod 664 brokereu-slave/etc/broker.xml &&
    sed -i "s/0.0.0.0/10.21.2.11/g" brokereu-slave/etc/broker.xml &&
    brokereu-slave/bin/artemis-service start

time_elapsed=0
has_started=0
while (( has_started <= 0 ))
do
    sleep 5
    time_elapsed=$((time_elapsed + 5))
    has_started=$(grep -c "backup announced" /opt/rh/brokereu-slave/log/artemis.log)
    if [[ $time_elapsed -ge 120 ]]; then
        echo "Waited $time_elapsed for startup. Exiting loop."
        break
    fi
done

cat /opt/rh/brokereu-slave/log/artemis.log

if [[ $has_started == 1 ]]; then
    echo "Broker has started up."
fi
