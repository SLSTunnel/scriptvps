#!/bin/bash
# Enhanced XRAY (Vmess) Menu

m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'

status_color() {
  if systemctl is-active --quiet xray; then
    echo -e "${GREEN}RUNNING${wh}"
  else
    echo -e "${RED}STOPPED${wh}"
  fi
}

XRAY_STATUS=$(status_color)

clear
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m                 ⇱ VMESS ⇲                    \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " XRAY Service: $XRAY_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "\033[1;33m 1. Create Account XRAYS Vmess Websocket\033[1;33m"
echo -e   "\033[0;34m 2. Delete Account XRAYS Vmess Websocket\033[0;34m"
echo -e   "\033[1;33m 3. Extending Account XRAYS Vmess Active Life\033[1;33m"
echo -e   "\033[0;34m 4. Check User Login XRAYS Vmess\033[0;34m"
echo -e   "\033[1;33m 5. Renew Certificate XRAYS Account\033[1;33m"
echo -e   "\033[0;34m 6. Menu\033[0;34m"
echo -e   "\033[1;33m 7. Exit\033[1;33m"
echo -e   "\033[0;34m 8. View XRAY Logs\033[0;34m"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p   "Select From Options [ 1 - 8 ] : " menu
echo -e   ""
case $menu in
1)
addvmess
;;
2)
delvmess
;;
3)
renewvmess
;;
4)
cekvmess
;;
5)
certv2ray
;;
6)
clear
menu
;;
7)
clear
exit
;;
8)
clear
echo -e "\033[1;34m--- XRAY Log (last 20 lines) ---\033[0m"
if [ -f /var/log/xray/access.log ]; then
  tail -n 20 /var/log/xray/access.log
else
  sudo journalctl -u xray -n 20 --no-pager
fi
echo
echo -e "Press Enter to return to menu..."
read
$0
;;
*)
clear
$0
;;
esac

echo -e "\n\033[1;34mScriptVPS by RichBoyBrown | WA: 18765946096\033[0m"
echo -e "For help, select any menu or see the README.\n"
