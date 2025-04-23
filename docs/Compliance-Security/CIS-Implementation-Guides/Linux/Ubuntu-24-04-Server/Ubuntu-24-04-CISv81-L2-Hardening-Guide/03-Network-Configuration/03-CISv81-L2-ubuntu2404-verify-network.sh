#!/bin/bash
# =============================================================================
# Script:  03-CISv81-L2-ubuntu2404-verify-network.sh
# Author:  VintageDon (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L2 network configuration controls:
# - Controls 3.1.1-3.4.4: Network security parameters and configurations
# - Checks for disabled wireless interfaces
# - Verifies secure IP and ICMP settings
# - Validates TCP/IP stack security parameters
# - Checks TCP Wrappers configuration and permissions
#
# Usage:
#   ./03-CISv81-L2-ubuntu2404-verify-network.sh
#
# Exit codes:
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
    print_section_header "CIS Ubuntu 24.04 LTS - Section 3: Network Configuration Checks"
    echo "Running checks for network configuration..."
    echo ""

    # Section 3.1 Network Parameters (Host Only)
    print_section_header "3.1 Network Parameters (Host Only)"
    check_3_1_1 # Ensure wireless interfaces are disabled
    
    # Section 3.2 Network Parameters (Host and Router)
    print_section_header "3.2 Network Parameters (Host and Router)"
    check_3_2_1 # Ensure IP forwarding is disabled
    check_3_2_2 # Ensure packet redirect sending is disabled
    
    # Section 3.3 Network Parameters (Host and Router)
    print_section_header "3.3 Network Parameters (Host and Router)"
    check_3_3_1 # Ensure source routed packets are not accepted
    check_3_3_2 # Ensure ICMP redirects are not accepted
    check_3_3_3 # Ensure secure ICMP redirects are not accepted
    check_3_3_4 # Ensure suspicious packets are logged
    check_3_3_5 # Ensure broadcast ICMP requests are ignored
    check_3_3_6 # Ensure bogus ICMP responses are ignored
    check_3_3_7 # Ensure Reverse Path Filtering is enabled
    check_3_3_8 # Ensure TCP SYN Cookies is enabled
    check_3_3_9 # Ensure IPv6 router advertisements are not accepted
    
    # Section 3.4 Uncommon Network Protocols
    print_section_header "3.4 Uncommon Network Protocols"
    check_3_4_1 # Ensure TCP Wrappers is installed
    check_3_4_2 # Ensure /etc/hosts.allow is configured
    check_3_4_3 # Ensure /etc/hosts.deny is configured
    check_3_4_4 # Ensure permissions on /etc/hosts.allow and /etc/hosts.deny are configured

    echo ""
    echo -e "${BOLD}Check complete.${NC} Review the results above for any needed remediation."
}

