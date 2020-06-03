### Стенд для занятия по bridge/tunnel/VPN

##### TODO
 - дописать README

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
