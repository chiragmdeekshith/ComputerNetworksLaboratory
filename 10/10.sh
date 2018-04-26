#!/bin/bash

echo "Producing TCP file TCP_10"
ns /root/Downloads/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/cbrgen.tcl -type cbr -nn 6 -seed 1 -mc 4 -rate 1 > /root/CN/10/TCP_10
echo "Running TCL file"
ns 10.tcl
echo "Running NAM file"
nam 10.nam &
echo "END of program 10"
