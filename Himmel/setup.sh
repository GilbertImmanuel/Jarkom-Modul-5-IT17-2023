# To Frieren
route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.72.14.141

# A9
route add -net 10.72.14.144 netmask 255.255.255.252 gw 10.72.14.2
# A10
route add -net 10.72.14.148 netmask 255.255.255.252 gw 10.72.14.2

echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt update
apt install netcat -y
apt install isc-dhcp-relay -y

echo '
SERVERS="10.72.14.150"
INTERFACES="eth0 eth1 eth2 eth3"
OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

service isc-dhcp-relay restart

## Command Testing Port 80 > Sein > while true; do nc -l -p 80 -c 'echo "ini sein"'; done
##                 Port 80 > Stark > while true; do nc -l -p 80 -c 'echo "ini stark"'; done
##                 Port 443 > Sein > while true; do nc -l -p 443 -c 'echo "ini sein"'; done
##                 Port 443 > Stark > while true; do nc -l -p 443 -c 'echo "ini stark"'; done
## Testing Command > Client - Sein & Stark : nc 10.72.8.2 80
##                 > Client - Sein & Stark : nc 10.72.14.138 443
## Nomor 7
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.72.8.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.72.8.2

iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.72.8.2 -j DNAT --to-destination 10.72.14.138

iptables -A PREROUTING -t nat -p tcp --dport 443 -d 10.72.14.138 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.72.14.138

iptables -A PREROUTING -t nat -p tcp --dport 443 -d 10.72.14.138 -j DNAT --to-destination 10.72.8.2

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10

