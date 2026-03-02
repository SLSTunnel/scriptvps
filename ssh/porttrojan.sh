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
tr="$(cat ~/log-install.txt | grep -w "Trojan" | cut -d: -f2|sed 's/ //g')"
echo -e "======================================"
echo -e ""
echo -e "Change Port $tr"
echo -e ""
echo -e "======================================"
read -p "New Port Trojan : " tr2
if [ -z $tr2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tr2)
if [[ -z $cek ]]; then
sed -i "s/$tr/$tr2/g" /etc/xray/config.json
sed -i "s/   - XRAYS Trojan         : $tr/   - XRAYS Trojan         : $tr2/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tr -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tr -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tr2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tr2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray.service > /dev/null
echo -e "\e[032;1mPort $tr2 modified successfully\e[0m"
else
echo "Port $tr2 is used"
fi
