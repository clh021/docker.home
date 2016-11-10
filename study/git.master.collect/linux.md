# 服务器初始化配置
```
#添加管理员用户
adduser username #设置复杂的密码
gpasswd -a username sudo
#禁用root远程登录
nano /etc/ssh/sshd_config
PermitRootLogin yes #yes 改为 no
Port 22 #22 改为 您想要的端口
service ssh restart
#个人平时多半网络办公，常周旋与电脑、平板、手机来办公，所以暂不配置秘钥
```
