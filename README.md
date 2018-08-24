# playbooks
## role部署redis cluster(On ubuntu 14.04 or ubuntu 16.04)
```
git clone git@github.com:wuwuming/playbooks.git
cd playbook
# redis-cluster-hosts主机组中配置待部署主机IP及认证秘钥
vim hosts 
# 系统参数优化(修改了部分优化redis的系统参数)
ansible -i hosts redis-cluster-hosts -m script -a files/redis_init_system_conf.sh -f3
# 部署单实例
ansible-playbook -i hosts redis-cluster-template.yml -f3
# 初始化一主一从集群（运行前把主机IP及认证密码写入redis_init_1master_1slave.sh）
IP=10.20.0.19
ansible -i hosts $IP -m script -a files/redis_init_1master_1slave.sh
# 初始化一主二从集群（运行前把主机IP及认证密码写入redis_init_1master_2slave.sh）
ansible -i hosts IP -m script -a files/redis_init_1master_2slave.sh
# 修改template配置文件后重启
ansible-playbook -i hosts redis-cluster-template.yml -f2 -tuc

```
## 清理垃圾日志定时任务
```
ansible all -m copy -a 'src=files/clean_log.sh dest=/tmp' -f10
ansible tx-saas-hosts -m cron -a "name='clean log and stdoutFile' hour=2 minute=30 user=root job='/bin/bash /tmp/clean_log.sh'"
ansible tx-o-hosts -m cron -a "name='clean log and stdoutFile' hour=2 minute=30 user=root job='/bin/bash /tmp/clean_log.sh'"
```
## 发布mesos-agent
```
确定目标主机组并配置认证方式、修改脚本中mesosServerIp
ansible -i hosts test -m script -a 'files/deploy_mesos_agent.sh' -f15
```
## 修改主机名
```
修改yml文件中目标主机组及主机名格式
ansible-playbook -i hosts change_hostname.yml -f15
```
