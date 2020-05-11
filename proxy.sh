#!/bin/bash

# Basic Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESTORE="\e[39"
BOLD="\e[1m"
NORMAL="\e[0m"

# Other Useful Variables 
path=$(pwd)
proxies=$(wc -l http.txt | cut -d\  -f1)
ip=$(curl -S ipinfo.io/ip)
user=$(hostname)

# Functions

function setup {
    clear
    echo -e "${YELLOW}[*] ${BLUE}Setup tool...."
    sleep 0.5
    echo -e "${YELLOW}[*] ${BLUE}Checking Internet Connection..."
    sleep 0.5
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null
    then
        echo -e "${YELLOW}[*] ${GREEN}You have connection..."
        sleep 0.5
        echo -e "${YELLOW}[*] ${BLUE}Your IP: ${RED}$ip"
        sleep 0.5
        #apt install curl
        sleep 0.5
        echo -e "${YELLOW}[*] ${BLUE}Removing old proxyfiles files in directory..."
        if [ -f http.txt ]; then
            rm http.txt
        fi
        if [ -f socks4.txt ]; then
            rm socks4.txt
        fi
        if [ -f socks5.txt ]; then
            rm socks5.txt
        fi
        echo -e "${YELLOW}[*] ${BLUE}Done."
        echo -e $RED""
        read -p "Press [ENTER] to re-run script"
        bash proxy.sh
    else
        echo -e "${YELLOW}[*] ${RED}No connection!"
        echo -e "${YELLOW}[*] ${RED}Quiting.."
        clear
        exit[0]
    fi
}

function http {
    echo -e "${YELLOW}[*] ${BLUE} Downloading HTTP Proxies"
    curl -LO "https://api.proxyscrape.com/?request=getproxies&proxytype=http&timeout=10000&country=all&ssl=all&anonymity=all"
    mv -v \?request\=getproxies\&proxytype\=http\&timeout\=10000\&country\=all\&ssl\=all\&anonymity\=all http.txt
    clear
    if [ -f http.txt ]
    then
        proxy=$(wc -l http.txt | cut -d\  -f1)
        echo -e "${YELLOW}[+] ${GREEN}Done: ${RED}$proxy ${GREEN}proxies saved in ${BLUE}$path/http.txt"    
        echo -e ${RED}""
        read -p "Press [ENTER] To Quit"
    else
        echo -e "${YELLOW}[!] ${RED}Can't download proxies, check your internet."
    fi
    }

function socks4 {
    echo -e "${YELLOW}[*] ${BLUE} Downloading Socks4 Proxies"
    curl -LO "https://api.proxyscrape.com/?request=getproxies&proxytype=socks4&timeout=10000&country=all"
    mv -v \?request\=getproxies\&proxytype\=socks4\&timeout\=10000\&country\=all socks4.txt
    clear
    if [ -f socks4.txt ]
    then
        proxy=$(wc -l socks4.txt | cut -d\  -f1)
        echo -e "${YELLOW}[+] ${GREEN}Done: ${RED}$proxy ${GREEN}proxies saved in ${BLUE}$path/socks4.txt"    
        echo -e ${RED}""
        read -p "Press [ENTER] To Quit"
    else
        echo -e "${YELLOW}[!] ${RED}Can't download proxies, check your internet."
    fi

    }

function socks5 {
    echo -e "${YELLOW}[*] ${BLUE} Downloading Socks5 Proxies"
    curl -LO "https://api.proxyscrape.com/?request=getproxies&proxytype=socks5&timeout=10000&country=all"
    mv -v \?request\=getproxies\&proxytype=socks5\&timeout=10000\&country\=all socks5.txt
    clear
    if [ -f socks5.txt ]
    then
        proxy=$(wc -l socks5.txt | cut -d\  -f1)
        echo -e "${YELLOW}[+] ${GREEN}Done: ${RED}$proxy ${GREEN}proxies saved in ${BLUE}$path/socks5.txt"    
        echo -e ${RED}""
        read -p "Press [ENTER] To Quit"
    else
        echo -e "${YELLOW}[!] ${RED}Can't download proxies, check your internet."
    fi
    }






# Banner
if [ "$EUID" -ne 0 ]
  then echo -e "${RED}[!] Please run as root"
  exit
fi
clear
echo -e "${BOLD}${BLUE}
██████╗ ██████╗  ██████╗ ██╗  ██╗██╗   ██╗
██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝
██████╔╝██████╔╝██║   ██║ ╚███╔╝  ╚████╔╝ 
██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗   ╚██╔╝  
██║     ██║  ██║╚██████╔╝██╔╝ ██╗   ██║   
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
███████╗ ██████╗██████╗  █████╗ ██████╗ ███████╗██████╗ 
██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
███████╗██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
╚════██║██║     ██╔══██╗██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
███████║╚██████╗██║  ██║██║  ██║██║     ███████╗██║  ██║
╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
$RED
${RED} |\ |\    ${BLUE}Telegram  : ${RED}t.me/rebl0x3r
${RED} \ \| |   ${BLUE}Coder	    : ${MAGENTA}@TheMasterCH
${RED}  \ | |	  ${BLUE}Update    : ${GREEN}v1.0 ${RED}[BETA]
${RED} .--''/	  ${BLUE}Path      : ${YELLOW}$path
${RED}/o     \  ${BLUE}Logo	    : ${CYAN}Playboy Bunny
${RED}\      /  ${BLUE}Sites     : ${RED}1
${RED}{>o<}='   ${BLUE}User      : ${GREEN}$user

${RED}[1] ${YELLOW}Setup
${RED}[2] ${YELLOW}HTTP Scrape
${RED}[3] ${YELLOW}Socks4 Scrape
${RED}[4] ${YELLOW}Socks5 Scrape
${RED}[5] ${YELLOW}Exit
"
echo -ne "${GREEN}╭${YELLOW}❨${RED}root${CYAN}@${BLUE}cracker${YELLOW}❩
${GREEN}╰╼${RED} $ ${YELLOW}:${CYAN} " 
read opt

case $opt in
    1)
    setup
    ;;
    2)
    http
    ;;
    3)
    socks4
    ;;
    4)
    socks5
    ;;
    5)
    exit
    ;;
    *)
    echo -e "${RED}[!] Invalid command"
esac
