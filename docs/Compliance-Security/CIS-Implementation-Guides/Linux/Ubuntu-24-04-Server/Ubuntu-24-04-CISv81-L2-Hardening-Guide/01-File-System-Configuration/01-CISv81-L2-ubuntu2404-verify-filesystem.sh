#!/bin/bash
# =============================================================================
# Script:  01-CISv81-L2-ubuntu2404-verify-filesystem.sh
# Author:  VintageDon (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L2 file system controls:
# - Controls 1.1.1.1-1.1.22: Extended file system partition layout and mount options
# - Verifies separate partitions for critical directories
# - Checks enhanced mount options (nodev, nosuid, noexec) on additional partitions
# - Verifies filesystem integrity with AIDE
# - Checks secure boot settings and additional process hardening
#
# Usage:
#   ./01-CISv81-L2-ubuntu2404-verify-filesystem.sh
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
echo -e "${BOLD}CIS Ubuntu 24.04 Level 2 Filesystem Configuration Verification Script${NC}"
echo -e "Running as: $(whoami) on $(hostname)"
echo -e "Date: $(date)"
echo -e "Ubuntu Version: $(lsb_release -ds)"
echo -e "${BOLD}Note: This script must be run with root privileges for accurate results${NC}"

# Verify script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "\n${RED}ERROR: This script must be run as root${NC}"
    exit 1
fi

# Begin filesystem checks
print_section_header "1.1 Filesystem Configuration"

# L1 Controls (included in L2)
check_control "1.1.1.1" "Ensure /tmp is a separate partition" \
    "mount | grep -E '\s/tmp\s' || exit 1" \
    "Configure /tmp as a separate partition during installation or create it post-installation"

check_control "1.1.1.2" "Ensure nodev option set on /tmp" \
    "mount | grep -E '\s/tmp\s' | grep -q 'nodev' || exit 1" \
    "Add 'nodev' mount option for /tmp in /etc/fstab"

check_control "1.1.1.3" "Ensure nosuid option set on /tmp" \
    "mount | grep -E '\s/tmp\s' | grep -q 'nosuid' || exit 1" \
    "Add 'nosuid' mount option for /tmp in /etc/fstab"

check_control "1.1.1.4" "Ensure noexec option set on /tmp" \
    "mount | grep -E '\s/tmp\s' | grep -q 'noexec' || exit 1" \
    "Add 'noexec' mount option for /tmp in /etc/fstab"

check_control "1.1.2.1" "Ensure /dev/shm is a separate partition" \
    "mount | grep -E '\s/dev/shm\s' || exit 1" \
    "Configure /dev/shm as a separate partition"

check_control "1.1.2.2" "Ensure nodev option set on /dev/shm" \
    "mount | grep -E '\s/dev/shm\s' | grep -q 'nodev' || exit 1" \
    "Add 'nodev' mount option for /dev/shm in /etc/fstab"

check_control "1.1.2.3" "Ensure nosuid option set on /dev/shm" \
    "mount | grep -E '\s/dev/shm\s' | grep -q 'nosuid' || exit 1" \
    "Add 'nosuid' mount option for /dev/shm in /etc/fstab"

check_control "1.1.2.4" "Ensure noexec option set on /dev/shm" \
    "mount | grep -E '\s/dev/shm\s' | grep -q 'noexec' || exit 1" \
    "Add 'noexec' mount option for /dev/shm in /etc/fstab"

check_control "1.1.3" "Ensure /var is a separate partition" \
    "mount | grep -E '\s/var\s' || exit 1" \
    "Configure /var as a separate partition during installation"

check_control "1.1.4" "Ensure /var/tmp is a separate partition" \
    "mount | grep -E '\s/var/tmp\s' || exit 1" \
    "Configure /var/tmp as a separate partition or bind mount from /tmp"

check_control "1.1.5" "Ensure nodev option set on /var/tmp" \
    "mount | grep -E '\s/var/tmp\s' | grep -q 'nodev' || exit 1" \
    "Add 'nodev' mount option for /var/tmp in /etc/fstab"

check_control "1.1.6" "Ensure nosuid option set on /var/tmp" \
    "mount | grep -E '\s/var/tmp\s' | grep -q 'nosuid' || exit 1" \
    "Add 'nosuid' mount option for /var/tmp in /etc/fstab"

check_control "1.1.7" "Ensure noexec option set on /var/tmp" \
    "mount | grep -E '\s/var/tmp\s' | grep -q 'noexec' || exit 1" \
    "Add 'noexec' mount option for /var/tmp in /etc/fstab"

check_control "1.1.8" "Ensure /var/log is a separate partition" \
    "mount | grep -E '\s/var/log\s' || exit 1" \
    "Configure /var/log as a separate partition during installation"

check_control "1.1.9" "Ensure /var/log/audit is a separate partition" \
    "mount | grep -E '\s/var/log/audit\s' || exit 1" \
    "Configure /var/log/audit as a separate partition during installation"

check_control "1.1.10" "Ensure /home is a separate partition" \
    "mount | grep -E '\s/home\s' || exit 1" \
    "Configure /home as a separate partition during installation"

check_control "1.1.11" "Ensure nodev option set on /home" \
    "mount | grep -E '\s/home\s' | grep -q 'nodev' || exit 1" \
    "Add 'nodev' mount option for /home in /etc/fstab"

check_control "1.1.12" "Ensure nodev option set on removable media" \
    "grep -E '^UDISKS_MOUNT_OPTIONS_VFAT=' /etc/udisks2/mount_options.conf | grep -q 'nodev' || exit 1" \
    "Configure nodev for removable media in /etc/udisks2/mount_options.conf"

