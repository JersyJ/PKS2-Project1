rrdtool create packets_in_total.rrd --step=60 DS:packets_in_total_i1:COUNTER:120:0:U DS:packets_in_total_i2:COUNTER:120:0:U DS:packets_in_total_i3:COUNTER:120:0:U DS:packets_in_total_i4:COUNTER:120:0:U RRA:MAX:0.5:1:10d RRA:MAX:0.5:15:90d RRA:MAX:0.5:60:12M
rrdtool create packets.rrd --step=60 DS:packets_i1:GAUGE:120:0:U DS:packets_i2:GAUGE:120:0:U DS:packets_i3:GAUGE:120:0:U DS:packets_i4:GAUGE:120:0:U RRA:MAX:0.5:1:12M
rrdtool update /var/lib/rrdtool/packets.rrd N:0:0:0:0


snmpwalk localhost ifInUcastPkts | awk ' { print $4 }'



values_string=$(snmpwalk localhost ifInUcastPkts | awk ' { print $4 }')
values_array=($values_string)

last_values_total=($(rrdtool lastupdate packets.rrd | sed -n '3s/^[^ ]* //p'))

progress_values=( $((values_array[0]-last_values_total[0])) $((values_array[1]-last_values_total[1])) $((values_array[2]-last_values_total[2])) $((values_array[3]-last_values_total[3])) )

rrdtool update /var/lib/rrdtool/packets_in_total.rrd N:${values_array[0]}:${values_array[1]}:${values_array[2]}:${values_array[3]}
rrdtool update /var/lib/rrdtool/packets.rrd N:${progress_values[0]}:${progress_values[1]}:${progress_values[2]}:${progress_values[3]}


#hodinovy graf

rrdtool graph /var/www/html/hourly_incoming_packets.png --start -3600 -a PNG --lower-limit 0 \
-t "Hourly Incoming packets" --vertical-label "Number of incoming packets" -w 700 -h 300 \
DEF:packets_i1=/var/lib/rrdtool/packets.rrd:packets_i1:LAST LINE2:packets_i1#ff0000 \
DEF:packets_i2=/var/lib/rrdtool/packets.rrd:packets_i2:LAST LINE2:packets_i2#ff0000 \
DEF:packets_i3=/var/lib/rrdtool/packets.rrd:packets_i3:LAST LINE2:packets_i3#ff0000 \
DEF:packets_i4=/var/lib/rrdtool/packets.rrd:packets_i4:LAST LINE2:packets_i4#ff0000

 

#denni graf

rrdtool graph /var/www/html/daily_incoming_packets.png --start -1d -a PNG --lower-limit 0 \
-t "Daily Incoming packets" --vertical-label "Number of incoming packets" -w 700 -h 300 \
DEF:noi=/var/lib/rrdtool/packets.rrd:noi:LAST LINE2:noi#ff0000 \

 

#tydenni graf

rrdtool graph /var/www/html/weekly_incoming_packets.png --start -1w -a PNG --lower-limit 0 \
-t "Weekly Incoming packets" --vertical-label "Number of incoming packets" -w 700 -h 300 \
DEF:noi=/var/lib/rrdtool/packets.rrd:noi:LAST LINE2:noi#ff0000

