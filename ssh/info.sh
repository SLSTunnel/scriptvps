#!/bin/bash
# Enhanced Info Script
# Mod By TARAP KUHING, Enhanced by RichBoyBrown
# ==========================================
GREEN='\033[0;32m'
NC='\033[0m'
BLUE='\033[0;34m'
# ==========================================
clear
echo -e "${GREEN}==== VPS INFORMATION ====${NC}"
echo -e "Hostname: $(hostname)"
echo -e "IP Address: $(wget -qO- ipinfo.io/ip)"
echo -e "Uptime: $(uptime -p)"
echo -e "Kernel: $(uname -r)"
echo -e "Total RAM: $(free -h | awk '/^Mem:/ {print $2}')"
echo -e "CPU: $(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo)"
echo -e "Disk Usage: $(df -h / | awk 'NR==2{print $3 "/" $2}')"
echo -e "${BLUE}=========================${NC}"
echo -e "\n\033[1;34mScriptVPS by RichBoyBrown | WA: 18765946096\033[0m"
echo -e "For help, select any menu or see the README.\n"