#!/bin/bash
# Advanced Uninstall Script for ScriptVPS
# Safely removes all services and configs installed by ScriptVPS

set -e
LOGFILE="uninstall.log"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

function log() {
  echo -e "$1" | tee -a "$LOGFILE"
}

clear
log "${YELLOW}==============================="
log " ScriptVPS Uninstall Wizard "
log "===============================${NC}"

read -p "Are you sure you want to uninstall all ScriptVPS services? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  log "${GREEN}Uninstall cancelled.${NC}"
  exit 0
fi

log "${YELLOW}Stopping and disabling services...${NC}"
SERVICES=(stunnel5 xray ws-tls ws-nontls ws-ovpn ssh-ohp dropbear-ohp openvpn-ohp accel-ppp ssrmu)
for svc in "${SERVICES[@]}"; do
  if systemctl list-unit-files | grep -q "^$svc"; then
    sudo systemctl stop "$svc" 2>/dev/null || true
    sudo systemctl disable "$svc" 2>/dev/null || true
    log "Stopped and disabled $svc."
  fi
  if [ -f "/etc/init.d/$svc" ]; then
    sudo /etc/init.d/$svc stop 2>/dev/null || true
    sudo update-rc.d -f $svc remove 2>/dev/null || true
    log "Removed init.d $svc."
  fi
  sudo rm -f "/etc/systemd/system/$svc.service"
done
sudo systemctl daemon-reload

log "${YELLOW}Removing configuration files...${NC}"
# Remove configs (but not user data)
sudo rm -rf /etc/stunnel5 /etc/xray /etc/accel-ppp.conf /etc/ssr /etc/shadowsocks /etc/wireguard /etc/openvpn /etc/sstp /etc/ssh/sshd_config /etc/squid /etc/webmin 2>/dev/null || true
sudo rm -f /etc/stunnel/stunnel.pem /etc/stunnel/stunnel.key /etc/stunnel/stunnel.crt 2>/dev/null || true

log "${YELLOW}Removing binaries and scripts...${NC}"
# Remove binaries installed by script
sudo rm -f /usr/local/lamvpn/stunnel5 /usr/local/bin/xray /usr/local/bin/ws-tls /usr/local/bin/ws-nontls /usr/local/bin/ws-ovpn /usr/local/bin/ohpserver /usr/local/bin/ssrmu 2>/dev/null || true

log "${YELLOW}Cleaning up crontab entries...${NC}"
sudo sed -i '/clearlog && reboot/d' /etc/crontab 2>/dev/null || true
sudo sed -i '/xp/d' /etc/crontab 2>/dev/null || true

log "${YELLOW}Uninstall complete!${NC}"
log "${GREEN}All ScriptVPS services and configs have been removed. Some user data and logs may remain for safety.${NC}"
log "${YELLOW}If you want to remove user accounts or additional data, please do so manually.${NC}" 