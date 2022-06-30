#!/bin/bash
total=$(free | grep Mem: | cut -d' ' -f11)
used=$(free | grep Mem: | cut -d' ' -f18)
opr=$(($used / $total))

echo "#Architecture: $(uname -a)"
echo "#CPU physical : $(nproc)"
echo "#vCPU : $(cat /proc/cpuinfo | grep processor | wc -l)"
echo "#Disk Usage: $(free -h | grep Mem: | cut -d' ' -f20 | cut -d'M' -f1)/$(free -h | grep Mem: | cut -d' ' -f12 | cut -d'i' -f1)B ($opr2%)"
echo "#CPU load: $nval%"
echo "#Last boot: $nval"
echo "#LVM use: $nval"
echo "#Connections TCP : $nval"
echo "#User log: $nval"
echo "#Network: $nval"
echo "#Sudo : $nval"

