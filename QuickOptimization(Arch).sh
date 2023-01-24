#!/bin/bash

# Clear the system's memory cache
sync; echo 3 > /proc/sys/vm/drop_caches

# Kill all processes using excessive amounts of CPU
for i in $(ps aux --sort=-%cpu | awk '{if($3>50.0) print $2}' | tail -n +2); do 
  kill -9 $i; 
done

# Clear the system's swap space
swapoff -a && swapon -a

# Remove old log files
find /var/log/ -name "*.log" -mtime +7 -delete

# Remove old core dump files
find /var/crash/ -name "core.*" -mtime +7 -delete

# Remove old package files
find /var/cache/apt/ -name "*.bin" -mtime +7 -delete

