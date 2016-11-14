## 服务器初始化配置
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
## 添加磁盘、格式化好并挂载
```
df -l #查看已经在使用的硬盘
fdisk -l #查看所有硬盘，发现没有在使用的
fdisk /dev/xvdb #找到没有在使用的硬盘 通过 n 来按照提示创建分区
fdisk -l #查看分区情况是否符合自己的想法，如果不对就重复上面的步骤
mkfs.ext4 /dev/xvdb1 #格式化好你的硬盘，创建文件系统
vi /etc/fstab #设置开机启动 "/dev/xvdb1    /mnt    ext4    defaults    0    0"
mount /dev/xvdb1 /mnt #或者手动挂载
```

日常使用
```
#安装中文字体
sudo apt-get install fonts-wqy-zenhei
#.bashrc末尾
PS1='\[\e[32m\]\# [\e[33m\D{%Y-%m-%d %T}]\[\e[31m\]\u\[\e[m\]@shenzhen\[\e[36m\]\h\[\e[32m\]\w\[\e[m\]\n\$ '
```
