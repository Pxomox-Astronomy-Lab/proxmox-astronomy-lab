<!-- 
---
title: "CIS Ubuntu 24.04 L1 Hardening - Network Configuration"
description: "Instructions for implementing CIS Level 1 network security controls for Ubuntu Server 24.04"
author: "VintageDon"
tags: ["hardening", "security", "cisv8", "ubuntu", "network", "tcp-ip", "firewall"]
category: "Security"
kb_type: "Procedure"
version: "1.1"
status: "Published"
last_updated: "2025-03-16"
---
-->

# **CIS Ubuntu 24.04 L1 Hardening - Network Configuration**

## **1. Overview**

### **1.1 Purpose**

This document provides implementation instructions for CIS Level 1 network security controls for Ubuntu Server 24.04. These configurations help protect systems from common network-based attacks by hardening the TCP/IP stack and disabling potentially vulnerable features.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Network kernel parameter configuration | Host-based firewall rule configuration |
| IPv4 and IPv6 stack hardening | Routing configuration |
| TCP SYN protection | VPN and advanced networking setup |
| ICMP security controls | Network intrusion detection systems |

### **1.3 Target Audience**

This article is intended for System Administrators, Security Engineers, and Compliance Officers responsible for implementing security controls on Ubuntu Server 24.04 systems.

| **Control ID** | **Description** | **Category** |
|----------------|----------------|--------------|
| 3.1.1 | Ensure IP forwarding is disabled | Network Parameters |
| 3.2.1 | Ensure packet redirect sending is disabled | Network Parameters |
| 3.3.1 | Ensure TCP SYN Cookies are enabled | Network Parameters |

---

## **2. Controls Implementation**

This guide addresses the following CIS Ubuntu 24.04 Level 1 controls:

| **Control ID** | **Description** | **Category** |
|----------------|----------------|--------------|
| 3.1.1 | Ensure IP forwarding is disabled | Network Parameters |
| 3.2.1 | Ensure packet redirect sending is disabled | Network Parameters |
| 3.3.1 | Ensure TCP SYN Cookies are enabled | Network Parameters |

### **2.1 Disable IP Forwarding**

IP forwarding allows a system to forward network packets between interfaces, which is necessary for routing but should be disabled on systems that are not functioning as routers.

#### **2.1.1 Check Current Settings**

```bash
# Check current runtime value
sysctl net.ipv4.ip_forward
sysctl net.ipv6.conf.all.forwarding

# Check configuration file
grep -E "net\.ipv4\.ip_forward|net\.ipv6\.conf\.all\.forwarding" /etc/sysctl.conf /etc/sysctl.d/*.conf
```

#### **2.1.2 Implementation**

```bash
# Create a new configuration file
cat << EOF > /etc/sysctl.d/60-disable-ip-forwarding.conf
# Disable IP forwarding
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0
EOF

# Apply the changes
sysctl -p /etc/sysctl.d/60-disable-ip-forwarding.conf
```

#### **2.1.3 Verification**

```bash
# Verify runtime values
sysctl net.ipv4.ip_forward
sysctl net.ipv6.conf.all.forwarding

# Both should return a value of 0
```

### **2.2 Disable ICMP Redirects**

ICMP redirects can potentially be used in MITM attacks to redirect traffic. They should be disabled unless specifically required.

#### **2.2.1 Check Current Settings**

```bash
# Check current runtime values for IPv4
sysctl net.ipv4.conf.all.send_redirects
sysctl net.ipv4.conf.default.send_redirects

# Check configuration file
grep -E "net\.ipv4\.conf\.(all|default)\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*.conf
```

#### **2.2.2 Implementation**

```bash
# Create a new configuration file
cat << EOF > /etc/sysctl.d/60-disable-ip-redirects.conf
# Disable ICMP redirects
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
EOF

# Apply the changes
sysctl -p /etc/sysctl.d/60-disable-ip-redirects.conf
```

#### **2.2.3 Verification**

```bash
# Verify runtime values
sysctl net.ipv4.conf.all.send_redirects
sysctl net.ipv4.conf.default.send_redirects

# Both should return a value of 0
```

### **2.3 Enable TCP SYN Cookies**

SYN cookies protect against SYN flood attacks by validating connection attempts without consuming resources for incomplete connections.

#### **2.3.1 Check Current Settings**

```bash
# Check current runtime value
sysctl net.ipv4.tcp_syncookies

# Check configuration file
grep -E "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf /etc/sysctl.d/*.conf
```

#### **2.3.2 Implementation**