# 3.1.1 Ensure wireless interfaces are disabled
check_3_1_1() {
    echo -e "\n${BOLD}3.1.1 Ensure wireless interfaces are disabled${NC}"
    
    # Check for wireless interface kernel modules
    WIRELESS_MODULES=("bluetooth" "ath" "wifi" "iwl" "wext" "wl")
    
    # Check if any wireless modules are loaded
    LOADED_WIRELESS_MODULES=()
    for module in "${WIRELESS_MODULES[@]}"; do
        if lsmod | grep -q "$module"; then
            LOADED_WIRELESS_MODULES+=("$module")
        fi
    done
    
    # Check for wireless interfaces
    WIRELESS_INTERFACES=()
    if command -v iwconfig &> /dev/null; then
        WIRELESS_INTERFACES+=($(iwconfig 2>&1 | grep -v "no wireless" | grep "IEEE" | cut -d ' ' -f 1))
    fi
    
    if command -v iw &> /dev/null; then
        WIRELESS_INTERFACES+=($(iw dev | grep Interface | awk '{print $2}'))
    fi
    
    # Remove duplicates
    WIRELESS_INTERFACES=($(echo "${WIRELESS_INTERFACES[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
    
    if [ ${#LOADED_WIRELESS_MODULES[@]} -eq 0 ] && [ ${#WIRELESS_INTERFACES[@]} -eq 0 ]; then
        print_status "No wireless interfaces detected" 0
    else
        print_status "Wireless interfaces detected" 1
        
        if [ ${#LOADED_WIRELESS_MODULES[@]} -gt 0 ]; then
            echo "The following wireless modules are loaded:"
            printf "  - %s\n" "${LOADED_WIRELESS_MODULES[@]}"
        fi
        
        if [ ${#WIRELESS_INTERFACES[@]} -gt 0 ]; then
            echo "The following wireless interfaces were detected:"
            printf "  - %s\n" "${WIRELESS_INTERFACES[@]}"
        fi
    fi
}

# 3.2.1 Ensure IP forwarding is disabled
check_3_2_1() {
    echo -e "\n${BOLD}3.2.1 Ensure IP forwarding is disabled${NC}"
    
    IPV4_FORWARD=$(sysctl net.ipv4.ip_forward | awk '{print $3}')
    IPV6_FORWARD=$(sysctl net.ipv6.conf.all.forwarding 2>/dev/null | awk '{print $3}')
    
    # Check if the system is a router/gateway
    IS_ROUTER=0
    if ip route | grep -v "default" | grep -q -E '^[0-9]'; then
        IS_ROUTER=1
    fi
    
    if [ "$IPV4_FORWARD" = "0" ] && { [ -z "$IPV6_FORWARD" ] || [ "$IPV6_FORWARD" = "0" ]; }; then
        print_status "IP forwarding is disabled" 0
    else
        if [ $IS_ROUTER -eq 1 ]; then
            print_info "IP forwarding is enabled, but system appears to be a router/gateway"
            echo "This might be intentional if this system serves as a router or gateway."
        else
            print_status "IP forwarding is enabled" 1
            echo "Current sysctl settings:"
            echo "  net.ipv4.ip_forward = $IPV4_FORWARD"
            [ -n "$IPV6_FORWARD" ] && echo "  net.ipv6.conf.all.forwarding = $IPV6_FORWARD"
        fi
    fi
}

# 3.2.2 Ensure packet redirect sending is disabled
check_3_2_2() {
    echo -e "\n${BOLD}3.2.2 Ensure packet redirect sending is disabled${NC}"
    
    # Check current sysctl settings
    ALL_SEND_REDIRECTS=$(sysctl net.ipv4.conf.all.send_redirects 2>/dev/null | awk '{print $3}')
    DEFAULT_SEND_REDIRECTS=$(sysctl net.ipv4.conf.default.send_redirects 2>/dev/null | awk '{print $3}')
    
    if [ "$ALL_SEND_REDIRECTS" = "0" ] && [ "$DEFAULT_SEND_REDIRECTS" = "0" ]; then
        print_status "Packet redirect sending is disabled" 0
    else
        print_status "Packet redirect sending is not fully disabled" 1
        echo "Current sysctl settings:"
        echo "  net.ipv4.conf.all.send_redirects = $ALL_SEND_REDIRECTS"
        echo "  net.ipv4.conf.default.send_redirects = $DEFAULT_SEND_REDIRECTS"
    fi
}

# 3.3.1 Ensure source routed packets are not accepted
check_3_3_1() {
    echo -e "\n${BOLD}3.3.1 Ensure source routed packets are not accepted${NC}"
    
    # Check current sysctl settings for IPv4
    ALL_ACCEPT_SOURCE_ROUTE_IPV4=$(sysctl net.ipv4.conf.all.accept_source_route 2>/dev/null | awk '{print $3}')
    DEFAULT_ACCEPT_SOURCE_ROUTE_IPV4=$(sysctl net.ipv4.conf.default.accept_source_route 2>/dev/null | awk '{print $3}')
    
    # Check current sysctl settings for IPv6 if IPv6 is enabled
    IPV6_ENABLED=0
    if [ -d /proc/sys/net/ipv6 ]; then
        IPV6_ENABLED=1
        ALL_ACCEPT_SOURCE_ROUTE_IPV6=$(sysctl net.ipv6.conf.all.accept_source_route 2>/dev/null | awk '{print $3}')
        DEFAULT_ACCEPT_SOURCE_ROUTE_IPV6=$(sysctl net.ipv6.conf.default.accept_source_route 2>/dev/null | awk '{print $3}')
    fi
    
    FAILED=0
    
    # Check if IPv4 source routed packets are not accepted
    if [ "$ALL_ACCEPT_SOURCE_ROUTE_IPV4" != "0" ] || [ "$DEFAULT_ACCEPT_SOURCE_ROUTE_IPV4" != "0" ]; then
        FAILED=1
    fi
    
    # Check if IPv6 source routed packets are not accepted (if IPv6 is enabled)
    if [ $IPV6_ENABLED -eq 1 ] && { [ "$ALL_ACCEPT_SOURCE_ROUTE_IPV6" != "0" ] || [ "$DEFAULT_ACCEPT_SOURCE_ROUTE_IPV6" != "0" ]; }; then
        FAILED=1
    fi
    
    if [ $FAILED -eq 0 ]; then
        print_status "Source routed packets are not accepted" 0
    else
        print_status "Source routed packets are accepted" 1
        echo "Current sysctl settings:"
        echo "  net.ipv4.conf.all.accept_source_route = $ALL_ACCEPT_SOURCE_ROUTE_IPV4"
        echo "  net.ipv4.conf.default.accept_source_route = $DEFAULT_ACCEPT_SOURCE_ROUTE_IPV4"
        if [ $IPV6_ENABLED -eq 1 ]; then
            echo "  net.ipv6.conf.all.accept_source_route = $ALL_ACCEPT_SOURCE_ROUTE_IPV6"
            echo "  net.ipv6.conf.default.accept_source_route = $DEFAULT_ACCEPT_SOURCE_ROUTE_IPV6"
        fi
    fi
}

# 3.3.2 Ensure ICMP redirects are not accepted
check_3_3_2() {
    echo -e "\n${BOLD}3.3.2 Ensure ICMP redirects are not accepted${NC}"
    
    # Check current sysctl settings for IPv4
    ALL_ACCEPT_REDIRECTS_IPV4=$(sysctl net.ipv4.conf.all.accept_redirects 2>/dev/null | awk '{print $3}')
    DEFAULT_ACCEPT_REDIRECTS_IPV4=$(sysctl net.ipv4.conf.default.accept_redirects 2>/dev/null | awk '{print $3}')
    
    # Check current sysctl settings for IPv6 if IPv6 is enabled
    IPV6_ENABLED=0
    if [ -d /proc/sys/net/ipv6 ]; then
        IPV6_ENABLED=1
        ALL_ACCEPT_REDIRECTS_IPV6=$(sysctl net.ipv6.conf.all.accept_redirects 2>/dev/null | awk '{print $3}')
        DEFAULT_ACCEPT_REDIRECTS_IPV6=$(sysctl net.ipv6.conf.default.accept_redirects 2>/dev/null | awk '{print $3}')
    fi
    
    FAILED=0
    
    # Check if IPv4 ICMP redirects are not accepted
    if [ "$ALL_ACCEPT_REDIRECTS_IPV4" != "0" ] || [ "$DEFAULT_ACCEPT_REDIRECTS_IPV4" != "0" ]; then
        FAILED=1
    fi
    
    # Check if IPv6 ICMP redirects are not accepted (if IPv6 is enabled)
    if [ $IPV6_ENABLED -eq 1 ] && { [ "$ALL_ACCEPT_REDIRECTS_IPV6" != "0" ] || [ "$DEFAULT_ACCEPT_REDIRECTS_IPV6" != "0" ]; }; then
        FAILED=1
    fi
    
    if [ $FAILED -eq 0 ]; then
        print_status "ICMP redirects are not accepted" 0
    else
        print_status "ICMP redirects are accepted" 1
        echo "Current settings:"
        echo "  net.ipv4.conf.all.accept_redirects = $ALL_ACCEPT_REDIRECTS_IPV4"
        echo "  net.ipv4.conf.default.accept_redirects = $DEFAULT_ACCEPT_REDIRECTS_IPV4"
        if [ $IPV6_ENABLED -eq 1 ]; then
            echo "  net.ipv6.conf.all.accept_redirects = $ALL_ACCEPT_REDIRECTS_IPV6"
            echo "  net.ipv6.conf.default.accept_redirects = $DEFAULT_ACCEPT_REDIRECTS_IPV6"
        fi
    fi
}

# 3.3.3 Ensure secure ICMP redirects are not accepted
check_3_3_3() {
    echo -e "\n${BOLD}3.3.3 Ensure secure ICMP redirects are not accepted${NC}"
    
    # Check current sysctl settings
    ALL_SECURE_REDIRECTS=$(sysctl net.ipv4.conf.all.secure_redirects 2>/dev/null | awk '{print $3}')
    DEFAULT_SECURE_REDIRECTS=$(sysctl net.ipv4.conf.default.secure_redirects 2>/dev/null | awk '{print $3}')
    
    if [ "$ALL_SECURE_REDIRECTS" = "0" ] && [ "$DEFAULT_SECURE_REDIRECTS" = "0" ]; then
        print_status "Secure ICMP redirects are not accepted" 0
    else
        print_status "Secure ICMP redirects are accepted" 1
        echo "Current settings:"
        echo "  net.ipv4.conf.all.secure_redirects = $ALL_SECURE_REDIRECTS"
        echo "  net.ipv4.conf.default.secure_redirects = $DEFAULT_SECURE_REDIRECTS"
    fi
}

# 3.3.4 Ensure suspicious packets are logged
check_3_3_4() {
    echo -e "\n${BOLD}3.3.4 Ensure suspicious packets are logged${NC}"
    
    # Check current sysctl settings
    ALL_LOG_MARTIANS=$(sysctl net.ipv4.conf.all.log_martians 2>/dev/null | awk '{print $3}')
    DEFAULT_LOG_MARTIANS=$(sysctl net.ipv4.conf.default.log_martians 2>/dev/null | awk '{print $3}')
    
    if [ "$ALL_LOG_MARTIANS" = "1" ] && [ "$DEFAULT_LOG_MARTIANS" = "1" ]; then
        print_status "Suspicious packets are logged" 0
    else
        print_status "Suspicious packets are not logged" 1
        echo "Current settings:"
        echo "  net.ipv4.conf.all.log_martians = $ALL_LOG_MARTIANS"
        echo "  net.ipv4.conf.default.log_martians = $DEFAULT_LOG_MARTIANS"
    fi
}

# 3.3.5 Ensure broadcast ICMP requests are ignored
check_3_3_5() {
    echo -e "\n${BOLD}3.3.5 Ensure broadcast ICMP requests are ignored${NC}"
    
    # Check current sysctl settings
    ICMP_ECHO_IGNORE_BROADCASTS=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts 2>/dev/null | awk '{print $3}')
    
    if [ "$ICMP_ECHO_IGNORE_BROADCASTS" = "1" ]; then
        print_status "Broadcast ICMP requests are ignored" 0
    else
        print_status "Broadcast ICMP requests are not ignored" 1
        echo "Current setting:"
        echo "  net.ipv4.icmp_echo_ignore_broadcasts = $ICMP_ECHO_IGNORE_BROADCASTS"
    fi
}

# 3.3.6 Ensure bogus ICMP responses are ignored
check_3_3_6() {
    echo -e "\n${BOLD}3.3.6 Ensure bogus ICMP responses are ignored${NC}"
    
    # Check current sysctl settings
    ICMP_IGNORE_BOGUS_ERROR_RESPONSES=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses 2>/dev/null | awk '{print $3}')
    
    if [ "$ICMP_IGNORE_BOGUS_ERROR_RESPONSES" = "1" ]; then
        print_status "Bogus ICMP responses are ignored" 0
    else
        print_status "Bogus ICMP responses are not ignored" 1
        echo "Current setting:"
        echo "  net.ipv4.icmp_ignore_bogus_error_responses = $ICMP_IGNORE_BOGUS_ERROR_RESPONSES"
    fi
}

# 3.3.7 Ensure Reverse Path Filtering is enabled
check_3_3_7() {
    echo -e "\n${BOLD}3.3.7 Ensure Reverse Path Filtering is enabled${NC}"
    
    # Check current sysctl settings
    ALL_RP_FILTER=$(sysctl net.ipv4.conf.all.rp_filter 2>/dev/null | awk '{print $3}')
    DEFAULT_RP_FILTER=$(sysctl net.ipv4.conf.default.rp_filter 2>/dev/null | awk '{print $3}')
    
    # Check if Reverse Path Filtering is properly configured (either strict or loose mode)
    if [[ "$ALL_RP_FILTER" == "1" || "$ALL_RP_FILTER" == "2" ]] && [[ "$DEFAULT_RP_FILTER" == "1" || "$DEFAULT_RP_FILTER" == "2" ]]; then
        print_status "Reverse Path Filtering is enabled" 0
        if [[ "$ALL_RP_FILTER" == "1" && "$DEFAULT_RP_FILTER" == "1" ]]; then
            echo "Reverse Path Filtering is configured in strict mode (recommended)."
        else
            echo "Reverse Path Filtering is configured in loose mode."
        fi
    else
        print_status "Reverse Path Filtering is not properly enabled" 1
        echo "Current settings:"
        echo "  net.ipv4.conf.all.rp_filter = $ALL_RP_FILTER"
        echo "  net.ipv4.conf.default.rp_filter = $DEFAULT_RP_FILTER"
    fi
}

# 3.3.8 Ensure TCP SYN Cookies is enabled
check_3_3_8() {
    echo -e "\n${BOLD}3.3.8 Ensure TCP SYN Cookies is enabled${NC}"
    
    # Check current sysctl settings
    TCP_SYNCOOKIES=$(sysctl net.ipv4.tcp_syncookies 2>/dev/null | awk '{print $3}')
    
    if [ "$TCP_SYNCOOKIES" = "1" ]; then
        print_status "TCP SYN Cookies is enabled" 0
    else
        print_status "TCP SYN Cookies is not enabled" 1
        echo "Current setting:"
        echo "  net.ipv4.tcp_syncookies = $TCP_SYNCOOKIES"
    fi
}

# 3.3.9 Ensure IPv6 router advertisements are not accepted
check_3_3_9() {
    echo -e "\n${BOLD}3.3.9 Ensure IPv6 router advertisements are not accepted${NC}"
    
    # Check if IPv6 is enabled
    IPV6_ENABLED=0
    if [ -d /proc/sys/net/ipv6 ]; then
        IPV6_ENABLED=1
    fi
    
    if [ $IPV6_ENABLED -eq 0 ]; then
        print_info "IPv6 is disabled on the system"
        echo "This check is not applicable when IPv6 is disabled."
        return
    fi
    
    # Check current sysctl settings
    ALL_ACCEPT_RA=$(sysctl net.ipv6.conf.all.accept_ra 2>/dev/null | awk '{print $3}')
    DEFAULT_ACCEPT_RA=$(sysctl net.ipv6.conf.default.accept_ra 2>/dev/null | awk '{print $3}')
    
    if [ "$ALL_ACCEPT_RA" = "0" ] && [ "$DEFAULT_ACCEPT_RA" = "0" ]; then
        print_status "IPv6 router advertisements are not accepted" 0
    else
        print_status "IPv6 router advertisements are accepted" 1
        echo "Current settings:"
        echo "  net.ipv6.conf.all.accept_ra = $ALL_ACCEPT_RA"
        echo "  net.ipv6.conf.default.accept_ra = $DEFAULT_ACCEPT_RA"
    fi
}

# 3.4.1 Ensure TCP Wrappers is installed
check_3_4_1() {
    echo -e "\n${BOLD}3.4.1 Ensure TCP Wrappers is installed${NC}"
    
    # Check if TCP Wrappers is installed (tcpd or libwrap0)
    TCPD_INSTALLED=0
    LIBWRAP_INSTALLED=0
    
    if dpkg -s tcpd &>/dev/null; then
        TCPD_INSTALLED=1
        TCPD_VERSION=$(dpkg -s tcpd | grep '^Version:' | awk '{print $2}')
    fi
    
    if dpkg -s libwrap0 &>/dev/null; then
        LIBWRAP_INSTALLED=1
        LIBWRAP_VERSION=$(dpkg -s libwrap0 | grep '^Version:' | awk '{print $2}')
    fi
    
    if [ $TCPD_INSTALLED -eq 1 ] || [ $LIBWRAP_INSTALLED -eq 1 ]; then
        print_status "TCP Wrappers is installed" 0
        [ $TCPD_INSTALLED -eq 1 ] && echo "  tcpd package installed (version: $TCPD_VERSION)"
        [ $LIBWRAP_INSTALLED -eq 1 ] && echo "  libwrap0 package installed (version: $LIBWRAP_VERSION)"
    else
        print_status "TCP Wrappers is not installed" 1
    fi
}

# 3.4.2 Ensure /etc/hosts.allow is configured
check_3_4_2() {
    echo -e "\n${BOLD}3.4.2 Ensure /etc/hosts.allow is configured${NC}"
    
    # Check if /etc/hosts.allow exists and has non-comment lines
    if [ -f /etc/hosts.allow ]; then
        NON_COMMENT_LINES=$(grep -v "^#" /etc/hosts.allow | sed '/^$/d' | wc -l)
        
        if [ $NON_COMMENT_LINES -gt 0 ]; then
            print_status "/etc/hosts.allow is configured" 0
            echo "File contains $NON_COMMENT_LINES non-comment lines:"
            grep -v "^#" /etc/hosts.allow | sed '/^$/d'
        else
            print_status "/etc/hosts.allow exists but has no rules" 1
        fi
    else
        print_status "/etc/hosts.allow file does not exist" 1
    fi
}

# 3.4.3 Ensure /etc/hosts.deny is configured
check_3_4_3() {
    echo -e "\n${BOLD}3.4.3 Ensure /etc/hosts.deny is configured${NC}"
    
    # Check if /etc/hosts.deny exists and has "ALL: ALL" rule
    if [ -f /etc/hosts.deny ]; then
        if grep -q "ALL: ALL" /etc/hosts.deny; then
            print_status "/etc/hosts.deny is configured with ALL: ALL rule" 0
            echo "Current configuration:"
            grep -v "^#" /etc/hosts.deny | sed '/^$/d'
        else
            NON_COMMENT_LINES=$(grep -v "^#" /etc/hosts.deny | sed '/^$/d' | wc -l)
            if [ $NON_COMMENT_LINES -gt 0 ]; then
                print_status "/etc/hosts.deny has rules but no ALL: ALL" 1
                echo "Current configuration:"
                grep -v "^#" /etc/hosts.deny | sed '/^$/d'
            else
                print_status "/etc/hosts.deny exists but has no rules" 1
            fi
        fi
    else
        print_status "/etc/hosts.deny file does not exist" 1
    fi
}

# 3.4.4 Ensure permissions on /etc/hosts.allow and /etc/hosts.deny are configured
check_3_4_4() {
    echo -e "\n${BOLD}3.4.4 Ensure permissions on /etc/hosts.allow and /etc/hosts.deny are configured${NC}"
    
    # Check permissions on /etc/hosts.allow
    if [ -f "/etc/hosts.allow" ]; then
        OWNER_ALLOW=$(stat -c "%U" "/etc/hosts.allow")
        GROUP_ALLOW=$(stat -c "%G" "/etc/hosts.allow")
        PERMS_ALLOW=$(stat -c "%a" "/etc/hosts.allow")
        
        if [ "$OWNER_ALLOW" = "root" ] && [ "$GROUP_ALLOW" = "root" ] && [ "$PERMS_ALLOW" = "644" ]; then
            print_status "Permissions on /etc/hosts.allow are configured correctly" 0
        else
            print_status "Permissions on /etc/hosts.allow are not configured correctly" 1
            echo "Current: owner=$OWNER_ALLOW group=$GROUP_ALLOW permissions=$PERMS_ALLOW"
            echo "Expected: owner=root group=root permissions=644"
        fi
    else
        print_info "/etc/hosts.allow does not exist"
    fi
    
    # Check permissions on /etc/hosts.deny
    if [ -f "/etc/hosts.deny" ]; then
        OWNER_DENY=$(stat -c "%U" "/etc/hosts.deny")
        GROUP_DENY=$(stat -c "%G" "/etc/hosts.deny")
        PERMS_DENY=$(stat -c "%a" "/etc/hosts.deny")
        
        if [ "$OWNER_DENY" = "root" ] && [ "$GROUP_DENY" = "root" ] && [ "$PERMS_DENY" = "644" ]; then
            print_status "Permissions on /etc/hosts.deny are configured correctly" 0
        else
            print_status "Permissions on /etc/hosts.deny are not configured correctly" 1
            echo "Current: owner=$OWNER_DENY group=$GROUP_DENY permissions=$PERMS_DENY"
            echo "Expected: owner=root group=root permissions=644"
        fi
    else
        print_info "/etc/hosts.deny does not exist"
    fi
}

# Run main function
main