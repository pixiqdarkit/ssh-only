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
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		user_EXISTS=$(grep -w $user /root/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(wget -qO- icanhazip.com);
domain=$(cat /etc/xray/domain);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sshws="$(cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2)"
sslws="$(cat ~/log-install.txt | grep -w "SSL Websocket" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
sleep 1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $user
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $user
exp="$(chage -l $user | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "### $user $exp" >> /root/akun.conf
echo -e "$Pass\n$Pass\n"|passwd $user &> /dev/null
echo -e ""
echo -e "Thank You For Using Our Services"
echo -e "SSH/SSL Cloudflare & OpenVPN Account Info"
echo -e "Username       : $user "
echo -e "Password       : $Pass"
echo -e "===============================" | lolcat
echo -e "Host           : $IP"
echo -e "Domain WS      : $domain"
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "SSL/TLS        :$ssl"
echo -e "Port HTTP WS   :$sshws"
echo -e "Port SSL WS    :$sslws"
echo -e "Port Openvpn WS: 2086"
echo -e "Port Squid     :$sqd"
echo -e "===============================" | lolcat
echo -e "Payload Websocket"
echo -e "GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "===============================" | lolcat
echo -e "Payload SSL Websocket"
echo -e "GET wss://bug.com/ HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "===============================" | lolcat
echo -e "OpenVPN        : Openvpn Config http://$IP:81/Openvpn-Config.zip"
echo -e "badvpn         : 7100-7900"
echo -e "===============================" | lolcat
echo -e "Expired On     : $exp"
