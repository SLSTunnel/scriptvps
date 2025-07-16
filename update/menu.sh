#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
echo -e "\033[0;36m==================================================\033[m"
echo -e   "\E[44;1;39m              ⇱ MENU ULTRA ⇲                      \E[0m"
echo -e   "\E[44;1;39m            ⇱ DEVSUPPORT VPS PREMIUM - VIP ⇲      \E[0m"
echo -e "\033[0;36m==================================================\033[m"
echo -e   "\033[0;33m  1. •SSH & OpenVPN MENU\033[0;33m"
echo -e   "\033[1;33m  2. •VMESS MENU\033[1;33m"
echo -e   "\033[0;33m  3. •VLESS MENU\033[0;33m"
echo -e   "\033[1;33m  4. •SSTP MENU\033[1;33m"
echo -e   "\033[0;33m  5. •WIREGUARD MENU\033[0;33m"
echo -e   "\033[1;33m  6. •SHADOWSOCKS MENU\033[1;33m"
echo -e   "\033[0;33m  7. •SHADOWSOCKSR MENU\033[0;33m"
echo -e   "\033[1;33m  8. •L2TP MENU\033[1;33m"
echo -e   "\033[0;33m  9. •PPTP MENU\033[0;33m"
echo -e   "\033[1;33m 10. •TROJAN GFW MENU\033[1;33m"
echo -e   "\033[0;33m 11. •TROJAN GO MENU\033[0;33m"
echo -e   "\033[1;33m 12. •CEK SEMUA SERVICE VPN\033[1;33m"
echo -e   "\033[0;33m 13. •SETTING\033[0;33m"
echo -e   "\033[1;33m 14. •UPDATE [ SCRIPT ]\033[1;33m"
echo -e   "\033[0;33m 15. •CLEAR TMP LOGS [SCRIPT]\003[0;33m"
echo -e   "\033[1;33m 16. •CHANGE OR ADD OWN NAMESERVERS\033[1;33m"
echo -e   "\033[0;33m 17. •CHANGE OR ADD OWN CLOUDFLARE DOMAIN\033[0;33m"
echo -e   "\033[1;33m 18. •UPDATE KERNEL VERSION\033[1;33m"
echo -e   "\033[1;33m 19. •SET UP REBOOT MODE\033[1;33m"
echo -e   "\033[0;33m 20. •Exit\033[0;33m"
echo -e   "\033[0;33m 21. •UNINSTALL SCRIPT\033[0;33m"
echo -e   "\033[0;33m 22. •VIEW LOGS\033[0;33m"
echo -e "\033[0;36m==================================================\033[m"
echo -e   "\E[44;1;39m           ⇱ MOD BY RichBoyBrown ⇲               \E[0m"
echo -e   "\E[44;1;39m            ⇱ WA : 18765946096 ⇲                 \E[0m"
echo -e "\033[0;36m==================================================\033[m"
# Add status check functions at the top
status_color() {
  if systemctl is-active --quiet "$1"; then
    echo -e "\033[0;32mRUNNING\033[0m"
  else
    echo -e "\033[0;31mSTOPPED\033[0m"
  fi
}

# Gather statuses
SSH_STATUS=$(status_color ssh)
OPENVPN_STATUS=$(status_color openvpn)
XRAY_STATUS=$(status_color xray)
STUNNEL_STATUS=$(status_color stunnel5)
WG_STATUS=$(status_color wg-quick@wg0)
SSTP_STATUS=$(status_color accel-ppp)
SSR_STATUS=$(status_color ssrmu)
SS_STATUS=$(status_color shadowsocks-libev)
SQUID_STATUS=$(status_color squid)
NGINX_STATUS=$(status_color nginx)

clear
# Print status dashboard
printf "\033[0;36m================= SERVICE STATUS =================\033[m\n"
printf " SSH:        %s\n" "$SSH_STATUS"
printf " OpenVPN:    %s\n" "$OPENVPN_STATUS"
printf " XRAY:       %s\n" "$XRAY_STATUS"
printf " Stunnel5:   %s\n" "$STUNNEL_STATUS"
printf " WireGuard:  %s\n" "$WG_STATUS"
printf " SSTP:       %s\n" "$SSTP_STATUS"
printf " SSR:        %s\n" "$SSR_STATUS"
printf " Shadowsocks:%s\n" "$SS_STATUS"
printf " Squid:      %s\n" "$SQUID_STATUS"
printf " Nginx:      %s\n" "$NGINX_STATUS"
printf "\033[0;36m==================================================\033[m\n\n"
read -p   "Select From Options [ 1 - 22 ] : " menu
case $menu in
1)
clear
sshovpnmenu
;;
2)
clear
vmessmenu
;;
3)
clear
vlessmenu
;;
4)
clear
sstpmenu
;;
5)
clear
wgmenu
;;
6)
clear
ssmenu
;;
7)
clear
ssrmenu
;;
8)
clear
l2tpmenu
;;
9)
clear
pptpmenu
;;
10)
clear
trmenu
;;
11)
clear
trgomenu
;;
12)
clear
running
;;
13)
clear
setmenu
;;
14)
clear
sudo apt install nginx
sudo ufw allow 'Nginx HTTP'
update
;;
15)
clear
clearlog
;;
16)
clear
nameserver
;;
17)
clear
domenu
;;
18)
clear
kernel-updt
;;
19)
clear
auto-reboot
;;
20)
clear
exit
;;
21)
clear
sudo bash uninstall.sh
;;
22)
clear
sudo tail -n 40 /var/log/syslog; echo; read -p "Press Enter to return to menu..."; menu
;;
*)
clear
menu
;;
esac
# Add help/about section at the bottom
printf "\n\033[1;34mScriptVPS by RichBoyBrown | WA: 18765946096\033[0m\n"
printf "For help, select any menu or see the README.\n\n"
