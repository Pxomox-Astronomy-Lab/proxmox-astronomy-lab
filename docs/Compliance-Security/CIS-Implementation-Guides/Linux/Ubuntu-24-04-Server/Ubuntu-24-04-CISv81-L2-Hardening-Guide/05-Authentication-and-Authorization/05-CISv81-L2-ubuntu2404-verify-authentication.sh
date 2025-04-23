#!/bin/bash
# =============================================================================
# Script:  05-CISv81-L2-ubuntu2404-verify-auth.sh
# Author:  VintageDon (https://github.com/vintagedon)
# Repo:    https://github.com/vintagedon/proxmox-astronomy-lab
# Date:    2025-03-16
# License: MIT
# =============================================================================
# Description:
# This script verifies compliance with CIS Ubuntu 24.04 L2 authentication &
# authorization controls, covering:
# - Password policies and restrictions
# - PAM configuration
# - Account restrictions
# - SSH configuration
# - User and group settings
#
# Usage:
#   ./05-CISv81-L2-ubuntu2404-verify-auth.sh
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
    print_section_header "CIS Ubuntu 24.04 LTS - Section 5: Authentication & Authorization"
    echo "Running checks for authentication and authorization configuration..."
    echo ""

    # Section 5.1 Configure cron
    print_section_header "5.1 Configure cron"
    check_5_1_1 # Ensure cron daemon is enabled and running
    check_5_1_2 # Ensure permissions on /etc/crontab are configured
    check_5_1_3 # Ensure permissions on /etc/cron.hourly are configured
    check_5_1_4 # Ensure permissions on /etc/cron.daily are configured
    check_5_1_5 # Ensure permissions on /etc/cron.weekly are configured
    check_5_1_6 # Ensure permissions on /etc/cron.monthly are configured
    check_5_1_7 # Ensure permissions on /etc/cron.d are configured
    check_5_1_8 # Ensure cron is restricted to authorized users
    check_5_1_9 # Ensure at is restricted to authorized users

    # Section 5.2 SSH Server Configuration
    print_section_header "5.2 SSH Server Configuration"
    check_5_2_1 # Ensure permissions on /etc/ssh/sshd_config are configured
    check_5_2_2 # Ensure permissions on SSH private host key files are configured
    check_5_2_3 # Ensure permissions on SSH public host key files are configured
    check_5_2_4 # Ensure SSH access is limited
    check_5_2_5 # Ensure SSH LogLevel is appropriate
    check_5_2_6 # Ensure SSH X11 forwarding is disabled
    check_5_2_7 # Ensure SSH MaxAuthTries is set to 4 or less
    check_5_2_8 # Ensure SSH IgnoreRhosts is enabled
    check_5_2_9 # Ensure SSH HostbasedAuthentication is disabled
    check_5_2_10 # Ensure SSH root login is disabled
    check_5_2_11 # Ensure SSH PermitEmptyPasswords is disabled
    check_5_2_12 # Ensure SSH PermitUserEnvironment is disabled
    check_5_2_13 # Ensure only strong Ciphers are used
    check_5_2_14 # Ensure only strong MAC algorithms are used
    check_5_2_15 # Ensure only strong Key Exchange algorithms are used
    check_5_2_16 # Ensure SSH Idle Timeout Interval is configured
    check_5_2_17 # Ensure SSH LoginGraceTime is set to one minute or less
    check_5_2_18 # Ensure SSH warning banner is configured
    check_5_2_19 # Ensure SSH PAM is enabled
    check_5_2_20 # Ensure SSH AllowTcpForwarding is disabled
    check_5_2_21 # Ensure SSH MaxStartups is configured
    check_5_2_22 # Ensure SSH MaxSessions is set to 10 or less

    # Section 5.3 Configure PAM
    print_section_header "5.3 Configure PAM"
    check_5_3_1 # Ensure password creation requirements are configured
    check_5_3_2 # Ensure lockout for failed password attempts is configured
    check_5_3_3 # Ensure password reuse is limited
    check_5_3_4 # Ensure password hashing algorithm is up to date
    check_5_3_5 # Ensure all users last password change date is in the past
    check_5_3_6 # Ensure password expiration is 365 days or less
    check_5_3_7 # Ensure password minimum days between changes is 7 or more
    check_5_3_8 # Ensure password expiration warning days is 7 or more
    check_5_3_9 # Ensure inactive password lock is 30 days or less
    check_5_3_10 # Ensure all users have a password set

    # Section 5.4 User Accounts and Environment
    print_section_header "5.4 User Accounts and Environment"
    check_5_4_1_1 # Ensure password expiration is 365 days or less
    check_5_4_1_2 # Ensure minimum days between password changes is 7 or more
    check_5_4_1_3 # Ensure password expiration warning days is 7 or more
    check_5_4_1_4 # Ensure inactive password lock is 30 days or less
    check_5_4_1_5 # Ensure all users last password change date is in the past
    check_5_4_2 # Ensure system accounts are secured
    check_5_4_3 # Ensure default group for the root account is GID 0
    check_5_4_4 # Ensure default user umask is 027 or more restrictive
    check_5_4_5 # Ensure default user shell timeout is 900 seconds or less

    # Section 5.5 Root account restrictions
    print_section_header "5.5 Root Account Restrictions"
    check_5_5_1_1 # Ensure password expiration is 365 days or less for root
    check_5_5_1_2 # Ensure minimum days between password changes is 7 or more for root
    check_5_5_1_3 # Ensure password expiration warning days is 7 or more for root
    check_5_5_1_4 # Ensure inactive password lock is 30 days or less for root
    check_5_5_1_5 # Ensure root account is locked
    check_5_5_2 # Ensure root login is restricted to system console
    check_5_5_3 # Ensure access to the su command is restricted

    echo ""
    echo -e "${BOLD}Check complete.${NC} Review the results above for any needed remediation."
}

