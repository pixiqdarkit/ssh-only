#!/bin/bash
if [[ -e /etc/debian_version ]]; then
  OS=debian
  RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
  OS=centos
  RCLOCAL='/etc/rc.d/rc.local'
  chmod +x /etc/rc.d/rc.local
else
  echo "It looks like you are not running this installer on Debian, Ubuntu or Centos system"
  exit
fi
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
MYIP=$(wget -qO- icanhazip.com);

clear
echo -e ""
echo -e "================-Welcome To Premium Script Menu-================" | lolcat
    echo "----------------- Moded By Gugun09 --------------------"
  cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
  cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
  freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
  tram=$( free -m | awk 'NR==2 {print $2}' )
  swap=$( free -m | awk 'NR==4 {print $2}' )
  up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')

  echo -e "\e[032;1mCPU Model:\e[0m $cname"
  echo -e "\e[032;1mNumber Of Cores:\e[0m $cores"
  echo -e "\e[032;1mCPU Frequency:\e[0m $freq MHz"
  echo -e "\e[032;1mTotal Amount Of RAM:\e[0m $tram MB"
  echo -e "\e[032;1mTotal Amount Of Swap:\e[0m $swap MB"
  echo -e "\e[032;1mSystem Uptime:\e[0m $up"
  echo "================================================================="
  echo ""
echo -e "=========================-SSH & OpenVPN-========================" | lolcat
echo -e "${color1}1${color3}.Create SSH & OpenVPN Account (${color2}usernew${color3})"
echo -e "${color1}2${color3}.Generate SSH & OpenVPN Trial Account (${color2}trial${color3})"
echo -e "${color1}3${color3}.Extending SSH & OpenVPN Account Active Life (${color2}renew${color3})"
echo -e "${color1}4${color3}.Delete SSH & OpenVPN Account (${color2}hapus${color3})"
echo -e "${color1}5${color3}.Check User Login SSH & OpenVPN (${color2}cek${color3})"
echo -e "${color1}6${color3}.Daftar Member SSH & OpenVPN (${color2}member${color3})"
echo -e "${color1}7${color3}.Delete User Expired SSH & OpenVPN (${color2}delete${color3})"
echo -e "${color1}8${color3}.Set up Autokill SSH (${color2}autokill${color3})"
echo -e "${color1}9${color3}.Displays Users Who Do Multi Login SSH (${color2}ceklim${color3})"
echo -e "${color1}10${color3}.Restart Service Dropbear, Squid3, OpenVPN dan SSH (${color2}restart${color3})"
echo -e ""
echo -e "=============================-SYSTEM-==========================" | lolcat
echo -e "${color1}11${color3}.Check Your Service Running (${color2}running${color3})"
echo -e "${color1}12${color3}.Add Or Change Subdomain Host For VPS (${color2}add-host${color3})"
echo -e "${color1}13${color3}.Change Port Of Some Service (${color2}change-port${color3})"
echo -e "${color1}14${color3}.Autobackup Data VPS (${color2}autobackup${color3})"
echo -e "${color1}15${color3}.Backup Data VPS (${color2}backup${color3})"
echo -e "${color1}16${color3}.Restore Data VPS (${color2}restore${color3})"
echo -e "${color1}17${color3}.Webmin Menu (${color2}wbmn${color3})"
echo -e "${color1}18${color3}.Update To Latest Kernel (${color2}kernel-updt${color3})"
echo -e "${color1}19${color3}.Limit Bandwith Speed Server (${color2}limit-speed${color3})"
echo -e "${color1}20${color3}.Check Usage of VPS Ram (${color2}ram${color3})"
echo -e "${color1}21${color3}.Reboot VPS (${color2}reboot${color3})"
echo -e "${color1}22${color3}.Speedtest VPS (${color2}speedtest${color3})"
echo -e "${color1}23${color3}.Update To Latest Script Version (${color2}update${color3})"
echo -e "${color1}24${color3}.Displaying System Information (${color2}info${color3})"
echo -e "${color1}25${color3}.Info Script Auto Install (${color2}about${color3})"
echo -e "${color1}0${color3}.Exit Menu VPS (${color2}exit${color3})"
echo -e ""
echo -e "===============================================================" | lolcat
read -p "Choose an option from (1-69): " x
case $x in
1)
usernew
;;
2)
trial
;;
3)
renew
;;
4)
hapus
;;
5)
cek
;;
6)
member
;;
7)
delete
;;
8)
autokill
;;
9)ceklim
;;
10)
restart
;;
11)
running
;;
12)
add-host
;;
13)
change-port
;;
14)
autobackup
;;
15)
backup
;;
16)
restore
;;
17)
wbmn
;;
18)
kernel-updt
;;
19)
limit-speed
;;
20)
ram
;;
21)
reboot
;;
22)
speedtest
;;
23)
update
;;
24)
info
;;
25)
about
;;
0)
clear
echo "Goodbye Menu!"
echo "Please Wait..."
sleep 3
clear
neofetch
welcomeadmin
exit
;;
*)
clear
echo "Back to menu"
echo "Please Wait..."
menu
;;
esac
