# interconnect-vagrant
Image to run JBoss AMQ 7 Interconnect

## What does this image do?
- Creates 4 VMs (USA, Iceland, Europe and Japan). Each VM has a interconnect running, which is connected to other interconnects to their geographical left and right.
- Installs and starts JBoss AMQ 7 Interconnect

## How to run
- vagrant up
- vagrant ssh interconnectdispatchusa
- vagrant ssh interconnectdispatcheu
- vagrant ssh interconnectdispatchice
- vagrant ssh interconnectdispatchjap
