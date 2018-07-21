#!/bin/bash
## 内存使用相关 ##
sysctl -w vm.overcommit_memory=1
sysctl -w vm.swappiness=0
echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
echo "vm.swappiness = 0" >> /etc/sysctl.conf
## 禁用透明大页 ##
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
sed -i "20 i\echo never > /sys/kernel/mm/transparent_hugepage/enabled" /etc/rc.local
sed -i "20 i\echo never > /sys/kernel/mm/transparent_hugepage/defrag" /etc/rc.local
## 网络优化 ##
sysctl -w net.core.somaxconn=65535
sysctl -w net.ipv4.tcp_max_syn_backlog=65536
echo "net.core.somaxconn=65535"  >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog=65536" >> /etc/sysctl.conf
## 打开文件数 ##
ulimit -n 288000
sed -i '/^root/d' /etc/security/limits.conf
sed -i "$ a\root soft nofile 288000\nroot hard nofile 288000"  /etc/security/limits.conf