```bash
# Create a new configuration file
cat << EOF > /etc/sysctl.d/60-enable-tcp-syncookies.conf
# Enable TCP SYN cookies
net.ipv4.tcp_syncookies = 1
EOF

# Apply the changes
sysctl -p /etc/sysctl.d/60-enable-tcp-syncookies.conf
```

#### **2.3.3 Verification**

```bash
# Verify runtime value
sysctl net.ipv4.tcp_syncookies

# Should return a value of 1
```

### **2.4 Consolidated Network Security Settings**

For convenience, the following is a consolidated set of recommended network security sysctl settings:

#### **2.4.1 Implementation**

```bash
# Create a comprehensive network security sysctl configuration
cat << EOF > /etc/sysctl.d/60-network-security.conf
# Disable IP forwarding
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0

# Disable ICMP redirects
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0

# Enable TCP SYN cookies
net.ipv4.tcp_syncookies = 1

# Additional network hardening (not explicitly in CIS L1)
# Protect against SYN flood attacks
net.ipv4.tcp_max_syn_backlog = 4096

# Ignore ICMP broadcasts
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Ignore bogus ICMP responses
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Enable source validation by reverse path
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Log martian packets
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
EOF

# Apply all settings
sysctl -p /etc/sysctl.d/60-network-security.conf
```

#### **2.4.2 Verification**

```bash
# Verify all settings were applied
sysctl -a | grep -E 'net.ipv4.ip_forward|net.ipv6.conf.all.forwarding|net.ipv4.conf.all.send_redirects|net.ipv4.conf.default.send_redirects|net.ipv4.tcp_syncookies'
```

---

## 🔄 **3. Automation Script**

The following script automates the implementation of these network security controls:

```bash
#!/bin/bash
# CIS Ubuntu 24.04 L1 Hardening - Network Configuration
# This script implements CIS Level 1 network security controls

echo "Implementing network security settings..."

# Create backup of any existing network sysctl settings
if [ -f /etc/sysctl.d/60-network-security.conf ]; then
    mv /etc/sysctl.d/60-network-security.conf /etc/sysctl.d/60-network-security.conf.$(date +%Y%m%d-%H%M%S).bak
fi

# Create comprehensive network security sysctl configuration
cat << EOF > /etc/sysctl.d/60-network-security.conf
# Disable IP forwarding
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0

# Disable ICMP redirects
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0

# Enable TCP SYN cookies
net.ipv4.tcp_syncookies = 1

# Additional network hardening (not explicitly in CIS L1)
# Protect against SYN flood attacks
net.ipv4.tcp_max_syn_backlog = 4096

# Ignore ICMP broadcasts
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Ignore bogus ICMP responses
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Enable source validation by reverse path
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Log martian packets
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
EOF

# Apply all settings
echo "Applying new network security settings..."
sysctl -p /etc/sysctl.d/60-network-security.conf

echo "Verifying network security settings..."
sysctl -a | grep -E 'net.ipv4.ip_forward|net.ipv6.conf.all.forwarding|net.ipv4.conf.all.send_redirects|net.ipv4.conf.default.send_redirects|net.ipv4.tcp_syncookies'

echo "Network security configuration complete."
```

> **Note**: Always review and test scripts in a non-production environment before applying to production systems.

---

## **4. Verification**

### **4.1 Automated Verification Script**

The lab uses a standardized script for verifying compliance with CIS network security controls. The script `03-CISv81-l1-ubuntu2404-verify-network.sh` provides a comprehensive validation of all configured parameters.

To run the verification:

```bash
sudo ./03-CISv81-l1-ubuntu2404-verify-network.sh
```

This will produce output similar to:

