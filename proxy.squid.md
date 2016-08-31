#Set Proxy Use Squid
---------------------------------
ubuntu16.04 source aliyuncs.com
##Install Squid
```
apt update && apt-get install squid
```
Config Squid file:///etc/squid3/squid.conf
```
http_port 3128 #which port you think is safy
acl localnet src 192.168.XXX.0/255.255.255.0 #your ip or you want net ips
#http_access allow localnet #uncomment this line
```
Restart Squid
```
service squid3 restart
```
---------------------------------
##Use it service
