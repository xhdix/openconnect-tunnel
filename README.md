# openconnect-tunnel
Tunnel server to server in Debian
- To route from server A to server B 
- IP Server A is displayed for the final service.
- Server B == Gateway

In server A
```
ip addr show | awk '/inet/ {print $2}' | grep -v "127.0.0.1" | grep -v "::" | cut -f1 -d"/"
==
curl https://ipinfo.io/ip
```
