#!/bin/bash

ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
domain=$(cat /etc/xray/domain)
echo -e "Selamat datang admin di Server $ISP\n  Silahkan ketik menu untuk pilihanmu\n   Script by Gugun09\n  Domain Wilcard : ${domain}" | boxes -d peek | lolcat

