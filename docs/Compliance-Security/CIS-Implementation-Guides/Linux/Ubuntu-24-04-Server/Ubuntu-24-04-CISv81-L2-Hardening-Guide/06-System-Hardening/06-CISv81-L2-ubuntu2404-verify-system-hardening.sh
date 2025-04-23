#!/bin/bash
# =============================================================================
# SCRIPT:  06-CISv81-L2-ubuntu2404-verify-hardening.sh
# AUTHOR:  VintageDon (https://github.com/vintagedon)
# REPO:    https://github.com/vintagedon/proxmox-astronomy-lab
# DATE:    2025-03-16
# LICENSE: MIT
# =============================================================================
# DESCRIPTION:
# Verifies compliance with CIS Ubuntu 24.04 L2 system hardening controls from
# section 1.6.x and 3.x, covering kernel parameters and network protections.
# 
# USAGE:
#   ./06-CISv81-L2-ubuntu2404-verify-hardening.sh
#
# EXIT CODES:
#   0 - All checks passed
#   1 - One or more checks failed
# =============================================================================

# Text formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print section headers
print_section_header() {
    echo -e "${BOLD}${BLUE}$1${NC}"
    echo -e "${BLUE}$(printf '=%.0s' {1..80})${NC}"
}

# Function to print pass/fail
print_status() {
    if [ "$2" -eq 0 ]; then
        echo -e "[ ${GREEN}PASS${NC} ] $1"
    else
        echo -e "[ ${RED}FAIL${NC} ] $1"
    fi
}

# Function to display info
print_info() {
    echo -e "[ ${YELLOW}INFO${NC} ] $1"
}

# Main function
main() {
    print_section_header "CIS Ubuntu 24.04 LTS - Section 1.6.x & 3.x: System Hardening"
    echo "Running checks for system hardening configuration..."
    echo ""

    # Section 1.6 - Mandatory Access Control
    print_section_header "1.6 Mandatory Access Control"
    check_1_6_1_1  # Ensure AppArmor is installed
    check_1_6_1_2  # Ensure AppArmor is enabled in the bootloader configuration
    check_1_6_1_3  # Ensure all AppArmor profiles are in enforce or complain mode
    check_1_6_1_4  # Ensure all AppArmor profiles are enforcing

    # Section 3.1 - Network Parameters (Host Only)
    print_section_header "3.1 Network Parameters (Host Only)"
    check_3_1_1  # Ensure IP forwarding is disabled
    check_3_1_2  # Ensure packet redirect sending is disabled
    
    # Section 3.2 - Network Parameters (Host and Router)
    print_section_header "3.2 Network Parameters (Host and Router)"
    check_3_2_1  # Ensure source routed packets are not accepted
    check_3_2_2  # Ensure ICMP redirects are not accepted
    check_3_2_3  # Ensure secure ICMP redirects are not accepted
    check_3_2_4  # Ensure suspicious packets are logged
    check_3_2_5  # Ensure broadcast ICMP requests are ignored
    check_3_2_6  # Ensure bogus ICMP responses are ignored
    check_3_2_7  # Ensure Reverse Path Filtering is enabled
    check_3_2_8  # Ensure TCP SYN Cookies is enabled
    check_3_2_9  # Ensure IPv6 router advertisements are not accepted
    
    # Section 3.3 - Uncommon Network Protocols
    print_section_header "3.3 Uncommon Network Protocols"
    check_3_3_1  # Ensure DCCP is disabled
    check_3_3_2  # Ensure SCTP is disabled
    check_3_3_3  # Ensure RDS is disabled
    check_3_3_4  # Ensure TIPC is disabled
    
    # Section 3.4 - Firewall Configuration
    print_section_header "3.4 Firewall Configuration"
    check_3_4_1_1  # Ensure ufw is installed
    check_3_4_1_2  # Ensure iptables-persistent is not installed
    check_3_4_1_3  # Ensure ufw service is enabled
    check_3_4_1_4  # Ensure ufw loopback traffic is configured
    check_3_4_1_5  # Ensure ufw outbound connections are configured
    check_3_4_1_6  # Ensure ufw firewall rules exist for all open ports
    check_3_4_1_7  # Ensure ufw default deny firewall policy
    
    echo ""
    echo -e "${BOLD}Check complete.${NC} Review the results above for any needed remediation."
}

# ==== SECTION 1.6: MANDATORY ACCESS CONTROL ====

# 1.6.1.1 Ensure AppArmor is installed
check_1_6_1_1() {
    echo -e "\n${BOLD}1.6.1.1 Ensure AppArmor is installed${NC}"
    
    APPARMOR_INSTALLED=$(dpkg-query -W -f='${Status}' apparmor 2>/dev/null | grep -c "ok installed")
    APPARMOR_UTILS_INSTALLED=$(dpkg-query -W -f='${Status}' apparmor-utils 2>/dev/null | grep -c "ok installed")
    
    if [ "$APPARMOR_INSTALLED" -eq 1 ] && [ "$APPARMOR_UTILS_INSTALLED" -eq 1 ]; then
        print_status "AppArmor and apparmor-utils are installed" 0
    else
        print_status "AppArmor and/or apparmor-utils are not installed" 1
        echo "Install with: sudo apt install apparmor apparmor-utils"
    fi
}

