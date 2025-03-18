<!-- 
---
title: "Authentication & Authorization Security - Proxmox Astronomy Lab"
description: "Comprehensive documentation for authentication and authorization security controls implemented in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["security", "authentication", "authorization", "cis", "compliance", "ssh", "pam", "accounts"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔑 **Authentication & Authorization Security**

A structured approach to authentication and authorization security is essential for protecting our infrastructure from unauthorized access. This document outlines our implementation of CIS Benchmark controls for secure system authentication, focusing on SSH hardening, PAM configuration, and account security.

## 🔍 **1. Overview**

### **1.1 Purpose**

This document details the implementation of authentication and authorization security controls in the Proxmox Astronomy Lab, following the CIS Ubuntu 24.04 L2 benchmark guidelines. These controls establish a secure foundation for access management, ensuring only authorized individuals can access lab resources while maintaining comprehensive audit trails.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| SSH server configuration and hardening | Application-specific authentication mechanisms |
| PAM configuration and password policies | Network access controls (covered in Network Security) |
| Account lockout and password requirements | Multi-factor authentication infrastructure details |
| Root account restrictions | Directory service configuration (Entra ID/AD) |
| Scheduled job access control (cron/at) | External authentication services |

### **1.3 Target Audience**

This documentation is intended for Security Administrators, System Engineers, and Operations personnel responsible for maintaining secure authentication practices within the lab environment.

---

## 📚 **2. Authentication Framework**

Our authentication security framework implements a defense-in-depth approach, combining multiple layers of controls to protect access to lab resources.

### **2.1 Key Security Principles**

The following table outlines the core security principles implemented across our authentication controls:

| **Principle** | **Implementation** | **CIS Reference** |
|---------------|-------------------|-------------------|
| **Least Privilege** | Service-specific access controls, restricted root access | 5.2.10, 5.4.2, 5.5.3 |
| **Defense in Depth** | Multiple authentication mechanisms, layered access controls | 5.2.19, 5.3.1 |
| **Secure Defaults** | Strong password requirements, implicit deny model | 5.3.1, 5.3.3, 5.3.4 |
| **Fail Secure** | Account lockout after failed attempts, encrypted authentication | 5.3.2, 5.2.13-15 |
| **Complete Mediation** | All access paths require authentication, no bypass mechanisms | 5.2.4, 5.2.11 |

These principles work together to create a robust and comprehensive authentication security posture that protects sensitive lab resources from unauthorized access.

---

## 🔐 **3. SSH Server Security**

SSH provides the primary remote access method for system administration in our environment. We've implemented a hardened SSH configuration that meets or exceeds CIS benchmarks.

### **3.1 Configuration Overview**

Our SSH server configuration has been hardened according to CIS Benchmark 5.2 requirements:

