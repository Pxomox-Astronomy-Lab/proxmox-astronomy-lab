<!-- 
---
title: "Fail2ban Configuration - Proxmox Astronomy Lab"
description: "Documentation of Fail2ban implementation for intrusion prevention in accordance with security best practices for Ubuntu 24.04 Server"
author: "VintageDon"
tags: ["security", "intrusion-prevention", "fail2ban", "hardening", "ubuntu"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **Fail2ban Configuration**

## 🔍 **1. Overview**

This document details the **Fail2ban intrusion prevention system** implementation across all Linux systems in the Proxmox Astronomy Lab. Fail2ban monitors log files for suspicious activity and dynamically creates firewall rules to block attack sources, significantly enhancing security against brute force and other persistent attack patterns.

Our Fail2ban implementation:

- Provides **active intrusion prevention** against brute force attacks
- Creates **dynamic firewall rules** to block malicious sources
- **Monitors critical services** including SSH, web servers, and authentication systems
- Is **automatically deployed** via Ansible during system provisioning
- Aligns with **security best practices** for server hardening

This document serves as a reference for understanding the lab's Fail2ban implementation, configuration standards, and management processes.

---

## 📊 **2. Implementation Details**

### **2.1 Deployment Status**

Fail2ban is deployed with the following characteristics:

| **Parameter** | **Status** | **Verification Method** |
|--------------|------------|-------------------------|
| Package | Installed (v1.0.2-3ubuntu0.1) | `dpkg -s fail2ban` |
| Service | Active & Enabled | `systemctl status fail2ban` |
| Default Configuration | Customized via jail.local | `/etc/fail2ban/jail.local` |
| Active Jails | SSH and critical services | `fail2ban-client status` |

### **2.2 Jail Configuration Approach**

Fail2ban jails are configured using a structured approach:

| **Configuration Level** | **Purpose** | **File Location** |
|------------------------|-------------|-------------------|
| Default Settings | Base configuration (vendor) | `/etc/fail2ban/jail.conf` |
| Local Overrides | Lab-specific settings | `/etc/fail2ban/jail.local` |
| Service-Specific | Per-service customizations | `/etc/fail2ban/jail.d/*.conf` |

This layered approach ensures both consistency and flexibility in our intrusion prevention configuration.

---

## 🛠️ **3. Protected Services**

### **3.1 Core Service Protection**

The following critical services are protected by Fail2ban:

| **Service** | **Jail Name** | **Purpose** | **Status** |
|-------------|--------------|-------------|------------|
| **SSH** | sshd | Prevent brute force SSH attacks | Enabled |
| **Web Authentication** | apache-auth, nginx-http-auth | Protect web authentication | Enabled when service present |
| **Mail Services** | postfix | Protect mail infrastructure | Enabled when service present |
| **FTP Services** | vsftpd, proftpd | Protect file transfer services | Enabled when service present |

### **3.2 Default Jail Parameters**

The standard configuration applies these defaults across all jails:

| **Parameter** | **Value** | **Purpose** |
|--------------|-----------|-------------|
| bantime | 10 minutes | Duration of IP ban |
| findtime | 10 minutes | Time window for maxretry count |
| maxretry | 5 attempts | Failed attempts before banning |
| banaction | iptables-multiport | Firewall backend for banning |
| destemail | root@localhost | Alert recipient |

### **3.3 Service-Specific Customizations**

Some services have custom parameters to address specific threat patterns:

| **Service** | **Custom Parameters** | **Rationale** |
|-------------|----------------------|---------------|
| SSH | maxretry=3 | Higher security for critical service |
| Web Authentication | bantime=12h | Extended ban for web attacks |
| Recidive | bantime=1w, findtime=1d | Persistent ban for repeat offenders |

---

## 🔄 **4. Management Procedures**

### **4.1 Monitoring and Alerts**

Fail2ban activity is monitored through:

| **Method** | **Purpose** | **Location** |
|------------|------------|--------------|
| System Logs | Record ban/unban events | `/var/log/syslog` |
| Fail2ban Log | Detailed service activity | `/var/log/fail2ban.log` |
| Email Alerts | Notify admins of ban events | Sent to defined destemail |
| SIEM Integration | Centralized security monitoring | Wazuh SIEM |

### **4.2 Maintenance Tasks**

| **Task** | **Frequency** | **Procedure** |
|----------|--------------|---------------|
| Log Rotation | Automatic (weekly) | Managed via `/etc/logrotate.d/fail2ban` |
| Configuration Updates | As needed | Deployed via Ansible, requires change request |
| Rule Verification | Monthly | Review ban activity and rule effectiveness |
| Version Updates | With system updates | Automatic via unattended-upgrades |

---

## 📝 **5. Customization Guidelines**

### **5.1 Adding New Jails**

To protect additional services:

1. Identify log file format and failure patterns
2. Create or customize filter in `/etc/fail2ban/filter.d/`
3. Add jail configuration to `/etc/fail2ban/jail.d/service-name.conf`
4. Test configuration with `fail2ban-client reload`
5. Monitor for false positives

### **5.2 Tuning Recommendations**

| **Scenario** | **Parameter Adjustment** | **Suggested Value** |
|--------------|--------------------------|---------------------|
| High false positives | Increase maxretry | 7-10 attempts |
| Persistent attackers | Increase bantime | 24h-1w |
| Distributed attacks | Implement IP reputation lists | Enable recidive jail |
| Critical services | Decrease maxretry | 2-3 attempts |

---

## 🔎 **6. Troubleshooting**

| **Issue** | **Verification Command** | **Resolution** |
|-----------|-------------------------|----------------|
| Service not starting | `systemctl status fail2ban` | Check config with `fail2ban-client -d` |
| Rules not applying | `iptables -L -n \| grep fail2ban` | Verify file permissions and iptables |
| Log monitoring failures | `fail2ban-regex /path/to/log /etc/fail2ban/filter.d/service.conf` | Update regex patterns in filter |
| False positives | Check server logs for legitimate blocks | Add IP to `ignoreip` parameter |

---

## 🔗 **7. Validation**

For specific validation procedures and evidence of implementation, see:

- [Fail2ban Validation Process](validation-process.md)
- [Fail2ban Implementation Evidence](validation-output.md)

---

## 📚 **8. Additional Resources**

- [Fail2ban Official Documentation](https://www.fail2ban.org/wiki/index.php/Main_Page)
- [Ubuntu Security Guide - Intrusion Prevention](https://ubuntu.com/server/docs/security-intrusion-detection)
- [Fail2ban GitHub Repository](https://github.com/fail2ban/fail2ban)

---

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |
