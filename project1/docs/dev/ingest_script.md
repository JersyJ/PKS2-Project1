# Ingest Script

## Get Total Incoming Packets into Array
```shellscript
values_string=$(snmpwalk localhost ifInUcastPkts | awk ' { print $4 }')
values_array=($values_string)
```

## Get Progress values
```shellscript
last_values_total=($(rrdtool lastupdate packets_in_total.rrd | sed -n '3s/^[^ ]* //p'))

progress_values=( $((values_array[0]-last_values_total[0])) $((values_array[1]-last_values_total[1])) $((values_array[2]-last_values_total[2])) $((values_array[3]-last_values_total[3])) )
```

## Ingest data
```shellscript
rrdtool update /var/lib/rrdtool/packets_in_total.rrd N:${values_array[0]}:${values_array[1]}:${values_array[2]}:${values_array[3]}

rrdtool update /var/lib/rrdtool/packets.rrd N:${progress_values[0]}:${progress_values[1]}:${progress_values[2]}:${progress_values[3]}
```

## Create graphs

```shellscript
#Hourly
rrdtool graph /var/www/html/assets/images/hourly_incoming_packets.png --start -3600 -a PNG --lower-limit 0 \
-t "Hourly Incoming packets" --vertical-label "Number of incoming packets" -w 700 -h 300 \
DEF:packets_i1=/var/lib/rrdtool/packets.rrd:packets_i1:LAST LINE2:packets_i1#ff0000:"lo" \
DEF:packets_i2=/var/lib/rrdtool/packets.rrd:packets_i2:LAST LINE2:packets_i2#55ff00:"ens160" \
DEF:packets_i3=/var/lib/rrdtool/packets.rrd:packets_i3:LAST LINE2:packets_i3#0059ff:"ens192" \
DEF:packets_i4=/var/lib/rrdtool/packets.rrd:packets_i4:LAST LINE2:packets_i4#ffe100:"ens224"

#Daily
rrdtool graph /var/www/html/assets/images/daily_incoming_packets.png --start -1d -a PNG --lower-limit 0 \
-t "Daily Incoming packets" --vertical-label "Number of incoming packets" -w 700 -h 300 \
DEF:packets_i1=/var/lib/rrdtool/packets.rrd:packets_i1:LAST LINE2:packets_i1#ff0000:"lo" \
DEF:packets_i2=/var/lib/rrdtool/packets.rrd:packets_i2:LAST LINE2:packets_i2#55ff00:"ens160" \
DEF:packets_i3=/var/lib/rrdtool/packets.rrd:packets_i3:LAST LINE2:packets_i3#0059ff:"ens192" \
DEF:packets_i4=/var/lib/rrdtool/packets.rrd:packets_i4:LAST LINE2:packets_i4#ffe100:"ens224"

#Weekly
rrdtool graph /var/www/html/assets/images/weekly_incoming_packets.png --start -1w -a PNG --lower-limit 0 \
-t "Weekly Incoming packets" --vertical-label "Number of incoming packets" -w 700 -h 300 \
DEF:packets_i1=/var/lib/rrdtool/packets.rrd:packets_i1:LAST LINE2:packets_i1#ff0000:"lo" \
DEF:packets_i2=/var/lib/rrdtool/packets.rrd:packets_i2:LAST LINE2:packets_i2#55ff00:"ens160" \
DEF:packets_i3=/var/lib/rrdtool/packets.rrd:packets_i3:LAST LINE2:packets_i3#0059ff:"ens192" \
DEF:packets_i4=/var/lib/rrdtool/packets.rrd:packets_i4:LAST LINE2:packets_i4#ffe100:"ens224"
```