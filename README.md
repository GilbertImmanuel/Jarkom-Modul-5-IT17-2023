# Jarkom-Modul-5-IT17-2023

Laporan resmi dari modul kelima mata kuliah Komunikasi Data dan Jaringan Komputer IT ITS 2023.

## Authors

| NRP        | Nama                       |
| :--------  | :------------------------  |
| 5027211038 | Ahnaf Musyaffa             |
| 5027211056 | Gilbert Immanuel Hasiholan |

## Topologi

![image](https://github.com/GilbertImmanuel/Jarkom-Modul-5-IT17-2023/assets/100693191/8fb51d6b-0949-4d73-b260-a0e30a6cb8db)

### Rute

![image](https://github.com/GilbertImmanuel/Jarkom-Modul-5-IT17-2023/assets/100693191/0a2a1f8e-0d48-46a6-b004-992d30fcc3d7)

### Pembagian IP

![image](https://github.com/GilbertImmanuel/Jarkom-Modul-5-IT17-2023/assets/100693191/10880eae-5c3b-4db7-908f-ef1fd6330212)

## Konfigurasi
Berdasarkan subnetting yang telah kami buat, berikut merupakan konfigurasi dan routing untuk setiap node yang ada dalam topologi:

- Aura

```bash
auto eth0
iface eth0 inet dhcp
      
auto eth1
iface eth1 inet static
      address 10.72.14.129
      netmask 255.255.255.252
      
auto eth2
iface eth2 inet static
      address 10.72.14.133
      netmask 255.255.255.252
  
route add -net 10.72.0.0 netmask 255.255.248.0 gw 10.72.14.130
# A3
route add -net 10.72.8.0 netmask 255.255.252.0 gw 10.72.14.130
      
# A5
route add -net 10.72.14.136 netmask 255.255.255.252 gw 10.72.14.134
# A6
route add -net 10.72.14.140 netmask 255.255.255.252 gw 10.72.14.134
# A7
route add -net 10.72.12.0 netmask 255.255.254.0 gw 10.72.14.134
# A8
route add -net 10.72.14.0 netmask 255.255.255.128 gw 10.72.14.134
# A9
route add -net 10.72.14.144 netmask 255.255.255.252 gw 10.72.14.134
# A10
route add -net 10.72.14.148 netmask 255.255.255.252 gw 10.72.14.134
  ```

- Heiter

```bash
auto eth0
iface eth0 inet static
      address 10.72.14.130
      netmask 255.255.255.252
      gateway 10.72.14.129
      
auto eth1
iface eth1 inet static
      address 10.72.0.1
      netmask 255.255.248.0
      
auto eth2
iface eth2 inet static
      address 10.72.8.1
      netmask 255.255.252.0
  
# To Aura
route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.72.14.129
```

  **DHCP Relay →** DHCP Relay diberikan pada router yang berdekatan dengan client, yaitu pada `Heiter` dan `Himmel`

  ```bash
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
  ```

- Frieren

```bash
auto eth0
iface eth0 inet static
      address 10.72.14.134
      netmask 255.255.255.252
      gateway 10.72.14.133
      
auto eth1
iface eth1 inet static
      address 10.72.14.137
      netmask 255.255.255.252
      
auto eth2
iface eth2 inet static
      address 10.72.14.141
      netmask 255.255.255.252
  
# To Aura
route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.72.14.133
      
# A7
route add -net 10.72.12.0 netmask 255.255.254.0 gw 10.72.14.142
# A8
route add -net 10.72.14.0 netmask 255.255.255.128 gw 10.72.14.142
# A9
route add -net 10.72.14.144 netmask 255.255.255.252 gw 10.72.14.142
# A10
route add -net 10.72.14.148 netmask 255.255.255.252 gw 10.72.14.142
```

- Himmel

```bash
auto eth0
iface eth0 inet static
      address 10.72.14.130
      netmask 255.255.255.252
      gateway 10.72.14.129
      
auto eth1
iface eth1 inet static
      address 10.72.0.1
      netmask 255.255.248.0
      
auto eth2
iface eth2 inet static
      address 10.72.8.1
      netmask 255.255.252.0
  
# To Aura
route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.72.14.129

# A7
route add -net 10.72.12.0 netmask 255.255.254.0 gw 10.72.14.142
# A8
route add -net 10.72.14.0 netmask 255.255.255.128 gw 10.72.14.142
# A9
route add -net 10.72.14.144 netmask 255.255.255.252 gw 10.72.14.142
# A10
route add -net 10.72.14.148 netmask 255.255.255.252 gw 10.72.14.142
```

  **DHCP Relay →** DHCP Relay diberikan pada router yang berdekatan dengan client, yaitu pada `Heiter` dan `Himmel`

  ```bash
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
  ```

- Fern

```bash
auto eth0
iface eth0 inet static
      address 10.72.14.2
      netmask 255.255.255.128
      gateway 10.72.14.1
      
auto eth1
iface eth1 inet static
    address 10.72.14.145
    netmask 255.255.255.252
      
auto eth2
iface eth2 inet static
    address 10.72.14.149
    netmask 255.255.255.252
      
# To Himmel
route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.72.14.1
```

- Revolte

```bash
auto eth0
iface eth0 inet static
      address 10.72.14.150
      netmask 255.255.255.252
      gateway 10.72.14.149
```

  Revolte juga berperan menjadi `DHCP Server`, dengan tambahan konfigurasi sebagai berikut :

  ```bash
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
  ```

- Richter

```bash
auto eth0
iface eth0 inet static
      address 10.72.14.146
      netmask 255.255.255.252
      gateway 10.72.14.145
```

  Ritcher juga berperan menjadi `DNS Server`, dengan tambahan konfigurasi sebagai berikut :

  ```bash
      echo 'nameserver 192.168.122.1' >/etc/resolv.conf
        
        apt get-update
        apt get-install netcat -y
        apt get-install bind9 -y
        
        echo '
        options {
          directory "/var/cache/bind";
          forwarders { 192.168.122.1; };
          allow-query { any; };
          auth-nxdomain no; // conform to RFC1035
          listen-on-v6 { any; };
        };' > /etc/bind/named.conf.options
  ```

- Stark

```bash
auto eth0
iface eth0 inet static
      address 10.72.14.138
      netmask 255.255.255.252
      gateway 10.72.14.137
```

  Stark juga berperan menjadi `Web Server`, dengan tambahan konfigurasi sebagai berikut : 

  ```bash
      echo 'nameserver 192.168.122.1' > /etc/resolv.conf
      
      apt update
      apt install netcat -y
      apt install apache2 -y
      service apache2 start
      
      echo '# If you just change the port or add more ports here, you will likely also
      # have to change the VirtualHost statement in
      # /etc/apache2/sites-enabled/000-default.conf
      
      Listen 80
      Listen 443
      
      <IfModule ssl_module>
              Listen 443
      </IfModule>
      
      <IfModule mod_gnutls.c>
              Listen 443
      </IfModule>
      
      # vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf
  ```

  Lalu pada `/var/www/html/index.html` ditambahkan berikut : 

  ```bash
  echo 'Selamat datang di Web Server - Stark!' > /var/www/html/index.html
  ```

- Sein

```bash
auto eth0
iface eth0 inet static
      address 10.72.8.2
      netmask 255.255.252.0
      gateway 10.72.8.1
```

  Sein juga berperan menjadi `Web Server`, dengan tambahan konfigurasi sebagai berikut :

  ```bash
      echo 'nameserver 192.168.122.1' > /etc/resolv.conf
      
      apt update
      apt install netcat -y
      apt install apache2 -y
      service apache2 start
      
      echo '# If you just change the port or add more ports here, you will likely also
      # have to change the VirtualHost statement in
      # /etc/apache2/sites-enabled/000-default.conf
      
      Listen 80
      Listen 443
      
      <IfModule ssl_module>
              Listen 443
      </IfModule>
      
      <IfModule mod_gnutls.c>
              Listen 443
      </IfModule>
      
      # vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf
  ```

  Lalu pada `/var/www/html/index.html` ditambahkan berikut : 

  ```bash
  echo 'Selamat datang di Web Server - Sein!' > /var/www/html/index.html
  ```

- Client

```bash
auto eth0
iface eth0 inet dhcp
```
