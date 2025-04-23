#!/bin/bash
# =============================================================================
# Script:  02-CISv81-l1-ubuntu2404-verify-services.sh
# Author:  VintageDon (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L1 service controls:
# - Control 2.1.1: Ensures xinetd service is not installed
# - Control 2.2.1: Ensures time synchronization is in use 
# - Control 2.2.2: Ensures chrony is configured properly with appropriate 
#                  NTP pool servers and synchronized status
#
# Usage:
#   ./02-CISv81-l1-ubuntu2404-verify-services.sh
#
# Exit codes:
#   0 - All checks passed
#   1 - One or more checks failed
# =============================================================================

# Initialize variables
xinetd_status="❌ FAIL: xinetd is installed"
time_sync_status="❌ FAIL: No time synchronization service is active"
chrony_config_status=""
chrony_sync_status=""

# Check Control 2.1.1 - Xinetd not installed
if ! dpkg -s xinetd &>/dev/null; then
   xinetd_status="✅ PASS: xinetd is not installed"
fi

# Check Control 2.2.1 - Time synchronization is in use
if systemctl is-active chronyd &>/dev/null || systemctl is-active systemd-timesyncd &>/dev/null; then
   time_sync_status="✅ PASS: Time synchronization service is active"
fi

# Check Control 2.2.2 - Chrony is properly configured
if systemctl is-active chronyd &>/dev/null; then
   # Check NTP server configuration
   if grep -E "^(server|pool)" /etc/chrony/chrony.conf | grep -q "pool.ntp.org"; then
       chrony_config_status="✅ PASS: Chrony is configured with proper NTP pool servers"
   else
       chrony_config_status="⚠️ WARNING: Chrony is running but may not have standard NTP servers configured"
   fi

   # Check synchronization status
   if chronyc tracking | grep -q "Stratum"; then
       chrony_sync_status="✅ PASS: Chrony is synchronized with time source"
   else
       chrony_sync_status="⚠️ WARNING: Chrony may not be properly synchronized"
   fi
elif systemctl is-active systemd-timesyncd &>/dev/null; then
   chrony_config_status="⚠️ WARNING: Using systemd-timesyncd instead of chrony"
   # No need to set chrony_sync_status as it's not relevant
else
   chrony_config_status="❌ FAIL: No time synchronization service is configured"
   # No need to set chrony_sync_status as it's not relevant
fi

# Print the report
echo "CIS Ubuntu 24.04 Service Controls Verification"
echo "==============================================="
echo
echo "Control 2.1.1 - Xinetd Service:"
echo "$xinetd_status"
echo
echo "Control 2.2.1 - Time Synchronization:"
echo "$time_sync_status"
echo
echo "Control 2.2.2 - Chrony Configuration:"
if [ -n "$chrony_config_status" ]; then
   echo "$chrony_config_status"
fi
if [ -n "$chrony_sync_status" ]; then
   echo "$chrony_sync_status"
fi

# Set exit status
if [[ "$xinetd_status" == *"FAIL"* ]] || [[ "$time_sync_status" == *"FAIL"* ]] || [[ "$chrony_config_status" == *"FAIL"* ]] || [[ "$chrony_sync_status" == *"FAIL"* ]]; then
   exit 1
else
   exit 0
fi