# 1.6.1.2 Ensure AppArmor is enabled in the bootloader configuration
check_1_6_1_2() {
    echo -e "\n${BOLD}1.6.1.2 Ensure AppArmor is enabled in the bootloader configuration${NC}"
    
    GRUB_APPARMOR_ENABLED=$(grep "^\s*GRUB_CMDLINE_LINUX=.*apparmor=1" /etc/default/grub)
    GRUB_SECURITY_ENABLED=$(grep "^\s*GRUB_CMDLINE_LINUX=.*security=apparmor" /etc/default/grub)
    
    if [ -n "$GRUB_APPARMOR_ENABLED" ] && [ -n "$GRUB_SECURITY_ENABLED" ]; then
        print_status "AppArmor is enabled in the bootloader configuration" 0
    else
        print_status "AppArmor is not enabled in the bootloader configuration" 1
        echo "Current bootloader configuration:"
        grep "^\s*GRUB_CMDLINE_LINUX=" /etc/default/grub
        echo "Edit /etc/default/grub and add 'apparmor=1 security=apparmor' to GRUB_CMDLINE_LINUX"
        echo "Then run: sudo update-grub"
    fi
}

# 1.6.1.3 Ensure all AppArmor profiles are in enforce or complain mode
check_1_6_1_3() {
    echo -e "\n${BOLD}1.6.1.3 Ensure all AppArmor profiles are in enforce or complain mode${NC}"
    
    if command -v apparmor_status > /dev/null 2>&1; then
        UNCONFINED_PROCESSES=$(apparmor_status | grep "processes are unconfined" | awk '{print $1}')
        
        if [ "$UNCONFINED_PROCESSES" = "0" ]; then
            print_status "All AppArmor profiles are in enforce or complain mode" 0
        else
            print_status "Some processes are unconfined by AppArmor" 1
            echo "Current AppArmor status:"
            apparmor_status | grep -A 2 "processes are unconfined"
            echo "Configure AppArmor profiles for unconfined processes"
        fi
    else
        print_status "AppArmor status utility not found" 1
        echo "Install with: sudo apt install apparmor-utils"
    fi
}

# 1.6.1.4 Ensure all AppArmor profiles are enforcing
check_1_6_1_4() {
    echo -e "\n${BOLD}1.6.1.4 Ensure all AppArmor profiles are enforcing${NC}"
    
    if command -v apparmor_status > /dev/null 2>&1; then
        PROFILES_IN_COMPLAIN_MODE=$(apparmor_status | grep "profiles are in complain mode" | awk '{print $1}')
        
        if [ "$PROFILES_IN_COMPLAIN_MODE" = "0" ]; then
            print_status "All AppArmor profiles are enforcing" 0
        else
            print_status "Some AppArmor profiles are in complain mode" 1
            echo "Current AppArmor status:"
            apparmor_status | grep -A 2 "profiles are in complain mode"
            echo "To set all profiles to enforce mode: sudo aa-enforce /etc/apparmor.d/*"
        fi
    else
        print_status "AppArmor status utility not found" 1
        echo "Install with: sudo apt install apparmor-utils"
    fi
}

# ==== SECTION 3.1: NETWORK PARAMETERS (HOST ONLY) ====