check_control "1.1.13" "Ensure nosuid option set on removable media" \
    "grep -E '^UDISKS_MOUNT_OPTIONS_VFAT=' /etc/udisks2/mount_options.conf | grep -q 'nosuid' || exit 1" \
    "Configure nosuid for removable media in /etc/udisks2/mount_options.conf"

check_control "1.1.14" "Ensure noexec option set on removable media" \
    "grep -E '^UDISKS_MOUNT_OPTIONS_VFAT=' /etc/udisks2/mount_options.conf | grep -q 'noexec' || exit 1" \
    "Configure noexec for removable media in /etc/udisks2/mount_options.conf"

# Level 2 specific controls
check_control "1.1.15" "Ensure nosuid option set on /var" \
    "mount | grep -E '\s/var\s' | grep -q 'nosuid' || exit 1" \
    "Add 'nosuid' mount option for /var in /etc/fstab"

check_control "1.1.16" "Ensure noexec option set on /var/log" \
    "mount | grep -E '\s/var/log\s' | grep -q 'noexec' || exit 1" \
    "Add 'noexec' mount option for /var/log in /etc/fstab"

check_control "1.1.17" "Ensure nodev option set on /var/log" \
    "mount | grep -E '\s/var/log\s' | grep -q 'nodev' || exit 1" \
    "Add 'nodev' mount option for /var/log in /etc/fstab"

check_control "1.1.18" "Ensure nosuid option set on /var/log" \
    "mount | grep -E '\s/var/log\s' | grep -q 'nosuid' || exit 1" \
    "Add 'nosuid' mount option for /var/log in /etc/fstab"

check_control "1.1.19" "Ensure nodev option set on /var/log/audit" \
    "mount | grep -E '\s/var/log/audit\s' | grep -q 'nodev' || exit 1" \
    "Add 'nodev' mount option for /var/log/audit in /etc/fstab"

check_control "1.1.20" "Ensure nosuid option set on /var/log/audit" \
    "mount | grep -E '\s/var/log/audit\s' | grep -q 'nosuid' || exit 1" \
    "Add 'nosuid' mount option for /var/log/audit in /etc/fstab"

check_control "1.1.21" "Ensure noexec option set on /var/log/audit" \
    "mount | grep -E '\s/var/log/audit\s' | grep -q 'noexec' || exit 1" \
    "Add 'noexec' mount option for /var/log/audit in /etc/fstab"

check_control "1.1.22" "Ensure sticky bit is set on all world-writable directories" \
    "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | wc -l | grep -q '^0$' || exit 1" \
    "Run: find <partition> -xdev -type d -perm -0002 -a ! -perm -1000 -exec chmod +t {} \;"

print_section_header "1.2 Filesystem Integrity"

check_control "1.2.1" "Ensure AIDE or equivalent is installed" \
    "dpkg -s aide || dpkg -s aide-common || exit 1" \
    "Run: apt install aide aide-common"

check_control "1.2.2" "Ensure filesystem integrity is regularly checked" \
    "grep -r aide /etc/cron.* /etc/crontab || systemctl is-enabled aidecheck.service || systemctl is-enabled aidecheck.timer || exit 1" \
    "Configure a cron job or systemd timer for regular AIDE checks"

print_section_header "1.3 Secure Boot Settings"

check_control "1.3.1" "Ensure bootloader permissions are configured" \
    "stat -L -c \"%a %u %g\" /boot/grub/grub.cfg | grep -q \"400 0 0\" || exit 1" \
    "Run: chown root:root /boot/grub/grub.cfg && chmod og-rwx /boot/grub/grub.cfg"

check_control "1.3.2" "Ensure bootloader password is set" \
    "grep -q \"password\" /boot/grub/grub.cfg || exit 1" \
    "Set bootloader password by running grub-mkpasswd-pbkdf2 and updating /etc/grub.d/40_custom"

check_control "1.3.3" "Ensure authentication required for single user mode" \
    "grep -q \"^root:[*!]:\" /etc/shadow || exit 1" \
    "Ensure root password is set and not locked"

print_section_header "1.4 Additional Process Hardening"

check_control "1.4.1" "Ensure core dumps are restricted" \
    "grep -q \"hard core 0\" /etc/security/limits.conf /etc/security/limits.d/* && grep -q \"fs.suid_dumpable = 0\" /etc/sysctl.conf /etc/sysctl.d/* && sysctl fs.suid_dumpable | grep -q \"fs.suid_dumpable = 0\" || exit 1" \
    "Configure core dump restrictions in /etc/security/limits.conf and sysctl settings"

check_control "1.4.2" "Ensure XD/NX support is enabled" \
    "journalctl | grep -i 'protection: active' || dmesg | grep -i 'protection: active' || grep -q -E 'nx|xd' /proc/cpuinfo || exit 1" \
    "Enable XD/NX in BIOS or ensure not disabled in bootloader configuration"

check_control "1.4.3" "Ensure prelink is disabled" \
    "dpkg -s prelink | grep -q 'Status: install ok installed' && exit 1 || exit 0" \
    "Run: apt purge prelink"

check_control "1.4.4" "Ensure ASLR is enabled" \
    "sysctl kernel.randomize_va_space | grep -q 'kernel.randomize_va_space = 2' || exit 1" \
    "Set kernel.randomize_va_space = 2 in /etc/sysctl.conf"

echo -e "\n${GREEN}Filesystem check completed!${NC}"
echo -e "Review any ${RED}FAIL${NC} results and apply the recommended remediation steps."