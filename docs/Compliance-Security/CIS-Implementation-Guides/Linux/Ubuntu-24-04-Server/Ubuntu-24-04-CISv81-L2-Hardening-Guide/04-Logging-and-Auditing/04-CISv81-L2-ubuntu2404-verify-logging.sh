#!/bin/bash
# =============================================================================
# Script:  04-CISv81-L2-ubuntu2404-verify-logging.sh
# Author:  VintageDon (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L2 logging and auditing controls:
# - Controls 4.1.1-4.1.17: Audit configuration
# - Controls 4.2.1-4.2.4: Logging configuration
# - Verifies auditd installation and rules
# - Checks rsyslog/syslog-ng configuration
# - Validates log file permissions and rotation settings
#
# Usage:
#   ./04-CISv81-L2-ubuntu2404-verify-logging.sh
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
    print_section_header "CIS Ubuntu 24.04 LTS - Section 4: Logging and Auditing"
    echo "Running checks for logging and auditing configuration..."
    echo ""

    # Section 4.1 Configure System Accounting (auditd)
    print_section_header "4.1 Configure System Accounting (auditd)"
    check_4_1_1_1 # Ensure auditd is installed
    check_4_1_1_2 # Ensure auditd service is enabled and active
    check_4_1_1_3 # Ensure auditing for processes that start prior to auditd is enabled
    check_4_1_1_4 # Ensure audit_backlog_limit is sufficient
    check_4_1_2_1 # Ensure audit log storage size is configured
    check_4_1_2_2 # Ensure audit logs are not automatically deleted
    check_4_1_2_3 # Ensure system is disabled when audit logs are full
    check_4_1_3_1 # Ensure changes to system administration scope is collected
    check_4_1_3_2 # Ensure actions as another user are always logged
    check_4_1_3_3 # Ensure events that modify the sudo log file are collected
    check_4_1_3_4 # Ensure events that modify date and time information are collected
    check_4_1_3_5 # Ensure events that modify the system's network environment are collected
    check_4_1_3_6 # Ensure events that modify the system's Mandatory Access Controls are collected
    check_4_1_3_7 # Ensure login and logout events are collected
    check_4_1_3_8 # Ensure session initiation information is collected
    check_4_1_3_9 # Ensure discretionary access control permission modification events are collected
    check_4_1_3_10 # Ensure unsuccessful unauthorized file access attempts are collected
    check_4_1_3_11 # Ensure successful file system mounts are collected
    check_4_1_3_12 # Ensure file deletion events by users are collected
    check_4_1_3_13 # Ensure system administrator actions (sudolog) are collected
    check_4_1_3_14 # Ensure kernel module loading and unloading is collected
    check_4_1_3_15 # Ensure suspicious activity is collected
    check_4_1_3_16 # Ensure the audit configuration is immutable
    
    # Section 4.2 Configure Logging
    print_section_header "4.2 Configure Logging"
    check_4_2_1_1 # Ensure rsyslog is installed
    check_4_2_1_2 # Ensure rsyslog service is enabled
    check_4_2_1_3 # Ensure rsyslog default file permissions are configured
    check_4_2_1_4 # Ensure logging is configured
    check_4_2_1_5 # Ensure rsyslog is configured to send logs to a remote log host
    check_4_2_1_6 # Ensure remote rsyslog messages are only accepted on designated log hosts
    check_4_2_2_1 # Ensure journald is configured to send logs to rsyslog
    check_4_2_2_2 # Ensure journald is configured to compress large log files
    check_4_2_2_3 # Ensure journald is configured to write logfiles to persistent disk
    check_4_2_3 # Ensure permissions on all logfiles are configured
    
    echo ""
    echo -e "${BOLD}Check complete.${NC} Review the results above for any needed remediation."
}

