#!/bin/bash
#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
echo -e   "$y===========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ CLOUDFLARE SETTING ⇲                 \E[0m"
echo -e   "$y===========================================================$wh"
echo -e   "\033[31;1m 1.  Add Subdomain Host For VPS\033[31;1m"
echo -e   "\033[1;33m 2.  Add ID Cloudflare\033[1;33m"
echo -e   "\033[31;1m 3.  Cloudflare Add-Ons\033[31;1m"
echo -e   "\033[1;33m 4.  Pointing BUG\033[1;33m"
echo -e   "\033[1;33m 5.  Renew Certificate V2RAY\033[1;33m"
echo -e   "\033[31;1m 6. BACK TO MENU\033[31;1m"
echo -e   "$y===========================================================$wh"
echo -e   "\E[44;1;39m            ⇱ Sc By RichBoyBrown ⇲              \E[0m"
echo -e   "$y===========================================================$wh"
echo -e   ""
read -p   "Select From Options [ 1 - 6 ] : " menu
echo -e ""
case $menu in
1) 
clear 
add-host 
;;
2) 
clear 
cff
;;
3) 
clear 
cfd 
;;
4)
clear 
cfh
;;
5)
clear 
certv2ray
;;
6) 
clear 
menu 
;;
x) exit ;;
*) echo "Please enter an correct number" ;;
esac
