#!/bin/bash

# SysPeek - A powerful script to fetch system information.
# SysPeek Version:1.3
# Author: Deepak Kushwaha
# License: MIT

echo -e "\e[35m🚀🚀🚀 Welcome to SysPeek - No Secrets, Just Pure System Insights. 🚀🚀🚀\e[0m"
echo "----------------------------------"

# VARIABLES FOR System Information
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
TERMINAL_NAME=$(ps -o comm= -p $(ps -o ppid= -p $(ps -o sid= -p $$)) 2>/dev/null || echo "Unknown")


# VARAIBLES For Hardware Information
CPU_MODEL=$(grep "model name" /proc/cpuinfo | head -1 | awk -F': ' '{print $2}')
CPU_CURRENTSPEED=$(grep "cpu MHz" /proc/cpuinfo | head -1 | awk -F': ' '{print $2}')
CPU_MAXSPEED=$(($(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq) / 1000))
CPU_CORES=$(nproc)
GPU=$(lspci | grep -i 'vga\|3d\|2d' | awk -F ': ' '{print $2}')
T_RAM=$(awk '/MemTotal/ {printf "%.2f GB\n", $2 / 1024 / 1024}' /proc/meminfo)
F_RAM=$(awk '/MemFree/ {printf "%.2f GB\n", $2 / 1024 / 1024}' /proc/meminfo)
STORAGE_INF=$(df -h --output=source,size,used,avail | column -t)
SWAP_MEM=$(free -h | awk '/Swap/ {print "Total: " $2, "| Used: " $3, "| Free: " $4}')

# VARIABLES FOR User Information
CURRENT_USER=$(whoami)
USER_ID=$(id -u)
USER_HOMEDIR=$(getent passwd "$USER" | cut -d: -f6)
CURRENTUSER_GROUPID=$(id -g)
CURRENTUSER_GROUPNAME=$(id -gn)
CURRENTUSER_AGROUPID=$(id -G)
CURRENTUSER_AGROUPNAME=$(id -Gn)
LOGGEDIN_USERS=$(who)
LAST_LOGIN=$(last -w -F "$USER" | awk 'NR==1 {print $4, $5, $6, $7, $8}')
LAST_SYSTEMBOOT=$(who -b | awk '{print $3" "$4}')

# VARIABLES FOR Network Information

# Determine USER_TYPE
if [[ "$USER_ID" -eq 0 ]]; then
   USER_TYPE="Root User"
elif [[ "$USER_ID" -lt 1000 ]]; then
    USER_TYPE="System User"
else
    USER_TYPE="Normal User"
fi

# Function for System Information
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

# Function for Hardware information
Hardware(){
echo "----------------------------------"
echo -e "\e[34m🛠️🛠️🛠️ Hardware Info : 🛠️🛠️🛠️\e[0m"
echo "----------------------------------"
echo -e "\e[34mCPU Model:\e[0m $CPU_MODEL"
echo -e "\e[34mCPU Current Speed:\e[0m $CPU_CURRENTSPEED MHz"
echo -e "\e[34mCPU Max Speed:\e[0m $CPU_MAXSPEED MHz"
echo -e "\e[34mCPU Cores:\e[0m $CPU_CORES"
echo -e "\e[34mGPU:\e[0m $GPU"
echo -e "\e[34mTotal RAM:\e[0m $T_RAM"
echo -e "\e[34mFree RAM:\e[0m $F_RAM"
echo -e "\e[34mStorage Info:\e[0m\n$STORAGE_INF"
echo -e "\e[34mSwap Memory:\e[0m $SWAP_MEM"
}
Hardware

# Function for User Information
User(){
echo "----------------------------------"
echo -e "\e[32m👨‍💻👨‍💻👨‍💻 User Info : 👨‍💻👨‍💻👨‍💻\e[0m"
echo "----------------------------------"
echo -e "\e[32mCurrent User:\e[0m $CURRENT_USER"
echo -e "\e[32mUser Type:\e[0m $USER_TYPE"
echo -e "\e[32mHome Directory:\e[0m $USER_HOMEDIR"
echo -e "\e[32mPrimary Group ID:\e[0m $CURRENTUSER_GROUPID"
echo -e "\e[32mPrimary Group Name:\e[0m $CURRENTUSER_GROUPNAME"
echo -e "\e[32mAll Group IDs:\e[0m $CURRENTUSER_AGROUPID"
echo -e "\e[32mAll Group Names:\e[0m $CURRENTUSER_AGROUPNAME"
echo -e "\e[32mLogged-in Users:\e[0m\n$LOGGEDIN_USERS"
echo -e "\e[32mLast Login:\e[0m $LAST_LOGIN"
echo -e "\e[32mLast System Boot:\e[0m $LAST_SYSTEMBOOT"
}
User
