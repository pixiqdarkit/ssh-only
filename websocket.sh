#!/bin/bash
# Proxy For Edukasi & Imclass
# Proxy For Telkomsel Opok
# ==============================
clear
echo Installing Websocket-SSH Python
sleep 1
echo Cek Hak Akses...
sleep 0.5
cd
cd /usr/local/bin/
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/ws-stunnel
chmod +x /usr/local/bin/ws-stunnel

# Installing Service
cat > /etc/systemd/system/ws-stunnel.service << END
[Unit]
Description=Python Edu Proxy By Gugun Service
Documentation=https://queen-ssh.my.id
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-stunnel
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
#Enable & Start & Restart ws-stunnel service
systemctl enable ws-stunnel.service
systemctl restart ws-stunnel.service