# 5.1.1 Ensure cron daemon is enabled and running
check_5_1_1() {
    echo -e "\n${BOLD}5.1.1 Ensure cron daemon is enabled and running${NC}"
    
    CRON_ENABLED=$(systemctl is-enabled cron 2>/dev/null || echo "disabled")
    CRON_ACTIVE=$(systemctl is-active cron 2>/dev/null || echo "inactive")
    
    if [ "$CRON_ENABLED" = "enabled" ] && [ "$CRON_ACTIVE" = "active" ]; then
        print_status "cron daemon is enabled and running" 0
    else
        print_status "cron daemon is not enabled and/or running" 1
        echo "Current status: enabled=$CRON_ENABLED, active=$CRON_ACTIVE"
        echo "Use: sudo systemctl enable cron && sudo systemctl start cron"
    fi
}

# 5.1.2 Ensure permissions on /etc/crontab are configured
check_5_1_2() {
    echo -e "\n${BOLD}5.1.2 Ensure permissions on /etc/crontab are configured${NC}"
    
    CRONTAB_PERMS=$(stat -c "%a" /etc/crontab 2>/dev/null)
    CRONTAB_OWNER=$(stat -c "%U:%G" /etc/crontab 2>/dev/null)
    
    if [ "$CRONTAB_PERMS" = "600" ] || [ "$CRONTAB_PERMS" = "400" ] && [ "$CRONTAB_OWNER" = "root:root" ]; then
        print_status "Permissions on /etc/crontab are configured correctly" 0
    else
        print_status "Permissions on /etc/crontab are not configured correctly" 1
        echo "Current permissions: $CRONTAB_PERMS, owner:group=$CRONTAB_OWNER"
        echo "Expected: 600, owner:group=root:root"
        echo "Use: sudo chmod 600 /etc/crontab && sudo chown root:root /etc/crontab"
    fi
}

# 5.1.3 Ensure permissions on /etc/cron.hourly are configured
check_5_1_3() {
    echo -e "\n${BOLD}5.1.3 Ensure permissions on /etc/cron.hourly are configured${NC}"
    
    CRON_HOURLY_PERMS=$(stat -c "%a" /etc/cron.hourly 2>/dev/null)
    CRON_HOURLY_OWNER=$(stat -c "%U:%G" /etc/cron.hourly 2>/dev/null)
    
    if [ "$CRON_HOURLY_PERMS" = "700" ] && [ "$CRON_HOURLY_OWNER" = "root:root" ]; then
        print_status "Permissions on /etc/cron.hourly are configured correctly" 0
    else
        print_status "Permissions on /etc/cron.hourly are not configured correctly" 1
        echo "Current permissions: $CRON_HOURLY_PERMS, owner:group=$CRON_HOURLY_OWNER"
        echo "Expected: 700, owner:group=root:root"
        echo "Use: sudo chmod 700 /etc/cron.hourly && sudo chown root:root /etc/cron.hourly"
    fi
}

# 5.1.4 Ensure permissions on /etc/cron.daily are configured
check_5_1_4() {
    echo -e "\n${BOLD}5.1.4 Ensure permissions on /etc/cron.daily are configured${NC}"
    
    CRON_DAILY_PERMS=$(stat -c "%a" /etc/cron.daily 2>/dev/null)
    CRON_DAILY_OWNER=$(stat -c "%U:%G" /etc/cron.daily 2>/dev/null)
    
    if [ "$CRON_DAILY_PERMS" = "700" ] && [ "$CRON_DAILY_OWNER" = "root:root" ]; then
        print_status "Permissions on /etc/cron.daily are configured correctly" 0
    else
        print_status "Permissions on /etc/cron.daily are not configured correctly" 1
        echo "Current permissions: $CRON_DAILY_PERMS, owner:group=$CRON_DAILY_OWNER"
        echo "Expected: 700, owner:group=root:root"
        echo "Use: sudo chmod 700 /etc/cron.daily && sudo chown root:root /etc/cron.daily"
    fi
}

# 5.1.5 Ensure permissions on /etc/cron.weekly are configured
check_5_1_5() {
    echo -e "\n${BOLD}5.1.5 Ensure permissions on /etc/cron.weekly are configured${NC}"
    
    CRON_WEEKLY_PERMS=$(stat -c "%a" /etc/cron.weekly 2>/dev/null)
    CRON_WEEKLY_OWNER=$(stat -c "%U:%G" /etc/cron.weekly 2>/dev/null)
    
    if [ "$CRON_WEEKLY_PERMS" = "700" ] && [ "$CRON_WEEKLY_OWNER" = "root:root" ]; then
        print_status "Permissions on /etc/cron.weekly are configured correctly" 0
    else
        print_status "Permissions on /etc/cron.weekly are not configured correctly" 1
        echo "Current permissions: $CRON_WEEKLY_PERMS, owner:group=$CRON_WEEKLY_OWNER"
        echo "Expected: 700, owner:group=root:root"
        echo "Use: sudo chmod 700 /etc/cron.weekly && sudo chown root:root /etc/cron.weekly"
    fi
}

# 5.1.6 Ensure permissions on /etc/cron.monthly are configured
check_5_1_6() {
    echo -e "\n${BOLD}5.1.6 Ensure permissions on /etc/cron.monthly are configured${NC}"
    
    CRON_MONTHLY_PERMS=$(stat -c "%a" /etc/cron.monthly 2>/dev/null)
    CRON_MONTHLY_OWNER=$(stat -c "%U:%G" /etc/cron.monthly 2>/dev/null)
    
    if [ "$CRON_MONTHLY_PERMS" = "700" ] && [ "$CRON_MONTHLY_OWNER" = "root:root" ]; then
        print_status "Permissions on /etc/cron.monthly are configured correctly" 0
    else
        print_status "Permissions on /etc/cron.monthly are not configured correctly" 1
        echo "Current permissions: $CRON_MONTHLY_PERMS, owner:group=$CRON_MONTHLY_OWNER"
        echo "Expected: 700, owner:group=root:root"
        echo "Use: sudo chmod 700 /etc/cron.monthly && sudo chown root:root /etc/cron.monthly"
    fi
}

