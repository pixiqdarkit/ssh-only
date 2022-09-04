#!/bin/bash
# Proxy For Edukasi & Imclass
# Proxy For Telkomsel Opok
# ==============================
clear
echo Installing OpenVpn Websocket Python
sleep 1
echo Cek Hak Akses...
sleep 0.5
cd
cd /usr/local/bin/
wget -O /usr/local/bin/ws-ovpn https://raw.githubusercontent.com/pixiqdarkit/ssh-only/main/ws-ovpn.py
chmod +x /usr/local/bin/ws-ovpn

# Installing Service
cat > /etc/systemd/system/ws-ovpn.service << END
[Unit]
Description=Python Edu Websocket Ovpn Proxy By Gugun09
Documentation=https://migtunnel.com
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-ovpn
Restart=on-failure
[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
#Enable & Start & Restart ws-ovpn service
systemctl enable ws-ovpn.service
systemctl restart ws-ovpn.service
