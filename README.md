[![Build Status](https://travis-ci.org/garethahealy/jboss-amq-7-poc.svg?branch=master)](https://travis-ci.org/garethahealy/jboss-amq-7-poc)

# jboss-amq-7-poc
Collection of internal/public docs which i found:

- https://mojo.redhat.com/docs/DOC-1077802
- https://mojo.redhat.com/docs/DOC-1071615
- https://mojo.redhat.com/docs/DOC-1075402
- https://access.redhat.com/documentation/en/red-hat-jboss-a-mq?version=7.0-alpha
- https://qpid.apache.org/releases/qpid-dispatch-0.6.0/book/book.html

## Whats this then boy-o?
PoC looking into the new JBoss AMQ7 Broker (https://github.com/apache/activemq-artemis) and JBoss AMQ7 Interconnect (https://github.com/apache/qpid-dispatch)

## How to run
- mvn clean install -Pdependencies
- cd broker-vagrant && vagrant up
- cd interconnect-vagrant && vagrant up

### Why do i need to mvn clean install?
The vagrant file expects to find any pre-req files in your m2 directory.

## I've up'ed it, now what?
If all brokers and interconnects have started, you now have a network of brokers.

    1. TabWindow1: Connect to the USA broker: vagrant ssh brokerusamaster
    2. TabWindow2: Connect to the EU Interconnect: vagrant ssh interconnectdispatcheu
    3. TabWindow2: Start a consumer on Interconnect: python /usr/share/proton-0.13.0/examples/python/simple_recv.py -a /jms.queue.first -m 10
    4. TabWindow1: Start a producer on the Broker: python /usr/share/proton-0.13.0/examples/python/simple_send.py -a 10.21.1.10:5672/jms.queue.first -m 10
    
If everything works, 10 messages will be:

    1. Produced to the USA Broker
    2. Routed via either the Iceland or Japan interconnect to the Europe interconnect
    3. Consumed from Europe interconnect
    
If you run the following on the interconnects, you will notice the stats change as messages are produced/consumed:

    clear &&
    sudo systemctl status qdrouterd.service &&
    qdstat -a &&
    qdstat -c &&
    qdstat --linkroutes