# 3.1.1 Ensure IP forwarding is disabled
check_3_1_1() {
    echo -e "\n${BOLD}3.1.1 Ensure IP forwarding is disabled${NC}"
    
    IPV4_FORWARD=$(sysctl net.ipv4.ip_forward 2>/dev/null | awk '{print $3}')
    IPV6_FORWARD=$(sysctl net.ipv6.conf.all.forwarding 2>/dev/null | awk '{print $3}')
    
    IPV4_FORWARD_FILE=$(grep -r "^\s*net\.ipv4\.ip_forward\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV6_FORWARD_FILE=$(grep -r "^\s*net\.ipv6\.conf\.all\.forwarding\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_FORWARD" = "0" ] && [ -z "$IPV4_FORWARD_FILE" ] && ([ -z "$IPV6_FORWARD" ] || [ "$IPV6_FORWARD" = "0" ]) && [ -z "$IPV6_FORWARD_FILE" ]; then
        print_status "IP forwarding is disabled" 0
    else
        print_status "IP forwarding is not disabled" 1
        echo "Current IPv4 forwarding: net.ipv4.ip_forward = $IPV4_FORWARD"
        [ -n "$IPV4_FORWARD_FILE" ] && echo "IPv4 forwarding enabled in file: $IPV4_FORWARD_FILE"
        [ -n "$IPV6_FORWARD" ] && echo "Current IPv6 forwarding: net.ipv6.conf.all.forwarding = $IPV6_FORWARD"
        [ -n "$IPV6_FORWARD_FILE" ] && echo "IPv6 forwarding enabled in file: $IPV6_FORWARD_FILE"
        echo "To disable IP forwarding, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.ip_forward = 0"
        echo "To disable IPv6 forwarding, add or modify the following in /etc/sysctl.d/60-netipv6_sysctl.conf:"
        echo "net.ipv6.conf.all.forwarding = 0"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.1.2 Ensure packet redirect sending is disabled
check_3_1_2() {
    echo -e "\n${BOLD}3.1.2 Ensure packet redirect sending is disabled${NC}"
    
    IPV4_SEND_REDIRECTS_ALL=$(sysctl net.ipv4.conf.all.send_redirects 2>/dev/null | awk '{print $3}')
    IPV4_SEND_REDIRECTS_DEFAULT=$(sysctl net.ipv4.conf.default.send_redirects 2>/dev/null | awk '{print $3}')
    
    IPV4_SEND_REDIRECTS_ALL_FILE=$(grep -r "^\s*net\.ipv4\.conf\.all\.send_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV4_SEND_REDIRECTS_DEFAULT_FILE=$(grep -r "^\s*net\.ipv4\.conf\.default\.send_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_SEND_REDIRECTS_ALL" = "0" ] && [ "$IPV4_SEND_REDIRECTS_DEFAULT" = "0" ] && [ -z "$IPV4_SEND_REDIRECTS_ALL_FILE" ] && [ -z "$IPV4_SEND_REDIRECTS_DEFAULT_FILE" ]; then
        print_status "Packet redirect sending is disabled" 0
    else
        print_status "Packet redirect sending is not disabled" 1
        echo "Current settings:"
        echo "net.ipv4.conf.all.send_redirects = $IPV4_SEND_REDIRECTS_ALL"
        echo "net.ipv4.conf.default.send_redirects = $IPV4_SEND_REDIRECTS_DEFAULT"
        [ -n "$IPV4_SEND_REDIRECTS_ALL_FILE" ] && echo "send_redirects enabled in file: $IPV4_SEND_REDIRECTS_ALL_FILE"
        [ -n "$IPV4_SEND_REDIRECTS_DEFAULT_FILE" ] && echo "send_redirects enabled in file: $IPV4_SEND_REDIRECTS_DEFAULT_FILE"
        echo "To disable packet redirect sending, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.conf.all.send_redirects = 0"
        echo "net.ipv4.conf.default.send_redirects = 0"
        echo "Then run: sudo sysctl -p"
    fi
}

# ==== SECTION 3.2: NETWORK PARAMETERS (HOST AND ROUTER) ====

# 3.2.1 Ensure source routed packets are not accepted
check_3_2_1() {
    echo -e "\n${BOLD}3.2.1 Ensure source routed packets are not accepted${NC}"
    
    IPV4_SRC_ROUTE_ALL=$(sysctl net.ipv4.conf.all.accept_source_route 2>/dev/null | awk '{print $3}')
    IPV4_SRC_ROUTE_DEFAULT=$(sysctl net.ipv4.conf.default.accept_source_route 2>/dev/null | awk '{print $3}')
    IPV6_SRC_ROUTE_ALL=$(sysctl net.ipv6.conf.all.accept_source_route 2>/dev/null | awk '{print $3}')
    IPV6_SRC_ROUTE_DEFAULT=$(sysctl net.ipv6.conf.default.accept_source_route 2>/dev/null | awk '{print $3}')
    
    IPV4_SRC_ROUTE_ALL_FILE=$(grep -r "^\s*net\.ipv4\.conf\.all\.accept_source_route\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV4_SRC_ROUTE_DEFAULT_FILE=$(grep -r "^\s*net\.ipv4\.conf\.default\.accept_source_route\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV6_SRC_ROUTE_ALL_FILE=$(grep -r "^\s*net\.ipv6\.conf\.all\.accept_source_route\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV6_SRC_ROUTE_DEFAULT_FILE=$(grep -r "^\s*net\.ipv6\.conf\.default\.accept_source_route\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_SRC_ROUTE_ALL" = "0" ] && [ "$IPV4_SRC_ROUTE_DEFAULT" = "0" ] && 
       ([ -z "$IPV6_SRC_ROUTE_ALL" ] || [ "$IPV6_SRC_ROUTE_ALL" = "0" ]) && 
       ([ -z "$IPV6_SRC_ROUTE_DEFAULT" ] || [ "$IPV6_SRC_ROUTE_DEFAULT" = "0" ]) &&
       [ -z "$IPV4_SRC_ROUTE_ALL_FILE" ] && [ -z "$IPV4_SRC_ROUTE_DEFAULT_FILE" ] &&
       [ -z "$IPV6_SRC_ROUTE_ALL_FILE" ] && [ -z "$IPV6_SRC_ROUTE_DEFAULT_FILE" ]; then
        print_status "Source routed packets are not accepted" 0
    else
        print_status "Source routed packets are accepted" 1
        echo "Current IPv4 settings:"
        echo "net.ipv4.conf.all.accept_source_route = $IPV4_SRC_ROUTE_ALL"
        echo "net.ipv4.conf.default.accept_source_route = $IPV4_SRC_ROUTE_DEFAULT"
        [ -n "$IPV6_SRC_ROUTE_ALL" ] && echo "net.ipv6.conf.all.accept_source_route = $IPV6_SRC_ROUTE_ALL"
        [ -n "$IPV6_SRC_ROUTE_DEFAULT" ] && echo "net.ipv6.conf.default.accept_source_route = $IPV6_SRC_ROUTE_DEFAULT"
        
        [ -n "$IPV4_SRC_ROUTE_ALL_FILE" ] && echo "IPv4 source route enabled in file: $IPV4_SRC_ROUTE_ALL_FILE"
        [ -n "$IPV4_SRC_ROUTE_DEFAULT_FILE" ] && echo "IPv4 source route enabled in file: $IPV4_SRC_ROUTE_DEFAULT_FILE"
        [ -n "$IPV6_SRC_ROUTE_ALL_FILE" ] && echo "IPv6 source route enabled in file: $IPV6_SRC_ROUTE_ALL_FILE"
        [ -n "$IPV6_SRC_ROUTE_DEFAULT_FILE" ] && echo "IPv6 source route enabled in file: $IPV6_SRC_ROUTE_DEFAULT_FILE"
        
        echo "To disable source routed packets, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.conf.all.accept_source_route = 0"
        echo "net.ipv4.conf.default.accept_source_route = 0"
        echo "To disable IPv6 source routed packets, add or modify the following in /etc/sysctl.d/60-netipv6_sysctl.conf:"
        echo "net.ipv6.conf.all.accept_source_route = 0"
        echo "net.ipv6.conf.default.accept_source_route = 0"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.2.2 Ensure ICMP redirects are not accepted
check_3_2_2() {
    echo -e "\n${BOLD}3.2.2 Ensure ICMP redirects are not accepted${NC}"
    
    IPV4_REDIRECTS_ALL=$(sysctl net.ipv4.conf.all.accept_redirects 2>/dev/null | awk '{print $3}')
    IPV4_REDIRECTS_DEFAULT=$(sysctl net.ipv4.conf.default.accept_redirects 2>/dev/null | awk '{print $3}')
    IPV6_REDIRECTS_ALL=$(sysctl net.ipv6.conf.all.accept_redirects 2>/dev/null | awk '{print $3}')
    IPV6_REDIRECTS_DEFAULT=$(sysctl net.ipv6.conf.default.accept_redirects 2>/dev/null | awk '{print $3}')
    
    IPV4_REDIRECTS_ALL_FILE=$(grep -r "^\s*net\.ipv4\.conf\.all\.accept_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV4_REDIRECTS_DEFAULT_FILE=$(grep -r "^\s*net\.ipv4\.conf\.default\.accept_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV6_REDIRECTS_ALL_FILE=$(grep -r "^\s*net\.ipv6\.conf\.all\.accept_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV6_REDIRECTS_DEFAULT_FILE=$(grep -r "^\s*net\.ipv6\.conf\.default\.accept_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_REDIRECTS_ALL" = "0" ] && [ "$IPV4_REDIRECTS_DEFAULT" = "0" ] && 
       ([ -z "$IPV6_REDIRECTS_ALL" ] || [ "$IPV6_REDIRECTS_ALL" = "0" ]) && 
       ([ -z "$IPV6_REDIRECTS_DEFAULT" ] || [ "$IPV6_REDIRECTS_DEFAULT" = "0" ]) &&
       [ -z "$IPV4_REDIRECTS_ALL_FILE" ] && [ -z "$IPV4_REDIRECTS_DEFAULT_FILE" ] &&
       [ -z "$IPV6_REDIRECTS_ALL_FILE" ] && [ -z "$IPV6_REDIRECTS_DEFAULT_FILE" ]; then
        print_status "ICMP redirects are not accepted" 0
    else
        print_status "ICMP redirects are accepted" 1
        echo "Current IPv4 settings:"
        echo "net.ipv4.conf.all.accept_redirects = $IPV4_REDIRECTS_ALL"
        echo "net.ipv4.conf.default.accept_redirects = $IPV4_REDIRECTS_DEFAULT"
        [ -n "$IPV6_REDIRECTS_ALL" ] && echo "net.ipv6.conf.all.accept_redirects = $IPV6_REDIRECTS_ALL"
        [ -n "$IPV6_REDIRECTS_DEFAULT" ] && echo "net.ipv6.conf.default.accept_redirects = $IPV6_REDIRECTS_DEFAULT"
        
        [ -n "$IPV4_REDIRECTS_ALL_FILE" ] && echo "IPv4 redirects enabled in file: $IPV4_REDIRECTS_ALL_FILE"
        [ -n "$IPV4_REDIRECTS_DEFAULT_FILE" ] && echo "IPv4 redirects enabled in file: $IPV4_REDIRECTS_DEFAULT_FILE"
        [ -n "$IPV6_REDIRECTS_ALL_FILE" ] && echo "IPv6 redirects enabled in file: $IPV6_REDIRECTS_ALL_FILE"
        [ -n "$IPV6_REDIRECTS_DEFAULT_FILE" ] && echo "IPv6 redirects enabled in file: $IPV6_REDIRECTS_DEFAULT_FILE"
        
        echo "To disable ICMP redirects, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.conf.all.accept_redirects = 0"
        echo "net.ipv4.conf.default.accept_redirects = 0"
        echo "To disable IPv6 ICMP redirects, add or modify the following in /etc/sysctl.d/60-netipv6_sysctl.conf:"
        echo "net.ipv6.conf.all.accept_redirects = 0"
        echo "net.ipv6.conf.default.accept_redirects = 0"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.2.3 Ensure secure ICMP redirects are not accepted
check_3_2_3() {
    echo -e "\n${BOLD}3.2.3 Ensure secure ICMP redirects are not accepted${NC}"
    
    IPV4_SECURE_REDIRECTS_ALL=$(sysctl net.ipv4.conf.all.secure_redirects 2>/dev/null | awk '{print $3}')
    IPV4_SECURE_REDIRECTS_DEFAULT=$(sysctl net.ipv4.conf.default.secure_redirects 2>/dev/null | awk '{print $3}')
    
    IPV4_SECURE_REDIRECTS_ALL_FILE=$(grep -r "^\s*net\.ipv4\.conf\.all\.secure_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV4_SECURE_REDIRECTS_DEFAULT_FILE=$(grep -r "^\s*net\.ipv4\.conf\.default\.secure_redirects\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_SECURE_REDIRECTS_ALL" = "0" ] && [ "$IPV4_SECURE_REDIRECTS_DEFAULT" = "0" ] &&
       [ -z "$IPV4_SECURE_REDIRECTS_ALL_FILE" ] && [ -z "$IPV4_SECURE_REDIRECTS_DEFAULT_FILE" ]; then
        print_status "Secure ICMP redirects are not accepted" 0
    else
        print_status "Secure ICMP redirects are accepted" 1
        echo "Current settings:"
        echo "net.ipv4.conf.all.secure_redirects = $IPV4_SECURE_REDIRECTS_ALL"
        echo "net.ipv4.conf.default.secure_redirects = $IPV4_SECURE_REDIRECTS_DEFAULT"
        [ -n "$IPV4_SECURE_REDIRECTS_ALL_FILE" ] && echo "Secure redirects enabled in file: $IPV4_SECURE_REDIRECTS_ALL_FILE"
        [ -n "$IPV4_SECURE_REDIRECTS_DEFAULT_FILE" ] && echo "Secure redirects enabled in file: $IPV4_SECURE_REDIRECTS_DEFAULT_FILE"
        echo "To disable secure ICMP redirects, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.conf.all.secure_redirects = 0"
        echo "net.ipv4.conf.default.secure_redirects = 0"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.2.4 Ensure suspicious packets are logged
check_3_2_4() {
    echo -e "\n${BOLD}3.2.4 Ensure suspicious packets are logged${NC}"
    
    IPV4_LOG_MARTIANS_ALL=$(sysctl net.ipv4.conf.all.log_martians 2>/dev/null | awk '{print $3}')
    IPV4_LOG_MARTIANS_DEFAULT=$(sysctl net.ipv4.conf.default.log_martians 2>/dev/null | awk '{print $3}')
    
    IPV4_LOG_MARTIANS_ALL_FILE=$(grep -r "^\s*net\.ipv4\.conf\.all\.log_martians\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV4_LOG_MARTIANS_DEFAULT_FILE=$(grep -r "^\s*net\.ipv4\.conf\.default\.log_martians\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_LOG_MARTIANS_ALL" = "1" ] && [ "$IPV4_LOG_MARTIANS_DEFAULT" = "1" ] &&
       [ -z "$IPV4_LOG_MARTIANS_ALL_FILE" ] && [ -z "$IPV4_LOG_MARTIANS_DEFAULT_FILE" ]; then
        print_status "Suspicious packets are logged" 0
    else
        print_status "Suspicious packets are not logged" 1
        echo "Current settings:"
        echo "net.ipv4.conf.all.log_martians = $IPV4_LOG_MARTIANS_ALL"
        echo "net.ipv4.conf.default.log_martians = $IPV4_LOG_MARTIANS_DEFAULT"
        [ -n "$IPV4_LOG_MARTIANS_ALL_FILE" ] && echo "log_martians disabled in file: $IPV4_LOG_MARTIANS_ALL_FILE"
        [ -n "$IPV4_LOG_MARTIANS_DEFAULT_FILE" ] && echo "log_martians disabled in file: $IPV4_LOG_MARTIANS_DEFAULT_FILE"
        echo "To enable suspicious packet logging, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.conf.all.log_martians = 1"
        echo "net.ipv4.conf.default.log_martians = 1"
        echo "Then run: sudo sysctl -p"
    fi
}

# Add more check functions for each control (3.2.5 through 3.4.1.7)
# For example:

# 3.2.5 Ensure broadcast ICMP requests are ignored
check_3_2_5() {
    echo -e "\n${BOLD}3.2.5 Ensure broadcast ICMP requests are ignored${NC}"
    
    IPV4_ICMP_ECHO_BROADCAST=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts 2>/dev/null | awk '{print $3}')
    IPV4_ICMP_ECHO_BROADCAST_FILE=$(grep -r "^\s*net\.ipv4\.icmp_echo_ignore_broadcasts\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_ICMP_ECHO_BROADCAST" = "1" ] && [ -z "$IPV4_ICMP_ECHO_BROADCAST_FILE" ]; then
        print_status "Broadcast ICMP requests are ignored" 0
    else
        print_status "Broadcast ICMP requests are not ignored" 1
        echo "Current setting: net.ipv4.icmp_echo_ignore_broadcasts = $IPV4_ICMP_ECHO_BROADCAST"
        [ -n "$IPV4_ICMP_ECHO_BROADCAST_FILE" ] && echo "ICMP broadcast echo disabled in file: $IPV4_ICMP_ECHO_BROADCAST_FILE"
        echo "To ignore broadcast ICMP requests, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.icmp_echo_ignore_broadcasts = 1"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.2.6 Ensure bogus ICMP responses are ignored
check_3_2_6() {
    echo -e "\n${BOLD}3.2.6 Ensure bogus ICMP responses are ignored${NC}"
    
    IPV4_ICMP_IGNORE_BOGUS=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses 2>/dev/null | awk '{print $3}')
    IPV4_ICMP_IGNORE_BOGUS_FILE=$(grep -r "^\s*net\.ipv4\.icmp_ignore_bogus_error_responses\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_ICMP_IGNORE_BOGUS" = "1" ] && [ -z "$IPV4_ICMP_IGNORE_BOGUS_FILE" ]; then
        print_status "Bogus ICMP responses are ignored" 0
    else
        print_status "Bogus ICMP responses are not ignored" 1
        echo "Current setting: net.ipv4.icmp_ignore_bogus_error_responses = $IPV4_ICMP_IGNORE_BOGUS"
        [ -n "$IPV4_ICMP_IGNORE_BOGUS_FILE" ] && echo "ICMP bogus response setting disabled in file: $IPV4_ICMP_IGNORE_BOGUS_FILE"
        echo "To ignore bogus ICMP responses, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.icmp_ignore_bogus_error_responses = 1"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.2.7 Ensure Reverse Path Filtering is enabled
check_3_2_7() {
    echo -e "\n${BOLD}3.2.7 Ensure Reverse Path Filtering is enabled${NC}"
    
    IPV4_RP_FILTER_ALL=$(sysctl net.ipv4.conf.all.rp_filter 2>/dev/null | awk '{print $3}')
    IPV4_RP_FILTER_DEFAULT=$(sysctl net.ipv4.conf.default.rp_filter 2>/dev/null | awk '{print $3}')
    
    IPV4_RP_FILTER_ALL_FILE=$(grep -r "^\s*net\.ipv4\.conf\.all\.rp_filter\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV4_RP_FILTER_DEFAULT_FILE=$(grep -r "^\s*net\.ipv4\.conf\.default\.rp_filter\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_RP_FILTER_ALL" = "1" ] && [ "$IPV4_RP_FILTER_DEFAULT" = "1" ] && [ -z "$IPV4_RP_FILTER_ALL_FILE" ] && [ -z "$IPV4_RP_FILTER_DEFAULT_FILE" ]; then
        print_status "Reverse Path Filtering is enabled" 0
    else
        print_status "Reverse Path Filtering is not enabled" 1
        echo "Current settings:"
        echo "net.ipv4.conf.all.rp_filter = $IPV4_RP_FILTER_ALL"
        echo "net.ipv4.conf.default.rp_filter = $IPV4_RP_FILTER_DEFAULT"
        [ -n "$IPV4_RP_FILTER_ALL_FILE" ] && echo "rp_filter disabled in file: $IPV4_RP_FILTER_ALL_FILE"
        [ -n "$IPV4_RP_FILTER_DEFAULT_FILE" ] && echo "rp_filter disabled in file: $IPV4_RP_FILTER_DEFAULT_FILE"
        echo "To enable reverse path filtering, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.conf.all.rp_filter = 1"
        echo "net.ipv4.conf.default.rp_filter = 1"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.2.8 Ensure TCP SYN Cookies is enabled
check_3_2_8() {
    echo -e "\n${BOLD}3.2.8 Ensure TCP SYN Cookies is enabled${NC}"
    
    IPV4_TCP_SYNCOOKIES=$(sysctl net.ipv4.tcp_syncookies 2>/dev/null | awk '{print $3}')
    IPV4_TCP_SYNCOOKIES_FILE=$(grep -r "^\s*net\.ipv4\.tcp_syncookies\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if [ "$IPV4_TCP_SYNCOOKIES" = "1" ] && [ -z "$IPV4_TCP_SYNCOOKIES_FILE" ]; then
        print_status "TCP SYN Cookies is enabled" 0
    else
        print_status "TCP SYN Cookies is not enabled" 1
        echo "Current setting: net.ipv4.tcp_syncookies = $IPV4_TCP_SYNCOOKIES"
        [ -n "$IPV4_TCP_SYNCOOKIES_FILE" ] && echo "TCP SYN Cookies disabled in file: $IPV4_TCP_SYNCOOKIES_FILE"
        echo "To enable TCP SYN Cookies, add or modify the following in /etc/sysctl.d/60-netipv4_sysctl.conf:"
        echo "net.ipv4.tcp_syncookies = 1"
        echo "Then run: sudo sysctl -p"
    fi
}

# 3.2.9 Ensure IPv6 router advertisements are not accepted
check_3_2_9() {
    echo -e "\n${BOLD}3.2.9 Ensure IPv6 router advertisements are not accepted${NC}"
    
    IPV6_RA_ALL=$(sysctl net.ipv6.conf.all.accept_ra 2>/dev/null | awk '{print $3}')
    IPV6_RA_DEFAULT=$(sysctl net.ipv6.conf.default.accept_ra 2>/dev/null | awk '{print $3}')
    
    IPV6_RA_ALL_FILE=$(grep -r "^\s*net\.ipv6\.conf\.all\.accept_ra\s*=\s*[1-2]" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    IPV6_RA_DEFAULT_FILE=$(grep -r "^\s*net\.ipv6\.conf\.default\.accept_ra\s*=\s*[1-2]" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null)
    
    if ([ -z "$IPV6_RA_ALL" ] || [ "$IPV6_RA_ALL" = "0" ]) && 
       ([ -z "$IPV6_RA_DEFAULT" ] || [ "$IPV6_RA_DEFAULT" = "0" ]) && 
       [ -z "$IPV6_RA_ALL_FILE" ] && [ -z "$IPV6_RA_DEFAULT_FILE" ]; then
        print_status "IPv6 router advertisements are not accepted" 0
    else
        print_status "IPv6 router advertisements are accepted" 1
        [ -n "$IPV6_RA_ALL" ] && echo "Current setting: net.ipv6.conf.all.accept_ra = $IPV6_RA_ALL"
        [ -n "$IPV6_RA_DEFAULT" ] && echo "Current setting: net.ipv6.conf.default.accept_ra = $IPV6_RA_DEFAULT"
        [ -n "$IPV6_RA_ALL_FILE" ] && echo "IPv6 router advertisements enabled in file: $IPV6_RA_ALL_FILE"
        [ -n "$IPV6_RA_DEFAULT_FILE" ] && echo "IPv6 router advertisements enabled in file: $IPV6_RA_DEFAULT_FILE"
        echo "To disable IPv6 router advertisements, add or modify the following in /etc/sysctl.d/60-netipv6_sysctl.conf:"
        echo "net.ipv6.conf.all.accept_ra = 0"
        echo "net.ipv6.conf.default.accept_ra = 0"
        echo "Then run: sudo sysctl -p"
    fi
}

# ==== SECTION 3.3: UNCOMMON NETWORK PROTOCOLS ====

# 3.3.1 Ensure DCCP is disabled
check_3_3_1() {
    echo -e "\n${BOLD}3.3.1 Ensure DCCP is disabled${NC}"
    
    DCCP_LOADED=$(lsmod | grep -c dccp)
    DCCP_MODULE_FILE=$(grep -r "^\s*install\s+dccp\s+/bin/true" /etc/modprobe.d/*.conf 2>/dev/null)
    DCCP_BLACKLIST_FILE=$(grep -r "^\s*blacklist\s+dccp" /etc/modprobe.d/*.conf 2>/dev/null)
    
    if [ "$DCCP_LOADED" = "0" ] && ([ -n "$DCCP_MODULE_FILE" ] || [ -n "$DCCP_BLACKLIST_FILE" ]); then
        print_status "DCCP is disabled" 0
    else
        print_status "DCCP is not disabled" 1
        [ "$DCCP_LOADED" != "0" ] && echo "DCCP module is currently loaded"
        [ -z "$DCCP_MODULE_FILE" ] && [ -z "$DCCP_BLACKLIST_FILE" ] && echo "DCCP module is not blacklisted"
        echo "To disable DCCP, create file /etc/modprobe.d/dccp.conf with content:"
        echo "install dccp /bin/true"
        echo "blacklist dccp"
        echo "Then run: sudo modprobe -r dccp"
    fi
}

# 3.3.2 Ensure SCTP is disabled
check_3_3_2() {
    echo -e "\n${BOLD}3.3.2 Ensure SCTP is disabled${NC}"
    
    SCTP_LOADED=$(lsmod | grep -c sctp)
    SCTP_MODULE_FILE=$(grep -r "^\s*install\s+sctp\s+/bin/true" /etc/modprobe.d/*.conf 2>/dev/null)
    SCTP_BLACKLIST_FILE=$(grep -r "^\s*blacklist\s+sctp" /etc/modprobe.d/*.conf 2>/dev/null)
    
    if [ "$SCTP_LOADED" = "0" ] && ([ -n "$SCTP_MODULE_FILE" ] || [ -n "$SCTP_BLACKLIST_FILE" ]); then
        print_status "SCTP is disabled" 0
    else
        print_status "SCTP is not disabled" 1
        [ "$SCTP_LOADED" != "0" ] && echo "SCTP module is currently loaded"
        [ -z "$SCTP_MODULE_FILE" ] && [ -z "$SCTP_BLACKLIST_FILE" ] && echo "SCTP module is not blacklisted"
        echo "To disable SCTP, create file /etc/modprobe.d/sctp.conf with content:"
        echo "install sctp /bin/true"
        echo "blacklist sctp"
        echo "Then run: sudo modprobe -r sctp"
    fi
}

# 3.3.3 Ensure RDS is disabled
check_3_3_3() {
    echo -e "\n${BOLD}3.3.3 Ensure RDS is disabled${NC}"
    
    RDS_LOADED=$(lsmod | grep -c rds)
    RDS_MODULE_FILE=$(grep -r "^\s*install\s+rds\s+/bin/true" /etc/modprobe.d/*.conf 2>/dev/null)
    RDS_BLACKLIST_FILE=$(grep -r "^\s*blacklist\s+rds" /etc/modprobe.d/*.conf 2>/dev/null)
    
    if [ "$RDS_LOADED" = "0" ] && ([ -n "$RDS_MODULE_FILE" ] || [ -n "$RDS_BLACKLIST_FILE" ]); then
        print_status "RDS is disabled" 0
    else
        print_status "RDS is not disabled" 1
        [ "$RDS_LOADED" != "0" ] && echo "RDS module is currently loaded"
        [ -z "$RDS_MODULE_FILE" ] && [ -z "$RDS_BLACKLIST_FILE" ] && echo "RDS module is not blacklisted"
        echo "To disable RDS, create file /etc/modprobe.d/rds.conf with content:"
        echo "install rds /bin/true"
        echo "blacklist rds"
        echo "Then run: sudo modprobe -r rds"
    fi
}

# 3.3.4 Ensure TIPC is disabled
check_3_3_4() {
    echo -e "\n${BOLD}3.3.4 Ensure TIPC is disabled${NC}"
    
    TIPC_LOADED=$(lsmod | grep -c tipc)
    TIPC_MODULE_FILE=$(grep -r "^\s*install\s+tipc\s+/bin/true" /etc/modprobe.d/*.conf 2>/dev/null)
    TIPC_BLACKLIST_FILE=$(grep -r "^\s*blacklist\s+tipc" /etc/modprobe.d/*.conf 2>/dev/null)
    
    if [ "$TIPC_LOADED" = "0" ] && ([ -n "$TIPC_MODULE_FILE" ] || [ -n "$TIPC_BLACKLIST_FILE" ]); then
        print_status "TIPC is disabled" 0
    else
        print_status "TIPC is not disabled" 1
        [ "$TIPC_LOADED" != "0" ] && echo "TIPC module is currently loaded"
        [ -z "$TIPC_MODULE_FILE" ] && [ -z "$TIPC_BLACKLIST_FILE" ] && echo "TIPC module is not blacklisted"
        echo "To disable TIPC, create file /etc/modprobe.d/tipc.conf with content:"
        echo "install tipc /bin/true"
        echo "blacklist tipc"
        echo "Then run: sudo modprobe -r tipc"
    fi
}

# ==== SECTION 3.4: FIREWALL CONFIGURATION ====

# 3.4.1.1 Ensure ufw is installed
check_3_4_1_1() {
    echo -e "\n${BOLD}3.4.1.1 Ensure ufw is installed${NC}"
    
    UFW_INSTALLED=$(dpkg-query -W -f='${Status}' ufw 2>/dev/null | grep -c "ok installed")
    
    if [ "$UFW_INSTALLED" -eq 1 ]; then
        print_status "ufw is installed" 0
    else
        print_status "ufw is not installed" 1
        echo "Install ufw with: sudo apt install ufw"
    fi
}

# 3.4.1.2 Ensure iptables-persistent is not installed
check_3_4_1_2() {
    echo -e "\n${BOLD}3.4.1.2 Ensure iptables-persistent is not installed${NC}"
    
    IPTABLES_PERSISTENT_INSTALLED=$(dpkg-query -W -f='${Status}' iptables-persistent 2>/dev/null | grep -c "ok installed")
    
    if [ "$IPTABLES_PERSISTENT_INSTALLED" -eq 0 ]; then
        print_status "iptables-persistent is not installed" 0
    else
        print_status "iptables-persistent is installed" 1
        echo "Remove iptables-persistent with: sudo apt purge iptables-persistent"
    fi
}

# 3.4.1.3 Ensure ufw service is enabled
check_3_4_1_3() {
    echo -e "\n${BOLD}3.4.1.3 Ensure ufw service is enabled${NC}"
    
    UFW_ACTIVE=$(systemctl is-active ufw 2>/dev/null || echo "inactive")
    UFW_ENABLED=$(systemctl is-enabled ufw 2>/dev/null || echo "disabled")
    UFW_STATUS=$(ufw status 2>/dev/null)
    
    if [ "$UFW_ACTIVE" = "active" ] && [ "$UFW_ENABLED" = "enabled" ] && [[ "$UFW_STATUS" =~ "Status: active" ]]; then
        print_status "ufw service is enabled and active" 0
    else
        print_status "ufw service is not enabled or not active" 1
        echo "Current status: service active=$UFW_ACTIVE, service enabled=$UFW_ENABLED"
        echo "UFW status: $UFW_STATUS"
        echo "Enable ufw with: sudo ufw enable"
        echo "Enable ufw service with: sudo systemctl enable ufw"
        echo "Start ufw service with: sudo systemctl start ufw"
    fi
}

# 3.4.1.4 Ensure ufw loopback traffic is configured
check_3_4_1_4() {
    echo -e "\n${BOLD}3.4.1.4 Ensure ufw loopback traffic is configured${NC}"
    
    UFW_LOOPBACK_IN_ALLOW=$(ufw status verbose 2>/dev/null | grep -E "Anywhere on lo\s+ALLOW IN\s+Anywhere")
    UFW_LOOPBACK_OUT_ALLOW=$(ufw status verbose 2>/dev/null | grep -E "Anywhere\s+ALLOW OUT\s+Anywhere on lo")
    UFW_LOOPBACK_DENY=$(ufw status verbose 2>/dev/null | grep -E "Anywhere\s+DENY\s+127.0.0.0/8")
    
    if [ -n "$UFW_LOOPBACK_IN_ALLOW" ] && [ -n "$UFW_LOOPBACK_OUT_ALLOW" ] && [ -n "$UFW_LOOPBACK_DENY" ]; then
        print_status "ufw loopback traffic is configured correctly" 0
    else
        print_status "ufw loopback traffic is not configured correctly" 1
        echo "Configure ufw loopback traffic with the following commands:"
        echo "sudo ufw allow in on lo"
        echo "sudo ufw allow out on lo"
        echo "sudo ufw deny in from 127.0.0.0/8"
        echo "sudo ufw deny in from ::1"
    fi
}

# 3.4.1.5 Ensure ufw outbound connections are configured
check_3_4_1_5() {
    echo -e "\n${BOLD}3.4.1.5 Ensure ufw outbound connections are configured${NC}"
    
    UFW_DEFAULT_OUTGOING=$(ufw status verbose 2>/dev/null | grep "Default:" | grep -c "allow (outgoing)")
    
    if [ "$UFW_DEFAULT_OUTGOING" -eq 1 ]; then
        print_status "ufw outbound connections are configured to allow by default" 0
    else
        print_status "ufw outbound connections are not configured to allow by default" 1
        echo "Set default outbound policy to allow with: sudo ufw default allow outgoing"
    fi
}

# 3.4.1.6 Ensure ufw firewall rules exist for all open ports
check_3_4_1_6() {
    echo -e "\n${BOLD}3.4.1.6 Ensure ufw firewall rules exist for all open ports${NC}"
    
    # Get listening ports (Fix: Ensure correct field selection in ss output)
    LISTENING_PORTS=$(ss -tuln | awk 'NR>1 {print $NF}' | awk -F':' '{print $NF}' | sort -n | uniq)

    # Get UFW rules (Fix: Ensure proper regex escaping)
    UFW_RULES=$(ufw status numbered 2>/dev/null | grep -oE '[0-9]+/(tcp|udp)')

    MISSING_PORTS=0

    # Check if each listening port has a corresponding UFW rule
    for PORT in $LISTENING_PORTS; do
        if ! echo "$UFW_RULES" | grep -qE "\b$PORT/(tcp|udp)\b"; then
            MISSING_PORTS=1
            echo "Port $PORT is listening but not explicitly allowed in UFW rules"
        fi
    done

    if [ "$MISSING_PORTS" -eq 0 ]; then
        print_status "ufw firewall rules exist for all open ports" 0
    else
        print_status "ufw firewall rules do not exist for all open ports" 1
        echo "For each open port, create a UFW rule with: sudo ufw allow <port>/<tcp|udp>"
    fi
}


# 3.4.1.7 Ensure ufw default deny firewall policy
check_3_4_1_7() {
    echo -e "\n${BOLD}3.4.1.7 Ensure ufw default deny firewall policy${NC}"
    
    UFW_DEFAULT_INCOMING=$(ufw status verbose 2>/dev/null | grep "Default:" | grep -c "deny (incoming)")
    
    if [ "$UFW_DEFAULT_INCOMING" -eq 1 ]; then
        print_status "ufw default deny firewall policy is set for incoming connections" 0
    else
        print_status "ufw default deny firewall policy is not set for incoming connections" 1
        echo "Set default incoming policy to deny with: sudo ufw default deny incoming"
    fi
}

# Run the main function
main