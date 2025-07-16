#!/bin/bash
# Enhanced System Settings Menu

m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'

# Show last backup/restore log if exists
show_backup_log() {
  if [ -f /var/log/backup.log ]; then
    echo -e "${yy}Last Backup/Restore:${wh}"
    tail -n 3 /var/log/backup.log
  fi
}

clear
echo -e   "$y===========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ SYSTEM SETTING ⇲                 \E[0m"
echo -e   "$y===========================================================$wh"
echo -e   "\033[31;1m 1.  Add Or Change Subdomain Host For VPS\033[31;1m"
echo -e   "\033[1;33m 2.  Change Port Of Some Service\033[1;33m"
echo -e   "\033[31;1m 3.  Autobackup Data VPS\033[31;1m"
echo -e   "\033[1;33m 4.  Backup Data VPS\033[1;33m"
echo -e   "\033[31;1m 5.  Restore Data VPS\033[31;1m"
echo -e   "\033[1;33m 6.  Webmin Menu\033[1;33m"
echo -e   "\033[31;1m 7.  Limit Bandwith Speed Server\033[31;1m"
echo -e   "\033[1;33m 8.  Check Usage of VPS Ram\033[1;33m"
echo -e   "\033[31;1m 9.  Reboot VPS\033[31;1m"
echo -e   "\033[1;33m 10. Speedtest VPS\033[1;33m"
echo -e   "\033[31;1m 11. Displaying System Information\033[31;1m"
echo -e   "\033[1;33m 12. Info Script Auto Install\033[1;33m"
echo -e   "\033[31;1m 13. Menu\033[31;1m"
echo -e   "\033[1;33m 14. Exit\033[1;33m"
echo -e   "$y===========================================================$wh"
show_backup_log
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲              \E[0m"
echo -e   "$y===========================================================$wh"
echo -e   ""
read -p   "Select From Options [ 1 - 14 ] : " menu
echo -e ""
case $menu in
1)
addhost
;;
2)
changeport
;;
3)
autobackup
;;
4)
backup
;;
5)
restore
;;
6)
wbmn
;;
7)
limitspeed
;;
8)
ram
;;
9)
reboot
;;
10)
speedtest
;;
11)
info
;;
12)
about
;;
13)
clear
menu
;;
14)
clear
exit
;;
*)
clear
menu
;;
esac

echo -e "\n\033[1;34mScriptVPS by RichBoyBrown | WA: 18765946096\033[0m"
echo -e "For help, select any menu or see the README.\n"
