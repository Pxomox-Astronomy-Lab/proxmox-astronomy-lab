<!-- 
---
title: "AppArmor Validation Process"
description: "Step-by-step procedure for validating AppArmor configuration in accordance with CIS Benchmarks for Ubuntu 24.04"
author: "VintageDon"
tags: ["security", "validation", "apparmor", "hardening", "cisv8", "ubuntu"]
category: "Security"
kb_type: "Procedure"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔍 **AppArmor Validation Process**

## 📋 **1. Purpose**

This document outlines the structured process for validating AppArmor configuration on Ubuntu 24.04 servers within the Proxmox Astronomy Lab. The validation ensures all systems maintain compliance with CIS Benchmarks Level 2 requirements for Mandatory Access Control.

This process should be executed:

- After initial system provisioning
- Following system upgrades
- During quarterly security assessments
- After any security-related configuration changes
- When new applications with AppArmor profiles are deployed

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
- System-specific application profile inventory (if any)

## 📊 **3. Validation Procedure**

### **3.1 Verify AppArmor Status**

#### **Step 1: Check if AppArmor is installed and enabled**

```bash
# Check AppArmor status
sudo aa-status

# Verify AppArmor service is enabled and active
sudo systemctl status apparmor
```

Expected results:

- Command should show "apparmor module is loaded"
- Service should show "active (exited)" status
- Service should show "enabled" in the loaded status

#### **Step 2: Verify AppArmor is enforcing**

```bash
# Check detailed status including enforced profiles
sudo apparmor_status

# Verify kernel module parameters
cat /sys/module/apparmor/parameters/enabled
```

Expected results:

- Command should show "Y" for enabled parameter
- Multiple profiles should be listed in "enforce mode"
- Active processes should be listed with profiles

#### **Step 3: Verify Boot Configuration**

```bash
# Check kernel command line parameters
cat /proc/cmdline | grep apparmor
```

Expected results:

- Should show "apparmor=1" and/or "security=apparmor"
- No "apparmor=0" should be present

### **3.2 Verify AppArmor Profiles**

#### **Step 1: Check Profile Configuration Files**

```bash
# List all AppArmor profile files
ls -la /etc/apparmor.d/

# Check for disable directory contents
ls -la /etc/apparmor.d/disable/

# Check for force-complain directory contents
ls -la /etc/apparmor.d/force-complain/
```

Expected results:

- Critical system services should have profile files
- Disable directory should be empty or contain only non-critical application profiles
- Force-complain directory should contain only development/testing profiles

#### **Step 2: Verify Enforced Profiles**

```bash
# List all profiles in enforce mode
sudo aa-status | grep -A9999 "profiles are in enforce mode:" | grep -B9999 "profiles are in complain mode:"

# Check for running processes with enforced profiles
sudo aa-status | grep "processes are in enforce mode"
```

Expected results:

- Critical system services should be listed under "enforce mode"
- Running critical services should show as processes with enforced profiles

#### **Step 3: Verify Critical Service Profiles**

Check that specific CIS-required service profiles are present and enforced:

```bash
# Check for specific service profiles (adjust as needed for installed services)
sudo aa-status | grep -E '(nginx|mysql|postgresql|sshd|chronyd|ntpd|named|lxc|bind)'
```

Expected results:

- Installed critical services should be listed and in enforce mode

### **3.3 Check AppArmor Logs**

#### **Step 1: Review AppArmor Messages in Logs**

```bash
# Check syslog for AppArmor messages
sudo grep -i apparmor /var/log/syslog

# Check authentication log for AppArmor denials
sudo grep -i apparmor /var/log/auth.log
```

Expected results:

- AppArmor initialization messages should be present
- No unexplained repeated denial messages for critical services
- Profile load messages should show successful loads

### **3.4 Automated Verification**

#### **Step 1: Run OpenSCAP Scan**

```bash
# Run OpenSCAP scan with CIS profile
sudo oscap xccdf eval --profile cis_level2 --report apparmor_report.html /usr/share/xml/scap/ssg/content/ssg-ubuntu2404-xccdf.xml
```

Expected results:

- AppArmor-related checks should show as "pass"

## ✅ **4. Validation Criteria**

Use the following table to validate key AppArmor requirements:

| **Component** | **Expected State** | **Validation Command** | **Compliant?** |
|--------------|-------------------|------------------------|----------------|
| AppArmor Module | Loaded | `lsmod \| grep apparmor` | ☐ |
| AppArmor Service | Active & Enabled | `systemctl status apparmor` | ☐ |
| Boot Parameters | Enabled | `cat /proc/cmdline \| grep apparmor` | ☐ |
| Module Parameters | Enabled (Y) | `cat /sys/module/apparmor/parameters/enabled` | ☐ |
| Profiles in Enforce | >20 profiles | `aa-status \| grep "profiles are in enforce mode"` | ☐ |
| Critical Services | Enforced | `aa-status \| grep -E '(chronyd\|rsyslogd)'` | ☐ |
| No AppArmor Failures | No unexpected denials | `grep -i "apparmor.*denied" /var/log/auth.log` | ☐ |

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

If non-compliant AppArmor configurations are identified:

1. Document the specific issue (e.g., AppArmor disabled, missing profiles)
2. Determine if there's a valid exception (check exceptions register)
3. If no valid exception exists:
   a. For disabled AppArmor: Enable the service and update boot parameters
   b. For missing profiles: Install or create required profiles
   c. For complain mode profiles: Transition to enforce mode if appropriate
   d. Re-validate to confirm the fix
   e. Document the remediation

## 🔄 **6. Periodic Validation**

| **Frequency** | **Validation Type** | **Responsible Role** |
|--------------|---------------------|----------------------|
| **Daily** | Automated Wazuh scan | Security automation |
| **Weekly** | AppArmor profile status check | Systems Administrator |
| **Quarterly** | Full manual validation | Security Administrator |
| **After Changes** | Targeted validation | Change implementer |

## 🔎 **7. Troubleshooting Guidelines**

If validation fails, these steps can help identify and resolve issues:

1. **Service Failures**:

   ```bash
   sudo systemctl status apparmor
   sudo journalctl -u apparmor
   ```

2. **Profile Syntax Errors**:

   ```bash
   sudo apparmor_parser -p /etc/apparmor.d/<profile_name>
   ```

3. **Application Compatibility Issues**:

   ```bash
   # Temporarily set profile to complain mode
   sudo aa-complain /path/to/application
   
   # Monitor logs for denied actions
   sudo grep -i "apparmor.*denied" /var/log/syslog
   ```

## 📚 **8. References**

- [CIS Benchmarks for Ubuntu 24.04](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [Ubuntu AppArmor Documentation](https://ubuntu.com/server/docs/security-apparmor)
- [AppArmor Wiki](https://gitlab.com/apparmor/apparmor/-/wikis/home/)

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial validation procedure | VintageDon |
