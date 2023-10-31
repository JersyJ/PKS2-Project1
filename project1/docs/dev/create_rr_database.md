# Create Round Robin Database via RRDtool

## Create databases

```shellscript
rrdtool create packets.rrd --step=60 \
DS:packets_i1:GAUGE:120:0:U \
DS:packets_i2:GAUGE:120:0:U \
DS:packets_i3:GAUGE:120:0:U \
DS:packets_i4:GAUGE:120:0:U \
RRA:MAX:0.5:1:12M

rrdtool create packets_in_total.rrd --step=60 \ DS:packets_in_total_i1:COUNTER:120:0:U \ DS:packets_in_total_i2:COUNTER:120:0:U \ DS:packets_in_total_i3:COUNTER:120:0:U \ DS:packets_in_total_i4:COUNTER:120:0:U \
RRA:MAX:0.5:1:10d \
RRA:MAX:0.5:15:90d \
RRA:MAX:0.5:60:12M
```

### Add start value to progress database
```shellscript
rrdtool update /var/lib/rrdtool/packets.rrd N:0:0:0:0
```

## Sources

[Source 1](https://oss.oetiker.ch/rrdtool/doc/rrdcreate.en.html)