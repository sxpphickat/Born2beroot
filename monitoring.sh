#!/bin/bash

total=$(free | grep Mem: | awk '{print $2}')
used=$(free | grep Mem: | awk '{print $3}')
opr=$(awk -v a=$used -v b=$total 'BEGIN {printf "%.2f", a/b*100}')
loud=$(mpstat | grep all | awk '{print $13}')
zero=0
if [ $( /usr/sbin/lvscan | grep ACTIVE | wc -l) -gt $zero ]
then
       lvm=$(echo "#LVM use: yes")
else
       lvm=$(echo "#LVM use: no")
fi

wall "
#Architecture: $(uname -a)
#CPU physical : $(lscpu | grep Socket | wc -l)
#vCPU : $(cat /proc/cpuinfo | grep processor | wc -l)
#Memory Usage: $(free -m | grep Mem: | awk '{print $3}')/$(free -m | grep Mem: | awk '{print $2}')MB ($opr%)
#Disk Usage: $(df -m --total | grep total | awk '{printf $3}')/$(df -h --total | grep total | awk '{printf $2}')b ($(df -h --total | grep total | awk '{print $5}'))
#CPU load: $(awk -v l=$loud 'BEGIN {printf "%.1f", 100-l}')%
#Last boot: $(who -b | awk '{print $3,$4}')
#Connections TCP : $(ss -t | grep ESTAB | wc -l) ESTABLISHED
$lvm
#User log: $(who | wc -l)
#Network: IP $(hostname -I) ($(ip addr | grep ether | cut -d' ' -f6))
#Sudo : $(journalctl _COMM=sudo | grep COMMAND | wc -l) cmd
"
