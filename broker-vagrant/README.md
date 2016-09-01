# broker-vagrant
Image to run JBoss AMQ 7 Alpha HA brokers

## What does this image do?
- Creates 2 VMs (USA and Europe). Each VM has a Master/Slave broker for HA
- Installs and starts JBoss AMQ 7 Alpha

## How to run
- vagrant up
- vagrant ssh brokerusamaster
- vagrant ssh brokerusaslave
- vagrant ssh brokereumaster
- vagrant ssh brokereuslave

## Web URLS for hawt.io
U: admin / P: admin
- http://broker-usa-master.amq7.vagrant.local:8161/hawtio
- http://broker-eu-master.amq7.vagrant.local:8161/hawtio

