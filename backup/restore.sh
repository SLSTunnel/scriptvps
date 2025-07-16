#!/bin/bash
# Enhanced Restore Script
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
clear
echo -e "${CYAN}Please wait, restore is in progress...${NC}"
echo "[$(date)] Starting restore" >> "$LOGFILE"
read -rp "Enter Google Drive file ID for restore: " fileid
wget -O restore.zip "https://drive.google.com/u/4/uc?id=${fileid}&export=download"
if [ ! -f restore.zip ]; then
  echo -e "${RED}Restore file not found!${NC}"
  echo "[$(date)] Restore failed: file not found" >> "$LOGFILE"
  exit 1
fi
unzip restore.zip > /dev/null 2>&1
cd backup
cp passwd /etc/
cp group /etc/
cp shadow /etc/
cp gshadow /etc/
cp -r wireguard /etc/
cp chap-secrets /etc/ppp/
cp passwd1 /etc/ipsec.d/passwd
cp ss.conf /etc/shadowsocks-libev/akun.conf
cp -r tarapkuhing /var/lib/
cp -r sstp /home/
cp -r xray /etc/
cp -r trojan-go /etc/
cp -r shadowsocksr /usr/local/
cp -r public_html /home/vps/
cd
rm -rf backup
rm -f restore.zip
clear
echo -e "${GREEN}Restore Complete!${NC}"
echo "[$(date)] Restore complete" >> "$LOGFILE"
echo -e "\n${yy}Restore log saved to $LOGFILE${wh}"
echo -e "\n\033[1;34mScriptVPS by RichBoyBrown | WA: 18765946096\033[0m"
echo -e "For help, select any menu or see the README.\n"