# 4.1.1.1 Ensure auditd is installed
check_4_1_1_1() {
    echo -e "\n${BOLD}4.1.1.1 Ensure auditd is installed${NC}"
    
    if dpkg -s auditd audispd-plugins &>/dev/null; then
        print_status "auditd and audispd-plugins are installed" 0
    else
        print_status "auditd and/or audispd-plugins are not installed" 1
        echo "Package should be installed with: sudo apt install auditd audispd-plugins"
    fi
}

# 4.1.1.2 Ensure auditd service is enabled and active
check_4_1_1_2() {
    echo -e "\n${BOLD}4.1.1.2 Ensure auditd service is enabled and active${NC}"
    
    AUDITD_ENABLED=$(systemctl is-enabled auditd 2>/dev/null || echo "disabled")
    AUDITD_ACTIVE=$(systemctl is-active auditd 2>/dev/null || echo "inactive")
    
    if [ "$AUDITD_ENABLED" = "enabled" ] && [ "$AUDITD_ACTIVE" = "active" ]; then
        print_status "auditd service is enabled and active" 0
    else
        print_status "auditd service is not enabled and/or active" 1
        echo "Service status: enabled=$AUDITD_ENABLED, active=$AUDITD_ACTIVE"
        echo "Service should be enabled and started with:"
        echo "sudo systemctl enable auditd"
        echo "sudo systemctl start auditd"
    fi
}

# 4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled
check_4_1_1_3() {
    echo -e "\n${BOLD}4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled${NC}"
    
    if grep -q "^GRUB_CMDLINE_LINUX=.*audit=1.*" /etc/default/grub; then
        print_status "Auditing for processes prior to auditd is enabled" 0
    else
        print_status "Auditing for processes prior to auditd is not enabled" 1
        echo "GRUB configuration should include 'audit=1' in GRUB_CMDLINE_LINUX"
        echo "Add audit=1 to GRUB_CMDLINE_LINUX in /etc/default/grub and run: sudo update-grub"
    fi
}

# 4.1.1.4 Ensure audit_backlog_limit is sufficient
check_4_1_1_4() {
    echo -e "\n${BOLD}4.1.1.4 Ensure audit_backlog_limit is sufficient${NC}"
    
    if grep -q "^GRUB_CMDLINE_LINUX=.*audit_backlog_limit=[0-9][0-9][0-9][0-9].*" /etc/default/grub; then
        print_status "audit_backlog_limit is configured sufficiently" 0
    else
        print_status "audit_backlog_limit is not configured sufficiently" 1
        echo "GRUB configuration should include 'audit_backlog_limit=8192' in GRUB_CMDLINE_LINUX"
        echo "Add audit_backlog_limit=8192 to GRUB_CMDLINE_LINUX in /etc/default/grub and run: sudo update-grub"
    fi
}

# 4.1.2.1 Ensure audit log storage size is configured
check_4_1_2_1() {
    echo -e "\n${BOLD}4.1.2.1 Ensure audit log storage size is configured${NC}"
    
    if grep -q "^max_log_file\s*=\s*[0-9]" /etc/audit/auditd.conf; then
        print_status "Audit log storage size is configured" 0
        MAX_LOG_FILE=$(grep "^max_log_file\s*=" /etc/audit/auditd.conf | awk -F "=" '{print $2}' | tr -d ' ')
        echo "Current max_log_file setting: $MAX_LOG_FILE"
    else
        print_status "Audit log storage size is not configured" 1
        echo "Edit /etc/audit/auditd.conf and set max_log_file to an appropriate value (e.g., 8 or higher)"
    fi
}

# 4.1.2.2 Ensure audit logs are not automatically deleted
check_4_1_2_2() {
    echo -e "\n${BOLD}4.1.2.2 Ensure audit logs are not automatically deleted${NC}"
    
    MAX_LOG_FILE_ACTION=$(grep "^max_log_file_action" /etc/audit/auditd.conf | awk -F "=" '{print $2}' | tr -d ' ')
    
    if [ "$MAX_LOG_FILE_ACTION" = "keep_logs" ]; then
        print_status "Audit logs are not automatically deleted" 0
    else
        print_status "Audit logs may be automatically deleted" 1
        echo "Current max_log_file_action setting: $MAX_LOG_FILE_ACTION"
        echo "Edit /etc/audit/auditd.conf and set max_log_file_action to keep_logs"
    fi
}

