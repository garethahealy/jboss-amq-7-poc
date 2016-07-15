[![Build Status](https://travis-ci.org/garethahealy/jboss-amq-7-poc.svg?branch=master)](https://travis-ci.org/garethahealy/jboss-amq-7-poc)

# jboss-amq-7-poc
Collection of internal/public docs which i found.

- https://mojo.redhat.com/docs/DOC-1077802
- https://mojo.redhat.com/docs/DOC-1071615
- https://mojo.redhat.com/docs/DOC-1075402
- https://access.redhat.com/documentation/en/red-hat-jboss-a-mq?version=7.0-alpha

## Whats this then boy-o?
PoC looking into the new JBoss AMQ7 Broker (https://github.com/apache/activemq-artemis) and JBoss AMQ7 Interconnect (https://github.com/apache/qpid-dispatch)

## How to run
- mvn clean install -Pdependencies
- cd broker-vagrant && vagrant up
- cd interconnect-vagrant && vagrant up

### Why do i need to mvn clean install?
The vagrant file expects to find any pre-req files in your m2 directory.
