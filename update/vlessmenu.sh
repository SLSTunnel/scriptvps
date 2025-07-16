#!/bin/bash
# Enhanced XRAY (VLESS) Menu

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
echo -e   "\E[44;1;39m                ⇱ VLESS ⇲                     \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " XRAY Service: $XRAY_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "$yy 1$y. Create Account XRAYS Vless Websocket"
echo -e   "$yy 2$y. Delete Account XRAYS Vless Websocket"
echo -e   "$yy 3$y. Extending Account XRAYS Vless Active Life"
echo -e   "$yy 4$y. Check User Login XRAYS Vless"
echo -e   "$yy 5$y. Menu"
echo -e   "$yy 6$y. Exit"
echo -e   "$yy 7$y. View XRAY Logs"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p   "Select From Options [ 1 - 7 ] : " menu
echo -e   ""
case $menu in
1)
addvless
;;
2)
delvless
;;
3)
renewvless
;;
4)
cekvless
;;
5)
clear
menu
;;
6)
clear
exit
;;
7)
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
