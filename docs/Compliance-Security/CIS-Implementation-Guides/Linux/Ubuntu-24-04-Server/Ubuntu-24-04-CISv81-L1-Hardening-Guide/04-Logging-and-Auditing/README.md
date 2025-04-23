<!-- 
---
title: "CIS Ubuntu 24.04 L1 Hardening - Logging and Auditing"
description: "Instructions for implementing CIS Level 1 logging and auditing controls for Ubuntu Server 24.04"
author: "VintageDon"
tags: ["hardening", "security", "cisv8", "ubuntu", "logging", "auditing", "auditd"]
category: "Security"
kb_type: "Procedure"
version: "1.1"
status: "Published"
last_updated: "2025-03-16"
---
-->

# **CIS Ubuntu 24.04 L1 Hardening - Logging and Auditing**

## **1. Overview**

### **1.1 Purpose**

This document provides implementation instructions for CIS Level 1 logging and auditing controls for Ubuntu Server 24.04. These configurations establish comprehensive system event recording, creating an audit trail that supports security monitoring, incident investigation, and compliance requirements.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Audit daemon installation and configuration | Advanced audit rule customization |
| System logging service setup | Log forwarding to SIEM systems |
| Log rotation and retention | Log analysis and alerting |
| Basic audit rules implementation | Custom audit reporting |

### **1.3 Target Audience**

This document is intended for System Administrators, Security Engineers, and Compliance Officers responsible for implementing security controls on Ubuntu Server 24.04 systems.

---

## **2. Controls Implementation**

This guide addresses the following CIS Ubuntu 24.04 Level 1 controls:

| **Control ID** | **Description** | **Category** |
|----------------|----------------|--------------|
| 4.1.1 | Ensure auditd is installed | Audit Configuration |
| 4.1.2 | Ensure auditd service is running | Audit Configuration |
| 4.1.3 | Ensure audit logs are not automatically deleted | Audit Configuration |
| 4.2.1 | Ensure system logs are collected | System Logging |
| 4.3.1 | Ensure logrotate is configured | Log Rotation |

### **2.1 Configure auditd**

The audit daemon (auditd) monitors system calls and logs security-relevant events.

#### **2.1.1 Install auditd**

```bash
# Install auditd and audit plugins
apt update
apt install -y auditd audispd-plugins
```

#### **2.1.2 Configure and Enable auditd Service**

```bash
# Enable and start auditd service
systemctl enable auditd
systemctl start auditd
```

#### **2.1.3 Configure Audit Log Retention**

```bash
# Backup the original configuration
cp /etc/audit/auditd.conf /etc/audit/auditd.conf.$(date +%Y%m%d-%H%M%S).bak

# Configure log retention
sed -i 's/^max_log_file_action.*$/max_log_file_action = keep_logs/' /etc/audit/auditd.conf
sed -i 's/^space_left_action.*$/space_left_action = email/' /etc/audit/auditd.conf
sed -i 's/^action_mail_acct.*$/action_mail_acct = root/' /etc/audit/auditd.conf
```

#### **2.1.4 Implement GitHub Best Practice Audit Rules**

The lab implements the Linux Audit Daemon best practice rules published by Florian Roth:

```bash
# Download best practice rules to the proper location
wget https://raw.githubusercontent.com/Neo23x0/auditd/master/audit.rules -O /etc/audit/rules.d/audit.rules

# Load the new rules
augenrules --load
```

### **2.2 Configure System Logging**

Ubuntu 24.04 uses `rsyslog` for system logging by default.

#### **2.2.1 Ensure rsyslog is Installed**

```bash
# Install rsyslog if not already installed
apt update
apt install -y rsyslog
```

#### **2.2.2 Configure and Enable rsyslog Service**

```bash
# Enable and start rsyslog service
systemctl enable rsyslog
systemctl start rsyslog
```

#### **2.2.3 Configure Basic rsyslog Rules**

```bash
# Create basic rsyslog configuration
cat > /etc/rsyslog.d/50-default.conf << EOF
# Log all kernel messages to kern.log
kern.*                                                 /var/log/kern.log

# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none              /var/log/messages

# Log auth messages to auth.log
auth,authpriv.*                                        /var/log/auth.log

# Log all mail messages in one place
mail.*                                                 /var/log/mail.log

# Log cron messages
cron.*                                                 /var/log/cron.log

# Log daemon messages
daemon.*                                               /var/log/daemon.log

# Everybody gets emergency messages
*.emerg                                                :omusrmsg:*

# Save boot messages
local7.*                                               /var/log/boot.log
EOF

# Restart rsyslog to apply changes
systemctl restart rsyslog
```

### **2.3 Configure Log Rotation**

```bash
# Create specific configuration for audit logs
cat > /etc/logrotate.d/auditd << EOF
/var/log/audit/audit.log {
    weekly
    rotate 13
    create 0600 root root
    dateext
    compress
    delaycompress
    missingok
    notifempty
    sharedscripts
    postrotate
        /usr/sbin/service auditd restart >/dev/null 2>&1 || true
    endscript
}
EOF
```

---

## **3. Verification**

### **3.1 Automated Verification Script**

The lab uses a standardized script (`04-CISv81-l1-ubuntu2404-verify-logging.sh`) to verify compliance with CIS logging and auditing controls:

```bash
sudo ./04-CISv81-l1-ubuntu2404-verify-logging.sh
```

The script provides comprehensive validation of all configured parameters, showing output similar to:

```bash
CIS Ubuntu 24.04 Logging and Auditing Controls Verification
===========================================================
Checking auditd installation (4.1.1)...
✅ PASS: 4.1.1 - Audit daemon is installed (auditd is installed)
✅ PASS: 4.1.1 - Audit dispatcher plugins are installed (audispd-plugins is installed)

Checking auditd service status (4.1.2)...
✅ PASS: 4.1.2 - Audit daemon is running and enabled (auditd is active)
✅ PASS: 4.1.2 - Audit daemon is running and enabled (auditd is enabled)

Checking audit log retention settings (4.1.3)...
✅ PASS: 4.1.3 - Audit logs are not automatically deleted (max_log_file_action = keep_logs)
✅ PASS: 4.1.3 - Space left action is set to email (space_left_action = email)
✅ PASS: 4.1.3 - Email notifications sent to root (action_mail_acct = root)

Checking audit rules configuration...
✅ PASS: Audit rules file exists at /etc/audit/rules.d/audit.rules
✅ PASS: Audit rules file contains expected GitHub header
✅ PASS: Audit rules contain auditlog monitoring
✅ PASS: Audit rules contain auditconfig monitoring
✅ PASS: Audit rules contain audittools monitoring

Checking if audit rules are loaded into kernel...
✅ PASS: Audit rules are loaded into kernel (355 rules)

Checking system logging configuration (4.2.1)...
✅ PASS: 4.2.1 - System logging daemon is installed (rsyslog is installed)
✅ PASS: 4.2.1 - System logging daemon is running and enabled (rsyslog is active)
✅ PASS: 4.2.1 - System logging daemon is running and enabled (rsyslog is enabled)
✅ PASS: Log file /var/log/auth.log exists
✅ PASS: Log file /var/log/syslog exists
✅ PASS: Log file /var/log/kern.log exists
⚠️ WARNING: Log file /var/log/messages not found
✅ PASS: 4.2.1 - System logging configuration exists (file /etc/rsyslog.conf exists)
✅ PASS: 4.2.1 - System logging configuration directory exists (directory /etc/rsyslog.d exists)
✅ PASS: Custom rsyslog configuration exists at /etc/rsyslog.d/50-default.conf
✅ PASS: rsyslog configured for kern.*
✅ PASS: rsyslog configured for auth,authpriv.*
✅ PASS: rsyslog configured for mail.*
✅ PASS: rsyslog configured for cron.*
✅ PASS: rsyslog configured for daemon.*
✅ PASS: rsyslog configured for *.emerg

Checking logrotate configuration (4.3.1)...
✅ PASS: 4.3.1 - Log rotation utility is installed (logrotate is installed)
✅ PASS: 4.3.1 - Log rotation configuration exists (file /etc/logrotate.conf exists)
✅ PASS: 4.3.1 - Log rotation configuration directory exists (directory /etc/logrotate.d exists)
✅ PASS: Logrotate has basic configuration settings
✅ PASS: Audit log rotation configuration exists

=== Summary ===
All logging and auditing controls passed!
```

The script checks:

- Audit daemon and plugin installation
- Service status (active and enabled)
- Log retention configuration
- Audit rules from GitHub implementation
- System logging (rsyslog) configuration
- Log rotation setup

### **3.2 Manual Verification**

Audit daemon configuration can be manually verified with:

```bash
# Check audit packages
dpkg -s auditd audispd-plugins | grep Status

# Check audit service
systemctl status auditd

# Check audit configuration
grep -E 'max_log_file_action|space_left_action|action_mail_acct' /etc/audit/auditd.conf

# Check audit rules
auditctl -l | wc -l
```

---

## **4. References and Related Resources**

### **4.1 Related GLPI Items**

| **GLPI Item Type** | **ID** | **Name** | **Relationship** |
|--------------------|-------|----------|-----------------|
| KB Article | KB-SEC-005 | Log Analysis Procedures | Complementary log review guidance |
| Asset | AST-SRV-056 | Production Web Server | Example implementation |
| Service | SVC-SEC-002 | Security Monitoring | Consumes log data |

### **4.2 External References**

| **Reference Type** | **Title** | **Location** |
|--------------------|----------|-------------|
| Documentation | CIS Ubuntu Linux 24.04 LTS Benchmark v1.0.0 | CIS SecureSuite |
| GitHub Repository | Linux Audit Daemon - Best Practice | <https://github.com/Neo23x0/auditd> |
| Article | "Linux auditd: Best Practice Configuration" | Florian Roth's Blog |

### **4.3 Related KB Articles**

| **Article Title** | **Article ID** | **Relationship** |
|-------------------|---------------|-----------------|
| Linux Log Analysis | KB-SEC-005 | Describes log review processes |
| CIS Benchmark Implementation Overview | KB-SEC-001 | Parent framework document |
| Incident Response Procedures | KB-SEC-007 | Uses log data for investigations |

---

## **5. Process Integration**

### **5.1 ITIL Process Relationship**

This implementation relates to the following ITIL processes:

- **Security Management**: Provides audit trail for security incidents
- **Incident Management**: Log data supports incident investigation
- **Problem Management**: Audit logs help identify root causes
- **Compliance Management**: Supports regulatory requirements

### **5.2 Role Responsibilities**

| **Role** | **Responsibility Related to This Article** |
|----------|--------------------------------------------|
| System Administrator | Implementation of logging configuration |
| Security Engineer | Review of audit rules and verification |
| Compliance Officer | Validation against CIS benchmarks |
| Incident Responder | Use of logs during incidents |

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
| 1.1 | 2025-03-16 | Added GitHub audit rules implementation and verification script | VintageDon |