# 4.1.2.3 Ensure system is disabled when audit logs are full
check_4_1_2_3() {
    echo -e "\n${BOLD}4.1.2.3 Ensure system is disabled when audit logs are full${NC}"
    
    SPACE_LEFT_ACTION=$(grep "^space_left_action" /etc/audit/auditd.conf | awk -F "=" '{print $2}' | tr -d ' ')
    ACTION_MAIL_ACCT=$(grep "^action_mail_acct" /etc/audit/auditd.conf | awk -F "=" '{print $2}' | tr -d ' ')
    ADMIN_SPACE_LEFT_ACTION=$(grep "^admin_space_left_action" /etc/audit/auditd.conf | awk -F "=" '{print $2}' | tr -d ' ')
    
    if [ "$SPACE_LEFT_ACTION" = "email" ] && [ "$ACTION_MAIL_ACCT" = "root" ] && [ "$ADMIN_SPACE_LEFT_ACTION" = "halt" ]; then
        print_status "System is configured to disable when audit logs are full" 0
    else
        print_status "System is not configured to disable when audit logs are full" 1
        echo "Current settings:"
        echo "space_left_action = $SPACE_LEFT_ACTION (should be email)"
        echo "action_mail_acct = $ACTION_MAIL_ACCT (should be root)"
        echo "admin_space_left_action = $ADMIN_SPACE_LEFT_ACTION (should be halt)"
        echo "Edit /etc/audit/auditd.conf and set appropriate values"
    fi
}

# 4.1.3.1 Ensure changes to system administration scope is collected
check_4_1_3_1() {
    echo -e "\n${BOLD}4.1.3.1 Ensure changes to system administration scope is collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-scope.rules ] && grep -q "\-w /etc/sudoers -p wa -k scope" /etc/audit/rules.d/50-scope.rules && grep -q "\-w /etc/sudoers.d/ -p wa -k scope" /etc/audit/rules.d/50-scope.rules; then
        print_status "Changes to system administration scope are collected" 0
    else
        print_status "Changes to system administration scope are not collected" 1
        echo "Audit rules should be configured to monitor changes to /etc/sudoers and /etc/sudoers.d/"
    fi
}

# 4.1.3.2 Ensure actions as another user are always logged
check_4_1_3_2() {
    echo -e "\n${BOLD}4.1.3.2 Ensure actions as another user are always logged${NC}"
    
    if [ -f /etc/audit/rules.d/50-user_emulation.rules ] && grep -q "\-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation" /etc/audit/rules.d/50-user_emulation.rules; then
        print_status "Actions as another user are being logged" 0
    else
        print_status "Actions as another user are not being logged" 1
        echo "Audit rules should be configured to monitor user emulation via execve"
    fi
}

# 4.1.3.3 Ensure events that modify the sudo log file are collected
check_4_1_3_3() {
    echo -e "\n${BOLD}4.1.3.3 Ensure events that modify the sudo log file are collected${NC}"
    
    SUDO_LOG=$(grep -r "^Defaults.*logfile=" /etc/sudoers /etc/sudoers.d/ 2>/dev/null | awk -F '=' '{print $2}' | tr -d ' "')
    
    if [ -n "$SUDO_LOG" ] && [ -f /etc/audit/rules.d/50-sudo.rules ] && grep -q "\-w $SUDO_LOG -p wa -k sudo_log_file" /etc/audit/rules.d/50-sudo.rules; then
        print_status "Events that modify the sudo log file are collected" 0
    else
        print_status "Events that modify the sudo log file are not collected" 1
        if [ -n "$SUDO_LOG" ]; then
            echo "Sudo log file: $SUDO_LOG"
        else
            echo "Sudo log file not defined in sudoers configuration"
        fi
        echo "Audit rules should be configured to monitor the sudo log file"
    fi
}

