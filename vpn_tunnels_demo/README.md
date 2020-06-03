### Стенд для занятия по bridge/tunnel/VPN

Попробуйте настроить разные туннели ориентируясь на приведенную ниже схему.
Конечная маршрутизация должна работать во все стороны. Доступ в Интернет обеспечивать необязательно, но приветствуется.

![](docs/vpn.png)

### Пример конфигурации bridge
```
brctl addbr bridge0
brctl addif bridge0 eth0
ip link set up dev bridge0
brctl show
```
или так:
```
ip link add name bridge0 type bridge
ip link set bridge0 up
ip link set eth0 up
ip link set eth0 master bridge0
bridge link
```
или файлами:
![](provisioning/templates/ifcfg-bridge0.j2)
![](provisioning/templates/ifcfg-eth1.j2)


### Пример конфигурации GRE

```
modprobe ip_gre
ip tunnel add tun0 mode gre remote <REMOTE_IP> local <LOCAL_IP> dev eth0
ip address add <TUNNEL_LOCAL_IP>/<TUNNEL_LOCAL_NETMASK> dev tun0
ifconfig tun0 mtu 1476 up
```

### Пример конфигурации OpenVPN

Сервер:
```
daemon
mode server
port 10000
proto udp
dev tap
ca ca.crt
cert 10.0.0.3.crt 
key 10.0.0.3.key
dh dh.pem
server 172.16.0.0 255.255.255.0
route 192.168.3.0 255.255.255.0
push "route 192.168.3.0 255.255.255.0"
ifconfig-pool-persist ipp.txt
keepalive 10 120
max-clients 32
client-to-client
persist-key
persist-tun
status /var/log/openvpn/openvpn-status.log
log-append /var/log/openvpn/openvpn.log
verb 4
mute 20
```

Клиент:
```
client
remote 10.0.0.3
port 10000
proto udp
dev tap
keepalive 10 120
status /var/log/openvpn/openvpn-status.log
log-append /var/log/openvpn/openvpn.log
verb 4
mute 20
<ca>
</ca>
<cert>
</cert>
<key>
</key>
<dh>
</dh>
```

### Пример конфигурации IPSec для libreswan

![](provisioning/templates/r2-ipsec.d.conf.j2)
![](provisioning/templates/r2-ipsec.d.secrets.j2)
![](provisioning/templates/ipsec.conf.j2)