#!/bin/bash
#清理大于1G,以.log或stdout结尾的文件
for i in `find /var/lib/docker/ -size +1G -exec ls {} \; | grep -e \.log$ -e stdout$`;do > $i;done
for i in `find /root -size +1G -exec ls {} \; | grep -e \.log$ -e stdout$`;do > $i;done
