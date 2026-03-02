#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo -e "${GREEN}[*]${NC} Checking VPS authorization..."
IZIN=$(curl -sf --max-time 10 "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ipvps.txt" | grep -c "$MYIP")
if [ "$IZIN" -gt 0 ]; then
echo -e "${GREEN}[✓]${NC} Authorization accepted."
else
echo -e "${RED}[✗]${NC} Authorization denied for IP: ${MYIP}"
echo -e "${LIGHT}Please contact the administrator."
echo -e "${LIGHT}Facebook  : "
echo -e "${LIGHT}WhatsApp  : 8765946096"
echo -e "${LIGHT}Telegram  : https://t.me/OfficialRichBoyBrown"
exit 1
fi
# ==========================================
# Getting
# Link Hosting Base URL
BASE_URL="raw.githubusercontent.com/SLSTunnel/scriptvps/main"
# Link Hosting Kalian Untuk Ssh Vpn
tarapkuhing_ssh="${BASE_URL}/ssh"
# Link Hosting Kalian Untuk Sstp
tarapkuhing_sstp="${BASE_URL}/sstp"
# Link Hosting Kalian Untuk Ssr
tarapkuhing_ssr="${BASE_URL}/ssr"
# Link Hosting Kalian Untuk Shadowsocks
tarapkuhing_ss="${BASE_URL}/shadowsocks"
# Link Hosting Kalian Untuk Wireguard
tarapkuhing_wg="${BASE_URL}/wireguard"
# Link Hosting Kalian Untuk Xray
tarapkuhing_xray="${BASE_URL}/xray"
# Link Hosting Kalian Untuk Ipsec
tarapkuhing_ipsec="${BASE_URL}/ipsec"
# Link Hosting Kalian Untuk Backup
tarapkuhing_backup="${BASE_URL}/backup"
# Link Hosting Kalian Untuk Websocket
tarapkuhing_ws="${BASE_URL}/websocket"
# Link Hosting Kalian Untuk Ohp
tarapkuhing_ohp="${BASE_URL}/ohp"

rm -f setup.sh
clear
if [ -f "/etc/xray/domain" ]; then
echo -e "${GREEN}[✓]${NC} Script already installed. Exiting."
exit 0
fi

# Create config directory
mkdir -p /var/lib/tarapkuhing
echo "IP=" > /var/lib/tarapkuhing/ipvps.conf

echo -e "\033[0;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m        ⇱ ScriptVPS - Full Installation ⇲        \E[0m"
echo -e "\033[0;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

# Helper: download and run a script
install_component() {
  local name="$1" url="$2" tmpfile="$3" screen_name="$4"
  echo -e "${CYAN}[➜]${NC} Installing ${name}..."
  wget -qO "/root/${tmpfile}" "${url}" && chmod +x "/root/${tmpfile}" || {
    echo -e "${RED}[✗]${NC} Failed to download ${name}. Skipping."
    return 1
  }
  if [ -n "${screen_name}" ]; then
    screen -dmS "${screen_name}" bash "/root/${tmpfile}"
  else
    bash "/root/${tmpfile}"
  fi
}

install_component "Cloudflare DNS"   "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ssh/cf.sh"              "cf.sh"           ""
install_component "XRAY/V2Ray"       "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/xray/ins-xray.sh"       "ins-xray.sh"     "xray"
install_component "SSH & OpenVPN"    "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ssh/ssh-vpn.sh"          "ssh-vpn.sh"      "ssh-vpn"
install_component "SSTP"             "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/sstp/sstp.sh"            "sstp.sh"         "sstp"
install_component "ShadowsocksR"     "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ssr/ssr.sh"              "ssr.sh"          "ssr"
install_component "Shadowsocks"      "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/shadowsocks/sodosok.sh"  "sodosok.sh"      "ss"
install_component "WireGuard"        "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/wireguard/wg.sh"         "wg.sh"           "wg"
install_component "L2TP/IPSec"       "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ipsec/ipsec.sh"          "ipsec.sh"        "ipsec"
install_component "Backup/Rclone"    "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/backup/set-br.sh"        "set-br.sh"       ""
install_component "WebSocket"        "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/websocket/edu.sh"        "edu.sh"          ""
install_component "OHP Server"       "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ohp/ohp.sh"              "ohp.sh"          ""

# Clean up installer scripts
echo -e "${CYAN}[➜]${NC} Cleaning up installer scripts..."
rm -f /root/ssh-vpn.sh /root/sstp.sh /root/wg.sh /root/ss.sh /root/ssr.sh /root/cf.sh /root/sodosok.sh
rm -f /root/ins-xray.sh /root/ipsec.sh /root/set-br.sh /root/edu.sh /root/ohp.sh
# Setup auto-start service
echo -e "${CYAN}[➜]${NC} Configuring auto-start service..."
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=ScriptVPS Auto Setting
Documentation=https://github.com/SLSTunnel/scriptvps
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -qO /etc/set.sh "https://raw.githubusercontent.com/SLSTunnel/scriptvps/main/ssh/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver

# Print installation summary
{
echo ""
echo -e "\033[0;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m         ⇱ Installation Summary ⇲               \E[0m"
echo -e "\033[0;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo "   >>> Service & Port"
echo "   ─────────────────────────────────────────────"
echo "   - OpenSSH                 : 443, 22"
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"
echo "   - Stunnel5                : 443, 445, 777"
echo "   - Dropbear                : 109, 143"
echo "   - Squid Proxy             : 3128, 8080"
echo "   - Badvpn                  : 7100, 7200, 7300"
echo "   - Nginx                   : 81"
echo "   - Wireguard               : 7070"
echo "   - L2TP/IPSEC VPN          : 1701"
echo "   - PPTP VPN                : 1732"
echo "   - SSTP VPN                : 444"
echo "   - Shadowsocks-R           : 1443-1543"
echo "   - SS-OBFS TLS             : 2443-2543"
echo "   - SS-OBFS HTTP            : 3443-3543"
echo "   - XRAYS Vmess TLS         : 8443"
echo "   - XRAYS Vmess None TLS    : 80"
echo "   - XRAYS Vless TLS         : 8443"
echo "   - XRAYS Vless None TLS    : 80"
echo "   - XRAYS Trojan            : 2083"
echo "   - Websocket TLS           : 443"
echo "   - Websocket None TLS      : 8880"
echo "   - Websocket Ovpn          : 2086"
echo "   - OHP SSH                 : 8181"
echo "   - OHP Dropbear            : 8282"
echo "   - OHP OpenVPN             : 8383"
echo "   - Trojan Go               : 2087"
echo ""
echo "   >>> Server Features"
echo "   ─────────────────────────────────────────────"
echo "   - Timezone                : Asia/Jakarta (GMT +7)"
echo "   - Fail2Ban                : [ON]"
echo "   - Deflate                 : [ON]"
echo "   - IPtables                : [ON]"
echo "   - Auto-Reboot             : [ON]"
echo "   - IPv6                    : [ON]"
echo "   - Auto-Reboot             : Daily at 05:00 GMT+7"
echo "   - Autobackup Data         : [ENABLED]"
echo "   - Restore Data            : [ENABLED]"
echo "   - Auto Delete Expired     : [ENABLED]"
echo "   - Installation Log        : /root/log-install.txt"
echo ""
echo -e "\033[0;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${GREEN}[✓] Installation completed successfully!${NC}"
echo -e "\033[0;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
} | tee -a log-install.txt
echo ""
echo -e "${CYAN}[➜]${NC} System will reboot in 15 seconds..."
sleep 15
rm -f setup.sh
reboot