```bash
# =============================================================================
# SSHD CONFIGURATION - SECURITY HARDENED
# AUTHOR: VintageDon (https://github.com/vintagedon)
# REPO: https://github.com/vintagedon/proxmox-astronomy-lab
# COMPLIANCE: CIS 5.2.x, NIST AC-17, ISO 27001 A.9.1.2
# LAST UPDATED: 2025-03-16
# =============================================================================
# 
# This configuration implements security controls for SSH server access,
# including strong cryptography, authentication restrictions, session controls,
# and compliance with security benchmarks.
# 
# COVERED CONTROLS:
# - Access restrictions and multi-factor authentication
# - Secure cryptographic settings (ciphers, MACs, key exchange)
# - Session timeout and connection limits
# - Privilege separation and process hardening
# - Audit logging and monitoring integration
# =============================================================================

# -----------------------------------------------------------------------------
# CORE PROTOCOL AND CONNECTIVITY SETTINGS
# -----------------------------------------------------------------------------
# Specify SSH protocol version (only SSH v2 is secure)
Protocol 2

# Network binding settings
Port 22                     # Default SSH port
AddressFamily inet          # Limit to IPv4 only
ListenAddress 0.0.0.0       # Listen on all network interfaces

# Host key configuration
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# -----------------------------------------------------------------------------
# AUTHENTICATION SETTINGS
# -----------------------------------------------------------------------------
# Access control - specify users allowed to connect
AllowUsers crainbramp ansible

# Authentication methods
AuthenticationMethods publickey       # Require key-based authentication
PubkeyAuthentication yes              # Enable public key authentication
PasswordAuthentication no             # Disable password authentication
PermitEmptyPasswords no               # Prohibit empty passwords (CIS 5.2.11)
PermitRootLogin no                    # Disable root login (CIS 5.2.10)

# Hardening against unauthorized access
MaxAuthTries 3                        # Limit auth attempts (CIS 5.2.7)
LoginGraceTime 60                     # Timeout for login (CIS 5.2.17)
MaxStartups 10:30:60                  # Rate-limit connections (CIS 5.2.21)
MaxSessions 5                         # Limit concurrent sessions (CIS 5.2.22)

# -----------------------------------------------------------------------------
# SESSION CONFIGURATION
# -----------------------------------------------------------------------------
# Session timeout settings (CIS 5.2.16)
ClientAliveInterval 300               # Check client every 5 minutes
ClientAliveCountMax 2                 # Disconnect after 2 missed responses

# Security restrictions
StrictModes yes                       # Enforce file permission checking
PermitUserEnvironment no              # Prevent env variable forwarding (CIS 5.2.12)
PermitUserRC no                       # Disable user rc files

# Terminal settings
PermitTTY yes                         # Allow TTY allocation

# -----------------------------------------------------------------------------
# FORWARDING AND TUNNELING RESTRICTIONS
# -----------------------------------------------------------------------------
# Disable unnecessary tunneling (security risk)
X11Forwarding no                      # Disable X11 forwarding (CIS 5.2.6)
AllowAgentForwarding no               # Disable agent forwarding
AllowTcpForwarding no                 # Disable TCP forwarding (CIS 5.2.20)
GatewayPorts no                       # Prevent remote port forwarding

# -----------------------------------------------------------------------------
# CRYPTOGRAPHIC SETTINGS
# -----------------------------------------------------------------------------
# Enforce strong encryption (CIS 5.2.13)
Ciphers aes256-ctr,aes192-ctr,aes128-ctr

# Secure key exchange algorithms (CIS 5.2.15)
KexAlgorithms curve25519-sha256,ecdh-sha2-nistp384,ecdh-sha2-nistp521

# Strong message authentication codes (CIS 5.2.14)
MACs hmac-sha2-512,hmac-sha2-256

# -----------------------------------------------------------------------------
# LOGGING AND MONITORING
# -----------------------------------------------------------------------------
# Comprehensive logging for security monitoring
LogLevel VERBOSE                      # Detailed logging (CIS 5.2.5)

# -----------------------------------------------------------------------------
# ADDITIONAL SECURITY HARDENING
# -----------------------------------------------------------------------------
# Disable insecure authentication methods
IgnoreRhosts yes                      # Disable .rhosts files (CIS 5.2.8)
HostbasedAuthentication no            # Disable host-based auth (CIS 5.2.9)

# Performance and usability
UseDNS no                             # Don't resolve client hostnames

# Pre-login warning message (CIS 5.2.18)
Banner /etc/issue.net                 # Display legal banner

# PAM integration for advanced authentication (CIS 5.2.19)
UsePAM yes                            # Enable PAM support

# -----------------------------------------------------------------------------
# SUBSYSTEM CONFIGURATION
# -----------------------------------------------------------------------------
# Define allowed subsystems
Subsystem sftp /usr/lib/openssh/sftp-server

# -----------------------------------------------------------------------------
# USER-SPECIFIC CONFIGURATIONS
# -----------------------------------------------------------------------------
# Special settings for ansible user
Match User ansible
    PasswordAuthentication no         # Force key-based authentication
    X11Forwarding no                  # No X11 forwarding
    AllowTcpForwarding no             # No TCP forwarding
    # PermitTTY yes needed for ansible functionality
```

