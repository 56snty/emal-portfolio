#!/bin/bash
# Practical Security Toolkit Menu (Only Available Tools)

show_menu() {
    clear
    echo "==================================="
    echo "     Practical Security Toolkit"
    echo "==================================="
    echo "1) Network Scanning (nmap)"
    echo "2) Username Search (sherlock)"
    echo "3) Domain Information (whois)"
    echo "4) Email/Domain Harvesting (theHarvester)"
    echo "5) SQL Injection Testing (sqlmap)"
    echo "6) Web Server Scanning (nikto)"
    echo "7) Reconnaissance Framework (recon-ng)"
    echo "8) DNS Information Gathering"
    echo "9) Update All Tools"
    echo "10) Check Installed Tools"
    echo "11) Exit"
    echo ""
}

dns_gathering() {
    read -p "Enter domain to investigate: " domain
    echo "=== Basic DNS Info ==="
    nslookup $domain
    echo ""
    echo "=== WHOIS Information ==="
    whois $domain
}

check_tools() {
    echo "=== Installed Tools Status ==="
    tools=("nmap" "python" "sqlmap" "sherlock" "nikto" "recon-ng")
    
    for tool in "${tools[@]}"; do
        if command -v $tool &> /dev/null; then
            echo "✓ $tool - INSTALLED"
        else
            echo "✗ $tool - NOT INSTALLED"
        fi
    done
    
    # Check git-based tools
    if [ -d "~/theHarvester" ]; then
        echo "✓ theHarvester - INSTALLED"
    else
        echo "✗ theHarvester - NOT INSTALLED"
    fi
}

while true; do
    show_menu
    read -p "Select an option [1-11]: " choice
    
    case $choice in
        1)
            read -p "Enter target IP or domain: " target
            nmap -sV $target
            ;;
        2)
            read -p "Enter username to search: " username
            sherlock $username
            ;;
        3)
            read -p "Enter domain to lookup: " domain
            whois $domain
            ;;
        4)
            read -p "Enter domain to harvest: " domain
            cd ~/theHarvester && python3 theHarvester.py -d $domain -b google,bing
            ;;
        5)
            read -p "Enter target URL (e.g., http://test.com?id=1): " url
            sqlmap -u "$url" --batch
            ;;
        6)
            read -p "Enter target URL: " url
            cd ~/nikto/program && perl nikto.pl -h "$url"
            ;;
        7)
            recon-ng
            ;;
        8)
            dns_gathering
            ;;
        9)
            echo "Updating packages..."
            pkg update && pkg upgrade
            echo "Updating Python tools..."
            pip install --upgrade sqlmap sherlock recon-ng
            ;;
        10)
            check_tools
            ;;
        11)
            echo "Exiting. Remember to use these tools ethically!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    
    read -p "Press [Enter] to continue..."
done
chmod +x ~/toolkit-menu.sh

