# playbooks
## 部署redis cluster
```
# redis-cluster-hosts主机组中添加部署主机IP
vim hosts 
# 系统参数优化
ansible -i hosts redis-cluster-hosts -m -a script files/redis_init_system_conf.sh -f3
# 部署
ansible-playbook -i hosts redis-cluster-template.yml -f3
# 修改template配置文件后重启
ansible-playbook -i hosts redis-cluster-template.yml -f2 -tuc

```
