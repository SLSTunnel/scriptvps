#!/bin/bash
# Advanced stunnel5 setup script for Ubuntu 20.04+ and Debian
# Idempotent, safe, and robust. Does NOT remove or overwrite user data.

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# 1. Detect OS and version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VER=$VERSION_ID
else
    echo -e "${RED}[ERROR] Cannot detect OS version.${NC}"
    exit 1
fi

if [[ "$OS" != "ubuntu" && "$OS" != "debian" ]]; then
    echo -e "${RED}[ERROR] This script supports Ubuntu and Debian only.${NC}"
    exit 1
fi

if [[ "$OS" == "ubuntu" && "${VER%%.*}" -lt 20 ]]; then
    echo -e "${RED}[ERROR] Ubuntu 20.04 or newer is required.${NC}"
    exit 1
fi

# 2. Install dependencies if missing
sudo apt-get update
sudo apt-get install -y unzip openssl

# Check for stunnel5 binary
if ! command -v stunnel5 >/dev/null 2>&1 && [ ! -x /usr/local/lamvpn/stunnel5 ]; then
    echo -e "${GREEN}[INFO] stunnel5 not found, attempting to install...${NC}"
    # Try to install from package or build from source
    if apt-cache show stunnel4 >/dev/null 2>&1; then
        sudo apt-get install -y stunnel4
        sudo ln -sf $(command -v stunnel4) /usr/local/lamvpn/stunnel5
    else
        echo -e "${RED}[ERROR] stunnel5/stunnel4 package not found. Please install manually or provide the binary at /usr/local/lamvpn/stunnel5.${NC}"
        exit 1
    fi
fi

STUNNEL_BIN="/usr/local/lamvpn/stunnel5"
if [ ! -x "$STUNNEL_BIN" ]; then
    echo -e "${RED}[ERROR] stunnel5 binary not found at $STUNNEL_BIN. Please install it first.${NC}"
    exit 1
fi

# 3. Ensure /etc/stunnel5 directory exists
sudo mkdir -p /etc/stunnel5

# 4. Copy config if not present
if [ ! -f /etc/stunnel5/stunnel5.conf ]; then
    if [ -f ./ssh/stunnel.conf ]; then
        sudo cp ./ssh/stunnel.conf /etc/stunnel5/stunnel5.conf
        echo -e "${GREEN}[INFO] Copied stunnel.conf to /etc/stunnel5/stunnel5.conf.${NC}"
    elif [ -f ./update/stunnel.conf ]; then
        sudo cp ./update/stunnel.conf /etc/stunnel5/stunnel5.conf
        echo -e "${GREEN}[INFO] Copied stunnel.conf to /etc/stunnel5/stunnel5.conf.${NC}"
    else
        echo -e "${RED}[ERROR] No stunnel.conf found in ./ssh or ./update.${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}[INFO] /etc/stunnel5/stunnel5.conf already exists. Not overwriting.${NC}"
fi

# 5. Ensure SSL certificate exists, generate if missing
if [ ! -f /etc/stunnel/stunnel.pem ]; then
    echo -e "${GREEN}[INFO] SSL certificate not found, generating self-signed cert...${NC}"
    sudo mkdir -p /etc/stunnel
    sudo openssl req -x509 -nodes -days 1095 -newkey rsa:2048 \
        -keyout /etc/stunnel/stunnel.key \
        -out /etc/stunnel/stunnel.crt \
        -subj "/C=ID/ST=Indonesia/L=Indonesia/O=akbarstorevpn/OU=akbarstorevpn/CN=akbarstorevpn/emailAddress=akbarssh21@gmail.com"
    sudo cat /etc/stunnel/stunnel.key /etc/stunnel/stunnel.crt | sudo tee /etc/stunnel/stunnel.pem >/dev/null
    sudo chmod 600 /etc/stunnel/stunnel.pem
    echo -e "${GREEN}[INFO] Self-signed SSL certificate generated at /etc/stunnel/stunnel.pem.${NC}"
else
    echo -e "${GREEN}[INFO] SSL certificate /etc/stunnel/stunnel.pem already exists. Not overwriting.${NC}"
fi

# 6. Ensure chroot directory exists and permissions are correct
sudo mkdir -p /var/run/stunnel
sudo chown nobody:nogroup /var/run/stunnel || true

# 7. Create systemd service if missing (for Ubuntu 20.04+)
if [ ! -f /etc/systemd/system/stunnel5.service ]; then
    echo -e "${GREEN}[INFO] Creating stunnel5 systemd service...${NC}"
    sudo tee /etc/systemd/system/stunnel5.service >/dev/null <<EOF
[Unit]
Description=stunnel5 Service
After=network.target

[Service]
Type=simple
ExecStart=$STUNNEL_BIN /etc/stunnel5/stunnel5.conf
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
    sudo systemctl daemon-reload
    sudo systemctl enable stunnel5
fi

# 8. Start stunnel5 service
sudo systemctl restart stunnel5

# 9. Status
sudo systemctl status stunnel5 --no-pager

# 10. Final message
if systemctl is-active --quiet stunnel5; then
    echo -e "${GREEN}[SUCCESS] stunnel5 is running and fully configured!${NC}"
else
    echo -e "${RED}[ERROR] stunnel5 failed to start. Check logs with: journalctl -u stunnel5${NC}"
    exit 1
fi 