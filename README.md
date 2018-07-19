# playbooks
## 部署redis cluster
```
# redis-cluster-hosts主机组中添加部署主机IP
vim hosts 
# 系统参数优化
ansible -i hosts redis-cluster-hosts -m script -a files/redis_init_system_conf.sh -f3
# 部署单实例
ansible-playbook -i hosts redis-cluster-template.yml -f3
# 初始化一主一从集群（运行前把主机IP写入redis_init_1master_1slave.sh）
ansible -i hosts IP -m script -a files/redis_init_1master_1slave.sh
# 初始化一主二从集群（运行前把主机IP写入redis_init_1master_2slave.sh）
ansible -i hosts IP -m script -a files/redis_init_1master_2slave.sh
# 修改template配置文件后重启
ansible-playbook -i hosts redis-cluster-template.yml -f2 -tuc

```