# 4.1.3.4 Ensure events that modify date and time information are collected
check_4_1_3_4() {
    echo -e "\n${BOLD}4.1.3.4 Ensure events that modify date and time information are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-time-change.rules ] && 
       grep -q "\-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k time-change" /etc/audit/rules.d/50-time-change.rules && 
       grep -q "\-w /etc/localtime -p wa -k time-change" /etc/audit/rules.d/50-time-change.rules; then
        print_status "Events that modify date and time information are collected" 0
    else
        print_status "Events that modify date and time information are not collected" 1
        echo "Audit rules should be configured to monitor time changes"
    fi
}

# 4.1.3.5 Ensure events that modify the system's network environment are collected
check_4_1_3_5() {
    echo -e "\n${BOLD}4.1.3.5 Ensure events that modify the system's network environment are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-network.rules ] && 
       grep -q "\-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" /etc/audit/rules.d/50-network.rules && 
       grep -q "\-w /etc/issue -p wa -k system-locale" /etc/audit/rules.d/50-network.rules && 
       grep -q "\-w /etc/issue.net -p wa -k system-locale" /etc/audit/rules.d/50-network.rules && 
       grep -q "\-w /etc/hosts -p wa -k system-locale" /etc/audit/rules.d/50-network.rules && 
       grep -q "\-w /etc/networks -p wa -k system-locale" /etc/audit/rules.d/50-network.rules && 
       grep -q "\-w /etc/network/ -p wa -k system-locale" /etc/audit/rules.d/50-network.rules; then
        print_status "Events that modify the system's network environment are collected" 0
    else
        print_status "Events that modify the system's network environment are not collected" 1
        echo "Audit rules should be configured to monitor network environment changes"
    fi
}

# 4.1.3.6 Ensure events that modify the system's Mandatory Access Controls are collected
check_4_1_3_6() {
    echo -e "\n${BOLD}4.1.3.6 Ensure events that modify the system's Mandatory Access Controls are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-MAC-policy.rules ] && 
       grep -q "\-w /etc/apparmor/ -p wa -k MAC-policy" /etc/audit/rules.d/50-MAC-policy.rules && 
       grep -q "\-w /etc/apparmor.d/ -p wa -k MAC-policy" /etc/audit/rules.d/50-MAC-policy.rules; then
        print_status "Events that modify the system's Mandatory Access Controls are collected" 0
    else
        print_status "Events that modify the system's Mandatory Access Controls are not collected" 1
        echo "Audit rules should be configured to monitor AppArmor configuration changes"
    fi
}

# 4.1.3.7 Ensure login and logout events are collected
check_4_1_3_7() {
    echo -e "\n${BOLD}4.1.3.7 Ensure login and logout events are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-login.rules ] && 
       grep -q "\-w /var/log/faillog -p wa -k logins" /etc/audit/rules.d/50-login.rules && 
       grep -q "\-w /var/log/lastlog -p wa -k logins" /etc/audit/rules.d/50-login.rules && 
       grep -q "\-w /var/log/tallylog -p wa -k logins" /etc/audit/rules.d/50-login.rules; then
        print_status "Login and logout events are collected" 0
    else
        print_status "Login and logout events are not collected" 1
        echo "Audit rules should be configured to monitor login/logout events"
    fi
}

# 4.1.3.8 Ensure session initiation information is collected
check_4_1_3_8() {
    echo -e "\n${BOLD}4.1.3.8 Ensure session initiation information is collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-session.rules ] && 
       grep -q "\-w /var/run/utmp -p wa -k session" /etc/audit/rules.d/50-session.rules && 
       grep -q "\-w /var/log/wtmp -p wa -k session" /etc/audit/rules.d/50-session.rules && 
       grep -q "\-w /var/log/btmp -p wa -k session" /etc/audit/rules.d/50-session.rules; then
        print_status "Session initiation information is collected" 0
    else
        print_status "Session initiation information is not collected" 1
        echo "Audit rules should be configured to monitor session information"
    fi
}

