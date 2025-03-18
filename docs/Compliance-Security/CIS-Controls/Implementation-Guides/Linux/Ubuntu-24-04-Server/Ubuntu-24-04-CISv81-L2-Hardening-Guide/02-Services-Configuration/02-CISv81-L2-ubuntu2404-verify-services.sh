#!/bin/bash
# =============================================================================
# Script:  02-CISv81-L2-ubuntu2404-verify-services.sh
# Author:  Based on VintageDon's work (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L2 services controls:
# - Controls 2.1.x: inetd services configuration
# - Controls 2.2.x: Special purpose services
# - Controls 2.3.x: Service clients
# - Controls 2.4.x: Time synchronization
# - Checks for presence/absence of specific services
# - Verifies secure configuration where services are required
#
# Usage:
#   ./02-CISv81-L2-ubuntu2404-verify-services.sh
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

# Function to display section headers
print_section_header() {
    echo -e "\n${BOLD}${BLUE}$1${NC}"
    echo -e "${BLUE}$(printf '=%.0s' {1..70})${NC}\n"
}

# Function to check if a control passes or fails
check_control() {
    local control_id="$1"
    local description="$2"
    local check_command="$3"
    local remediation="$4"
    
    echo -e "${BOLD}${control_id}${NC} - ${description}"
    
    # Evaluate the command
    eval "$check_command"
    local status=$?
    
    if [ $status -eq 0 ]; then
        echo -e "Status: ${GREEN}PASS${NC}"
    else
        echo -e "Status: ${RED}FAIL${NC}"
        echo -e "Remediation: ${YELLOW}${remediation}${NC}"
    fi
    echo ""
}

# Print script information
echo -e "${BOLD}CIS Ubuntu 24.04 Level 2 Services Configuration Verification Script${NC}"
echo -e "Running as: $(whoami) on $(hostname)"
echo -e "Date: $(date)"
echo -e "Ubuntu Version: $(lsb_release -ds)"
echo -e "${BOLD}Note: This script must be run with root privileges for accurate results${NC}"

# Verify script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "\n${RED}ERROR: This script must be run as root${NC}"
    exit 1
fi

# Begin Services checks
print_section_header "2.1 inetd Services"

check_control "2.1.1" "Ensure xinetd is not installed" \
    "dpkg -s xinetd 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge xinetd"

check_control "2.1.2" "Ensure openbsd-inetd is not installed" \
    "dpkg -s openbsd-inetd 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge openbsd-inetd"

print_section_header "2.2 Special Purpose Services"

check_control "2.2.1" "Ensure X Window System is not installed" \
    "dpkg -l | grep -E '^ii.*xserver-xorg.*' && exit 1 || exit 0" \
    "Run: apt purge xserver-xorg*"

check_control "2.2.2" "Ensure Avahi Server is not installed" \
    "dpkg -s avahi-daemon 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge avahi-daemon"

check_control "2.2.3" "Ensure CUPS is not installed" \
    "dpkg -s cups 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge cups"

check_control "2.2.4" "Ensure DHCP Server is not installed" \
    "dpkg -s isc-dhcp-server 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge isc-dhcp-server"

check_control "2.2.5" "Ensure LDAP server is not installed" \
    "dpkg -s slapd 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge slapd"

check_control "2.2.6" "Ensure NFS is not installed" \
    "dpkg -s nfs-kernel-server 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge nfs-kernel-server"

check_control "2.2.7" "Ensure DNS Server is not installed" \
    "dpkg -s bind9 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge bind9"

check_control "2.2.8" "Ensure FTP Server is not installed" \
    "dpkg -s vsftpd 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge vsftpd"

check_control "2.2.9" "Ensure HTTP server is not installed" \
    "dpkg -s apache2 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge apache2"

check_control "2.2.10" "Ensure IMAP and POP3 server are not installed" \
    "dpkg -s dovecot-imapd dovecot-pop3d 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge dovecot-imapd dovecot-pop3d"

check_control "2.2.11" "Ensure Samba is not installed" \
    "dpkg -s samba 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge samba"

check_control "2.2.12" "Ensure HTTP Proxy Server is not installed" \
    "dpkg -s squid 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge squid"

check_control "2.2.13" "Ensure SNMP Server is not installed" \
    "dpkg -s snmpd 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge snmpd"

check_control "2.2.14" "Ensure mail transfer agent is configured for local-only mode" \
    "ss -lntu | grep -E ':25\\s' | grep -E -v '\\s127.0.0.1:25\\s' | grep -q . && exit 1 || exit 0" \
    "Configure MTA to listen on localhost only"

