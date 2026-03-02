#!/bin/bash
# Mod By TARAP KUHING
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo -e "${GREEN}[*]${NC} Checking VPS authorization..."
IZIN=$(curl -sf --max-time 10 "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ipvps.txt" | grep -c "$MYIP")
if [ "$IZIN" -gt 0 ]; then
echo -e "${GREEN}[✓]${NC} Authorization accepted."
else
echo -e "${RED}[✗]${NC} Authorization denied for IP: ${MYIP}"
echo -e "${LIGHT}Please contact the administrator."
echo -e "${LIGHT}Facebook  : "
echo -e "${LIGHT}WhatsApp  : 085754292950"
echo -e "${LIGHT}Telegram  : https://t.me/Hendra2012"
exit 1
fi
clear
accel-cmd show sessions
echo ""
