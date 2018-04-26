#!/bin/bash
echo "Running TCL script"
ns 13.tcl
echo "Running NAM script"
nam 13.nam &
echo "Running XGRAPH "
/root/Documents/XGRAPH/bin/xgraph cwnd0.tr cwnd1.tr &
echo "End of program"

