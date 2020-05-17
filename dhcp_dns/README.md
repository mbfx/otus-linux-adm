### DHCP

Как получить IPv6 DUID:

1. на клиенте до получения адреса:
```bash
cat /var/lib/NetworkManager/dhclient6-9c92fad9-6ecb-3e6c-eb4d-8a47c6f50c04-eth1.lease | grep default-duid
...
printf "\000\004\224\177\027\316(2\254\224O\335\223\024\030\016\245\371" | hexdump -e '14/1 "%02x " "\n"' | sed 's/ /:/g'
```
2. на клиенте после получения адреса:
```bash
cat /var/lib/NetworkManager/dhclient6-9c92fad9-6ecb-3e6c-eb4d-8a47c6f50c04-eth1.lease | grep dhcp6.client-id
```
3. захватив трафик и проанализировав содержимое пакетов DHCPv6.

