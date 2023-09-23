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
