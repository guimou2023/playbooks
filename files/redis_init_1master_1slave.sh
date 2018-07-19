#!/bin/bash
# 配置主机IP及认证密码
IP1="10.20.0.19"
IP2="10.20.0.51"
IP3="10.20.0.86"
password="rediscluster123"

nc -z $IP1 6379
r1=$?
nc -z $IP2 6379
r2=$?
nc -z $IP3 6379
r3=$?

# 如果各主机redis单实例正常启动，创建集群
if [ $r1 = 0 ] && [ $r2 = 0 ] && [ $r3 = 0 ];then
sed -i  "/password =>/s/nil/'${password}'/" /var/lib/gems/2.3.0/gems/redis-4.0.1/lib/redis/client.rb
echo yes | redis-trib.rb create  $IP1:6379  $IP2:6379  $IP3:6379 
declare -A node_hash_dic
counter=1
info=`redis-cli -c -p 6379 -a "${password}"  cluster nodes| cut -d @ -f1 | sed 's/:6379//g'`
for i in $info
do
if [ "$((counter % 2))" -ne 0 ];then
value=${i}
else
key=${i}
node_hash_dic+=([${key}]=${value})
fi
let counter=${counter}+1
done

# echo ${node_hash_dic[${IP1}]}
# echo ${node_hash_dic[${IP2}]}
# echo ${node_hash_dic[${IP3}]}

redis-trib.rb add-node --slave --master-id ${node_hash_dic[${IP1}]}  ${IP2}:6380 127.0.0.1:6379
redis-trib.rb add-node --slave --master-id ${node_hash_dic[${IP2}]}  ${IP3}:6380 127.0.0.1:6379
redis-trib.rb add-node --slave --master-id ${node_hash_dic[${IP3}]}  ${IP1}:6380 127.0.0.1:6379

else
echo 'Some node is down.'
exit 1
fi