# 5.1.7 Ensure permissions on /etc/cron.d are configured
check_5_1_7() {
    echo -e "\n${BOLD}5.1.7 Ensure permissions on /etc/cron.d are configured${NC}"
    
    CRON_D_PERMS=$(stat -c "%a" /etc/cron.d 2>/dev/null)
    CRON_D_OWNER=$(stat -c "%U:%G" /etc/cron.d 2>/dev/null)
    
    if [ "$CRON_D_PERMS" = "700" ] && [ "$CRON_D_OWNER" = "root:root" ]; then
        print_status "Permissions on /etc/cron.d are configured correctly" 0
    else
        print_status "Permissions on /etc/cron.d are not configured correctly" 1
        echo "Current permissions: $CRON_D_PERMS, owner:group=$CRON_D_OWNER"
        echo "Expected: 700, owner:group=root:root"
        echo "Use: sudo chmod 700 /etc/cron.d && sudo chown root:root /etc/cron.d"
    fi
}

# 5.1.8 Ensure cron is restricted to authorized users
check_5_1_8() {
    echo -e "\n${BOLD}5.1.8 Ensure cron is restricted to authorized users${NC}"
    
    if [ -f /etc/cron.deny ]; then
        print_status "/etc/cron.deny exists - fails CIS requirements" 1
        echo "Remove /etc/cron.deny: sudo rm /etc/cron.deny"
    else
        print_status "/etc/cron.deny does not exist" 0
    fi
    
    if [ -f /etc/cron.allow ]; then
        CRON_ALLOW_PERMS=$(stat -c "%a" /etc/cron.allow 2>/dev/null)
        CRON_ALLOW_OWNER=$(stat -c "%U:%G" /etc/cron.allow 2>/dev/null)
        
        if [ "$CRON_ALLOW_PERMS" = "640" ] || [ "$CRON_ALLOW_PERMS" = "600" ] && [ "$CRON_ALLOW_OWNER" = "root:root" ]; then
            print_status "/etc/cron.allow exists with correct permissions" 0
        else
            print_status "/etc/cron.allow exists but has incorrect permissions" 1
            echo "Current permissions: $CRON_ALLOW_PERMS, owner:group=$CRON_ALLOW_OWNER"
            echo "Expected: 640 or 600, owner:group=root:root"
            echo "Use: sudo chmod 640 /etc/cron.allow && sudo chown root:root /etc/cron.allow"
        fi
    else
        print_status "/etc/cron.allow does not exist" 1
        echo "Create /etc/cron.allow with proper permissions:"
        echo "sudo touch /etc/cron.allow"
        echo "sudo chmod 640 /etc/cron.allow"
        echo "sudo chown root:root /etc/cron.allow"
    fi
}

# 5.1.9 Ensure at is restricted to authorized users
check_5_1_9() {
    echo -e "\n${BOLD}5.1.9 Ensure at is restricted to authorized users${NC}"
    
    if [ -f /etc/at.deny ]; then
        print_status "/etc/at.deny exists - fails CIS requirements" 1
        echo "Remove /etc/at.deny: sudo rm /etc/at.deny"
    else
        print_status "/etc/at.deny does not exist" 0
    fi
    
    if [ -f /etc/at.allow ]; then
        AT_ALLOW_PERMS=$(stat -c "%a" /etc/at.allow 2>/dev/null)
        AT_ALLOW_OWNER=$(stat -c "%U:%G" /etc/at.allow 2>/dev/null)
        
        if [ "$AT_ALLOW_PERMS" = "640" ] || [ "$AT_ALLOW_PERMS" = "600" ] && [ "$AT_ALLOW_OWNER" = "root:root" ]; then
            print_status "/etc/at.allow exists with correct permissions" 0
        else
            print_status "/etc/at.allow exists but has incorrect permissions" 1
            echo "Current permissions: $AT_ALLOW_PERMS, owner:group=$AT_ALLOW_OWNER"
            echo "Expected: 640 or 600, owner:group=root:root"
            echo "Use: sudo chmod 640 /etc/at.allow && sudo chown root:root /etc/at.allow"
        fi
    else
        print_status "/etc/at.allow does not exist" 1
        echo "Create /etc/at.allow with proper permissions:"
        echo "sudo touch /etc/at.allow"
        echo "sudo chmod 640 /etc/at.allow"
        echo "sudo chown root:root /etc/at.allow"
    fi
}

# 5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured
check_5_2_1() {
    echo -e "\n${BOLD}5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured${NC}"
    
    SSHD_CONFIG_PERMS=$(stat -c "%a" /etc/ssh/sshd_config 2>/dev/null)
    SSHD_CONFIG_OWNER=$(stat -c "%U:%G" /etc/ssh/sshd_config 2>/dev/null)
    
    if [ "$SSHD_CONFIG_PERMS" = "600" ] && [ "$SSHD_CONFIG_OWNER" = "root:root" ]; then
        print_status "Permissions on /etc/ssh/sshd_config are configured correctly" 0
    else
        print_status "Permissions on /etc/ssh/sshd_config are not configured correctly" 1
        echo "Current permissions: $SSHD_CONFIG_PERMS, owner:group=$SSHD_CONFIG_OWNER"
        echo "Expected: 600, owner:group=root:root"
        echo "Use: sudo chmod 600 /etc/ssh/sshd_config && sudo chown root:root /etc/ssh/sshd_config"
    fi
}

