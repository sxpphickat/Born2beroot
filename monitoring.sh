#!/bin/bash

total=$(free | grep Mem: | cut -d' ' -f11)
used=$(free | grep Mem: | cut -d' ' -f18)
opr=$(echo "scale=4;(($used / $total * 100))" | bc -l | rev | cut -c3- | rev) 

echo "#Architecture: $(uname -a)"
echo "#CPU physical : $(nproc)"
echo "#vCPU : $(cat /proc/cpuinfo | grep processor | wc -l)"
echo "#Memory Usage: $(free -h | grep Mem: | cut -d' ' -f20 | cut -d'M' -f1)/$(free -h | grep Mem: | cut -d' ' -f12 | cut -d'i' -f1)B ($opr%)"
echo "#Disk Usage: $nval%"
echo "#CPU load: $nval%"
echo "#Last boot: $(who -d | cut -d' ' -f18) $(who -d | cut -d' ' -f19)"
zero=0
if [ $(lvscan | grep ACTIVE | wc -l) -gt $zero ]
then
	echo "#LVM use: yes"
else
	echo "#LVM use: no"
fi
echo "#Connections TCP : $(ss -s | grep TCP: | cut -d' ' -f4) ESTABLISHED"
echo "#User log: $(who | wc -l)"
echo "#Network: IP $(ip addr | grep global | cut -d' ' -f6 | cut -d'/' -f1) ($(ip addr | grep ether | cut -d' ' -f6))"
echo "#Sudo : $(cat /var/log/sudo/sudo.log | grep COMMAND | wc -l) cmd"

