#!/bin/bash
# AutoScript By Gugun09
# ======================

useradd -e `date -d "$3" +"%Y-%m-%d"` -s /bin/false -M $1
exp="$(chage -l $1 | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "### $1 $exp" >> /root/akun.conf
echo -e "$2\n$2\n"|passwd $1 &> /dev/null

