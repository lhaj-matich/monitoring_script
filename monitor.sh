#!/bin/sh

uname -a | awk '{print "#Architecture: " $0}'
lscpu | grep "CPU" | awk 'NR == 2 {print "#CPU physical: "$2}'
cat /proc/cpuinfo | grep "processor" | wc -l | awk '{print "#vCPU: " $0}'
free -m | awk  'NR == 2 {printf "#Memory Usage: %s/%sMB (%.2f%%)\n",$3,$2, $3 * 100 / $2}'
df -m | grep -v "tmpfs" | awk '{avai+= $2; used+= $3} END {printf("%d/%dGB (%.1f%%)\n",used / 1000, avai / 1000, used * 100 / avai)}'
uptime | awk '{printf("CPU usage: %.2f%%\n",$9)}'
last reboot | awk 'NR == 2 {printf("#Last boot: %s %s %d %s\n",$5,$6,$7,$8)}'
netstat -an | grep ESTABLISHED | wc -l | awk '{print "#Connexions TCP: " $0 " ESTABLISHED"}'
echo "#Network: IP `hostname -I`(`ip addr | grep "ether" | awk '{print $2}'`)"
who | wc -l |  awk '{print "#User log: " $0 }'
cat /var/log/sudo.log | grep COMMAND | wc -l | awk '{print "#Sudo: " $0 " cmd" }'
