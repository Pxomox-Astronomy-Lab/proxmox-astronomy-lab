#!/bin/bash
# =============================================================================
# Script:  03-CISv81-l1-ubuntu2404-verify-network.sh
# Author:  Based on VintageDon's work (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L1 network security controls:
# - Control 3.1.1: Ensure IP forwarding is disabled
# - Control 3.2.1: Ensure packet redirect sending is disabled
# - Control 3.3.1: Ensure TCP SYN Cookies are enabled
#
# Usage:
#   ./03-CISv81-l1-ubuntu2404-verify-network.sh
#
# Exit codes:
#   0 - All checks passed
#   1 - One or more checks failed
# =============================================================================

# Terminal colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Count failures for exit status
FAILURES=0

echo "CIS Ubuntu 24.04 Network Security Controls Verification"
echo "======================================================"
echo

# Function to check sysctl value
check_sysctl() {
    local param=$1
    local expected=$2
    local control=$3
    local description=$4
    
    # Check if the sysctl parameter exists
    if [ ! -f "/proc/sys/${param//.//}" ]; then
        # Check if this is an IPv6 parameter
        if [[ "$param" == *"ipv6"* ]]; then
            echo -e "${YELLOW}⚠️ INFO: $control - $description ($param not available - IPv6 appears to be disabled)${NC}"
            return 0
        else
            echo -e "${RED}❌ FAIL: $control - $description ($param does not exist)${NC}"
            FAILURES=$((FAILURES+1))
            return 1
        fi
    fi
    
    # Get the current value
    local actual=$(sysctl -n "$param" 2>/dev/null)
    
    if [ "$actual" = "$expected" ]; then
        echo -e "${GREEN}✅ PASS: $control - $description ($param = $actual)${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL: $control - $description ($param = $actual, should be $expected)${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
}

# Check Control 3.1.1 - IP forwarding disabled
echo "Checking IP forwarding settings (3.1.1)..."
check_sysctl "net.ipv4.ip_forward" "0" "3.1.1" "IPv4 forwarding is disabled"
check_sysctl "net.ipv6.conf.all.forwarding" "0" "3.1.1" "IPv6 forwarding is disabled"

# Check Control 3.2.1 - ICMP redirects disabled
echo -e "\nChecking ICMP redirect settings (3.2.1)..."
check_sysctl "net.ipv4.conf.all.send_redirects" "0" "3.2.1" "IPv4 send redirects disabled (all)"
check_sysctl "net.ipv4.conf.default.send_redirects" "0" "3.2.1" "IPv4 send redirects disabled (default)"

# Additional checks - ICMP redirect acceptance (complementary to 3.2.1)
echo -e "\nChecking additional ICMP redirect security settings..."
check_sysctl "net.ipv4.conf.all.accept_redirects" "0" "3.2.1+" "IPv4 accept redirects disabled (all)"
check_sysctl "net.ipv4.conf.default.accept_redirects" "0" "3.2.1+" "IPv4 accept redirects disabled (default)"
check_sysctl "net.ipv6.conf.all.accept_redirects" "0" "3.2.1+" "IPv6 accept redirects disabled (all)"
check_sysctl "net.ipv6.conf.default.accept_redirects" "0" "3.2.1+" "IPv6 accept redirects disabled (default)"

# Check Control 3.3.1 - TCP SYN cookies enabled
echo -e "\nChecking TCP SYN cookies (3.3.1)..."
check_sysctl "net.ipv4.tcp_syncookies" "1" "3.3.1" "TCP SYN cookies enabled"

# Check additional recommended network hardening settings
echo -e "\nChecking additional recommended network security settings..."
check_sysctl "net.ipv4.tcp_max_syn_backlog" "4096" "Additional" "SYN backlog size"
check_sysctl "net.ipv4.icmp_echo_ignore_broadcasts" "1" "Additional" "ICMP broadcast ignore"
check_sysctl "net.ipv4.icmp_ignore_bogus_error_responses" "1" "Additional" "Bogus ICMP responses ignored"
check_sysctl "net.ipv4.conf.all.rp_filter" "1" "Additional" "Source validation enabled (all)"
check_sysctl "net.ipv4.conf.default.rp_filter" "1" "Additional" "Source validation enabled (default)"
check_sysctl "net.ipv4.conf.all.log_martians" "1" "Additional" "Martian packet logging enabled (all)"
check_sysctl "net.ipv4.conf.default.log_martians" "1" "Additional" "Martian packet logging enabled (default)"

# Check if network settings are persisted
echo -e "\nChecking persistence of network security settings..."
if grep -q "net.ipv4.ip_forward = 0" /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo -e "${GREEN}✅ PASS: Network security settings are persisted in configuration files${NC}"
else
    echo -e "${YELLOW}⚠️ WARNING: Network security settings may not be persisted in configuration files${NC}"
    echo -e "${YELLOW}   Recommend checking /etc/sysctl.conf or /etc/sysctl.d/ directory for settings${NC}"
fi

# Summary
echo -e "\n=== Summary ==="
if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}All network security controls passed!${NC}"
    exit 0
else
    echo -e "${RED}$FAILURES network security controls failed!${NC}"
    exit 1
fi