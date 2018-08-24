#!/bin/bash
docker run -d  --net=host --env CONSUL_BIND_INTERFACE=eth0 --env CONSUL_LOCAL_CONFIG:="{\"leave_on_terminate\": true}" consul agent -retry-join 10.70.0.28  -recursor=169.254.169.250 -client=0.0.0.0
sleep 4
docker run -d  --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator consul://localhost:8500