check_control "2.2.15" "Ensure rsync service is not installed" \
    "dpkg -s rsync 2>/dev/null | grep -q 'Status: install ok installed' && systemctl is-enabled rsync.service && exit 1 || exit 0" \
    "Run: apt purge rsync or disable with systemctl disable rsync"

check_control "2.2.16" "Ensure NIS Server is not installed" \
    "dpkg -s nis 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge nis"

print_section_header "2.3 Service Clients"

check_control "2.3.1" "Ensure NIS Client is not installed" \
    "dpkg -s nis 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge nis"

check_control "2.3.2" "Ensure rsh client is not installed" \
    "dpkg -s rsh-client 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge rsh-client"

check_control "2.3.3" "Ensure talk client is not installed" \
    "dpkg -s talk 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge talk"

check_control "2.3.4" "Ensure telnet client is not installed" \
    "dpkg -s telnet 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge telnet"

check_control "2.3.5" "Ensure LDAP client is not installed" \
    "dpkg -s ldap-utils 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge ldap-utils"

check_control "2.3.6" "Ensure RPC client is not installed" \
    "dpkg -s rpcbind 2>/dev/null | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge rpcbind"

print_section_header "2.4 Time Synchronization"

check_control "2.4.1" "Ensure a time synchronization daemon is in use" \
    "dpkg -s chrony 2>/dev/null | grep -q 'Status: install ok installed' || dpkg -s ntp 2>/dev/null | grep -q 'Status: install ok installed' || dpkg -s systemd-timesyncd 2>/dev/null | grep -q 'Status: install ok installed' || exit 1" \
    "Install a time synchronization daemon: apt install systemd-timesyncd"

check_control "2.4.1.1" "Ensure systemd-timesyncd is configured with authorized NTP server" \
    "if systemctl is-enabled systemd-timesyncd; then grep -q '^NTP=' /etc/systemd/timesyncd.conf || exit 1; else exit 0; fi" \
    "Configure authorized NTP servers in /etc/systemd/timesyncd.conf"

check_control "2.4.1.2" "Ensure chrony is configured with authorized NTP server" \
    "if dpkg -s chrony 2>/dev/null | grep -q 'Status: install ok installed'; then grep -E '^(server|pool)' /etc/chrony/chrony.conf | grep -v '^#' | grep -q . || exit 1; else exit 0; fi" \
    "Configure authorized NTP servers in /etc/chrony/chrony.conf"

check_control "2.4.1.3" "Ensure ntp is configured with authorized NTP server" \
    "if dpkg -s ntp 2>/dev/null | grep -q 'Status: install ok installed'; then grep -E '^(server|pool)' /etc/ntp.conf | grep -v '^#' | grep -q . || exit 1; else exit 0; fi" \
    "Configure authorized NTP servers in /etc/ntp.conf"

# Level 2 specific controls
check_control "2.4.2" "Ensure time synchronization is configured to use authenticated sources" \
    "if dpkg -s chrony 2>/dev/null | grep -q 'Status: install ok installed'; then grep -q 'auth' /etc/chrony/chrony.conf || exit 1; elif dpkg -s ntp 2>/dev/null | grep -q 'Status: install ok installed'; then grep -q 'authenticate' /etc/ntp.conf || exit 1; else exit 0; fi" \
    "Configure authenticated time sources in NTP configuration"

print_section_header "2.5 Additional Service Hardening"

check_control "2.5.1" "Ensure NTP implementation is secured if required" \
    "if dpkg -s ntp 2>/dev/null | grep -q 'Status: install ok installed'; then grep -q 'restrict -4 default kod nomodify notrap nopeer noquery' /etc/ntp.conf && grep -q 'restrict -6 default kod nomodify notrap nopeer noquery' /etc/ntp.conf || exit 1; else exit 0; fi" \
    "Secure NTP with appropriate restrict statements"

check_control "2.5.2" "Ensure systemd-timesyncd is configured with secure pool settings" \
    "if systemctl is-enabled systemd-timesyncd; then grep -q '^RootDistanceMaxSec=1' /etc/systemd/timesyncd.conf || exit 1; else exit 0; fi" \
    "Add 'RootDistanceMaxSec=1' to /etc/systemd/timesyncd.conf"

check_control "2.5.3" "Ensure unnecessary services are removed or masked" \
    "systemctl list-unit-files --state=enabled | grep -E 'snapd|ufw|apparmor' || exit 0" \
    "Review and mask unused services with: systemctl mask <service>"

echo -e "\n${GREEN}Services check completed!${NC}"
echo -e "Review any ${RED}FAIL${NC} results and apply the recommended remediation steps."