# 5.2.2 Ensure permissions on SSH private host key files are configured
check_5_2_2() {
    echo -e "\n${BOLD}5.2.2 Ensure permissions on SSH private host key files are configured${NC}"
    
    SSH_PRIVATE_KEYS=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key')
    INCORRECT_PERMS=0
    
    if [ -z "$SSH_PRIVATE_KEYS" ]; then
        print_status "No SSH private host key files found" 1
        echo "SSH server might not be properly configured"
    else
        for KEY_FILE in $SSH_PRIVATE_KEYS; do
            PERMS=$(stat -c "%a" "$KEY_FILE")
            OWNER=$(stat -c "%U" "$KEY_FILE")
            GROUP=$(stat -c "%G" "$KEY_FILE")
            
            if [ "$PERMS" != "600" ] || [ "$OWNER" != "root" ] || [ "$GROUP" != "root" ]; then
                echo "Incorrect permissions on $KEY_FILE: $PERMS, owner:$OWNER, group:$GROUP"
                INCORRECT_PERMS=1
            fi
        done
        
        if [ $INCORRECT_PERMS -eq 0 ]; then
            print_status "All SSH private host key files have correct permissions" 0
        else
            print_status "Some SSH private host key files have incorrect permissions" 1
            echo "Expected: 0600, owner:root, group:root"
            echo "Use: sudo chmod 600 /etc/ssh/ssh_host_*_key && sudo chown root:root /etc/ssh/ssh_host_*_key"
        fi
    fi
}

# 5.2.3 Ensure permissions on SSH public host key files are configured
check_5_2_3() {
    echo -e "\n${BOLD}5.2.3 Ensure permissions on SSH public host key files are configured${NC}"
    
    SSH_PUBLIC_KEYS=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub')
    INCORRECT_PERMS=0
    
    if [ -z "$SSH_PUBLIC_KEYS" ]; then
        print_status "No SSH public host key files found" 1
        echo "SSH server might not be properly configured"
    else
        for KEY_FILE in $SSH_PUBLIC_KEYS; do
            PERMS=$(stat -c "%a" "$KEY_FILE")
            OWNER=$(stat -c "%U" "$KEY_FILE")
            GROUP=$(stat -c "%G" "$KEY_FILE")
            
            if [ "$PERMS" != "644" ] || [ "$OWNER" != "root" ] || [ "$GROUP" != "root" ]; then
                echo "Incorrect permissions on $KEY_FILE: $PERMS, owner:$OWNER, group:$GROUP"
                INCORRECT_PERMS=1
            fi
        done
        
        if [ $INCORRECT_PERMS -eq 0 ]; then
            print_status "All SSH public host key files have correct permissions" 0
        else
            print_status "Some SSH public host key files have incorrect permissions" 1
            echo "Expected: 0644, owner:root, group:root"
            echo "Use: sudo chmod 644 /etc/ssh/ssh_host_*_key.pub && sudo chown root:root /etc/ssh/ssh_host_*_key.pub"
        fi
    fi
}

# 5.2.4 Ensure SSH access is limited
check_5_2_4() {
    echo -e "\n${BOLD}5.2.4 Ensure SSH access is limited${NC}"
    
    ALLOWUSERS=$(grep -i "^AllowUsers" /etc/ssh/sshd_config 2>/dev/null)
    ALLOWGROUPS=$(grep -i "^AllowGroups" /etc/ssh/sshd_config 2>/dev/null)
    DENYUSERS=$(grep -i "^DenyUsers" /etc/ssh/sshd_config 2>/dev/null)
    DENYGROUPS=$(grep -i "^DenyGroups" /etc/ssh/sshd_config 2>/dev/null)
    
    if [ -n "$ALLOWUSERS" ] || [ -n "$ALLOWGROUPS" ] || [ -n "$DENYUSERS" ] || [ -n "$DENYGROUPS" ]; then
        print_status "SSH access is limited" 0
        [ -n "$ALLOWUSERS" ] && echo "AllowUsers: $ALLOWUSERS"
        [ -n "$ALLOWGROUPS" ] && echo "AllowGroups: $ALLOWGROUPS"
        [ -n "$DENYUSERS" ] && echo "DenyUsers: $DENYUSERS"
        [ -n "$DENYGROUPS" ] && echo "DenyGroups: $DENYGROUPS"
    else
        print_status "SSH access is not limited" 1
        echo "No user/group access controls found in /etc/ssh/sshd_config"
        echo "Edit /etc/ssh/sshd_config and add appropriate allow/deny directives"
    fi
}

