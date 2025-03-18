<!-- 
---
title: "Fail2ban Validation Process"
description: "Step-by-step procedure for validating Fail2ban intrusion prevention configuration on Ubuntu 24.04 servers"
author: "VintageDon"
tags: ["security", "validation", "fail2ban", "intrusion-prevention", "ubuntu"]
category: "Security"
kb_type: "Procedure"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔍 **Fail2ban Validation Process**

## 📋 **1. Purpose**

This document outlines the structured process for validating Fail2ban configuration on Ubuntu 24.04 servers within the Proxmox Astronomy Lab. The validation ensures that intrusion prevention measures are properly implemented to protect critical services from brute force and other persistent attacks.

This process should be executed:

- After initial system provisioning
- Following system upgrades
- During quarterly security assessments
- After any security-related configuration changes
- When new services that require Fail2ban protection are deployed

## 🛠️ **2. Prerequisites**

### **2.1 Required Access**

| **Requirement** | **Details** |
|----------------|------------|
| **Access Level** | Root or sudo privileges on target system |
| **System Type** | Ubuntu 24.04 Server |
| **Tools** | SSH client, iptables knowledge |

### **2.2 Required Documentation**

- Security best practices guide
- This validation procedure
- System-specific service inventory

## 📊 **3. Validation Procedure**

### **3.1 Verify Fail2ban Installation**

#### **Step 1: Check if Fail2ban is installed**

```bash
# Verify package installation
dpkg -s fail2ban

# Check version information
fail2ban-client --version
```

Expected results:

- Command should show package status as "install ok installed"
- Version should match the expected version (currently 1.0.2-3ubuntu0.1)

#### **Step 2: Verify Fail2ban service status**

```bash
# Check service status
systemctl status fail2ban

# Verify service is enabled at boot
systemctl is-enabled fail2ban
```

Expected results:

- Service should be "active (running)"
- Service should be "enabled"

### **3.2 Verify Fail2ban Configuration**

#### **Step 1: Check configuration files**

```bash
# List Fail2ban configuration files
ls -la /etc/fail2ban/

# Check for custom configuration
cat /etc/fail2ban/jail.local

# Check jail.d directory for additional configurations
ls -la /etc/fail2ban/jail.d/
```

Expected results:

- jail.local file should exist with customized settings
- jail.d directory should contain service-specific configurations

#### **Step 2: Verify jail configurations**

```bash
# List all active jails
fail2ban-client status

# Check details for SSH jail
fail2ban-client status sshd

# Check for other critical service jails based on installed services
fail2ban-client status apache-auth # If Apache is installed
fail2ban-client status nginx-http-auth # If Nginx is installed
```

Expected results:

- SSH jail should be active
- Service-specific jails should be active for installed services

#### **Step 3: Verify filter definitions**

```bash
# Check filter definitions directory
ls -la /etc/fail2ban/filter.d/

# Verify SSH filter configuration
cat /etc/fail2ban/filter.d/sshd.conf

# Check log path configurations
grep "logpath" /etc/fail2ban/jail.d/* /etc/fail2ban/jail.local
```

Expected results:

- Filter definitions should exist for all activated jails
- Log paths should be correctly configured for the system

### **3.3 Verify Firewall Rules**

#### **Step 1: Check if Fail2ban rules are in the firewall**

```bash
# Verify Fail2ban chains exist in iptables
iptables -L -n | grep fail2ban

# Check for any currently banned IPs
iptables -L -n | grep REJECT
```

Expected results:

- Fail2ban chains should be present in iptables
- Any active bans should show as REJECT or DROP rules

### **3.4 Verify Logging and Monitoring**

#### **Step 1: Check Fail2ban logs**

```bash
# Check system logs for Fail2ban entries
grep "fail2ban" /var/log/syslog | tail -n 20

# Check for ban actions
grep "Ban" /var/log/fail2ban.log
```

Expected results:

- Log entries should show Fail2ban startup and operation
- Ban/unban actions should be recorded if any attacks occurred

#### **Step 2: Verify log rotation**

```bash
# Check log rotation configuration
cat /etc/logrotate.d/fail2ban
```

Expected results:

- Log rotation should be properly configured

### **3.5 Configuration Syntax Check**

```bash
# Verify configuration syntax
fail2ban-client -d
```

Expected results:

- No syntax errors should be reported

## ✅ **4. Validation Criteria**

Use the following table to validate key Fail2ban requirements:

| **Component** | **Expected State** | **Validation Command** | **Compliant?** |
|--------------|-------------------|------------------------|----------------|
| Fail2ban Package | Installed | `dpkg -s fail2ban` | ☐ |
| Fail2ban Service | Active & Enabled | `systemctl status fail2ban` | ☐ |
| Custom Configuration | Present | `cat /etc/fail2ban/jail.local` | ☐ |
| SSH Jail | Enabled | `fail2ban-client status sshd` | ☐ |
| Firewall Rules | Present | `iptables -L -n \| grep fail2ban` | ☐ |
| Log Configuration | Proper paths | `grep "logpath" /etc/fail2ban/jail.local` | ☐ |
| Syntax Check | No errors | `fail2ban-client -d` | ☐ |

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

If non-compliant Fail2ban configurations are identified:

1. Document the specific issue (e.g., service not running, missing jails)
2. Determine if there's a valid exception
3. If no valid exception exists:
   a. For missing package: Install Fail2ban via Ansible
   b. For service issues: Troubleshoot service startup
   c. For missing jails: Add appropriate jail configurations
   d. Re-validate to confirm the fix
   e. Document the remediation

## 🔄 **6. Periodic Validation**

| **Frequency** | **Validation Type** | **Responsible Role** |
|--------------|---------------------|----------------------|
| **Daily** | Automated service check | Security automation |
| **Weekly** | Log review for ban activity | Systems Administrator |
| **Monthly** | Full jail configuration verification | Security Administrator |
| **After Changes** | Targeted validation | Change implementer |

## 🔎 **7. Troubleshooting Guidelines**

If validation fails, these steps can help identify and resolve issues:

1. **Service Failures**:

   ```bash
   sudo systemctl status fail2ban
   sudo journalctl -u fail2ban
   ```

2. **Configuration Errors**:

   ```bash
   sudo fail2ban-client -d
   sudo fail2ban-client -t
   ```

3. **Firewall Issues**:

   ```bash
   sudo iptables -L -n
   sudo fail2ban-client reload
   ```

4. **Log File Permission Issues**:

   ```bash
   sudo ls -la /var/log/auth.log
   sudo chmod 640 /var/log/auth.log
   ```

## 📚 **8. References**

- [Fail2ban Official Documentation](https://www.fail2ban.org/wiki/index.php/Main_Page)
- [Ubuntu Security Guide - Intrusion Prevention](https://ubuntu.com/server/docs/security-intrusion-detection)
- [Fail2ban GitHub Repository](https://github.com/fail2ban/fail2ban)

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial validation procedure | VintageDon |
