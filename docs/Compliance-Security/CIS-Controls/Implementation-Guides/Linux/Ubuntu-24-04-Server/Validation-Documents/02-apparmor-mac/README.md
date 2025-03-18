<!-- 
---
title: "AppArmor Configuration - Proxmox Astronomy Lab"
description: "Documentation of AppArmor Mandatory Access Control implementation in accordance with CIS Benchmarks for Ubuntu 24.04 Server"
author: "VintageDon"
tags: ["security", "hardening", "apparmor", "mac", "cisv8", "ubuntu"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **AppArmor Configuration**

## 🔍 **1. Overview**

This document details the **AppArmor Mandatory Access Control (MAC)** implementation across all Linux systems in the Proxmox Astronomy Lab. AppArmor provides fine-grained control over application capabilities, reducing the attack surface and limiting potential damage from compromised applications.

Our AppArmor implementation:

- Aligns with **CIS Benchmarks for Ubuntu 24.04 Server Level 2** requirements
- Provides **defense-in-depth** through application confinement
- Uses **enforce mode** for critical system services
- Is **automatically deployed** via Ansible during system provisioning

This document serves as a reference for understanding the lab's AppArmor implementation, configuration standards, and management processes.

---

## 📊 **2. AppArmor Framework Implementation**

### **2.1 Deployment Status**

AppArmor is deployed with the following characteristics:

| **Parameter** | **Status** | **CIS Requirement** | **Verification Method** |
|--------------|------------|---------------------|-------------------------|
| AppArmor Module | Loaded | L1 | `aa-status`, `lsmod \| grep apparmor` |
| Boot Configuration | Enabled | L1 | Kernel parameter `apparmor=1 security=apparmor` |
| Enforcement Mode | Enforcing | L1 | `apparmor_status`, `/sys/module/apparmor/parameters/enabled` |
| Profile Management | systemd-integrated | Best Practice | `systemctl status apparmor` |

### **2.2 Profile Management Approach**

AppArmor profiles are managed using a structured approach:

| **Management Method** | **Description** | **Responsibility** |
|----------------------|-----------------|-------------------|
| **Base Profiles** | Default Ubuntu-provided profiles | Ubuntu Security Team |
| **Custom Profiles** | Lab-specific application profiles | Security Administrator |
| **Profile Updates** | Regular updates via apt | Automated via Ansible |
| **Profile Deployment** | Centralized deployment | Configuration Management |

---

## 🛠️ **3. Enforced Profiles**

### **3.1 System Service Profiles**

The following critical system services have enforced AppArmor profiles:

| **Service** | **Profile Location** | **Purpose** |
|-------------|----------------------|-------------|
| **chronyd** | `/etc/apparmor.d/usr.sbin.chronyd` | Time synchronization service |
| **rsyslogd** | `/etc/apparmor.d/usr.sbin.rsyslogd` | System logging |
| **snapd** | `/etc/apparmor.d/usr.lib.snapd.snap-confine.real` | Containerized application manager |
| **man** | `/etc/apparmor.d/usr.bin.man` | Manual page viewer |
| **tcpdump** | `/etc/apparmor.d/usr.bin.tcpdump` | Network packet analyzer |

### **3.2 Custom Application Profiles**

Additional custom profiles are configured for lab-specific applications:

| **Application Type** | **Profile Count** | **Examples** |
|----------------------|-------------------|--------------|
| Network Services | 5+ | `bind`, `nginx` (when installed) |
| Database Services | 3+ | `postgresql`, `mysql` (when installed) |
| Container Technologies | 10+ | `lxc-*` commands, `unprivileged_userns` |
| System Utilities | 5+ | `unix-chkpwd`, `nvidia_modprobe` |

### **3.3 Complain Mode Profiles**

A limited set of profiles operate in complain mode for development and testing:

| **Application** | **Purpose** | **Transition Plan** |
|-----------------|-------------|---------------------|
| `transmission-*` | BitTorrent client | Scheduled for enforce mode after testing |

---

## 🔄 **4. Management Procedures**

### **4.1 Profile Development Life Cycle**

New AppArmor profiles follow this development cycle:

1. **Initial Deployment** - Profile created in complain mode
2. **Log Analysis** - Application behavior studied via audit logs
3. **Profile Refinement** - Access requirements incorporated
4. **Testing** - Profile tested in complain mode
5. **Enforcement** - Profile transitioned to enforce mode
6. **Monitoring** - Ongoing monitoring for issues

### **4.2 Profile Updates**

| **Update Type** | **Frequency** | **Process** |
|-----------------|--------------|-------------|
| Security Updates | As released | Automatic via unattended-upgrades |
| Custom Profiles | As needed | Change management process |
| Profile Generation | Application deployment | Part of application deployment playbook |

---

## 📝 **5. Monitoring and Compliance**

### **5.1 Verification Methods**

AppArmor compliance is verified through:

- **Daily automated compliance scans** via Wazuh + OpenSCAP
- **Quarterly manual verification** using `aa-status`
- **System boot-time validation** checks
- **Log monitoring** for AppArmor rejections and alerts

### **5.2 Integration with SIEM**

AppArmor events are centrally monitored via:

| **Log Source** | **Event Types** | **Alerts** |
|----------------|----------------|------------|
| `/var/log/syslog` | Profile loads, status changes | Critical for detected state changes |
| `/var/log/auth.log` | Access denials | Medium/High for unexpected denials |
| Kernel audit logs | Detailed violation information | High for repeated violations |

---

## 🔎 **6. Troubleshooting**

### **6.1 Common Issues**

| **Issue** | **Symptoms** | **Resolution** |
|-----------|-------------|----------------|
| Application failures | Access denied messages in logs | Review and update profile permissions |
| Profile syntax errors | Failed profile loading | Validate profile syntax with `apparmor_parser -p` |
| Incompatible applications | Repeated access violations | Consider custom profile or complain mode |

### **6.2 Adjusting Profiles**

For troubleshooting application issues:

1. **Identify** - Use `aa-status` to verify profile status
2. **Analyze** - Check logs for denial messages
3. **Test** - Temporarily set to complain mode with `aa-complain`
4. **Update** - Modify profile based on observed behavior
5. **Verify** - Return to enforce mode with `aa-enforce`

---

## 🔗 **7. Validation**

For specific validation procedures and evidence of implementation, see:

- [AppArmor Validation Process](validation-process.md)
- [AppArmor Implementation Evidence](validation-output.md)

---

## 📚 **8. Additional Resources**

- [Ubuntu AppArmor Documentation](https://ubuntu.com/server/docs/security-apparmor)
- [CIS Benchmarks for Ubuntu 24.04](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [AppArmor Wiki](https://gitlab.com/apparmor/apparmor/-/wikis/home/)
- [AppArmor Profile Development](https://gitlab.com/apparmor/apparmor/-/wikis/ProfileDevelopment)

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
