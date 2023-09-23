# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/SLSTunnel/perizinan/main/ipvps.txt | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
echo -e "${NC}${LIGHT}Facebook : "
echo -e "${NC}${LIGHT}WhatsApp : 085754292950"
echo -e "${NC}${LIGHT}Telegram : https://t.me/Hendra2012"
exit 0
fi
done=$(cat $installed | grep -w "done" | wc -l)
if [[ ${done} == '1' ]]; then
    echo -ne "Nama Server: "
    read bug_digi
    echo "$bug_digi" >$nameserver
    echo "$bug_digi" >$svr
else
mkdir /root/.svr
echo 'ctechdidik.me' >$nameserver
echo 'ctechdidik.me' >$svr

echo 'done' >$installed
clear
kumbang
fi

read -n 1 -s -r -p "Press any key to back on menu"
menu
