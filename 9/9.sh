#!/bin/bash
echo "Choose the typre of protocol in the TCL file:- AODV;DSDV;DSR" 
echo "Running TCL file"
ns 9.tcl
echo "Running AWK script"
awk -f 9.awk 9.tr
echo "TCL file completed. Running NAM file."
nam 9.nam &
echo "END of program"
