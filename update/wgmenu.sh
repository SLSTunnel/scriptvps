#!/bin/bash
# Enhanced WireGuard Menu

m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'

status_color() {
  if systemctl is-active --quiet wg-quick@wg0; then
    echo -e "${GREEN}RUNNING${wh}"
  else
    echo -e "${RED}STOPPED${wh}"
  fi
}

WG_STATUS=$(status_color)

clear
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ WIREGUARD ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " WireGuard Service: $WG_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "$yy 1$y. Create Account Wireguard"
echo -e   "$yy 2$y. Delete Account Wireguard"
echo -e   "$yy 3$y. Extending Account Wireguard Active Life"
echo -e   "$yy 4$y. Menu"
echo -e   "$yy 5$y. Exit"
echo -e   "$yy 6$y. View WireGuard Logs"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p   "Select From Options [ 1 - 6 ] : " menu
echo -e   ""
case $menu in
1)
addwg
;;
2)
delwg
;;
3)
renewwg
;;
4)
clear
menu
;;
5)
clear
exit
;;
6)
clear
echo -e "\033[1;34m--- WireGuard Log (last 20 lines) ---\033[0m"
sudo journalctl -u wg-quick@wg0 -n 20 --no-pager
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
