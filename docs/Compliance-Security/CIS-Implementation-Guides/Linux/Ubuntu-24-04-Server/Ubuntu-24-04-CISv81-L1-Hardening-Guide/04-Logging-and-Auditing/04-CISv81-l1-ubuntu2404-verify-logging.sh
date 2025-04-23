#!/bin/bash
# =============================================================================
# Script:  04-CISv81-l1-ubuntu2404-verify-logging.sh
# Author:  Based on VintageDon's work (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L1 logging and auditing controls:
# - Control 4.1.1: Ensure auditd is installed
# - Control 4.1.2: Ensure auditd service is running
# - Control 4.1.3: Ensure audit logs are not automatically deleted
# - Control 4.2.1: Ensure system logs are collected
# - Control 4.3.1: Ensure logrotate is configured
#
# Usage:
#   ./04-CISv81-l1-ubuntu2404-verify-logging.sh
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

echo "CIS Ubuntu 24.04 Logging and Auditing Controls Verification"
echo "==========================================================="
echo

# Function to check if a package is installed
check_package() {
    local pkg=$1
    local control=$2
    local description=$3
    
    if dpkg -s "$pkg" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ PASS: $control - $description ($pkg is installed)${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL: $control - $description ($pkg is not installed)${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
}

# Function to check if a service is active and enabled
check_service() {
    local service=$1
    local control=$2
    local description=$3
    
    if systemctl is-active "$service" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ PASS: $control - $description ($service is active)${NC}"
        active_status=0
    else
        echo -e "${RED}❌ FAIL: $control - $description ($service is not active)${NC}"
        active_status=1
        FAILURES=$((FAILURES+1))
    fi
    
    if systemctl is-enabled "$service" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ PASS: $control - $description ($service is enabled)${NC}"
        enabled_status=0
    else
        echo -e "${RED}❌ FAIL: $control - $description ($service is not enabled)${NC}"
        enabled_status=1
        FAILURES=$((FAILURES+1))
    fi
    
    return $((active_status || enabled_status))
}

# Function to check config file setting
check_config() {
    local file=$1
    local pattern=$2
    local expected=$3
    local control=$4
    local description=$5
    
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ FAIL: $control - $description (file $file not found)${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
    
    local value=$(grep "^$pattern" "$file" | awk '{print $NF}')
    
    if [ "$value" = "$expected" ]; then
        echo -e "${GREEN}✅ PASS: $control - $description ($pattern = $value)${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL: $control - $description ($pattern = $value, should be $expected)${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
}

# Function to check if a file exists
check_file() {
    local file=$1
    local control=$2
    local description=$3
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ PASS: $control - $description (file $file exists)${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL: $control - $description (file $file not found)${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
}

# Function to check if a directory exists
check_dir() {
    local dir=$1
    local control=$2
    local description=$3
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✅ PASS: $control - $description (directory $dir exists)${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL: $control - $description (directory $dir not found)${NC}"
        FAILURES=$((FAILURES+1))
        return 1
    fi
}

# Check Control 4.1.1 - Ensure auditd is installed
echo "Checking auditd installation (4.1.1)..."
check_package "auditd" "4.1.1" "Audit daemon is installed"
check_package "audispd-plugins" "4.1.1" "Audit dispatcher plugins are installed"

# Check Control 4.1.2 - Ensure auditd service is running
echo -e "\nChecking auditd service status (4.1.2)..."
check_service "auditd" "4.1.2" "Audit daemon is running and enabled"

# Check Control 4.1.3 - Ensure audit logs are not automatically deleted
echo -e "\nChecking audit log retention settings (4.1.3)..."
check_config "/etc/audit/auditd.conf" "max_log_file_action" "keep_logs" "4.1.3" "Audit logs are not automatically deleted"
check_config "/etc/audit/auditd.conf" "space_left_action" "email" "4.1.3" "Space left action is set to email"
check_config "/etc/audit/auditd.conf" "action_mail_acct" "root" "4.1.3" "Email notifications sent to root"

# Check audit rules from GitHub repository
echo -e "\nChecking audit rules configuration..."
AUDIT_RULES_LOCATION="/etc/audit/rules.d/audit.rules"
if [ -f "$AUDIT_RULES_LOCATION" ]; then
    echo -e "${GREEN}✅ PASS: Audit rules file exists at $AUDIT_RULES_LOCATION${NC}"
    
    # Check for GitHub header in rules file
    if grep -q "Linux Audit Daemon - Best Practice Configuration" "$AUDIT_RULES_LOCATION"; then
        echo -e "${GREEN}✅ PASS: Audit rules file contains expected GitHub header${NC}"
    else
        echo -e "${RED}❌ FAIL: Audit rules file doesn't contain expected GitHub header${NC}"
        FAILURES=$((FAILURES+1))
    fi
    
    # Check for common rule components
    RULE_CHECKS=(
        "auditlog"
        "auditconfig"
        "audittools"
    )
    
    for check in "${RULE_CHECKS[@]}"; do
        if grep -q "$check" "$AUDIT_RULES_LOCATION"; then
            echo -e "${GREEN}✅ PASS: Audit rules contain $check monitoring${NC}"
        else
            echo -e "${RED}❌ FAIL: Audit rules missing $check monitoring${NC}"
            FAILURES=$((FAILURES+1))
        fi
    done
    
    # Check if rules are loaded
    echo -e "\nChecking if audit rules are loaded into kernel..."
    loaded_rules=$(auditctl -l | wc -l)
    if [ "$loaded_rules" -gt 5 ]; then
        echo -e "${GREEN}✅ PASS: Audit rules are loaded into kernel ($loaded_rules rules)${NC}"
    else
        echo -e "${RED}❌ FAIL: Few or no audit rules loaded into kernel ($loaded_rules rules)${NC}"
        FAILURES=$((FAILURES+1))
    fi
else
    echo -e "${RED}❌ FAIL: Audit rules file not found at $AUDIT_RULES_LOCATION${NC}"
    FAILURES=$((FAILURES+1))
fi

# Check Control 4.2.1 - Ensure system logs are collected (rsyslog)
echo -e "\nChecking system logging configuration (4.2.1)..."
check_package "rsyslog" "4.2.1" "System logging daemon is installed"
check_service "rsyslog" "4.2.1" "System logging daemon is running and enabled"

# Check for common log files that should be configured
LOG_FILES=(
    "/var/log/auth.log"
    "/var/log/syslog"
    "/var/log/kern.log"
    "/var/log/messages"
)

for log_file in "${LOG_FILES[@]}"; do
    if [ -f "$log_file" ]; then
        echo -e "${GREEN}✅ PASS: Log file $log_file exists${NC}"
    else
        echo -e "${YELLOW}⚠️ WARNING: Log file $log_file not found${NC}"
        # Not counting as failure since logs might not have been generated yet
    fi
done

# Check rsyslog configuration
check_file "/etc/rsyslog.conf" "4.2.1" "System logging configuration exists"
check_dir "/etc/rsyslog.d" "4.2.1" "System logging configuration directory exists"

# Check if custom rsyslog config exists
if [ -f "/etc/rsyslog.d/50-default.conf" ]; then
    echo -e "${GREEN}✅ PASS: Custom rsyslog configuration exists at /etc/rsyslog.d/50-default.conf${NC}"
    
    # Check for key logging facilities that should be defined
    LOG_FACILITIES=(
        "kern.*"
        "auth,authpriv.*"
        "mail.*"
        "cron.*"
        "daemon.*"
        "*.emerg"
    )
    
    for facility in "${LOG_FACILITIES[@]}"; do
        if grep -q "$facility" /etc/rsyslog.d/50-default.conf; then
            echo -e "${GREEN}✅ PASS: rsyslog configured for $facility${NC}"
        else
            echo -e "${RED}❌ FAIL: rsyslog missing configuration for $facility${NC}"
            FAILURES=$((FAILURES+1))
        fi
    done
else
    echo -e "${YELLOW}⚠️ WARNING: Custom rsyslog config file not found at /etc/rsyslog.d/50-default.conf${NC}"
    echo -e "${YELLOW}   Checking default rsyslog configuration instead${NC}"
    
    # Check default rsyslog config
    if grep -q "FileOwner\|FileGroup" /etc/rsyslog.conf; then
        echo -e "${GREEN}✅ PASS: Default rsyslog configuration exists${NC}"
    else
        echo -e "${RED}❌ FAIL: Default rsyslog configuration appears invalid${NC}"
        FAILURES=$((FAILURES+1))
    fi
fi

# Check Control 4.3.1 - Ensure logrotate is configured
echo -e "\nChecking logrotate configuration (4.3.1)..."
check_package "logrotate" "4.3.1" "Log rotation utility is installed"
check_file "/etc/logrotate.conf" "4.3.1" "Log rotation configuration exists"
check_dir "/etc/logrotate.d" "4.3.1" "Log rotation configuration directory exists"

# Check logrotate configuration
if grep -q "weekly\|rotate\|create\|compress" /etc/logrotate.conf; then
    echo -e "${GREEN}✅ PASS: Logrotate has basic configuration settings${NC}"
else
    echo -e "${RED}❌ FAIL: Logrotate configuration appears to be missing basic settings${NC}"
    FAILURES=$((FAILURES+1))
fi

# Check for specific log file configurations
if [ -f "/etc/logrotate.d/auditd" ]; then
    echo -e "${GREEN}✅ PASS: Audit log rotation configuration exists${NC}"
else
    echo -e "${RED}❌ FAIL: Audit log rotation configuration not found${NC}"
    FAILURES=$((FAILURES+1))
fi

# Summary
echo -e "\n=== Summary ==="
if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}All logging and auditing controls passed!${NC}"
    exit 0
else
    echo -e "${RED}$FAILURES logging and auditing controls failed!${NC}"
    exit 1
fi