```bash
CIS Ubuntu 24.04 Network Security Controls Verification
======================================================
Checking IP forwarding settings (3.1.1)...
✅ PASS: 3.1.1 - IPv4 forwarding is disabled (net.ipv4.ip_forward = 0)
⚠️ INFO: 3.1.1 - IPv6 forwarding is disabled (net.ipv6.conf.all.forwarding not available - IPv6 appears to be disabled)
Checking ICMP redirect settings (3.2.1)...
✅ PASS: 3.2.1 - IPv4 send redirects disabled (all) (net.ipv4.conf.all.send_redirects = 0)
✅ PASS: 3.2.1 - IPv4 send redirects disabled (default) (net.ipv4.conf.default.send_redirects = 0)
Checking additional ICMP redirect security settings...
✅ PASS: 3.2.1+ - IPv4 accept redirects disabled (all) (net.ipv4.conf.all.accept_redirects = 0)
✅ PASS: 3.2.1+ - IPv4 accept redirects disabled (default) (net.ipv4.conf.default.accept_redirects = 0)
⚠️ INFO: 3.2.1+ - IPv6 accept redirects disabled (all) (net.ipv6.conf.all.accept_redirects not available - IPv6 appears to be disabled)
⚠️ INFO: 3.2.1+ - IPv6 accept redirects disabled (default) (net.ipv6.conf.default.accept_redirects not available - IPv6 appears to be disabled)
Checking TCP SYN cookies (3.3.1)...
✅ PASS: 3.3.1 - TCP SYN cookies enabled (net.ipv4.tcp_syncookies = 1)
Checking additional recommended network security settings...
✅ PASS: Additional - SYN backlog size (net.ipv4.tcp_max_syn_backlog = 4096)
✅ PASS: Additional - ICMP broadcast ignore (net.ipv4.icmp_echo_ignore_broadcasts = 1)
✅ PASS: Additional - Bogus ICMP responses ignored (net.ipv4.icmp_ignore_bogus_error_responses = 1)
✅ PASS: Additional - Source validation enabled (all) (net.ipv4.conf.all.rp_filter = 1)
✅ PASS: Additional - Source validation enabled (default) (net.ipv4.conf.default.rp_filter = 1)
✅ PASS: Additional - Martian packet logging enabled (all) (net.ipv4.conf.all.log_martians = 1)
✅ PASS: Additional - Martian packet logging enabled (default) (net.ipv4.conf.default.log_martians = 1)
Checking persistence of network security settings...
✅ PASS: Network security settings are persisted in configuration files
=== Summary ===
All network security controls passed!
```

The script automatically checks:

- CIS control 3.1.1: IP forwarding settings
- CIS control 3.2.1: ICMP redirect settings
- CIS control 3.3.1: TCP SYN cookies
- Additional recommended network security settings
- Configuration persistence

### **4.2 Manual Verification**

If the automated script is unavailable, use these commands to verify key settings:

```bash
# Check IP forwarding settings
sysctl net.ipv4.ip_forward
sysctl net.ipv6.conf.all.forwarding 2>/dev/null || echo "IPv6 not enabled"

# Check ICMP redirect settings
sysctl net.ipv4.conf.all.send_redirects
sysctl net.ipv4.conf.default.send_redirects

# Check TCP SYN cookies
sysctl net.ipv4.tcp_syncookies

# Check configuration persistence
grep -r "net.ipv4.ip_forward" /etc/sysctl.conf /etc/sysctl.d/
```

---

## **5. References and Related Resources**

### **5.1 Related GLPI Items**

| **GLPI Item Type** | **ID** | **Name** | **Relationship** |
|--------------------|-------|----------|-----------------|
| KB Article | KB-SEC-002 | Linux Firewall Configuration | Complementary network security |
| Asset | AST-SRV-056 | Production Web Server | Example implementation |
| SCAP Scan | SCN-2025-03-14 | CIS Ubuntu Compliance Scan | Verification method |

### **5.2 External References**

| **Reference Type** | **Title** | **Location** |
|--------------------|----------|-------------|
| Documentation | CIS Ubuntu Linux 24.04 LTS Benchmark v1.0.0 | CIS SecureSuite |
| Article | "Linux Kernel Network Hardening" | Linux Security Journal |
| Tool | Lynis Security Auditing Tool | <https://cisofy.com/lynis/> |

### **5.3 Related KB Articles**

| **Article Title** | **Article ID** | **Relationship** |
|-------------------|---------------|-----------------|
| Firewall Configuration for Ubuntu Server | KB-SEC-002 | Complements network parameter hardening |
| CIS Benchmark Implementation Overview | KB-SEC-001 | Parent framework document |
| System Hardening Verification | KB-SEC-010 | Verification methodology |

---

## **6. Process Integration**

### **6.1 ITIL Process Relationship**

This implementation relates to the following ITIL processes:

- **Change Management**: All modifications to network parameters require RFC
- **Configuration Management**: Network parameters are tracked as configuration items
- **Security Management**: Supports the security baseline for all systems
- **Release Management**: Validation required before production release

### **6.2 Role Responsibilities**

| **Role** | **Responsibility Related to This Article** |
|----------|--------------------------------------------|
| System Administrator | Implementation of network security settings |
| Security Engineer | Verification of control effectiveness |
| Change Manager | Approval of network parameter modifications |
| Compliance Officer | Validation against CIS benchmarks |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial version | VintageDon |
| 1.1 | 2025-03-16 | Added automated verification script details | VintageDon |
