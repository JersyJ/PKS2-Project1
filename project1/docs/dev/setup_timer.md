# Use Systemd Timer to schedule script every minute

## Create Service
New file /etc/systemd/system/memory/monitoring-packets.service
Set explicit journal for logs and path of the script
```
[Unit]
Description=Run script to collect number of packets received

[Service]
Type=oneshot
ExecStart=/var/lib/rrdtool/script.sh
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

## Create Timer
New file /etc/systemd/system/memory/monitoring-packets.timer
Set OnUnitActiveSec=1min to run every minute
```
[Unit]
Description=Timer to run rrd-monitoring-packets.service

[Timer]
Unit=monitoring-packets.service
OnUnitActiveSec=1min
Persistent=True

[Install]
WantedBy=timers.target
```

## Start the timer

```shellscript
systemctl enable monitoring-packets.timer
systemctl daemo-reload
systemctl start monitoring-packets.timer
reboot
```

## Check list of timers
```shellscript
systemctl list-timers
```

## Sources
[Source 1](https://www.airplane.dev/blog/systemd-timer-how-to-schedule-tasks-with-systemd)