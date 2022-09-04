#!/bin/bash

cd /root
echo "        Add ID Cloudlare "
echo ""
read -e -p " Masukan Domain :$domain" domain
read -e -p " Masukan Email Cloudflare :" email
read -e -p " Masukan Api Key :" key
echo -e "domain=$domain" >> /home/email_cf.conf
echo -e "email=$email" >> /home/email_cf.conf
echo -e "key=$key" >> /home/email_cf.conf
clear
echo "Done"
echo "Your ID Cloudflare"
echo -e "==============================="
echo "DOMAIN         : $domain"
echo "Email          : $email"
echo "Api Key        : $key"
echo -e "==============================="
