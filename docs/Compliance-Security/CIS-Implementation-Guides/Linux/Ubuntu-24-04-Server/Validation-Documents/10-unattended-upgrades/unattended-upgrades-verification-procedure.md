<!-- 
---
title: "Unattended Upgrades Validation Process"
description: "Step-by-step procedure for validating unattended-upgrades configuration on Ubuntu 24.04 servers"
author: "VintageDon"
tags: ["security", "validation", "unattended-upgrades", "patching", "ubuntu"]
category: "Security"
kb_type: "Procedure"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔍 **Unattended Upgrades Validation Process**

## 📋 **1. Purpose**

This document outlines the structured process for validating unattended-upgrades configuration on Ubuntu 24.04 servers within the Proxmox Astronomy Lab. The validation ensures that automated security updates are properly configured to maintain system security without requiring manual intervention.

This process should be executed:

- After initial system provisioning
- Following system upgrades
- During quarterly security assessments
- After any security-related configuration changes
- When troubleshooting update-related issues

## 🛠️ **2. Prerequisites**

### **2.1 Required Access**

| **Requirement** | **Details** |
|----------------|------------|
| **Access Level** | Root or sudo privileges on target system |
| **System Type** | Ubuntu 24.04 Server |
| **Tools** | SSH client, access to system logs |

### **2.2 Required Documentation**

- Security best practices guide
- This validation procedure
- Expected configuration parameters

## 📊 **3. Validation Procedure**

### **3.1 Verify Package Installation**

#### **Step 1: Check if unattended-upgrades is installed**

```bash
# Verify the package is installed
dpkg -s unattended-upgrades

# Check the current installed version
dpkg -s unattended-upgrades | grep Version
```

Expected results:

- Package status should be "install ok installed"
- Version should be current (at least 2.9.1+nmu4ubuntu1 for Ubuntu 24.04)

### **3.2 Verify Service Status**

#### **Step 1: Check if the unattended-upgrades service is enabled**

```bash
# Check service status
systemctl status unattended-upgrades

# Verify the service is enabled to start at boot
systemctl is-enabled unattended-upgrades
```

Expected results:

- Service should be "active"
- Service should be "enabled"

#### **Step 2: Check timer status**

```bash
# Check apt daily timer status
systemctl status apt-daily.timer

# Check apt daily upgrade timer status
systemctl status apt-daily-upgrade.timer
```

Expected results:

- Timers should be "active"
- Next trigger time should be displayed

### **3.3 Verify Configuration Files**

#### **Step 1: Check auto-upgrades configuration**

```bash
# Verify the periodic update configuration
cat /etc/apt/apt.conf.d/20auto-upgrades
```

Expected results:

- Should contain `APT::Periodic::Update-Package-Lists "1";`
- Should contain `APT::Periodic::Unattended-Upgrade "1";`

#### **Step 2: Check unattended-upgrades configuration**

```bash
# Verify the unattended-upgrades configuration
cat /etc/apt/apt.conf.d/50unattended-upgrades
```

Expected results:

- Should enable Ubuntu security updates (`${distro_id}:${distro_codename}-security`)
- Should have appropriate blacklist/whitelist settings
- Should have appropriate reboot settings defined

#### **Step 3: Check update schedule settings**

```bash
# Check periodic update settings
cat /etc/apt/apt.conf.d/10periodic
```

Expected results:

- Should contain appropriate settings for update frequency

### **3.4 Verify Update History**

#### **Step 1: Check unattended-upgrades logs**

```bash
# Check for recent unattended upgrade activity
grep "Unattended-Upgrade" /var/log/unattended-upgrades/unattended-upgrades.log

# Check system package update history
grep "Unattended-Upgrade" /var/log/apt/history.log
```

Expected results:

- Should see evidence of regular update checks
- Should see successful update installations if updates were available

### **3.5 Verify Functional Operation**

#### **Step 1: Run a dry-run to test configuration**

```bash
# Perform a dry run of unattended-upgrades with debugging
sudo unattended-upgrade --dry-run --debug
```

Expected results:

- Should show available updates without actually installing them
- Should not show configuration errors

#### **Step 2: Check for any held packages that might block updates**

```bash
# Check for held packages
apt-mark showhold
```

Expected results:

- Should not show any critical packages on hold unless specifically intended

## ✅ **4. Validation Criteria**

Use the following table to validate key unattended-upgrades requirements:

| **Component** | **Expected State** | **Validation Command** | **Compliant?** |
|--------------|-------------------|------------------------|----------------|
| Package Installation | Installed | `dpkg -s unattended-upgrades` | ☐ |
| Service Status | Active & Enabled | `systemctl status unattended-upgrades` | ☐ |
| Daily Update Timer | Active & Enabled | `systemctl status apt-daily.timer` | ☐ |
| Daily Upgrade Timer | Active & Enabled | `systemctl status apt-daily-upgrade.timer` | ☐ |
| Periodic Updates | Configured (value=1) | `cat /etc/apt/apt.conf.d/20auto-upgrades` | ☐ |
| Security Repositories | Enabled | `cat /etc/apt/apt.conf.d/50unattended-upgrades` | ☐ |
| Update History | Evidence of activity | `grep "Unattended-Upgrade" /var/log/apt/history.log` | ☐ |

## 📝 **5. Documentation**

### **5.1 Recording Results**

For each system validation, create a record in the format:

```bash
Hostname: <system_name>
Date of Validation: YYYY-MM-DD
Validator: <name_of_validator>
Tool(s) Used: Manual verification
Results: Pass/Fail
Notes: <any_exceptions_or_issues_identified>
Evidence File: <link_to_captured_output>
```

### **5.2 Handling Non-Compliance**

If non-compliant configurations are identified:

1. Document the specific issue (e.g., service not running, incorrect configuration)
2. Determine if there's a valid exception
3. If no valid exception exists:
   a. For missing package: Install unattended-upgrades via Ansible
   b. For service issues: Enable and start the service
   c. For configuration issues: Deploy correct configuration files
   d. Re-validate to confirm the fix
   e. Document the remediation

## 🔄 **6. Periodic Validation**

| **Frequency** | **Validation Type** | **Responsible Role** |
|--------------|---------------------|----------------------|
| **Daily** | Automated service check | Security automation |
| **Weekly** | Log review for update activity | Systems Administrator |
| **Monthly** | Configuration verification | Security Administrator |
| **After Changes** | Targeted validation | Change implementer |

## 🔎 **7. Troubleshooting Guidelines**

If validation fails, these steps can help identify and resolve issues:

1. **Service Failures**:

   ```bash
   sudo systemctl status unattended-upgrades
   sudo journalctl -u unattended-upgrades
   sudo systemctl restart unattended-upgrades
   ```

2. **Configuration Errors**:

   ```bash
   sudo unattended-upgrade --dry-run --debug
   ```

3. **Package Issues**:

   ```bash
   sudo apt update
   sudo apt install --reinstall unattended-upgrades
   ```

4. **Timer Problems**:

   ```bash
   sudo systemctl restart apt-daily.timer
   sudo systemctl restart apt-daily-upgrade.timer
   ```

## 📚 **8. References**

- [Ubuntu Automatic Updates Documentation](https://ubuntu.com/server/docs/package-management#automatic-updates)
- [Unattended-Upgrades GitHub Repository](https://github.com/mvo5/unattended-upgrades)
- [Debian Wiki - UnattendedUpgrades](https://wiki.debian.org/UnattendedUpgrades)

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial validation procedure | VintageDon |
