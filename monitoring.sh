#!/bin/bash

memm=$(free | wc -c)
x=10
nval=$(($memm / $x))

echo "#Architecture: $(uname -a)" > display_message.txt
echo "#CPU physical: $(nproc)" >> display_message.txt
echo "#vCPU: $(cat /proc/cpuinfo | grep processor | wc -l)" >> display_message.txt
echo "#Memory Usage: $nval" >> display_message.txt
echo "#Memory Usage: $nval" >> display_message.txt
echo "#Memory Usage: $nval" >> display_message.txt
echo "#Memory Usage: $nval" >> display_message.txt
echo "#Memory Usage: $nval" >> display_message.txt
echo "#Memory Usage: $nval" >> display_message.txt
echo "#Memory Usage: $nval" >> display_message.txt
#wall display_message.txt
