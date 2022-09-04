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
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/akun.conf")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
	echo ""
	echo "You have no existing clients!"
	exit 1
fi

echo ""
echo " Select the existing client you want to remove"
echo " Press CTRL+C to return"
echo " ===============================" | lolcat
echo "     No  Expired   User"
grep -E "^### " "/root/akun.conf" | cut -d ' ' -f 2-5 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
	if [[ ${CLIENT_NUMBER} == '1' ]]; then
		read -rp "Select one client [1]: " CLIENT_NUMBER
	else
		read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi
done
CLIENT_NAME=$(grep -E "^### " "/root/akun.conf" | cut -d ' ' -f 2-5 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^### " "/root/akun.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/root/akun.conf" | cut -d ' ' -f 3-5 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/d" /root/akun.conf
if getent passwd $user > /dev/null 2>&1; then
	userdel $user
	echo " SSH Account Deleted Successfully"
	echo " ==========================" | lolcat
	echo " Client Name : $user"
	echo " Expired On  : $exp"
	echo " ==========================" | lolcat
else
	echo -e "Failure: User $Pengguna Not Exist."
fi
