#!/bin/bash

# validate-auth-controls.sh
# Script to validate CIS Ubuntu 24.04 Level 1 Authentication and Authorization controls
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

echo -e "\n${BLUE}====== CIS Ubuntu 24.04 Authentication & Authorization Controls Validation ======${NC}\n"

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}Warning: This script should be run with sudo for complete results${NC}\n"
fi

echo -e "${BLUE}=== Password Quality Requirements (CIS 5.4.1) ===${NC}"

# Check if libpam-pwquality is installed
if dpkg -s libpam-pwquality &> /dev/null; then
    check_result 0 "libpam-pwquality package is installed"
else
    check_result 1 "libpam-pwquality package is not installed"
fi

# Check pwquality.conf settings
PWQUALITY_CHECKS=(
    "minlen = 14"
    "minclass = 4"
    "dcredit = -1"
    "ucredit = -1"
    "lcredit = -1"
    "ocredit = -1"
)

for check in "${PWQUALITY_CHECKS[@]}"; do
    setting=$(echo "$check" | cut -d' ' -f1)
    expected_value=$(echo "$check" | cut -d' ' -f3)
    
    if grep -q "^$setting\s*=\s*$expected_value" /etc/security/pwquality.conf; then
        check_result 0 "Password quality setting $setting is set to $expected_value"
    else
        actual=$(grep "^$setting" /etc/security/pwquality.conf || echo "$setting = not set")
        check_result 1 "Password quality setting $setting should be $expected_value (Current: $actual)"
    fi
done

# Check if pam_pwquality is properly configured
if grep -q "^password\s*requisite\s*pam_pwquality.so" /etc/pam.d/common-password; then
    check_result 0 "pam_pwquality.so is configured in /etc/pam.d/common-password"
else
    check_result 1 "pam_pwquality.so is not properly configured in /etc/pam.d/common-password"
fi

echo -e "\n${BLUE}=== Password Hashing Algorithm (CIS 5.4.4) ===${NC}"

# Check if SHA-512 is configured for password hashing
if grep -q "pam_unix.so.*sha512" /etc/pam.d/common-password; then
    check_result 0 "SHA-512 is configured for password hashing"
else
    check_result 1 "SHA-512 is not configured for password hashing"
fi

echo -e "\n${BLUE}=== Password Reuse Limits (CIS 5.4.2) ===${NC}"

# Check password reuse limits
if grep -q "remember=5" /etc/pam.d/common-password; then
    check_result 0 "Password reuse limit is configured to remember 5 passwords"
else
    actual=$(grep "remember=" /etc/pam.d/common-password || echo "remember limit not set")
    check_result 1 "Password reuse limit should remember 5 passwords (Current: $actual)"
fi

echo -e "\n${BLUE}=== Password Expiration Settings (CIS 5.5.1) ===${NC}"

# Check /etc/login.defs settings
LOGIN_DEFS_CHECKS=(
    "PASS_MAX_DAYS 90"
    "PASS_MIN_DAYS 7"
    "PASS_WARN_AGE 7"
)

for check in "${LOGIN_DEFS_CHECKS[@]}"; do
    setting=$(echo "$check" | cut -d' ' -f1)
    expected_value=$(echo "$check" | cut -d' ' -f2)
    
    actual_value=$(grep "^$setting" /etc/login.defs | awk '{print $2}')
    
    if [ "$actual_value" = "$expected_value" ]; then
        check_result 0 "$setting is set to $expected_value days"
    else
        check_result 1 "$setting should be $expected_value days (Current: $actual_value)"
    fi
done

echo -e "\n${BLUE}=== Restrict Access to su Command (CIS 5.6) ===${NC}"

# Check if pam_wheel.so is configured for su
if grep -q "^auth\s*required\s*pam_wheel.so" /etc/pam.d/su; then
    check_result 0 "su access is restricted to wheel group"
else
    check_result 1 "su access is not restricted to wheel group"
fi

# Check wheel group configuration
if grep -q "^auth\s*required\s*pam_wheel.so\s*use_uid\s*group=sudo" /etc/pam.d/su; then
    check_result 0 "su access properly configured with group=sudo"
else
    check_result 1 "su access should be configured with group=sudo"
fi

echo -e "\n${BLUE}=== Sudo Configuration (CIS 5.7) ===${NC}"

# Check if sudo is installed
if command -v sudo &> /dev/null; then
    check_result 0 "sudo is installed"
else
    check_result 1 "sudo is not installed"
fi

# Check sudo log file configuration
if grep -q "^Defaults\s*logfile=" /etc/sudoers /etc/sudoers.d/*; then
    check_result 0 "sudo logs are configured"
else
    check_result 1 "sudo logs are not configured"
fi

# Check sudo use_pty setting
if grep -q "^Defaults\s*use_pty" /etc/sudoers /etc/sudoers.d/*; then
    check_result 0 "sudo use_pty is configured"
else
    check_result 1 "sudo use_pty is not configured"
fi

# Check sudo lecture setting
if grep -q "^Defaults\s*lecture=always" /etc/sudoers /etc/sudoers.d/*; then
    check_result 0 "sudo lecture message is configured"
else
    check_result 1 "sudo lecture message is not configured"
fi

echo -e "\n${BLUE}=== Last User Login Notification (CIS 5.3.1) ===${NC}"

# Check if last login notification is enabled
if grep -q "^session\s*required\s*pam_lastlog.so\s*showfailed" /etc/pam.d/login; then
    check_result 0 "Last login notification is enabled"
else
    check_result 1 "Last login notification is not enabled"
fi

echo -e "\n${BLUE}=== Default Group for root (CIS 5.2.2) ===${NC}"

# Check root group
root_gid=$(grep "^root:" /etc/passwd | cut -d: -f4)
if [ "$root_gid" = "0" ]; then
    check_result 0 "root account has GID 0"
else
    check_result 1 "root account does not have GID 0"
fi

echo -e "\n${BLUE}=== Default umask (CIS 5.4.5) ===${NC}"

# Check default umask setting
if grep -q "^UMASK\s*027" /etc/login.defs; then
    check_result 0 "Default umask is properly set to 027"
else
    actual=$(grep "^UMASK" /etc/login.defs | awk '{print $2}')
    check_result 1 "Default umask should be 027 (Current: $actual)"
fi

echo -e "\n${BLUE}=== Inactive Account Lockout (CIS 5.5.2) ===${NC}"

# Check inactive account lockout
inactive_days=$(useradd -D | grep INACTIVE | cut -d= -f2)
if [ "$inactive_days" -le 30 ] && [ "$inactive_days" -ne -1 ]; then
    check_result 0 "Inactive account lockout is set to $inactive_days days"
else
    check_result 1 "Inactive account lockout should be 30 days or less (Current: $inactive_days)"
fi

# Final summary
echo -e "\n${BLUE}====== Authentication & Authorization Controls Summary ======${NC}"
echo -e "Total checks: $TOTAL_CHECKS"
echo -e "${GREEN}Passed: $PASS_COUNT${NC}"
echo -e "${RED}Failed: $FAIL_COUNT${NC}"

if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "\n${GREEN}All authentication and authorization controls have been properly implemented!${NC}"
else
    echo -e "\n${YELLOW}Some controls require remediation. Review the failed checks above.${NC}"
    exit 1
fi

exit 0