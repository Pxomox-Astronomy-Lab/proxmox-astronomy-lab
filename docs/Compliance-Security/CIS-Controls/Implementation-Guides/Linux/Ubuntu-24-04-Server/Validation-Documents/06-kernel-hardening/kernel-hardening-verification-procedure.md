<!-- 
---
title: "Kernel Hardening Validation Process"
description: "Step-by-step procedure for validating kernel hardening controls in accordance with CIS Benchmarks for Ubuntu 24.04"
author: "VintageDon"
tags: ["security", "validation", "kernel", "hardening", "cisv8", "ubuntu"]
category: "Security"
kb_type: "Procedure"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔍 **Kernel Hardening Validation Process**

## 📋 **1. Purpose**

This document outlines the structured process for validating kernel hardening controls on Ubuntu 24.04 servers within the Proxmox Astronomy Lab. The validation ensures that all systems maintain compliance with CIS Benchmarks Level 2 requirements for kernel parameters.

This process should be executed:

- After initial system provisioning
- Following system upgrades
- During quarterly security assessments
- After any security-related configuration changes

## 🛠️ **2. Prerequisites**

### **2.1 Required Access**

| **Requirement** | **Details** |
|----------------|------------|
| **Access Level** | Root or sudo privileges on target system |
| **System Type** | Ubuntu 24.04 Server |
| **Tools** | SSH client, Wazuh agent (for automated validation) |

### **2.2 Required Documentation**

- CIS Benchmark for Ubuntu 24.04 (latest version)
- This validation procedure
- System-specific configuration exceptions (if any)

## 📊 **3. Validation Procedure**

### **3.1 Manual Verification Process**

Follow these steps to manually verify kernel hardening settings:

#### **Step 1: Verify sysctl Configuration Files**

```bash
# Check main configuration file
sudo cat /etc/sysctl.conf

# Check configuration in sysctl.d directory
sudo ls -la /etc/sysctl.d/
sudo cat /etc/sysctl.d/99-cis-kernel.conf
```

Verify that the file exists and contains the required parameters with correct values.

#### **Step 2: Check Current Kernel Parameters**

```bash
# View all current kernel parameters
sudo sysctl -a

# Filter for specific security-relevant parameters
sudo sysctl -a | grep -E 'fs.suid_dumpable|kernel.randomize_va_space|kernel.kptr_restrict|kernel.dmesg_restrict|kernel.sysrq|net.ipv4.conf.all.accept_redirects|net.ipv4.conf.default.accept_redirects|net.ipv4.conf.all.secure_redirects|net.ipv4.conf.default.secure_redirects|net.ipv4.conf.all.log_martians|net.ipv4.conf.default.log_martians|net.ipv4.conf.all.rp_filter|net.ipv4.conf.default.rp_filter|fs.protected_fifos|fs.protected_hardlinks|fs.protected_symlinks|fs.protected_regular|net.ipv4.tcp_syncookies|net.ipv4.conf.all.send_redirects|net.ipv4.conf.default.send_redirects|net.ipv4.conf.all.accept_source_route|net.ipv4.conf.default.accept_source_route|net.ipv4.tcp_timestamps'
```

#### **Step 3: Verify Parameter Application**

```bash
# Force reload of sysctl parameters
sudo sysctl -p /etc/sysctl.d/99-cis-kernel.conf

# Verify there are no errors in application
```

#### **Step 4: Verify Boot Parameters**

Some kernel parameters need to be set via boot parameters:

```bash
# Check kernel command line parameters
cat /proc/cmdline
```

### **3.2 Automated Verification**

#### **Step 1: Run Wazuh Scan**

```bash
# Run on-demand CIS compliance scan with Wazuh agent
sudo /var/ossec/bin/agent_control -r -a

# Check results with focus on kernel-related controls
sudo grep -r "kernel" /var/ossec/logs/alerts
```

#### **Step 2: Run OpenSCAP Scan**

```bash
# Run OpenSCAP scan with CIS profile
sudo oscap xccdf eval --profile cis_level2 --report report.html /usr/share/xml/scap/ssg/content/ssg-ubuntu2404-xccdf.xml

# Open the HTML report for review
```

## ✅ **4. Validation Criteria**

Use the following table to validate the key parameters:

