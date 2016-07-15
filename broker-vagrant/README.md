# broker-vagrant
Image to run JBoss AMQ 7 Alpha HA brokers

## What does this image do?
- Creates 2 VMs (USA and Europe). Each VM has a Master/Slave broker for HA
- Installs and starts JBoss AMQ 7 Alpha

## How to run
- vagrant up
- vagrant ssh brokerusa
- vagrant ssh brokereu

## Web URLS for hawt.io
U: admin / P: admin
- http://brokerusa.amq7.vagrant.local:8161/hawtio
- http://brokereu.amq7.vagrant.local:8161/hawtio

