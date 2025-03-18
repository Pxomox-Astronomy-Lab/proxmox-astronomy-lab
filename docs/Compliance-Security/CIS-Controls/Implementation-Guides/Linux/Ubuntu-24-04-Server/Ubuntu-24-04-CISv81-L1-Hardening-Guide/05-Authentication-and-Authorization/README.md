<!-- 
---
title: "Authentication and System Hardening - CIS Ubuntu 24.04"
description: "Guide for implementing CIS Ubuntu 24.04 Level 1 authentication and system hardening controls"
author: "VintageDon"
tags: ["security", "hardening", "cis", "ubuntu", "authentication", "compliance"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔐 **Authentication and System Hardening**

## 🔍 **1. Overview**

This directory contains scripts and documentation for implementing CIS Ubuntu 24.04 Level 1 Benchmark controls related to authentication, authorization, and system hardening. These controls are critical for establishing a secure baseline for Ubuntu 24.04 server systems.

## 📂 **2. Components**

This directory includes the following files:

- **05-authentication-and-authorization.md**: Documentation for user accounts, password policies, and sudo configuration
- **06-system-hardening.md**: Documentation for AppArmor, warning banners, and system updates
- **05-CISv81-l1-ubuntu2404-verify-authentication.sh**: Validation script to check conformance with authentication controls

## 🛠️ **3. Using the Validation Script**

The validation script checks if your system complies with the CIS Level 1 authentication controls.

### **3.1 Prerequisites**

- Root or sudo access to the system
- Bash shell

### **3.2 Running the Script**

```bash
sudo ./05-CISv81-l1-ubuntu2404-verify-authentication.sh
```

### **3.3 Expected Output**

When all controls are properly implemented, you should see output similar to the following:

```bash
====== CIS Ubuntu 24.04 Authentication & Authorization Controls Validation ======

=== Password Quality Requirements (CIS 5.4.1) ===
[PASS] libpam-pwquality package is installed
[PASS] Password quality setting minlen is set to 14
[PASS] Password quality setting minclass is set to 4
[PASS] Password quality setting dcredit is set to -1
[PASS] Password quality setting ucredit is set to -1
[PASS] Password quality setting lcredit is set to -1
[PASS] Password quality setting ocredit is set to -1
[PASS] pam_pwquality.so is configured in /etc/pam.d/common-password

=== Password Hashing Algorithm (CIS 5.4.4) ===
[PASS] SHA-512 is configured for password hashing

=== Password Reuse Limits (CIS 5.4.2) ===
[PASS] Password reuse limit is configured to remember 5 passwords

=== Password Expiration Settings (CIS 5.5.1) ===
[PASS] PASS_MAX_DAYS is set to 90 days
[PASS] PASS_MIN_DAYS is set to 7 days
[PASS] PASS_WARN_AGE is set to 7 days

=== Restrict Access to su Command (CIS 5.6) ===
[PASS] su access is restricted to wheel group
[PASS] su access properly configured with group=sudo

=== Sudo Configuration (CIS 5.7) ===
[PASS] sudo is installed
[PASS] sudo logs are configured
[PASS] sudo use_pty is configured
[PASS] sudo lecture message is configured

=== Last User Login Notification (CIS 5.3.1) ===
[PASS] Last login notification is enabled

=== Default Group for root (CIS 5.2.2) ===
[PASS] root account has GID 0

=== Default umask (CIS 5.4.5) ===
[PASS] Default umask is properly set to 027

=== Inactive Account Lockout (CIS 5.5.2) ===
[PASS] Inactive account lockout is set to 30 days

====== Authentication & Authorization Controls Summary ======
Total checks: 23
Passed: 23
Failed: 0

All authentication and authorization controls have been properly implemented!
```

## 🔧 **4. Quick Fixes for Common Issues**

### **4.1 Fix SHA-512 Password Hashing**

If the validation shows SHA-512 is not configured:

```bash
sudo sed -i '/pam_unix.so/ s/$/ sha512/' /etc/pam.d/common-password
```

### **4.2 Fix Password Quality - minclass Setting**

If minclass is not properly set:

```bash
echo 'minclass = 4' | sudo tee -a /etc/security/pwquality.conf
```

### **4.3 Fix Password Reuse Limits**

If password reuse limit is not configured:

```bash
sudo sed -i '/pam_unix.so/ s/$/ remember=5/' /etc/pam.d/common-password
```

### **4.4 Fix su Access Restriction**

If su access is not restricted:

```bash
echo 'auth required pam_wheel.so use_uid group=sudo' | sudo tee -a /etc/pam.d/su
```

### **4.5 Fix Inactive Account Lockout**

If inactive account lockout is not configured:

```bash
sudo useradd -D -f 30
```

## 🔄 **5. Full Remediation**

For comprehensive remediation, refer to the detailed guides in this directory or run the remediation script:

```bash
sudo ./05-CISv81-l1-ubuntu2404-remediate-authentication.sh
```

## 🔗 **6. Additional Resources**

- [CIS Ubuntu Linux 24.04 LTS Benchmark](https://www.cisecurity.org/benchmark/ubuntu_linux)
- [Ubuntu 24.04 Security Guide](https://ubuntu.com/security/guides)

## ✅ **7. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 **8. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |
