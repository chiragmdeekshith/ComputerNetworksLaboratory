#!/bin/bash
echo "Executing TCL file."
ns 11.tcl
echo "Executing AWK script"
awk -f 11.awk 11.tr 
echo "Executing NAM file"
nam 11.nam &
echo "End of program 11"
