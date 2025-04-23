#!/bin/bash
# =============================================================================
# Script:  cis-filesystem.sh
# Author:  Based on VintageDon's work (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L1 file system controls:
# - Controls 1.1.1.1-1.1.14: File system partition layout and mount options
# - Verifies separate partitions for critical directories
# - Checks mount options (nodev, nosuid, noexec)
# - Verifies sticky bit on world-writable directories
#
# Usage:
#   ./cis-filesystem.sh
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

echo "CIS Ubuntu 24.04 File System Controls Verification"
echo "=================================================="
echo

# Function to check if a directory is a separate partition
check_separate_partition() {
    local dir=$1
    local control=$2
    
    # Get the mount point for this directory
    local mount=$(df -P "$dir" | awk 'NR==2 {print $6}')
    
    # Check if it's mounted as its own partition
    if [ "$mount" = "$dir" ]; then
        echo -e "${GREEN}✅ PASS: $control - $dir is a separate partition${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL: $control - $dir is not a separate partition (mounted on $mount)${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
}

# Function to check mount options
check_mount_option() {
    local dir=$1
    local option=$2
    local control=$3
    
    # Get the mount options for this directory
    if mount | grep " $dir " | grep -q "$option"; then
        echo -e "${GREEN}✅ PASS: $control - $option option is set on $dir${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL: $control - $option option is not set on $dir${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
}

# Check if /tmp is a separate partition (1.1.1.1)
check_separate_partition "/tmp" "1.1.1.1"

# Check mount options for /tmp
check_mount_option "/tmp" "nodev" "1.1.1.2"
check_mount_option "/tmp" "nosuid" "1.1.1.3"
check_mount_option "/tmp" "noexec" "1.1.1.4"

# Check if /var is a separate partition (1.1.2)
check_separate_partition "/var" "1.1.2"

# Check if /var/tmp is a separate partition (1.1.3)
check_separate_partition "/var/tmp" "1.1.3"

# Check mount options for /var/tmp
check_mount_option "/var/tmp" "nodev" "1.1.4"
check_mount_option "/var/tmp" "nosuid" "1.1.5"
check_mount_option "/var/tmp" "noexec" "1.1.6"

# Check if /var/log is a separate partition (1.1.7)
check_separate_partition "/var/log" "1.1.7"

# Check if /var/log/audit is a separate partition (1.1.8)
check_separate_partition "/var/log/audit" "1.1.8"

# Check if /home is a separate partition (1.1.9)
check_separate_partition "/home" "1.1.9"

# Check mount options for /home
check_mount_option "/home" "nodev" "1.1.10"

# Check mount options for /dev/shm
check_mount_option "/dev/shm" "nodev" "1.1.11"
check_mount_option "/dev/shm" "nosuid" "1.1.12"
check_mount_option "/dev/shm" "noexec" "1.1.13"

# Check sticky bit on world-writable directories (1.1.14)
echo -e "\nChecking sticky bit on world-writable directories (1.1.14)..."
WORLD_WRITABLE=$(find / -path /proc -prune -o -type d -perm -0002 -not -perm -1000 -ls 2>/dev/null)

if [ -z "$WORLD_WRITABLE" ]; then
    echo -e "${GREEN}✅ PASS: 1.1.14 - All world-writable directories have the sticky bit set${NC}"
else
    echo -e "${RED}❌ FAIL: 1.1.14 - Found world-writable directories without sticky bit:${NC}"
    echo "$WORLD_WRITABLE"
    FAILURES=$((FAILURES+1))
fi

# Check bootloader file ownership and permissions
echo -e "\nChecking bootloader file security..."

# Bootloader owned by root (1.4.1)
BOOTLOADER_OWNER=$(stat -c "%U:%G" /boot/grub/grub.cfg)
if [ "$BOOTLOADER_OWNER" = "root:root" ]; then
    echo -e "${GREEN}✅ PASS: 1.4.1 - Bootloader is owned by root:root${NC}"
else
    echo -e "${RED}❌ FAIL: 1.4.1 - Bootloader is not owned by root:root (current: $BOOTLOADER_OWNER)${NC}"
    FAILURES=$((FAILURES+1))
fi

# Bootloader permissions (1.4.2)
BOOTLOADER_PERMS=$(stat -c "%a" /boot/grub/grub.cfg)
if [ "$BOOTLOADER_PERMS" = "400" ]; then
    echo -e "${GREEN}✅ PASS: 1.4.2 - Bootloader has correct permissions (400)${NC}"
else
    echo -e "${RED}❌ FAIL: 1.4.2 - Bootloader has incorrect permissions (current: $BOOTLOADER_PERMS, should be 400)${NC}"
    FAILURES=$((FAILURES+1))
fi

# Summary
echo -e "\n=== Summary ==="
if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}All file system controls passed!${NC}"
    exit 0
else
    echo -e "${RED}$FAILURES file system controls failed!${NC}"
    exit 1
fi