| **Parameter** | **Expected Value** | **Validation Command** | **Compliant?** |
|--------------|-------------------|------------------------|----------------|
| `fs.suid_dumpable` | `0` | `sysctl fs.suid_dumpable` | ☐ |
| `kernel.randomize_va_space` | `2` | `sysctl kernel.randomize_va_space` | ☐ |
| `kernel.kptr_restrict` | `2` | `sysctl kernel.kptr_restrict` | ☐ |
| `kernel.dmesg_restrict` | `1` | `sysctl kernel.dmesg_restrict` | ☐ |
| `kernel.sysrq` | `0` | `sysctl kernel.sysrq` | ☐ |
| `net.ipv4.conf.all.accept_redirects` | `0` | `sysctl net.ipv4.conf.all.accept_redirects` | ☐ |
| `net.ipv4.conf.default.accept_redirects` | `0` | `sysctl net.ipv4.conf.default.accept_redirects` | ☐ |
| `net.ipv4.conf.all.secure_redirects` | `0` | `sysctl net.ipv4.conf.all.secure_redirects` | ☐ |
| `net.ipv4.conf.default.secure_redirects` | `0` | `sysctl net.ipv4.conf.default.secure_redirects` | ☐ |
| `net.ipv4.conf.all.log_martians` | `1` | `sysctl net.ipv4.conf.all.log_martians` | ☐ |
| `net.ipv4.conf.default.log_martians` | `1` | `sysctl net.ipv4.conf.default.log_martians` | ☐ |
| `net.ipv4.conf.all.rp_filter` | `1` | `sysctl net.ipv4.conf.all.rp_filter` | ☐ |
| `net.ipv4.conf.default.rp_filter` | `1` | `sysctl net.ipv4.conf.default.rp_filter` | ☐ |
| `fs.protected_fifos` | `1` | `sysctl fs.protected_fifos` | ☐ |
| `fs.protected_hardlinks` | `1` | `sysctl fs.protected_hardlinks` | ☐ |
| `fs.protected_symlinks` | `1` | `sysctl fs.protected_symlinks` | ☐ |
| `fs.protected_regular` | `2` | `sysctl fs.protected_regular` | ☐ |
| `net.ipv4.tcp_syncookies` | `1` | `sysctl net.ipv4.tcp_syncookies` | ☐ |
| `net.ipv4.conf.all.send_redirects` | `0` | `sysctl net.ipv4.conf.all.send_redirects` | ☐ |
| `net.ipv4.conf.default.send_redirects` | `0` | `sysctl net.ipv4.conf.default.send_redirects` | ☐ |
| `net.ipv4.conf.all.accept_source_route` | `0` | `sysctl net.ipv4.conf.all.accept_source_route` | ☐ |
| `net.ipv4.conf.default.accept_source_route` | `0` | `sysctl net.ipv4.conf.default.accept_source_route` | ☐ |
| `net.ipv4.tcp_timestamps` | `0` | `sysctl net.ipv4.tcp_timestamps` | ☐ |

## 📝 **5. Documentation**

### **5.1 Recording Results**

For each system validation, create a record in the format:

```bash
Hostname: <system_name>
Date of Validation: YYYY-MM-DD
Validator: <name_of_validator>
Tool(s) Used: Manual verification, Wazuh scan, OpenSCAP
Results: Pass/Fail
Notes: <any_exceptions_or_issues_identified>
Evidence File: <link_to_captured_output>
```

### **5.2 Handling Non-Compliance**

If non-compliant parameters are identified:

1. Document the specific parameter and its current value
2. Determine if there's a valid exception (check exceptions register)
3. If no valid exception exists:
   a. Update the configuration file with the correct value
   b. Apply the change via `sysctl -p`
   c. Re-validate to confirm the fix
   d. Document the remediation

## 🔄 **6. Periodic Validation**

| **Frequency** | **Validation Type** | **Responsible Role** |
|--------------|---------------------|----------------------|
| **Daily** | Automated Wazuh scan | Security automation |
| **Weekly** | Configuration drift check | Systems Administrator |
| **Quarterly** | Full manual validation | Security Administrator |
| **After Changes** | Targeted validation | Change implementer |

## 📚 **7. References**

- [CIS Benchmarks for Ubuntu 24.04](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [Ubuntu Security Guide - Kernel Hardening](https://ubuntu.com/security/certification/docs/kernel-hardening)
- [NSA Linux Hardening Guide](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_UBUNTU_18-04_V2_R1_SECURITY_TECHNICAL_IMPLEMENTATION_GUIDE.PDF)

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial validation procedure | VintageDon |
