<!-- 
---
title: "System Hardening - CIS Ubuntu 24.04"
description: "Guide for implementing CIS Ubuntu 24.04 Level 1 system hardening controls"
author: "VintageDon"
tags: ["security", "hardening", "cis", "ubuntu", "apparmor", "compliance"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **System Hardening**

## 🔍 **1. Overview**

This directory contains scripts and documentation for implementing CIS Ubuntu 24.04 Level 1 Benchmark controls related to system hardening. These controls establish a foundational security baseline for Ubuntu 24.04 server systems.

## 📂 **2. Components**

This directory includes the following files:

- **05-authentication-and-authorization.md**: Documentation for user accounts, password policies, and sudo configuration
- **06-system-hardening.md**: Documentation for AppArmor, warning banners, and system updates
- **05-CISv81-l1-ubuntu2404-verify-authentication.sh**: Validation script for authentication controls
- **06-CISv81-l1-ubuntu2404-verify-system-hardening.sh**: Validation script for system hardening controls
- **06-CISv81-l1-ubuntu2404-remediate-system-hardening.sh**: Remediation script for system hardening controls

## 🛠️ **3. System Hardening Controls**

The system hardening scripts implement and validate these key CIS Level 1 controls:

| **Control** | **Description** | **CIS Reference** |
|-------------|----------------|-------------------|
| AppArmor | Mandatory access control framework | CIS 1.6.1, 1.6.2 |
| Warning Banners | Security notices for system access | CIS 1.7.1 - 1.7.5 |
| Update Management | Automated security updates | CIS 1.8.1 |
| Core Dump Restrictions | Prevention of sensitive memory dumps | CIS 1.5.1 |
| Bootloader Security | GRUB configuration protection | CIS 1.4.1, 1.4.2 |
| File Integrity | AIDE configuration and scheduling | CIS 1.3.1, 1.3.2 |
| Bootloader Password | Password protection for GRUB | CIS 1.2.1 |

## 🔧 **4. Using the Scripts**

### **4.1 Validation Script**

Run the system hardening validation script to check your current compliance:

```bash
sudo ./06-CISv81-l1-ubuntu2404-verify-system-hardening.sh
```

### **4.2 Remediation Script**

Apply the system hardening configurations:

```bash
sudo ./06-CISv81-l1-ubuntu2404-remediate-system-hardening.sh
```

**Note**: A system restart is required after running the remediation script for AppArmor changes to take effect.

## ✅ **5. Validation Results**

When properly implemented, the validation script will show all checks as passing:

```bash
====== CIS Ubuntu 24.04 System Hardening Controls Validation ======

=== AppArmor Configuration (CIS 1.6.1, 1.6.2) ===
[PASS] AppArmor packages are installed
[PASS] AppArmor is enabled in GRUB configuration
[PASS] AppArmor module is loaded
[PASS] AppArmor has profiles in enforce mode

=== Warning Banners (CIS 1.7.1 - 1.7.5) ===
[PASS] Message of the day banner exists and has content
[PASS] Login warning banner (/etc/issue) exists and has content
[PASS] Network login warning banner (/etc/issue.net) exists and has content
[PASS] /etc/motd has proper permissions (644) and ownership (root:root)
[PASS] /etc/issue has proper permissions (644) and ownership (root:root)
[PASS] /etc/issue.net has proper permissions (644) and ownership (root:root)

=== Update Management (CIS 1.8.1) ===
[PASS] unattended-upgrades package is installed
[PASS] Security updates are enabled in unattended-upgrades
[PASS] Automatic updates are configured

=== Core Dump Restrictions (CIS 1.5.1) ===
[PASS] Core dumps are restricted in limits.conf
[PASS] systemd core dump storage is properly configured
[PASS] fs.suid_dumpable is set to 0

=== Bootloader Configuration (CIS 1.4.1, 1.4.2) ===
[PASS] GRUB configuration is owned by root:root
[PASS] GRUB configuration has secure permissions

=== AIDE File Integrity Monitoring (CIS 1.3.1, 1.3.2) ===
[PASS] AIDE packages are installed
[PASS] AIDE database exists
[PASS] AIDE is scheduled to run periodically

=== Bootloader Password (CIS 1.2.1) ===
[PASS] GRUB bootloader is password protected

====== System Hardening Controls Summary ======
Total checks: 22
Passed: 22
Failed: 0

All system hardening controls have been properly implemented!
```

## 🧰 **6. Common Remediation Steps**

If you encounter failures in the validation, here are the key remediation steps:

### **AppArmor Configuration**

```bash
sudo apt install -y apparmor apparmor-utils
sudo sed -i 's/^GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor /' /etc/default/grub
sudo update-grub
sudo aa-enforce /etc/apparmor.d/*
```

### **Warning Banners**

```bash
sudo bash -c 'cat > /etc/motd << EOL
**************************************************************************
* This system is for the use of authorized users only.                   *
* Unauthorized access is prohibited.                                     *
**************************************************************************
EOL'
sudo chmod 644 /etc/motd /etc/issue /etc/issue.net
sudo chown root:root /etc/motd /etc/issue /etc/issue.net
```

### **Unattended Upgrades**

```bash
sudo apt install -y unattended-upgrades
sudo sed -i 's|^//\s*"${distro_id}:${distro_codename}-security";|"${distro_id}:${distro_codename}-security";|' /etc/apt/apt.conf.d/50unattended-upgrades
```

### **AIDE Setup**

```bash
sudo apt install -y aide aide-common
echo y | sudo aideinit
sudo cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
```

## 🔗 **7. Additional Resources**

- [CIS Ubuntu Linux 24.04 LTS Benchmark](https://www.cisecurity.org/benchmark/ubuntu_linux)
- [Ubuntu Security Documentation](https://ubuntu.com/security/documentation)
- [AppArmor Documentation](https://gitlab.com/apparmor/apparmor/-/wikis/home)

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |
