#!/bin/bash
# Enhanced SSTP Menu

m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'

status_color() {
  if systemctl is-active --quiet accel-ppp; then
    echo -e "${GREEN}RUNNING${wh}"
  else
    echo -e "${RED}STOPPED${wh}"
  fi
}

SSTP_STATUS=$(status_color)

clear
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m                  ⇱ SSTP ⇲                    \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " SSTP Service: $SSTP_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "$yy 1$y. Create Account SSTP"
echo -e   "$yy 2$y. Delete Account SSTP"
echo -e   "$yy 3$y. Extending Account SSTP Active Life"
echo -e   "$yy 4$y. Check User Login SSTP"
echo -e   "$yy 5$y. Menu"
echo -e   "$yy 6$y. Exit"
echo -e   "$yy 7$y. View SSTP Logs"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p   "Select From Options [ 1 - 7 ] : " menu
echo -e   ""
case $menu in
1)
addsstp
;;
2)
delsstp
;;
3)
renewsstp
;;
4)
ceksstp
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
echo -e "\033[1;34m--- SSTP Log (last 20 lines) ---\033[0m"
sudo journalctl -u accel-ppp -n 20 --no-pager
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
