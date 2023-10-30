#!/bin/bash
values_string=$(snmpwalk localhost ifInUcastPkts | awk ' { print $4 }')
values_array=($values_string)

last_values_total=($(rrdtool lastupdate packets_in_total.rrd | sed -n '3s/^[^ ]* //p'))

progress_values=( $((values_array[0]-last_values_total[0])) $((values_array[1]-last_values_total[1])) $((values_array[2]-last_values_total[2])) $((values_array[3]-last_values_total[3])) )

rrdtool update /var/lib/rrdtool/packets_in_total.rrd N:${values_array[0]}:${values_array[1]}:${values_array[2]}:${values_array[3]}
rrdtool update /var/lib/rrdtool/packets.rrd N:${progress_values[0]}:${progress_values[1]}:${progress_values[2]}:${progress_values[3]}