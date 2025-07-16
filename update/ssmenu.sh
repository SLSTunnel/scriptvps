#!/bin/bash
# Enhanced Shadowsocks Menu

m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'

status_color() {
  if systemctl is-active --quiet shadowsocks-libev; then
    echo -e "${GREEN}RUNNING${wh}"
  else
    echo -e "${RED}STOPPED${wh}"
  fi
}

SS_STATUS=$(status_color)

clear
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m              ⇱ SHADOWSOCKS ⇲                 \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " Shadowsocks Service: $SS_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "$yy 1$y. Create Account Shadowsocks"
echo -e   "$yy 2$y. Delete Account Shadowsocks"
echo -e   "$yy 3$y. Extending Account Shadowsocks Active Life"
echo -e   "$yy 4$y. Check User Login Shadowsocks"
echo -e   "$yy 5$y. Menu"
echo -e   "$yy 6$y. Exit"
echo -e   "$yy 7$y. View Shadowsocks Logs"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p   "Select From Options [ 1 - 7 ] : " menu
echo -e   ""
case $menu in
1)
addss
;;
2)
delss
;;
3)
renewss
;;
4)
cekss
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
echo -e "\033[1;34m--- Shadowsocks Log (last 20 lines) ---\033[0m"
sudo journalctl -u shadowsocks-libev -n 20 --no-pager
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
