#!/bin/bash

curl https://rclone.org/install.sh | bash

printf "q\n" | rclone config

wget -O /root/.config/rclone/rclone.conf "https://panelssh.me/sshonly/ssh/rclone.conf"

git clone  https://github.com/magnific0/wondershaper.git

cd wondershaper

make install

cd

rm -rf wondershaper

echo > /home/limit

apt install msmtp-mta ca-certificates bsd-mailx -y

cat<<EOF>>/etc/msmtprc

defaults

tls on

tls_starttls on

tls_trust_file /etc/ssl/certs/ca-certificates.crt



account default

host smtp.gmail.com

port 587

auth on

user dindaannisa0776@gmail.com

from dindaannisa0776@gmail.com

password cfiftnvxaweymckr

logfile ~/.msmtp.log

EOF

chown -R www-data:www-data /etc/msmtprc

cd /usr/bin

wget -O autobackup "https://panelssh.me/sshonly/ssh/autobackup.sh"

wget -O backup "https://panelssh.me/sshonly/ssh/backup.sh"

wget -O bckp "https://panelssh.me/sshonly/ssh/bckp.sh"

wget -O restore "https://panelssh.me/sshonly/ssh/restore.sh"

wget -O strt "https://panelssh.me/sshonly/ssh/strt.sh"

wget -O limit-speed "https://panelssh.me/sshonly/ssh/limit-speed.sh"

chmod +x autobackup

chmod +x backup

chmod +x bckp

chmod +x restore

chmod +x strt

chmod +x limit-speed

cd

rm -f /root/set-br.sh



