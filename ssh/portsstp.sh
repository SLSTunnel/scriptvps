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
echo -e "${LIGHT}WhatsApp  : 8765946096"
echo -e "${LIGHT}Telegram  : https://t.me/OfficialRichBoyBrown"
exit 1
fi
clear
sstp="$(cat ~/log-install.txt | grep -i SSTP | cut -d: -f2|sed 's/ //g')"
echo -e "======================================"
echo -e ""
echo -e "Change Port $sstp"
echo -e ""
echo -e "======================================"
read -p "New Port sstp : " sstp2
if [ -z $sstp2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $sstp2)
if [[ -z $cek ]]; then
sed -i "s/$sstp/$sstp2/g" /etc/accel-ppp.conf
sed -i "s/   - SSTP VPN                : $sstp/   - SSTP VPN                : $sstp2/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $sstp -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $sstp -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $sstp2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $sstp2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart accel-ppp> /dev/null
echo -e "\e[032;1mPort $sstp2 modified successfully\e[0m"
else
echo "Port $sstp2 is used"
fi
