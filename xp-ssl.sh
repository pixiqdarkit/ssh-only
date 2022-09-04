#!/bin/bash
data=( `cat /root/akun.conf | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/root/akun.conf" | cut -d ' ' -f 3-5)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/d" "/root/akun.conf"
if getent passwd $user > /dev/null 2>&1; then
        userdel $user
fi
fi
done
systemctl restart stunnel5
