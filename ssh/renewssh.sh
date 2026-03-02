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
read -p "Username : " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Day Extend : " Days
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e ""
echo -e "========================================"
echo -e ""
echo -e "    Username        :  $User"
echo -e "    Days Added      :  $Days Days"
echo -e "    Expires on      :  $Expiration_Display"
echo -e ""
echo -e "========================================"
else
clear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "        Username Doesnt Exist        "
echo -e ""
echo -e "======================================"
fi