### **3.2 SSH Cryptographic Controls**

The following table details our SSH cryptographic settings:

| **Control Type** | **Implemented Settings** | **CIS Reference** |
|------------------|--------------------------|-------------------|
| **Ciphers** | aes256-ctr, aes192-ctr, aes128-ctr | 5.2.13 |
| **MACs** | hmac-sha2-512, hmac-sha2-256 | 5.2.14 |
| **Key Exchange** | curve25519-sha256, ecdh-sha2-nistp384, ecdh-sha2-nistp521 | 5.2.15 |

These cryptographic settings ensure all SSH connections use strong encryption, preventing interception and tampering of remote access sessions.

### **3.3 SSH Permission Requirements**

Proper file permissions are essential for SSH security:

| **File Type** | **Required Permissions** | **Ownership** | **CIS Reference** |
|---------------|--------------------------|--------------|-------------------|
| sshd_config | 0600 | root:root | 5.2.1 |
| Private Host Keys | 0600 | root:root | 5.2.2 |
| Public Host Keys | 0644 | root:root | 5.2.3 |

Regular permission verification is performed as part of our security scanning procedures.

---

## 👥 **4. PAM Configuration & Password Policies**

PAM (Pluggable Authentication Modules) provides the framework for authentication mechanisms in our environment, including password quality enforcement and account lockout.

### **4.1 Password Requirements**

Our password policy enforces the following requirements:

| **Requirement** | **Setting** | **Implementation** | **CIS Reference** |
|----------------|-------------|-------------------|-------------------|
| **Minimum Length** | 14 characters | pam_pwquality.so (minlen=14) | 5.3.1 |
| **Complexity** | 4 character classes | pam_pwquality.so (minclass=4) | 5.3.1 |
| **Password Reuse** | 5 passwords remembered | pam_unix.so (remember=5) | 5.3.3 |
| **Hashing Algorithm** | SHA-512 | pam_unix.so (sha512) | 5.3.4 |

These settings ensure that users select strong, complex passwords that are resistant to brute force and dictionary attacks.

### **4.2 Account Lockout Configuration**

Our account lockout policy helps prevent brute force attempts:

```bash
# Account lockout configuration in /etc/pam.d/common-auth
auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900
auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900
auth required pam_faillock.so authsucc audit deny=5 unlock_time=900
```

This configuration:

- Locks accounts after 5 failed attempts
- Maintains the lockout for 15 minutes (900 seconds)
- Records all authentication attempts in the audit log

### **4.3 Password Aging and Expiration**

Password aging policies enforce regular rotation of credentials:

| **Policy** | **Setting** | **Implementation Location** | **CIS Reference** |
|------------|-------------|----------------------------|-------------------|
| **Max Password Age** | 365 days | /etc/login.defs (PASS_MAX_DAYS) | 5.4.1.1 |
| **Min Password Age** | 7 days | /etc/login.defs (PASS_MIN_DAYS) | 5.4.1.2 |
| **Password Warning** | 7 days | /etc/login.defs (PASS_WARN_AGE) | 5.4.1.3 |
| **Account Inactivity** | 30 days | /etc/default/useradd (INACTIVE) | 5.4.1.4 |

These settings ensure regular password updates while preventing users from immediately cycling back to old passwords.

---

## ⏱️ **5. Cron & Scheduled Jobs Security**

Scheduled job mechanisms (cron and at) require special security controls to prevent unauthorized task execution.

### **5.1 File Permission Requirements**

Permissions for cron directories are tightly controlled:

