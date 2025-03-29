#!/bin/bash

echo -e "\e[35m 🚀🚀🚀 Welcome to SysPeek - a single script to get System information 🚀🚀🚀\e[0m"
echo -e "\n"
echo "----------------------------------"

# VARIABLES for System info
. /etc/os-release
OS_NAME="${PRETTY_NAME}"
ARCHITECTURE=$(uname -m)
KERNEL_VERSION=$(uname -s -r)
HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
SHELL_NAME=$(basename "$SHELL")
SHELL_VERSION=$($SHELL --version 2>/dev/null | head -n1)
DESKTOP_ENVIRONMENT="${XDG_CURRENT_DESKTOP:-Unknown}"
WINDOW_MANAGER=$(ps -e | grep -m1 -oE 'kwin_x11|mutter|openbox|i3|bspwm|xfwm4|compiz|marco')
TERMINAL_NAME=$(ps -o comm= -p $(ps -o ppid= -p $(ps -o sid= -p $$)))

#function for System information

System(){
echo -e "\e[31m💻💻💻 System Info : 💻💻💻\e[0m"
echo "----------------------------------"
echo -e "\e[31mOS:\e[0m $OS_NAME"
echo -e "\e[31mARCHITECTURE:\e[0m $ARCHITECTURE"
echo -e "\e[31mKERNEL:\e[0m $KERNEL_VERSION"
echo -e "\e[31mHOST:\e[0m $HOSTNAME"
echo -e "\e[31mUPTIME:\e[0m $UPTIME"
echo -e "\e[31mSHELL:\e[0m $SHELL_NAME"
echo -e "\e[31mSHELL VERSION:\e[0m $SHELL_VERSION"
echo -e "\e[31mDE:\e[0m $DESKTOP_ENVIRONMENT"
echo -e "\e[31mWM:\e[0m $WINDOW_MANAGER"
echo -e "\e[31mTERMINAL:\e[0m $TERMINAL_NAME"
}
System
