#!/bin/bash
sysctl -w vm.overcommit_memory=1
sysctl -w vm.swappiness=0
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag

echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
echo "vm.swappiness = 0" >> /etc/sysctl.conf
sed -i "20 i\echo never > /sys/kernel/mm/transparent_hugepage/enabled" /etc/rc.local
sed -i "20 i\echo never > /sys/kernel/mm/transparent_hugepage/defrag" /etc/rc.local