| **Directory/File** | **Required Permissions** | **Ownership** | **CIS Reference** |
|--------------------|--------------------------|--------------|-------------------|
| /etc/crontab | 0600 | root:root | 5.1.2 |
| /etc/cron.hourly | 0700 | root:root | 5.1.3 |
| /etc/cron.daily | 0700 | root:root | 5.1.4 |
| /etc/cron.weekly | 0700 | root:root | 5.1.5 |
| /etc/cron.monthly | 0700 | root:root | 5.1.6 |
| /etc/cron.d | 0700 | root:root | 5.1.7 |

### **5.2 Access Control**

Access to scheduled job functionality is restricted:

| **Mechanism** | **Implementation** | **CIS Reference** |
|---------------|-------------------|-------------------|
| **cron.allow** | Only authorized users listed | 5.1.8 |
| **cron.deny** | File removed (implicit deny) | 5.1.8 |
| **at.allow** | Only authorized users listed | 5.1.9 |
| **at.deny** | File removed (implicit deny) | 5.1.9 |

This configuration ensures that only authorized users can create scheduled tasks, preventing potential privilege escalation or unauthorized persistence mechanisms.

---

## 🔍 **6. Authentication Monitoring & Auditing**

Monitoring and auditing are essential components of our authentication security posture.

### **6.1 SSH Logging Configuration**

SSH events are logged at a verbose level:

```
LogLevel VERBOSE
```

This setting ensures detailed logging of SSH connection attempts, sessions, and authentication activities.

### **6.2 Authentication Event Monitoring**

The following authentication events are monitored and generate alerts:

| **Event Type** | **Monitoring** | **Alert Threshold** |
|----------------|---------------|---------------------|
| Failed logins | Wazuh SIEM | 5 failures within 5 minutes |
| Account lockouts | Wazuh SIEM | Any occurrence |
| Root login attempts | Wazuh SIEM | Any occurrence |
| Off-hours authentication | Wazuh SIEM | Based on user pattern |
| Unauthorized SSH access | Wazuh SIEM | Any occurrence |

Alerts are sent to the central security monitoring platform and trigger appropriate response procedures according to the [Incident Response Plan](../compliance-security/incident-response/README.md).

---

## 🚀 **7. Implementation & Verification**

### **7.1 Implementation Status**

We use automated verification scripts to ensure consistent compliance with authentication security controls:

```bash
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
```

These scripts run as part of our regular security compliance checks and automatically report any deviations from the required configuration.

### **7.2 Current Compliance Status**

The latest compliance scan for authentication controls shows:

| **Section** | **Compliance Rate** | **Last Verified** |
|-------------|---------------------|-------------------|
| SSH Server Configuration | 100% (22/22 controls) | 2025-03-16 |
| PAM Configuration | 100% (5/5 controls) | 2025-03-16 |
| Cron Configuration | 100% (9/9 controls) | 2025-03-16 |
| User Accounts Environment | Pending verification | - |
| Root Account Restrictions | Pending verification | - |

Any identified non-compliance issues are tracked in our [Security Compliance Tracker](../compliance-security/compliance-tracker.md) and remediated according to their severity.

---

## 🔗 **8. Related Documentation**

| **Document** | **Purpose** | **Location** |
|--------------|------------|-------------|
| **CIS Ubuntu 24.04 LTS L2 Benchmark** | Source compliance guidelines | [Compliance Framework](../compliance-security/frameworks/cis-benchmarks.md) |
| **Incident Response Plan** | Procedures for authentication-related incidents | [IR Documentation](../compliance-security/incident-response/README.md) |
| **User Account Management** | Procedures for account creation and maintenance | [User Management](../control-plane/identity-management/user-management.md) |
| **Security Monitoring Configuration** | Details on authentication event monitoring | [Monitoring Documentation](../compliance-security/security-monitoring/authentication-monitoring.md) |

---

## ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial version, complete documentation of SSH, PAM, and cron security | VintageDon |
