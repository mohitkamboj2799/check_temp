#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Missing argument/s. Usage: check_temp.sh [Warning] [Critical]"
        exit 3
fi

cwarn=$1
ccrit=$2

#cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
#cpuTemp1=$(($cpuTemp0/1000))
cpuTemp1_float=$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')
cpuTemp1=${cpuTemp1_float%.*}


if [  "$cpuTemp1" -gt "$ccrit" ]
then
 echo "CRITICAL:  - $cpuTemp1 C°"
 exit 2
elif [ "$cpuTemp1" -gt "$cwarn" ]
then
 echo "WARNING - $cpuTemp1 C°"
 exit 1
elif [  "$cpuTemp1" -lt "$cwarn" ]
then
 echo "OK: Raspberry Pi - $cpuTemp1 C°"
 exit 0
else
 echo "UNKNOWN FAILURE"
 exit 2
fi

