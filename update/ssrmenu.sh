#!/bin/bash
# Enhanced SSR Menu

m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'

status_color() {
  if systemctl is-active --quiet ssrmu; then
    echo -e "${GREEN}RUNNING${wh}"
  else
    echo -e "${RED}STOPPED${wh}"
  fi
}

SSR_STATUS=$(status_color)

clear
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ SHADOSOCKSR ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " SSR Service: $SSR_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "$yy 1$y. Create Account SSR"
echo -e   "$yy 2$y. Delete Account SSR"
echo -e   "$yy 3$y. Extending Account SSR Active Life"
echo -e   "$yy 4$y. Show Other SSR Menu"
echo -e   "$yy 5$y. Menu"
echo -e   "$yy 6$y. Exit"
echo -e   "$yy 7$y. View SSR Logs"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p   "Select From Options [ 1 - 7 ] : " menu
echo -e   ""
case $menu in
1)
addssr
;;
2)
delssr
;;
3)
renewssr
;;
4)
ssr
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
echo -e "\033[1;34m--- SSR Log (last 20 lines) ---\033[0m"
sudo journalctl -u ssrmu -n 20 --no-pager
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