# 4.1.3.9 Ensure discretionary access control permission modification events are collected
check_4_1_3_9() {
    echo -e "\n${BOLD}4.1.3.9 Ensure discretionary access control permission modification events are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-perm_mod.rules ] && 
       grep -q "\-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=unset -k perm_mod" /etc/audit/rules.d/50-perm_mod.rules && 
       grep -q "\-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=unset -k perm_mod" /etc/audit/rules.d/50-perm_mod.rules; then
        print_status "DAC permission modification events are collected" 0
    else
        print_status "DAC permission modification events are not collected" 1
        echo "Audit rules should be configured to monitor permission changes"
    fi
}

# 4.1.3.10 Ensure unsuccessful unauthorized file access attempts are collected
check_4_1_3_10() {
    echo -e "\n${BOLD}4.1.3.10 Ensure unsuccessful unauthorized file access attempts are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-access.rules ] && 
       grep -q "\-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -k access" /etc/audit/rules.d/50-access.rules && 
       grep -q "\-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -k access" /etc/audit/rules.d/50-access.rules; then
        print_status "Unsuccessful unauthorized file access attempts are collected" 0
    else
        print_status "Unsuccessful unauthorized file access attempts are not collected" 1
        echo "Audit rules should be configured to monitor unsuccessful file access attempts"
    fi
}

# 4.1.3.11 Ensure successful file system mounts are collected
check_4_1_3_11() {
    echo -e "\n${BOLD}4.1.3.11 Ensure successful file system mounts are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-mounts.rules ] && 
       grep -q "\-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -k mounts" /etc/audit/rules.d/50-mounts.rules; then
        print_status "Successful file system mounts are collected" 0
    else
        print_status "Successful file system mounts are not collected" 1
        echo "Audit rules should be configured to monitor successful mounts"
    fi
}

# 4.1.3.12 Ensure file deletion events by users are collected
check_4_1_3_12() {
    echo -e "\n${BOLD}4.1.3.12 Ensure file deletion events by users are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-delete.rules ] && 
       grep -q "\-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=unset -k delete" /etc/audit/rules.d/50-delete.rules; then
        print_status "File deletion events by users are collected" 0
    else
        print_status "File deletion events by users are not collected" 1
        echo "Audit rules should be configured to monitor file deletion events"
    fi
}

# 4.1.3.13 Ensure system administrator actions (sudolog) are collected
check_4_1_3_13() {
    echo -e "\n${BOLD}4.1.3.13 Ensure system administrator actions (sudolog) are collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-actions.rules ] && 
       grep -q "\-w /var/log/sudo.log -p wa -k actions" /etc/audit/rules.d/50-actions.rules; then
        print_status "System administrator actions are collected" 0
    else
        print_status "System administrator actions are not collected" 1
        echo "Audit rules should be configured to monitor sudo.log"
    fi
}

# 4.1.3.14 Ensure kernel module loading and unloading is collected
check_4_1_3_14() {
    echo -e "\n${BOLD}4.1.3.14 Ensure kernel module loading and unloading is collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-modules.rules ] && 
       grep -q "\-w /sbin/insmod -p x -k modules" /etc/audit/rules.d/50-modules.rules && 
       grep -q "\-w /sbin/rmmod -p x -k modules" /etc/audit/rules.d/50-modules.rules && 
       grep -q "\-w /sbin/modprobe -p x -k modules" /etc/audit/rules.d/50-modules.rules && 
       grep -q "\-a always,exit -F arch=b64 -S init_module -S delete_module -k modules" /etc/audit/rules.d/50-modules.rules; then
        print_status "Kernel module loading and unloading is collected" 0
    else
        print_status "Kernel module loading and unloading is not collected" 1
        echo "Audit rules should be configured to monitor kernel module operations"
    fi
}

