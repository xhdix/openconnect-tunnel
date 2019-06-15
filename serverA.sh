#!/bin/bash
### pre-alpha version for openconnect installer in Debian
###-- To route from server A to server B 
###-- IP Server A is displayed for the final service.
###
### bash serverA.sh ADDRESS USERNAME PASSWORD

###### Main

ADDRESS=""
USERNAME=""
PASSWORD=""

ADDRESS=$1
USERNAME=$2
PASSWORD=$3

if [[ $PASSWORD == "" ]] ; then
  echo "run:\n bash serverA.sh ADDRESS USERNAME PASSWORD"
  exit
fi

apt update
apt dist-upgrade -y
apt install openconnect -y


cat > /etc/systemd/system/ocvpn.service << "EOF"
[Unit]
Description=Connect to my VPN
After=network.target

[Service]
Type=simple
ExecStart=/bin/sh -c 'echo password | openconnect -u username --passwd-on-stdin address'
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sed -i "s~password~$PASSWORD~" /etc/systemd/system/ocvpn.service
sed -i "s~username~$USERNAME~" /etc/systemd/system/ocvpn.service
sed -i "s~address~$ADDRESS~" /etc/systemd/system/ocvpn.service

systemctl daemon-reload
systemctl enable ocvpn
systemctl start ocvpn

systemctl status ocvpn
