#!/bin/bash
cd /root
HOST_IP=`ip a|awk -F'/| '+ '/10.70.0/{print $3}'`
docker run -d --net=host --privileged \
  -e "MESOS_IP=${HOST_IP}" \
  -e "MESOS_HOSTNAME=${HOST_IP}" \
  -e MESOS_PORT=5051 \
  -e MESOS_MASTER=zk://10.70.0.137:2181,10.70.0.160:2181,10.70.0.161:2181/mesos  \
  -e MESOS_SWITCH_USER=0 \
  -e MESOS_CONTAINERIZERS=docker,mesos \
  -e MESOS_LOG_DIR=/var/log/mesos \
  -e MESOS_WORK_DIR=/var/tmp/mesos \
  -v "$(pwd)/log/mesos:/var/log/mesos" \
  -v "$(pwd)/tmp/mesos:/var/tmp/mesos" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /cgroup:/cgroup \
  -v /sys:/sys \
  -e "MESOS_SYSTEMD_ENABLE_SUPPORT=false" \
mesosphere/mesos-slave:1.5.0
