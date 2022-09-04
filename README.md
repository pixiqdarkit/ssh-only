# AUTOSCRIPT QUEENSSH
- Script Mod by Gugun
<hr>
<br><br>
- apt update && apt upgrade -y --fix-missing && update-grub && sleep 2 && reboot
<br><br>
- sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/setup.sh && chmod +x setup.sh && screen -S setup ./setup.sh
<br><br>
