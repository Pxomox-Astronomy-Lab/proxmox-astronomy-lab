#!/bin/bash

# 06-CISv81-l1-ubuntu2404-verify-system-hardening.sh
# Script to validate CIS Ubuntu 24.04 Level 1 System Hardening controls
# Run with sudo privileges for complete results

# Text formatting
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Initialize counters
PASS_COUNT=0
FAIL_COUNT=0
TOTAL_CHECKS=0

# Function to display results
check_result() {
    TOTAL_CHECKS=$((TOTAL_CHECKS+1))
    
    if [ "$1" -eq 0 ]; then
        echo -e "${GREEN}[PASS]${NC} $2"
        PASS_COUNT=$((PASS_COUNT+1))
    else
        echo -e "${RED}[FAIL]${NC} $2"
        FAIL_COUNT=$((FAIL_COUNT+1))
    fi
}

echo -e "\n${BLUE}====== CIS Ubuntu 24.04 System Hardening Controls Validation ======${NC}\n"

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}Warning: This script should be run with sudo for complete results${NC}\n"
fi

echo -e "${BLUE}=== AppArmor Configuration (CIS 1.6.1, 1.6.2) ===${NC}"

# Check if AppArmor is installed
if dpkg -l | grep -q "^ii.*apparmor "; then
    check_result 0 "AppArmor packages are installed"
else
    check_result 1 "AppArmor packages are not installed"
fi

# Check if AppArmor is enabled in GRUB
if grep -q "apparmor=1" /etc/default/grub && grep -q "security=apparmor" /etc/default/grub; then
    check_result 0 "AppArmor is enabled in GRUB configuration"
else
    check_result 1 "AppArmor is not enabled in GRUB configuration"
fi

# Check if AppArmor is loaded and enforcing
if command -v aa-status &> /dev/null; then
    if aa-status 2>/dev/null | grep -q "apparmor module is loaded"; then
        check_result 0 "AppArmor module is loaded"
        if aa-status 2>/dev/null | grep -q "profiles are in enforce mode"; then
            check_result 0 "AppArmor has profiles in enforce mode"
        else
            check_result 1 "AppArmor does not have profiles in enforce mode"
        fi
    else
        check_result 1 "AppArmor module is not loaded"
        check_result 1 "AppArmor does not have profiles in enforce mode"
    fi
else
    check_result 1 "AppArmor command not found"
    check_result 1 "Unable to check AppArmor profiles"
fi

echo -e "\n${BLUE}=== Warning Banners (CIS 1.7.1 - 1.7.5) ===${NC}"

# Check /etc/motd exists and has content
if [ -s /etc/motd ]; then
    check_result 0 "Message of the day banner exists and has content"
else
    check_result 1 "Message of the day banner is missing or empty"
fi

# Check /etc/issue exists and has content
if [ -s /etc/issue ]; then
    check_result 0 "Login warning banner (/etc/issue) exists and has content"
else
    check_result 1 "Login warning banner (/etc/issue) is missing or empty"
fi

# Check /etc/issue.net exists and has content
if [ -s /etc/issue.net ]; then
    check_result 0 "Network login warning banner (/etc/issue.net) exists and has content"
else
    check_result 1 "Network login warning banner (/etc/issue.net) is missing or empty"
fi

# Check permissions on banner files
for file in /etc/motd /etc/issue /etc/issue.net; do
    if [ -f "$file" ]; then
        perms=$(stat -c "%a" "$file")
        owner=$(stat -c "%U:%G" "$file")
        if [ "$perms" = "644" ] && [ "$owner" = "root:root" ]; then
            check_result 0 "$file has proper permissions (644) and ownership (root:root)"
        else
            check_result 1 "$file has incorrect permissions or ownership (Current: $perms, $owner)"
        fi
    else
        check_result 1 "$file does not exist"
    fi
done

echo -e "\n${BLUE}=== Update Management (CIS 1.8.1) ===${NC}"

# Check if unattended-upgrades is installed
if dpkg -l | grep -q "^ii.*unattended-upgrades "; then
    check_result 0 "unattended-upgrades package is installed"
else
    check_result 1 "unattended-upgrades package is not installed"
fi

# Check if security updates are enabled in unattended-upgrades
if grep -q '^\s*"${distro_id}:${distro_codename}-security";' /etc/apt/apt.conf.d/50unattended-upgrades; then
    check_result 0 "Security updates are enabled in unattended-upgrades"
else
    check_result 1 "Security updates are not enabled in unattended-upgrades"
fi

# Check if automatic updates are configured
if grep -q "APT::Periodic::Update-Package-Lists \"1\";" /etc/apt/apt.conf.d/20auto-upgrades 2>/dev/null; then
    check_result 0 "Automatic updates are configured"
else
    check_result 1 "Automatic updates are not configured"