# 5.2.5 Ensure SSH LogLevel is appropriate
check_5_2_5() {
    echo -e "\n${BOLD}5.2.5 Ensure SSH LogLevel is appropriate${NC}"
    
    SSH_LOGLEVEL=$(grep -i "^LogLevel" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$SSH_LOGLEVEL" = "VERBOSE" ] || [ "$SSH_LOGLEVEL" = "INFO" ]; then
        print_status "SSH LogLevel is set appropriately to $SSH_LOGLEVEL" 0
    else
        print_status "SSH LogLevel is not set appropriately" 1
        echo "Current LogLevel: $SSH_LOGLEVEL"
        echo "Expected: VERBOSE or INFO"
        echo "Edit /etc/ssh/sshd_config and set 'LogLevel VERBOSE' or 'LogLevel INFO'"
    fi
}

# 5.2.6 Ensure SSH X11 forwarding is disabled
check_5_2_6() {
    echo -e "\n${BOLD}5.2.6 Ensure SSH X11 forwarding is disabled${NC}"
    
    SSH_X11_FORWARDING=$(grep -i "^X11Forwarding" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$SSH_X11_FORWARDING" = "no" ]; then
        print_status "SSH X11 forwarding is disabled" 0
    else
        print_status "SSH X11 forwarding is not disabled" 1
        echo "Current X11Forwarding: $SSH_X11_FORWARDING"
        echo "Edit /etc/ssh/sshd_config and set 'X11Forwarding no'"
    fi
}

# 5.2.7 Ensure SSH MaxAuthTries is set to 4 or less
check_5_2_7() {
    echo -e "\n${BOLD}5.2.7 Ensure SSH MaxAuthTries is set to 4 or less${NC}"
    
    SSH_MAX_AUTH_TRIES=$(grep -i "^MaxAuthTries" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ -n "$SSH_MAX_AUTH_TRIES" ] && [ "$SSH_MAX_AUTH_TRIES" -le 4 ]; then
        print_status "SSH MaxAuthTries is set to $SSH_MAX_AUTH_TRIES" 0
    else
        print_status "SSH MaxAuthTries is not set appropriately" 1
        echo "Current MaxAuthTries: $SSH_MAX_AUTH_TRIES"
        echo "Edit /etc/ssh/sshd_config and set 'MaxAuthTries 4' or less"
    fi
}

# 5.2.8 Ensure SSH IgnoreRhosts is enabled
check_5_2_8() {
    echo -e "\n${BOLD}5.2.8 Ensure SSH IgnoreRhosts is enabled${NC}"
    
    SSH_IGNORE_RHOSTS=$(grep -i "^IgnoreRhosts" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$SSH_IGNORE_RHOSTS" = "yes" ]; then
        print_status "SSH IgnoreRhosts is enabled" 0
    else
        print_status "SSH IgnoreRhosts is not enabled" 1
        echo "Current IgnoreRhosts: $SSH_IGNORE_RHOSTS"
        echo "Edit /etc/ssh/sshd_config and set 'IgnoreRhosts yes'"
    fi
}

# 5.2.9 Ensure SSH HostbasedAuthentication is disabled (continued)
check_5_2_9() {
    echo -e "\n${BOLD}5.2.9 Ensure SSH HostbasedAuthentication is disabled${NC}"
    
    SSH_HOSTBASED_AUTH=$(grep -i "^HostbasedAuthentication" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$SSH_HOSTBASED_AUTH" = "no" ]; then
        print_status "SSH HostbasedAuthentication is disabled" 0
    else
        print_status "SSH HostbasedAuthentication is not disabled" 1
        echo "Current HostbasedAuthentication: $SSH_HOSTBASED_AUTH"
        echo "Edit /etc/ssh/sshd_config and set 'HostbasedAuthentication no'"
    fi
}

# 5.2.10 Ensure SSH root login is disabled
check_5_2_10() {
    echo -e "\n${BOLD}5.2.10 Ensure SSH root login is disabled${NC}"
    
    SSH_ROOT_LOGIN=$(grep -i "^PermitRootLogin" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$SSH_ROOT_LOGIN" = "no" ]; then
        print_status "SSH root login is disabled" 0
    else
        print_status "SSH root login is not disabled" 1
        echo "Current PermitRootLogin: $SSH_ROOT_LOGIN"
        echo "Edit /etc/ssh/sshd_config and set 'PermitRootLogin no'"
    fi
}

# 5.2.11 Ensure SSH PermitEmptyPasswords is disabled
check_5_2_11() {
    echo -e "\n${BOLD}5.2.11 Ensure SSH PermitEmptyPasswords is disabled${NC}"
    
    SSH_EMPTY_PASSWORDS=$(grep -i "^PermitEmptyPasswords" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$SSH_EMPTY_PASSWORDS" = "no" ]; then
        print_status "SSH PermitEmptyPasswords is disabled" 0
    else
        print_status "SSH PermitEmptyPasswords is not disabled" 1
        echo "Current PermitEmptyPasswords: $SSH_EMPTY_PASSWORDS"
        echo "Edit /etc/ssh/sshd_config and set 'PermitEmptyPasswords no'"
    fi
}

# 5.2.12 Ensure SSH PermitUserEnvironment is disabled
check_5_2_12() {
    echo -e "\n${BOLD}5.2.12 Ensure SSH PermitUserEnvironment is disabled${NC}"
    
    SSH_USER_ENV=$(grep -i "^PermitUserEnvironment" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$SSH_USER_ENV" = "no" ]; then
        print_status "SSH PermitUserEnvironment is disabled" 0
    else
        print_status "SSH PermitUserEnvironment is not disabled" 1
        echo "Current PermitUserEnvironment: $SSH_USER_ENV"
        echo "Edit /etc/ssh/sshd_config and set 'PermitUserEnvironment no'"
    fi
}

# 5.2.13 Ensure only strong Ciphers are used
check_5_2_13() {
    echo -e "\n${BOLD}5.2.13 Ensure only strong Ciphers are used${NC}"
    
    WEAK_CIPHERS="3des-cbc|aes128-cbc|aes192-cbc|aes256-cbc|arcfour|arcfour128|arcfour256|blowfish-cbc|cast128-cbc|rijndael-cbc@lysator.liu.se"
    SSH_CIPHERS=$(grep -i "^Ciphers" /etc/ssh/sshd_config 2>/dev/null)
    
    if [ -z "$SSH_CIPHERS" ]; then
        print_status "SSH Ciphers not explicitly configured" 1
        echo "Edit /etc/ssh/sshd_config and set 'Ciphers' with approved strong ciphers"
    else
        if echo "$SSH_CIPHERS" | grep -E "$WEAK_CIPHERS" > /dev/null; then
            print_status "SSH has weak ciphers enabled" 1
            echo "Current setting: $SSH_CIPHERS"
            echo "Remove any weak ciphers from the 'Ciphers' line in /etc/ssh/sshd_config"
        else
            print_status "SSH has only strong ciphers enabled" 0
            echo "Current setting: $SSH_CIPHERS"
        fi
    fi
}

# 5.2.14 Ensure only strong MAC algorithms are used
check_5_2_14() {
    echo -e "\n${BOLD}5.2.14 Ensure only strong MAC algorithms are used${NC}"
    
    WEAK_MACS="hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1|hmac-sha1-96|umac-64@openssh.com|umac-128@openssh.com|hmac-md5-etm@openssh.com|hmac-md5-96-etm@openssh.com|hmac-ripemd160-etm@openssh.com|hmac-sha1-etm@openssh.com|hmac-sha1-96-etm@openssh.com|umac-64-etm@openssh.com|umac-128-etm@openssh.com"
    SSH_MACS=$(grep -i "^MACs" /etc/ssh/sshd_config 2>/dev/null)
    
    if [ -z "$SSH_MACS" ]; then
        print_status "SSH MACs not explicitly configured" 1
        echo "Edit /etc/ssh/sshd_config and set 'MACs' with approved strong algorithms"
    else
        if echo "$SSH_MACS" | grep -E "$WEAK_MACS" > /dev/null; then
            print_status "SSH has weak MAC algorithms enabled" 1
            echo "Current setting: $SSH_MACS"
            echo "Remove any weak algorithms from the 'MACs' line in /etc/ssh/sshd_config"
        else
            print_status "SSH has only strong MAC algorithms enabled" 0
            echo "Current setting: $SSH_MACS"
        fi
    fi
}

# 5.2.15 Ensure only strong Key Exchange algorithms are used
check_5_2_15() {
    echo -e "\n${BOLD}5.2.15 Ensure only strong Key Exchange algorithms are used${NC}"
    
    WEAK_KEX="diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1"
    SSH_KEX=$(grep -i "^KexAlgorithms" /etc/ssh/sshd_config 2>/dev/null)
    
    if [ -z "$SSH_KEX" ]; then
        print_status "SSH KexAlgorithms not explicitly configured" 1
        echo "Edit /etc/ssh/sshd_config and set 'KexAlgorithms' with approved strong algorithms"
    else
        if echo "$SSH_KEX" | grep -E "$WEAK_KEX" > /dev/null; then
            print_status "SSH has weak Key Exchange algorithms enabled" 1
            echo "Current setting: $SSH_KEX"
            echo "Remove any weak algorithms from the 'KexAlgorithms' line in /etc/ssh/sshd_config"
        else
            print_status "SSH has only strong Key Exchange algorithms enabled" 0
            echo "Current setting: $SSH_KEX"
        fi
    fi
}

# 5.2.16 Ensure SSH Idle Timeout Interval is configured
check_5_2_16() {
    echo -e "\n${BOLD}5.2.16 Ensure SSH Idle Timeout Interval is configured${NC}"
    
    CLIENT_ALIVE_INTERVAL=$(grep -i "^ClientAliveInterval" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    CLIENT_ALIVE_COUNT_MAX=$(grep -i "^ClientAliveCountMax" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ -n "$CLIENT_ALIVE_INTERVAL" ] && [ "$CLIENT_ALIVE_INTERVAL" -gt 0 ] && [ "$CLIENT_ALIVE_INTERVAL" -le 300 ] && [ -n "$CLIENT_ALIVE_COUNT_MAX" ] && [ "$CLIENT_ALIVE_COUNT_MAX" -le 3 ]; then
        print_status "SSH Idle Timeout Interval is configured properly" 0
        echo "ClientAliveInterval: $CLIENT_ALIVE_INTERVAL"
        echo "ClientAliveCountMax: $CLIENT_ALIVE_COUNT_MAX"
    else
        print_status "SSH Idle Timeout Interval is not configured properly" 1
        echo "Current ClientAliveInterval: $CLIENT_ALIVE_INTERVAL (should be between 1 and 300)"
        echo "Current ClientAliveCountMax: $CLIENT_ALIVE_COUNT_MAX (should be 0-3)"
        echo "Edit /etc/ssh/sshd_config and set appropriate values"
    fi
}

# 5.2.17 Ensure SSH LoginGraceTime is set to one minute or less
check_5_2_17() {
    echo -e "\n${BOLD}5.2.17 Ensure SSH LoginGraceTime is set to one minute or less${NC}"
    
    LOGIN_GRACE_TIME=$(grep -i "^LoginGraceTime" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ -n "$LOGIN_GRACE_TIME" ]; then
        # Handle time units (s for seconds, m for minutes)
        if [[ "$LOGIN_GRACE_TIME" == *s ]]; then
            # Convert seconds to numeric value
            SECONDS_VALUE=${LOGIN_GRACE_TIME%s}
            if [ "$SECONDS_VALUE" -le 60 ] && [ "$SECONDS_VALUE" -gt 0 ]; then
                print_status "SSH LoginGraceTime is set to $LOGIN_GRACE_TIME" 0
            else
                print_status "SSH LoginGraceTime is not set to one minute or less" 1
                echo "Current LoginGraceTime: $LOGIN_GRACE_TIME"
                echo "Edit /etc/ssh/sshd_config and set 'LoginGraceTime 60' or less"
            fi
        elif [[ "$LOGIN_GRACE_TIME" == *m ]]; then
            # Convert minutes to numeric value
            MINUTES_VALUE=${LOGIN_GRACE_TIME%m}
            if [ "$MINUTES_VALUE" -le 1 ] && [ "$MINUTES_VALUE" -gt 0 ]; then
                print_status "SSH LoginGraceTime is set to $LOGIN_GRACE_TIME" 0
            else
                print_status "SSH LoginGraceTime is not set to one minute or less" 1
                echo "Current LoginGraceTime: $LOGIN_GRACE_TIME"
                echo "Edit /etc/ssh/sshd_config and set 'LoginGraceTime 1m' or less"
            fi
        else
            # Assume seconds if no unit is specified
            if [ "$LOGIN_GRACE_TIME" -le 60 ] && [ "$LOGIN_GRACE_TIME" -gt 0 ]; then
                print_status "SSH LoginGraceTime is set to $LOGIN_GRACE_TIME seconds" 0
            else
                print_status "SSH LoginGraceTime is not set to one minute or less" 1
                echo "Current LoginGraceTime: $LOGIN_GRACE_TIME"
                echo "Edit /etc/ssh/sshd_config and set 'LoginGraceTime 60' or less"
            fi
        fi
    else
        print_status "SSH LoginGraceTime is not set" 1
        echo "Edit /etc/ssh/sshd_config and set 'LoginGraceTime 60' or less"
    fi
}

# 5.2.18 Ensure SSH warning banner is configured
check_5_2_18() {
    echo -e "\n${BOLD}5.2.18 Ensure SSH warning banner is configured${NC}"
    
    BANNER=$(grep -i "^Banner" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ -n "$BANNER" ]; then
        print_status "SSH Banner is configured: $BANNER" 0
        if [ -f "$BANNER" ]; then
            echo "Banner file exists"
        else
            echo "Banner file does not exist: $BANNER"
            echo "Create the banner file with appropriate warning text"
        fi
    else
        print_status "SSH Banner is not configured" 1
        echo "Edit /etc/ssh/sshd_config and set 'Banner /etc/issue.net' or similar"
    fi
}

# 5.2.19 Ensure SSH PAM is enabled
check_5_2_19() {
    echo -e "\n${BOLD}5.2.19 Ensure SSH PAM is enabled${NC}"
    
    USE_PAM=$(grep -i "^UsePAM" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$USE_PAM" = "yes" ]; then
        print_status "SSH PAM is enabled" 0
    else
        print_status "SSH PAM is not enabled" 1
        echo "Current UsePAM: $USE_PAM"
        echo "Edit /etc/ssh/sshd_config and set 'UsePAM yes'"
    fi
}

# 5.2.20 Ensure SSH AllowTcpForwarding is disabled
check_5_2_20() {
    echo -e "\n${BOLD}5.2.20 Ensure SSH AllowTcpForwarding is disabled${NC}"
    
    TCP_FORWARDING=$(grep -i "^AllowTcpForwarding" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ "$TCP_FORWARDING" = "no" ]; then
        print_status "SSH AllowTcpForwarding is disabled" 0
    else
        print_status "SSH AllowTcpForwarding is not disabled" 1
        echo "Current AllowTcpForwarding: $TCP_FORWARDING"
        echo "Edit /etc/ssh/sshd_config and set 'AllowTcpForwarding no'"
    fi
}

# 5.2.21 Ensure SSH MaxStartups is configured
check_5_2_21() {
    echo -e "\n${BOLD}5.2.21 Ensure SSH MaxStartups is configured${NC}"
    
    MAX_STARTUPS=$(grep -i "^MaxStartups" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ -n "$MAX_STARTUPS" ]; then
        # Check for format like "10:30:100"
        if [[ "$MAX_STARTUPS" =~ ^[0-9]+:[0-9]+:[0-9]+$ ]]; then
            START=$(echo $MAX_STARTUPS | cut -d: -f1)
            RATE=$(echo $MAX_STARTUPS | cut -d: -f2)
            FULL=$(echo $MAX_STARTUPS | cut -d: -f3)
            
            if [ "$START" -le 10 ] && [ "$FULL" -le 100 ]; then
                print_status "SSH MaxStartups is configured appropriately" 0
                echo "Current MaxStartups: $MAX_STARTUPS"
            else
                print_status "SSH MaxStartups values are too high" 1
                echo "Current MaxStartups: $MAX_STARTUPS"
                echo "Edit /etc/ssh/sshd_config and set 'MaxStartups 10:30:60' or similar"
            fi
        else
            # Simple numeric value
            if [ "$MAX_STARTUPS" -le 10 ]; then
                print_status "SSH MaxStartups is configured appropriately" 0
                echo "Current MaxStartups: $MAX_STARTUPS"
            else
                print_status "SSH MaxStartups value is too high" 1
                echo "Current MaxStartups: $MAX_STARTUPS"
                echo "Edit /etc/ssh/sshd_config and set 'MaxStartups 10' or less"
            fi
        fi
    else
        print_status "SSH MaxStartups is not configured" 1
        echo "Edit /etc/ssh/sshd_config and set 'MaxStartups 10:30:60' or similar"
    fi
}

# 5.2.22 Ensure SSH MaxSessions is set to 10 or less
check_5_2_22() {
    echo -e "\n${BOLD}5.2.22 Ensure SSH MaxSessions is set to 10 or less${NC}"
    
    MAX_SESSIONS=$(grep -i "^MaxSessions" /etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')
    
    if [ -n "$MAX_SESSIONS" ] && [ "$MAX_SESSIONS" -le 10 ]; then
        print_status "SSH MaxSessions is set to $MAX_SESSIONS" 0
    else
        print_status "SSH MaxSessions is not set appropriately" 1
        echo "Current MaxSessions: $MAX_SESSIONS"
        echo "Edit /etc/ssh/sshd_config and set 'MaxSessions 10' or less"
    fi
}

# 5.3.1 Ensure password creation requirements are configured
check_5_3_1() {
    echo -e "\n${BOLD}5.3.1 Ensure password creation requirements are configured${NC}"
    
    PWQUALITY_CONF="/etc/security/pwquality.conf"
    if [ -f "$PWQUALITY_CONF" ]; then
        MINLEN=$(grep -i "^minlen" $PWQUALITY_CONF 2>/dev/null | awk -F= '{print $2}' | tr -d ' ')
        MINCLASS=$(grep -i "^minclass" $PWQUALITY_CONF 2>/dev/null | awk -F= '{print $2}' | tr -d ' ')
        
        if [ -n "$MINLEN" ] && [ "$MINLEN" -ge 14 ] && [ -n "$MINCLASS" ] && [ "$MINCLASS" -ge 4 ]; then
            print_status "Password creation requirements are configured correctly" 0
            echo "Current minlen: $MINLEN"
            echo "Current minclass: $MINCLASS"
        else
            print_status "Password creation requirements are not configured correctly" 1
            echo "Current minlen: $MINLEN (should be 14 or more)"
            echo "Current minclass: $MINCLASS (should be 4 or more)"
            echo "Edit $PWQUALITY_CONF and set appropriate values"
        fi
    else
        print_status "Password quality configuration file not found" 1
        echo "Install libpam-pwquality and configure $PWQUALITY_CONF"
    fi
    
    # Check PAM configuration
    PAM_PWQUALITY=$(grep -i "pam_pwquality.so" /etc/pam.d/common-password 2>/dev/null)
    if [ -z "$PAM_PWQUALITY" ]; then
        print_status "PAM is not configured to use pwquality" 1
        echo "Edit /etc/pam.d/common-password and add/configure pam_pwquality.so"
    else
        print_status "PAM is configured to use pwquality" 0
        echo "PAM configuration: $PAM_PWQUALITY"
    fi
}

# 5.3.2 Ensure lockout for failed password attempts is configured
check_5_3_2() {
    echo -e "\n${BOLD}5.3.2 Ensure lockout for failed password attempts is configured${NC}"
    
    PAM_TALLY2=$(grep -i "pam_tally2.so" /etc/pam.d/common-auth 2>/dev/null)
    PAM_FAILLOCK=$(grep -i "pam_faillock.so" /etc/pam.d/common-auth 2>/dev/null)
    
    if [ -n "$PAM_TALLY2" ] || [ -n "$PAM_FAILLOCK" ]; then
        if [ -n "$PAM_TALLY2" ]; then
            print_status "PAM is configured to use pam_tally2.so for lockout" 0
            echo "PAM configuration: $PAM_TALLY2"
            
            # Check unlock_time
            UNLOCK_TIME=$(echo "$PAM_TALLY2" | grep -o "unlock_time=[0-9]*" | head -1 | cut -d= -f2)
            if [ -n "$UNLOCK_TIME" ] && [ "$UNLOCK_TIME" -ge 900 ]; then
                print_status "Unlock time is set to $UNLOCK_TIME seconds" 0
            else
                print_status "Unlock time is less than 900 seconds" 1
                echo "Current unlock_time: $UNLOCK_TIME"
                echo "Edit /etc/pam.d/common-auth and set unlock_time=900 or more"
            fi
        fi
        
        if [ -n "$PAM_FAILLOCK" ]; then
            print_status "PAM is configured to use pam_faillock.so for lockout" 0
            echo "PAM configuration: $PAM_FAILLOCK"
            
            # Check unlock_time - take just the first occurrence
            UNLOCK_TIME=$(echo "$PAM_FAILLOCK" | grep -o "unlock_time=[0-9]*" | head -1 | cut -d= -f2)
            if [ -n "$UNLOCK_TIME" ] && [ "$UNLOCK_TIME" -ge 900 ]; then
                print_status "Unlock time is set to $UNLOCK_TIME seconds" 0
            else
                print_status "Unlock time is less than 900 seconds" 1
                echo "Current unlock_time: $UNLOCK_TIME"
                echo "Edit /etc/pam.d/common-auth and set unlock_time=900 or more"
            fi
        fi
    else
        print_status "PAM is not configured for lockout on failed password attempts" 1
        echo "Edit /etc/pam.d/common-auth and configure pam_tally2.so or pam_faillock.so"
    fi
}

# 5.3.3 Ensure password reuse is limited
check_5_3_3() {
    echo -e "\n${BOLD}5.3.3 Ensure password reuse is limited${NC}"
    
    PAM_UNIX=$(grep -i "password.*pam_unix.so" /etc/pam.d/common-password 2>/dev/null)
    PAM_PWHISTORY=$(grep -i "password.*pam_pwhistory.so" /etc/pam.d/common-password 2>/dev/null)
    
    REMEMBER=""
    if echo "$PAM_UNIX" | grep -q "remember="; then
        REMEMBER=$(echo "$PAM_UNIX" | grep -o "remember=[0-9]*" | cut -d= -f2)
    elif echo "$PAM_PWHISTORY" | grep -q "remember="; then
        REMEMBER=$(echo "$PAM_PWHISTORY" | grep -o "remember=[0-9]*" | cut -d= -f2)
    fi
    
    if [ -n "$REMEMBER" ] && [ "$REMEMBER" -ge 5 ]; then
        print_status "Password reuse is limited to last $REMEMBER passwords" 0
    else
        print_status "Password reuse is not sufficiently limited" 1
        echo "Current remember setting: $REMEMBER (should be 5 or more)"
        echo "Edit /etc/pam.d/common-password and configure 'remember=5' or more"
    fi
}

# 5.3.4 Ensure password hashing algorithm is up to date
check_5_3_4() {
    echo -e "\n${BOLD}5.3.4 Ensure password hashing algorithm is up to date${NC}"
    
    PAM_UNIX=$(grep -i "password.*pam_unix.so" /etc/pam.d/common-password 2>/dev/null)
    
    if echo "$PAM_UNIX" | grep -q "sha512"; then
        print_status "Password hashing algorithm is SHA512" 0
    else
        print_status "Password hashing algorithm is not set to SHA512" 1
        echo "Current PAM configuration: $PAM_UNIX"
        echo "Edit /etc/pam.d/common-password and add 'sha512' to pam_unix.so options"
    fi
}

# 5.3.5 Ensure all users last password change date is in the past
check_5_3_5() {
    echo -e "\n${BOLD}5.3.5 Ensure all users last password change date is in the past${NC}"
    
    # Get current date in days since 1970-01-01
    CURRENT_DATE=$(date +%s)
    CURRENT_DAYS=$((CURRENT_DATE / 86400))
    
    FUTURE_USERS=0
    
    # Check all users with UID >= 1000 and not locked
    for USER in $(awk -F: '($3>=1000 && $3!=65534) {print $1}' /etc/passwd); do
        # Get last password change date in days since 1970-01-01
        PASSWD_CHANGE=$(passwd -S "$USER" 2>/dev/null | awk '{print $3}')
        
        if [ -n "$PASSWD_CHANGE" ] && [ "$PASSWD_CHANGE" -gt "$CURRENT_DAYS" ]; then
            echo "User $USER has password change date in the future: $PASSWD_CHANGE"
            FUTURE_USERS=$((FUTURE_USERS + 1))
        fi
    done
    
    if [ "$FUTURE_USERS" -eq 0 ]; then
        print_status "All users have password change dates in the past" 0
    else
        print_status "$FUTURE_USERS users have password change dates in the future" 1
        echo "Use 'chage -d YYYY-MM-DD username' to set correct password change date"
    fi
}

# Run the main function
main