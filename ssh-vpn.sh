#!/bin/bash
# By Gugun09
#
# ==================================================

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ifconfig.co);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=ID
state=Indonesia
locality=Indonesia
organization=wdkuvpn.tk
organizationalunit=wdkuvpn.tk
commonname=wdkuvpn.tk
email=gugun@wdkuvpn.tk

# simple password minimal
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/password"
chmod +x /etc/pam.d/common-password

# go to root
cd
touch /root/akun.conf
touch /root/hour.conf
# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

mkdir -p /etc/xray/

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# set repo
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
apt install gnupg gnupg1 gnupg2 -y
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y

# install wget and curl
apt -y install wget curl

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git
echo "clear" >> .profile
echo "neofetch | lolcat && welcomeadmin" >> .profile

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by Gugun09</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/vps.conf"
/etc/init.d/nginx restart

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config

# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid
cd
apt -y install squid3
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

# install webmin
apt install webmin -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
/etc/init.d/webmin restart

# install stunnel 4
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[stunnelws]
accept = 2053
connect = 127.0.0.1:443

[dropbear]
accept = 445
connect = 127.0.0.1:109

[dropbear]
accept = 990
connect = 127.0.0.1:109

[openvpn]
accept = 992
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

#install sslh
apt-get install sslh -y

# #konfigurasi
# #port 3127 to 443
wget -O /etc/default/sslh "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/sslh.conf"
service sslh restart

# colored text
apt-get -y install ruby
gem install lolcat

#install boxes
apt install boxes

# OpenVPN WebSocket
#port 1194 ( Dropbear) to 2086 (HTTP Websocket)
wget https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/wsovpn.sh && chmod +x wsovpn.sh && sed -i -e 's/\r$//' wsovpn.sh && ./wsovpn.sh && rm -f wsovpn.sh

#OpenVPN
wget https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/vpn.sh &&  chmod +x vpn.sh && sed -i -e 's/\r$//' vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# xml parser
cd
apt install -y libxml-parser-perl

# banner /etc/issue.net
wget -O /etc/issue.net "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/issue.net"
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

#install bbr dan optimasi kernel
wget https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

download script
cd /usr/bin
if [ -f "/home/email_cf.conf" ]; then
	wget -O add-host "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/add-cf.sh"
else
echo "Original Domain Script"
	wget -O add-host "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/add-host.sh"
fi
wget -O about "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/about.sh"
wget -O menu "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/menu.sh"
wget -O usernew "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/trial.sh"
wget -O htrial "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/htrial.sh"
wget -O hapus "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/hapus.sh"
wget -O member "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/member.sh"
wget -O delete "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/delete.sh"
wget -O cek "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/cek.sh"
wget -O restart "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/info.sh"
wget -O ram "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/ram.sh"
wget -O renew "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/renew.sh"
wget -O autokill "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/tendang.sh"
wget -O clear-log "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/clear-log.sh"
wget -O change-port "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/change.sh"
wget -O port-ovpn "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/port-ovpn.sh"
wget -O port-ssl "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/port-ssl.sh"
wget -O port-squid "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/port-squid.sh"
wget -O wbmn "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/webmin.sh"
wget -O running "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/running.sh"
wget -O welcomeadmin "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/welcomeadmin.sh"
wget -O xp-ssl "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/xp-ssl.sh"
wget -O xp-hour "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/xp-hour.sh"

# Untuk Panel ssh
wget -O addAccount "https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/addAccount.sh" && chmod +x addAccount

chmod +x add-host
chmod +x menu
chmod +x usernew
chmod +x trial
chmod +x htrial
chmod +x hapus
chmod +x member
chmod +x delete
chmod +x cek
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renew
chmod +x clear-log
chmod +x change-port
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-squid
chmod +x wbmn
chmod +x running
chmod +x welcomeadmin
chmod +x xp-ssl
chmod +x xp-hour
sed -i -e 's/\r$//' menu
sed -i -e 's/\r$//' addAccount

echo "0 4 * * * root clear-log && reboot" >> /etc/crontab
echo "0 0 * * * root xp-ssl" >> /etc/crontab
echo "* * * * * root xp-hour" >> /etc/crontab

cd
# remove unnecessary files
apt -y autoclean
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y

# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
/etc/init.d/vnstat restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/ssh-vpn.sh

# finihsing
cp domain /etc/xray/
clear
neofetch
netstat -nutlp

