#!/bin/bash
# Enhanced Backup Script
# Mod By TARAP KUHING, Enhanced by RichBoyBrown
# ==========================================
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
LOGFILE="/var/log/backup.log"
# ==========================================
# Getting
clear
IP=$(wget -qO- ipinfo.io/ip)
date=$(date +"%Y-%m-%d")
clear
email=$(cat /home/email 2>/dev/null)
if [[ "$email" = "" ]]; then
  echo -e "${ORANGE}Enter your email to receive backup:${NC}"
  read -rp "Email : " -e email
  echo "$email" > /home/email
fi
clear
echo -e "${CYAN}Please wait, backup is in progress...${NC}"
echo "[$(date)] Starting backup for $IP" >> "$LOGFILE"
rm -rf /root/backup
mkdir /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /etc/wireguard backup/wireguard
cp /etc/ppp/chap-secrets backup/chap-secrets
cp /etc/ipsec.d/passwd backup/passwd1
cp /etc/shadowsocks-libev/akun.conf backup/ss.conf
cp -r /var/lib/tarapkuhing/ backup/tarapkuhing
cp -r /home/sstp backup/sstp
cp -r /etc/xray backup/xray
cp -r /etc/trojan-go backup/trojan-go
cp -r /usr/local/shadowsocksr/ backup/shadowsocksr
cp -r /home/vps/public_html backup/public_html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "\nDetail Backup\n==================================\nIP VPS        : $IP\nLink Backup   : $link\nTanggal       : $date\n==================================\n" | mail -s "Backup Data" $email
echo "[$(date)] Backup complete for $IP, link: $link" >> "$LOGFILE"
rm -rf /root/backup
rm -r /root/$IP-$date.zip
clear
echo -e "${GREEN}Backup Complete!${NC}"
echo -e "\n${BLUE}Detail Backup${NC}\n==================================\nIP VPS        : $IP\nLink Backup   : $link\nTanggal       : $date\n==================================\n"
echo -e "Check your inbox: ${ORANGE}$email${NC}"
echo -e "\n${yy}Backup log saved to $LOGFILE${wh}"
echo -e "\n\033[1;34mScriptVPS by RichBoyBrown | WA: 18765946096\033[0m"
echo -e "For help, select any menu or see the README.\n"