fi

echo -e "\n${BLUE}=== Core Dump Restrictions (CIS 1.5.1) ===${NC}"

# Check limits.conf for core dump restriction
if grep -q "^\* hard core 0$" /etc/security/limits.conf; then
    check_result 0 "Core dumps are restricted in limits.conf"
else
    check_result 1 "Core dumps are not restricted in limits.conf"
fi

# Check systemd coredump.conf
if [ -f /etc/systemd/coredump.conf ] && grep -q "^Storage=none$" /etc/systemd/coredump.conf && grep -q "^ProcessSizeMax=0$" /etc/systemd/coredump.conf; then
    check_result 0 "systemd core dump storage is properly configured"
else
    check_result 1 "systemd core dump storage is not properly configured"
fi

# Check suid_dumpable setting
if sysctl -n fs.suid_dumpable 2>/dev/null | grep -q "0"; then
    check_result 0 "fs.suid_dumpable is set to 0"
else
    check_result 1 "fs.suid_dumpable is not set to 0"
fi

echo -e "\n${BLUE}=== Bootloader Configuration (CIS 1.4.1, 1.4.2) ===${NC}"

# Find GRUB configuration file
GRUB_CONFIG=""
for path in /boot/grub/grub.cfg /boot/grub2/grub.cfg /boot/efi/EFI/ubuntu/grub.cfg; do
    if [ -f "$path" ]; then
        GRUB_CONFIG="$path"
        break
    fi
done

if [ -n "$GRUB_CONFIG" ]; then
    # Check GRUB configuration ownership
    grub_owner=$(stat -c "%U:%G" "$GRUB_CONFIG")
    if [ "$grub_owner" = "root:root" ]; then
        check_result 0 "GRUB configuration is owned by root:root"
    else
        check_result 1 "GRUB configuration is not owned by root:root (Current: $grub_owner)"
    fi
    
    # Check GRUB configuration permissions
    grub_perms=$(stat -c "%a" "$GRUB_CONFIG")
    if [ "$grub_perms" = "400" ] || [ "$grub_perms" = "600" ] || [ "$grub_perms" = "444" ]; then
        check_result 0 "GRUB configuration has secure permissions"
    else
        check_result 1 "GRUB configuration does not have secure permissions (Current: $grub_perms)"
    fi
else
    check_result 1 "GRUB configuration file not found"
    check_result 1 "Unable to check GRUB configuration permissions"
fi

echo -e "\n${BLUE}=== AIDE File Integrity Monitoring (CIS 1.3.1, 1.3.2) ===${NC}"

# Check if AIDE is installed
if dpkg -l | grep -q "^ii.*aide "; then
    check_result 0 "AIDE packages are installed"
else
    check_result 1 "AIDE packages are not installed"
fi

# Check if AIDE database exists (check multiple possible locations)
if [ -f /var/lib/aide/aide.db ] || [ -f /var/lib/aide/aide.db.new ] || [ -f /var/lib/aide/aide.db.gz ] || [ -f /var/lib/aide/aide.db.new.gz ]; then
    check_result 0 "AIDE database exists"
else
    check_result 1 "AIDE database does not exist"
fi

# Check if AIDE is scheduled to run
if grep -r "aide" /etc/cron.* &>/dev/null || systemctl is-enabled aidecheck.service &>/dev/null || systemctl is-enabled aidecheck.timer &>/dev/null; then
    check_result 0 "AIDE is scheduled to run periodically"
else
    check_result 1 "AIDE is not scheduled to run periodically"
fi

echo -e "\n${BLUE}=== Bootloader Password (CIS 1.2.1) ===${NC}"

# Check for GRUB password protection
if [ -n "$GRUB_CONFIG" ] && grep -q "password" "$GRUB_CONFIG"; then
    check_result 0 "GRUB bootloader is password protected"
elif [ -f /etc/grub.d/40_custom ] && grep -q "password" /etc/grub.d/40_custom; then
    check_result 0 "GRUB bootloader password is configured in custom settings"
elif [ -f /etc/grub.d/01_password ] && grep -q "password" /etc/grub.d/01_password; then
    check_result 0 "GRUB bootloader password is configured in password settings"
else
    check_result 1 "GRUB bootloader does not appear to be password protected"
fi

# Final summary
echo -e "\n${BLUE}====== System Hardening Controls Summary ======${NC}"
echo -e "Total checks: $TOTAL_CHECKS"
echo -e "${GREEN}Passed: $PASS_COUNT${NC}"
echo -e "${RED}Failed: $FAIL_COUNT${NC}"

if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "\n${GREEN}All system hardening controls have been properly implemented!${NC}"
else
    echo -e "\n${YELLOW}Some controls require remediation. Review the failed checks above.${NC}"
    exit 1
fi

exit 0