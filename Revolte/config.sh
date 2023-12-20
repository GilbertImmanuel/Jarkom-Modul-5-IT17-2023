echo '
# A3
subnet 10.72.8.0 netmask 255.255.252.0 {
  range 10.72.8.2 10.72.11.254;
  option routers 10.72.8.1;
  option broadcast-address 10.72.11.255; 
  option domain-name-servers 10.72.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A2
subnet 10.72.0.0 netmask 255.255.248.0 {
  range 10.72.0.2 10.72.7.254;
  option routers 10.72.0.1;
  option broadcast-address 10.72.7.255;
  option domain-name-servers 10.72.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A7
subnet 10.72.12.0 netmask 255.255.254.0 {
  range 10.72.12.2 10.72.13.254;
  option routers 10.72.12.1;
  option broadcast-address 10.72.13.255;
  option domain-name-servers 10.72.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A8
subnet 10.72.14.0 netmask 255.255.255.128 {
  range 10.72.14.2 10.72.14.126;
  option routers 10.72.14.1;
  option broadcast-address 10.72.14.127;
  option domain-name-servers 10.72.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A1
subnet 10.72.14.128 netmask 255.255.255.252 {}

# A4
subnet 10.72.14.132 netmask 255.255.255.252 {}

# A5
subnet 10.72.14.136 netmask 255.255.255.252 {}

# A6
subnet 10.72.14.140 netmask 255.255.255.252 {}

# A9
subnet 10.72.14.144 netmask 255.255.255.252 {}

# A10
subnet 10.72.14.148 netmask 255.255.255.252 {}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server start

## Test Command > Revolte : nc -l -p 8080
##                          nc -u -l -p 8080
##                          nc -l -p 5000
## Test Command > Client  : nc 10.72.14.150 8080
##                          nc -u 10.72.14.150 8080
##                          nc 10.72.14.150 5000

### Nomor 2
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -j DROP
iptables -A INPUT -p udp -j DROP

## Test Command > Ping 3+ ke 10.72.14.150(DHCP), 10.72.14.146(DNS)
## Nomor 3
iptables -I INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10