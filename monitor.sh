#!/bin/sh

uname -a | awk '{print "#Architecture: " $0}'
lscpu | awk NR==4 | awk '{print "#CPU physical: " $2}'
cat /proc/cpuinfo | grep "processor" | wc -l | awk '{print "#vCPU: " $0}'
free -m | awk  'NR == 2 {printf "#Memory Usage: %s/%sMB (%.2f%%)\n",$3,$2, $3 * 100 / $2}'
df -h /dev/sda5 | awk 'NR == 2 {printf "#Disk Usage: %d/%dGb (%.2f%%)\n",$3,$2,$3 * 100 / $2}'
top -n 1 | awk 'NR== 3 {printf("#CPU load: %.f%%\n",$2)}'
last reboot | awk 'NR == 2 {printf("#Last boot: %s %s %d %s\n",$5,$6,$7,$8)}'
netstat -an | grep ESTABLISHED | wc -l | awk '{print "#Connexions TCP: " $0 " ESTABLISHED"}'
who | wc -l |  awk '{print "#User log: " $0 }'
cat /var/log/sudo.log | grep COMMAND | wc -l | awk '{print "#Sudo: " $0 " cmd" }'
