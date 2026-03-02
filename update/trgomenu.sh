#!/bin/bash
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'

status_color() {
  if systemctl is-active --quiet "$1"; then
    echo -e "${GREEN}RUNNING${wh}"
  else
    echo -e "${RED}STOPPED${wh}"
  fi
}

TRGO_STATUS=$(status_color trojan-go)

clear
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m                ⇱ TROJAN GO ⇲                 \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " Trojan Go Service: $TRGO_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "$yy 1$y. Create Account Trojan Go"
echo -e   "$yy 2$y. Delete Account Trojan Go"
echo -e   "$yy 3$y. Extending Account Trojan Go Active Life"
echo -e   "$yy 4$y. Check User Login Trojan Go"
echo -e   "$yy 5$y. Menu"
echo -e   "$yy 6$y. Exit"
echo -e   "$yy 7$y. View Trojan Go Logs"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p "Select From Options [ 1 - 7 ] : " menu
echo -e ""
case $menu in
1)
addtrgo
;;
2)
deltrgo
;;
3)
renewtrgo
;;
4)
cektrgo
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
echo -e "\033[1;34m--- Trojan Go Log (last 20 lines) ---\033[0m"
sudo journalctl -u trojan-go -n 20 --no-pager
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
