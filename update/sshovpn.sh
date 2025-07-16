#!/bin/bash
# Enhanced SSH & OpenVPN Menu

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

SSH_STATUS=$(status_color ssh)
OPENVPN_STATUS=$(status_color openvpn)

clear
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m              ⇱ SSH & OPENVPN ⇲               \E[0m"
echo -e   "$y==========================================================$wh"
echo -e   " SSH Service:     $SSH_STATUS"
echo -e   " OpenVPN Service: $OPENVPN_STATUS"
echo -e   "$y==========================================================$wh"
echo -e   "\033[1;33m  1.  Create SSH & OpenVPN Account\033[1;33m"
echo -e   "\033[31;1m  2.  Generate SSH & OpenVPN Trial Account\033[31;1m"
echo -e   "\033[1;33m  3.  Extending SSH & OpenVPN Account Active Life\033[1;33m"
echo -e   "\033[31;1m  4.  Check User Login SSH & OpenVPN\033[31;1m"
echo -e   "\033[1;33m  5.  Daftar Member SSH & OpenVPN\033[1;33m"
echo -e   "\033[31;1m  6.  Delete SSH & OpenVpn Account\033[31;1m"
echo -e   "\033[1;33m  7.  Delete User Expired SSH & OpenVPN\033[1;33m"
echo -e   "\033[31;1m  8.  Set up Autokill SSH\033[31;1m"
echo -e   "\033[1;33m  9.  Displays Users Who Do Multi Login SSH\033[1;33m"
echo -e   "\033[31;1m 10. Restart All Service\033[31;1m"
echo -e   "\033[1;33m 11. Menu Utama\033[1;33m"
echo -e   "\033[31;1m 12. Exit\033[31;1m"
echo -e   "\033[1;33m 13. View SSH & OpenVPN Logs\033[1;33m"
echo -e   "$y==========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲             \E[0m"
echo -e   "$y==========================================================$wh"
read -p   "Select From Options [ 1 - 13 ] : " menu
echo -e   ""
case $menu in
1)
addssh
;;
2)
trialssh
;;
3)
renewssh
;;
4)
cekssh
;;
5)
member
;;
6)
delssh
;;
7)
delexp
;;
8)
autokill
;;
9)
ceklim
;;
10)
restart
;;
11)
menu
;;
12)
clear
exit
;;
13)
clear
echo -e "\033[1;34m--- SSH Service Log (last 20 lines) ---\033[0m"
sudo journalctl -u ssh -n 20 --no-pager

echo -e "\033[1;34m--- OpenVPN Log (last 20 lines) ---\033[0m"
if [ -f /var/log/openvpn.log ]; then
  tail -n 20 /var/log/openvpn.log
else
  sudo journalctl -u openvpn -n 20 --no-pager
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