# 4.1.3.15 Ensure suspicious activity is collected
check_4_1_3_15() {
    echo -e "\n${BOLD}4.1.3.15 Ensure suspicious activity is collected${NC}"
    
    if [ -f /etc/audit/rules.d/50-suspicious.rules ] && 
       grep -q "\-w /usr/bin/wget -p x -k suspicious" /etc/audit/rules.d/50-suspicious.rules && 
       grep -q "\-w /usr/bin/curl -p x -k suspicious" /etc/audit/rules.d/50-suspicious.rules; then
        print_status "Suspicious activity is collected" 0
    else
        print_status "Suspicious activity is not collected" 1
        echo "Audit rules should be configured to monitor suspicious activities"
    fi
}

# 4.1.3.16 Ensure the audit configuration is immutable
check_4_1_3_16() {
    echo -e "\n${BOLD}4.1.3.16 Ensure the audit configuration is immutable${NC}"
    
    # Check if the audit configuration is immutable
    AUDIT_IMMUTABLE=$(grep "^\s*-e\s*2\s*$" /etc/audit/rules.d/99-finalize.rules 2>/dev/null)
    
    if [ -n "$AUDIT_IMMUTABLE" ]; then
        print_status "Audit configuration is immutable" 0
    else
        print_status "Audit configuration is not immutable" 1
        echo "Add '-e 2' as the last line in /etc/audit/rules.d/99-finalize.rules"
    fi
}

# 4.2.1.1 Ensure rsyslog is installed
check_4_2_1_1() {
    echo -e "\n${BOLD}4.2.1.1 Ensure rsyslog is installed${NC}"
    
    if dpkg -s rsyslog &>/dev/null; then
        print_status "rsyslog is installed" 0
    else
        print_status "rsyslog is not installed" 1
        echo "Install rsyslog with: sudo apt install rsyslog"
    fi
}

# 4.2.1.2 Ensure rsyslog service is enabled
check_4_2_1_2() {
    echo -e "\n${BOLD}4.2.1.2 Ensure rsyslog service is enabled${NC}"
    
    if systemctl is-enabled rsyslog &>/dev/null; then
        print_status "rsyslog service is enabled" 0
    else
        print_status "rsyslog service is not enabled" 1
        echo "Enable rsyslog with: sudo systemctl enable rsyslog"
    fi
}

# 4.2.1.3 Ensure rsyslog default file permissions are configured
check_4_2_1_3() {
    echo -e "\n${BOLD}4.2.1.3 Ensure rsyslog default file permissions are configured${NC}"
    
    if grep -q "^\$FileCreateMode\s*0[0-7][0-7][0-7]" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null; then
        FILE_MODE=$(grep "^\$FileCreateMode\s*0[0-7][0-7][0-7]" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null | awk '{print $2}')
        if [ "$FILE_MODE" -le "0640" ]; then
            print_status "rsyslog default file permissions are configured properly" 0
            echo "Current FileCreateMode: $FILE_MODE"
        else
            print_status "rsyslog default file permissions are not secure enough" 1
            echo "Current FileCreateMode: $FILE_MODE (should be 0640 or more restrictive)"
        fi
    else
        print_status "rsyslog default file permissions are not configured" 1
        echo "Add '\$FileCreateMode 0640' to /etc/rsyslog.conf"
    fi
}

# 4.2.1.4 Ensure logging is configured
check_4_2_1_4() {
    echo -e "\n${BOLD}4.2.1.4 Ensure logging is configured${NC}"
    
    if grep -q "^[^#].*\.\*" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null; then
        print_status "Logging appears to be configured" 0
        echo "Log destinations found in rsyslog configuration"
    else
        print_status "Logging does not appear to be configured" 1
        echo "No log destinations found in rsyslog configuration"
        echo "Edit /etc/rsyslog.conf to ensure logs are sent to appropriate files"
    fi
}

