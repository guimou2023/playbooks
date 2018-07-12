#!/bin/bash
for i in `find /var/lib/docker/ -size +1G -exec ls {} \; | grep -e *log.log -e stdout`;do > $i;done
for i in `find /root -size +1G -exec ls {} \; | grep -e *log.log -e stdout`;do > $i;done
