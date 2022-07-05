#!/bin/bash

total=$(free | grep Mem: | awk '{print $2}')
used=$(free | grep Mem: | awk '{print $3}')
opr=$(awk -v a=$used -v b=$total 'BEGIN {printf "%.2f", a/b*100}')
loud=$(mpstat | grep all | awk '{print $13}')
zero=0

echo "#Architecture: $(uname -a)"
echo "#CPU physical : $(lscpu | grep Socket | wc -l)"
echo "#vCPU : $(cat /proc/cpuinfo | grep processor | wc -l)"
echo "#Memory Usage: $(free -m | grep Mem: | awk '{print $3}')/$(free -m | grep Mem: | awk '{print $2}')MB ($opr%)"
echo "#Disk Usage: $(df -m --total | grep total | awk '{printf $3}')/$(df -h --total | grep total | awk '{printf $2}')b ($(df -h --total | grep total | awk '{print $5}'))"
echo "#CPU load: $(awk -v l=$loud 'BEGIN {printf "%.1f", 100-l}')%"
echo "#Last boot: $(who -b | awk '{print $3,$4}')"
if [ $( /usr/sbin/lvscan | grep ACTIVE | wc -l) -gt $zero ]
then
        echo "#LVM use: yes"
else
        echo "#LVM use: no"
fi
echo "#Connections TCP : $(ss -t | grep ESTAB | wc -l) ESTABLISHED"
echo "#User log: $(who | wc -l)"
echo "#Network: IP $(hostname -I) ($(ip addr | grep ether | cut -d' ' -f6))"
echo "#Sudo : $(journalctl _COMM=sudo | grep COMMAND | wc -l) cmd"