# 4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host
check_4_2_1_5() {
    echo -e "\n${BOLD}4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host${NC}"
    
    if grep -q "^[^#].*\@\@.*" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null || grep -q "^[^#].*\@.*" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null; then
        print_status "rsyslog is configured to send logs to a remote log host" 0
        REMOTE_CONFIG=$(grep -h "^[^#].*\@" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)
        echo "Remote logging configuration: $REMOTE_CONFIG"
    else
        print_status "rsyslog is not configured to send logs to a remote log host" 1
        echo "Configure rsyslog to send logs to a remote host using:"
        echo "*.* @@remote-host:514 (for TCP) or *.* @remote-host:514 (for UDP)"
    fi
}

# 4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts
check_4_2_1_6() {
    echo -e "\n${BOLD}4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts${NC}"
    
    IMUDP=$(grep -h "^\$ModLoad\s*imudp" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)
    IMTCP=$(grep -h "^\$ModLoad\s*imtcp" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)
    
    if [ -n "$IMUDP" ] || [ -n "$IMTCP" ]; then
        print_info "System is configured to receive remote rsyslog messages"
        echo "UDP module loaded: $([ -n "$IMUDP" ] && echo "Yes" || echo "No")"
        echo "TCP module loaded: $([ -n "$IMTCP" ] && echo "Yes" || echo "No")"
        echo "Ensure this system is designated as a log host"
    else
        print_status "System is not accepting remote rsyslog messages" 0
        echo "If this is a designated log host, configure it to accept remote logs"
    fi
}

# 4.2.2.1 Ensure journald is configured to send logs to rsyslog
check_4_2_2_1() {
    echo -e "\n${BOLD}4.2.2.1 Ensure journald is configured to send logs to rsyslog${NC}"
    
    if grep -q "^ForwardToSyslog=yes" /etc/systemd/journald.conf; then
        print_status "journald is configured to send logs to rsyslog" 0
    else
        print_status "journald is not configured to send logs to rsyslog" 1
        echo "Edit /etc/systemd/journald.conf and set ForwardToSyslog=yes"
    fi
}

# 4.2.2.2 Ensure journald is configured to compress large log files
check_4_2_2_2() {
    echo -e "\n${BOLD}4.2.2.2 Ensure journald is configured to compress large log files${NC}"
    
    if grep -q "^Compress=yes" /etc/systemd/journald.conf; then
        print_status "journald is configured to compress large log files" 0
    else
        print_status "journald is not configured to compress large log files" 1
        echo "Edit /etc/systemd/journald.conf and set Compress=yes"
    fi
}

# 4.2.2.3 Ensure journald is configured to write logfiles to persistent disk
check_4_2_2_3() {
    echo -e "\n${BOLD}4.2.2.3 Ensure journald is configured to write logfiles to persistent disk${NC}"
    
    if grep -q "^Storage=persistent" /etc/systemd/journald.conf; then
        print_status "journald is configured to write logfiles to persistent disk" 0
    else
        print_status "journald is not configured to write logfiles to persistent disk" 1
        echo "Edit /etc/systemd/journald.conf and set Storage=persistent"
    fi
}

# 4.2.3 Ensure permissions on all logfiles are configured
check_4_2_3() {
    echo -e "\n${BOLD}4.2.3 Ensure permissions on all logfiles are configured${NC}"
    
    INCORRECT_PERMISSIONS=$(find /var/log -type f -perm /g+w,o+r -o -perm /g+wx,o+wx 2>/dev/null)
    
    if [ -z "$INCORRECT_PERMISSIONS" ]; then
        print_status "All logfiles have appropriate permissions" 0
    else
        print_status "Some logfiles have incorrect permissions" 1
        echo "Files with improper permissions:"
        echo "$INCORRECT_PERMISSIONS"
        echo "Fix permissions with: sudo chmod g-wx,o-rwx /var/log/<file>"
    fi
}

# Run the main function
main