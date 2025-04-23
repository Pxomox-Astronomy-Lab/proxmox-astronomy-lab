<!-- 
---
title: "Unattended Upgrades - Proxmox Astronomy Lab"
description: "Documentation of automated security updates configuration in accordance with security best practices for Ubuntu 24.04 Server"
author: "VintageDon"
tags: ["security", "patching", "unattended-upgrades", "updates", "ubuntu"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔄 **Unattended Upgrades**

## 🔍 **1. Overview**

This document details the **unattended-upgrades configuration** implemented across all Linux systems in the Proxmox Astronomy Lab. Automated security updates are a critical component of our defense-in-depth strategy, ensuring that systems are promptly patched against known vulnerabilities without requiring manual intervention.

Our unattended-upgrades implementation:

- Automatically installs **security updates** from Ubuntu repositories
- Maintains a **controlled update schedule** to minimize service disruption
- Includes **safeguards** to prevent problematic updates
- Aligns with **security best practices** for server management
- Ensures **consistent patching** across all infrastructure components

---

## 📊 **2. Implementation Details**

### **2.1 Package Configuration**

Unattended-upgrades is deployed with the following configuration:

| **Component** | **Status** | **Verification Method** |
|--------------|------------|-------------------------|
| unattended-upgrades Package | Installed (v2.9.1+nmu4ubuntu1) | `dpkg -s unattended-upgrades` |
| Service Status | Active & Enabled | `systemctl status unattended-upgrades` |
| Daily Update Timer | Active & Enabled | `systemctl status apt-daily.timer` |
| Daily Upgrade Timer | Active & Enabled | `systemctl status apt-daily-upgrade.timer` |

### **2.2 Update Sources**

The system is configured to automatically install updates from specific repositories:

| **Repository** | **Status** | **Purpose** |
|----------------|-----------|-------------|
| Main Ubuntu Updates | Enabled | `${distro_id}:${distro_codename}` |
| Security Updates | Enabled | `${distro_id}:${distro_codename}-security` |
| ESM Apps Security | Enabled | `${distro_id}ESMApps:${distro_codename}-apps-security` |
| ESM Infra Security | Enabled | `${distro_id}ESM:${distro_codename}-infra-security` |
| Regular Updates | Disabled | Non-security feature updates |
| Proposed Updates | Disabled | Pre-release updates |
| Backports | Disabled | Newer package versions |

This configuration ensures that only security updates are applied automatically, minimizing the risk of unintended consequences from non-security updates.

---

## 🛠️ **3. Configuration Details**

### **3.1 Update Schedule**

Updates are scheduled according to the following parameters:

| **Process** | **Schedule** | **Configuration** |
|-------------|------------|-------------------|
| Package List Update | Daily | `APT::Periodic::Update-Package-Lists "1"` |
| Security Update Download | Daily | `APT::Periodic::Download-Upgradeable-Packages "0"` |
| Security Update Installation | Daily | `APT::Periodic::Unattended-Upgrade "1"` |
| System Cleanup | Disabled | `APT::Periodic::AutocleanInterval "0"` |

### **3.2 Advanced Configuration**

Several additional parameters control update behavior:

| **Parameter** | **Setting** | **Purpose** |
|---------------|------------|-------------|
| Blacklisted Packages | None | No packages excluded from updates |
| Automatic Reboot | Disabled | `Unattended-Upgrade::Automatic-Reboot "false"` |
| Dependency Handling | Default | Allows new dependencies from security updates |
| Failed Update Recovery | Enabled | Automatic recovery of interrupted updates |
| Verbose Logging | Disabled | Standard logging level |

---

## 🔄 **4. Management Procedures**

### **4.1 Monitoring Update Activity**

Update activities are monitored through:

| **Method** | **Purpose** | **Location** |
|------------|------------|--------------|
| System Logs | Record update activity | `/var/log/apt/history.log` |
| Unattended-Upgrades Log | Detailed update information | `/var/log/unattended-upgrades/` |
| Email Notifications | Alert on errors | Configured in `/etc/apt/apt.conf.d/50unattended-upgrades` |
| SIEM Integration | Centralized monitoring | Wazuh alerts for update failures |

### **4.2 Manual Intervention Scenarios**

In certain situations, manual intervention may be required:

| **Scenario** | **Detection Method** | **Action Required** |
|--------------|---------------------|---------------------|
| Failed Updates | Log review or SIEM alert | Investigate and manually update |
| Configuration Changes | Configuration review | Deploy via Ansible for consistency |
| Critical Patches | Security bulletins | Force immediate update via `unattended-upgrade --debug` |
| Package Holds | Package status check | Review and adjust hold status as needed |

---

## 📝 **5. Customization Guidelines**

### **5.1 Configuration Adjustments**

To modify the unattended-upgrades behavior:

1. Edit configuration via Ansible templates
2. Update the following files:
   - `/etc/apt/apt.conf.d/20auto-upgrades` - Controls update frequency
   - `/etc/apt/apt.conf.d/50unattended-upgrades` - Controls update behavior
3. Deploy changes through configuration management
4. Verify changes with validation process

### **5.2 Recommended Settings**

| **Requirement** | **Recommended Configuration** | **Rationale** |
|-----------------|---------------------------|---------------|
| High-availability systems | Disable auto-reboot | Prevent unexpected downtime |
| Development systems | Enable backports | Allow access to newer package versions |
| Production systems | Security updates only | Minimize unplanned changes |
| Mission-critical | Email notifications | Ensure awareness of any update issues |

---

## 🔎 **6. Troubleshooting**

| **Issue** | **Verification Command** | **Resolution** |
|-----------|-------------------------|----------------|
| Updates not running | `systemctl status apt-daily.timer` | Ensure timer is enabled and active |
| Configuration issues | `unattended-upgrades --dry-run --debug` | Review and correct configuration files |
| Failed updates | `grep "Error" /var/log/unattended-upgrades/unattended-upgrades.log` | Manually resolve package conflicts |
| Unexpected behavior | `cat /etc/apt/apt.conf.d/50unattended-upgrades` | Verify correct configuration parameters |

---

## 🔗 **7. Validation**

For specific validation procedures and evidence of implementation, see:

- [Unattended-Upgrades Validation Process](validation-process.md)
- [Unattended-Upgrades Implementation Evidence](validation-output.md)

---

## 📚 **8. Additional Resources**

- [Ubuntu Automatic Updates Documentation](https://ubuntu.com/server/docs/package-management#automatic-updates)
- [Unattended-Upgrades GitHub Repository](https://github.com/mvo5/unattended-upgrades)
- [Debian Wiki - UnattendedUpgrades](https://wiki.debian.org/UnattendedUpgrades)

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
