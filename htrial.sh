#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
IZIN=$( wget -qO- icanhazip.com | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}PermissionAccepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}"
echo -e "Please Contact Admin"
echo -e "+6281357879215"
rm -f setup.sh
exit 0
fi
clear
IP=$(wget -qO- icanhazip.com);
domain=$(cat /etc/xray/domain);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sshws="$(cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2)"
sslws="$(cat ~/log-install.txt | grep -w "SSL Websocket" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
Login=30menit`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
hour=$(date -d "30 minute" +"%Y-%m-%d %H:%M:%S")
useradd -e `date -d "$hari day" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "### $Login $hour" >> /root/hour.conf
now=$(date +"%Y-%m-%d %H:%M:%S")
exp2=$(grep -w "^### $Login" "/root/hour.conf" | cut -d ' ' -f 3-5)
d1=$(date -d "$exp2" +%s)
d2=$(date -d "$now" +%s)
exp3=$(( (d1 - d2) / 60 ))
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Informasi Trial 30 Menit SSH/SSL Cloudflare & OpenVPN"
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "===============================" | lolcat
echo -e "Host           : $IP"
echo -e "Domain WS      : $domain"
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "SSL/TLS        : $ssl"
echo -e "Port HTTP WS   : $sshws"
echo -e "Port SSL WS    : $sslws"
echo -e "Port Squid     : $sqd"
echo -e "===============================" | lolcat
echo -e "Payload SSH Websocket"
echo -e "GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================="
echo -e "OpenVPN        : ALL http://$IP:81/VPN-Config.zip"
echo -e "badvpn         : 7100-7900"
echo -e "===============================" | lolcat
echo -e "Aktif Sampai   : $exp3 Menit"

