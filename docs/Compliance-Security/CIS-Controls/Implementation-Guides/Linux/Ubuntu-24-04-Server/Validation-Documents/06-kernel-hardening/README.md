<!-- 
---
title: "Kernel Hardening Controls - Proxmox Astronomy Lab"
description: "Documentation of kernel hardening controls implemented in accordance with CIS Benchmarks for Ubuntu 24.04 Server"
author: "VintageDon"
tags: ["security", "hardening", "kernel", "sysctl", "cisv8", "ubuntu"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **Kernel Hardening Controls**

## 🔍 **1. Overview**

This document details the **kernel hardening controls** implemented across all Linux systems in the Proxmox Astronomy Lab. These controls align with **CIS Benchmarks for Ubuntu 24.04 Server Level 2** requirements and provide defense-in-depth against various kernel-level attack vectors.

Proper kernel parameter configuration is critical for system security as it:

- **Prevents information leakage** from kernel memory
- **Protects against memory-based attacks** such as buffer overflows
- **Prevents IP and routing-based attacks**
- **Restricts dangerous system capabilities**
- **Enables security logging** for suspicious activities

The following controls are automatically deployed via Ansible during system provisioning and verified through regular compliance scanning.

---

## 📊 **2. Implemented Kernel Controls**

### **2.1 Memory Protection Controls**

The following sysctl parameters enhance memory protection:

| **Parameter** | **Value** | **CIS Requirement** | **Purpose** |
|--------------|-----------|---------------------|-------------|
| `kernel.randomize_va_space` | `2` | L1 | Enables full address space layout randomization (ASLR) |
| `fs.suid_dumpable` | `0` | L1 | Prevents unauthorized core dumps from setuid programs |
| `kernel.kptr_restrict` | `2` | L2 | Hides kernel pointer addresses in /proc (maximum protection) |

### **2.2 System Capability Restrictions**

These parameters restrict potentially dangerous system capabilities:

| **Parameter** | **Value** | **CIS Requirement** | **Purpose** |
|--------------|-----------|---------------------|-------------|
| `kernel.dmesg_restrict` | `1` | L1 | Restricts access to kernel logs to privileged users |
| `kernel.sysrq` | `0` | L1 | Disables magic SysRq key functions |
| `dev.tty.ldisc_autoload` | `0` | L2 | Prevents auto-loading TTY line disciplines |
| `dev.tty.legacy_tiocsti` | `0` | L2 | Disables legacy TIOCSTI TTY command |

### **2.3 Network Security Controls**

These controls enhance network-level security:

| **Parameter** | **Value** | **CIS Requirement** | **Purpose** |
|--------------|-----------|---------------------|-------------|
| `net.ipv4.conf.all.accept_redirects` | `0` | L1 | Disables ICMP redirects to prevent MITM attacks |
| `net.ipv4.conf.default.accept_redirects` | `0` | L1 | Same as above, but for new interfaces |
| `net.ipv4.conf.all.secure_redirects` | `0` | L1 | Disables "secure" ICMP redirects |
| `net.ipv4.conf.default.secure_redirects` | `0` | L1 | Same as above, but for new interfaces |
| `net.ipv4.conf.all.log_martians` | `1` | L1 | Logs packets with impossible source addresses |
| `net.ipv4.conf.default.log_martians` | `1` | L1 | Same as above, but for new interfaces |
| `net.ipv4.conf.all.rp_filter` | `1` | L1 | Enables reverse path filtering |
| `net.ipv4.conf.default.rp_filter` | `1` | L1 | Same as above, but for new interfaces |
| `net.ipv4.tcp_syncookies` | `1` | L1 | Protects against SYN flood attacks |
| `net.ipv4.conf.all.send_redirects` | `0` | L1 | Prevents system from sending ICMP redirects |
| `net.ipv4.conf.default.send_redirects` | `0` | L1 | Same as above, but for new interfaces |
| `net.ipv4.conf.all.accept_source_route` | `0` | L1 | Disables IPv4 source routing |
| `net.ipv4.conf.default.accept_source_route` | `0` | L1 | Same as above, but for new interfaces |
| `net.ipv4.tcp_timestamps` | `0` | L2 | Disables TCP timestamps to prevent fingerprinting |

### **2.4 Additional Filesystem Protection**

These parameters provide additional filesystem security:

| **Parameter** | **Value** | **CIS Requirement** | **Purpose** |
|--------------|-----------|---------------------|-------------|
| `fs.protected_fifos` | `1` | L1 | Protects against FIFO races |
| `fs.protected_hardlinks` | `1` | L1 | Prevents creating hardlinks to files not owned by the user |
| `fs.protected_symlinks` | `1` | L1 | Prevents following symlinks not owned by the user |
| `fs.protected_regular` | `2` | L2 | Highest protection for regular files |

---

## 🛠️ **3. Implementation Method**

### **3.1 Automated Deployment**

Kernel parameters are configured via:

1. **Ansible Playbooks** - Automated configuration management
2. **sysctl.d Configuration** - Persistent configuration in `/etc/sysctl.d/99-cis-kernel.conf`
3. **Boot Parameters** - Kernel command line parameters where required

### **3.2 Verification Process**

These controls are verified through:

- **Daily automated compliance scans** via Wazuh + OpenSCAP
- **Quarterly manual verification** using `sysctl -a`
- **System boot-time validation** checks

---

## 🔄 **4. Troubleshooting**

| **Issue** | **Possible Cause** | **Resolution** |
|-----------|-------------------|----------------|
| **Parameters not applied after reboot** | Config file ordering issue | Verify parameter in `/etc/sysctl.d/99-cis-kernel.conf` has higher precedence |
| **Application compatibility issues** | Strict security parameters | Review `/var/log/syslog` for issues and consider parameter adjustment |
| **Inconsistent parameter application** | Manual changes | Run Ansible playbook to enforce configuration |

---

## 🔎 **5. Validation**

For specific validation procedures and evidence of implementation, see:

- [Kernel Hardening Validation Process](validation-process.md)
- [Kernel Hardening Implementation Evidence](validation-output.md)

---

## 📚 **6. Additional Resources**

- [CIS Benchmarks for Ubuntu 24.04](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [Linux Kernel Documentation - sysctl](https://www.kernel.org/doc/Documentation/sysctl/)
- [NSA Hardening Guide for Linux](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_UBUNTU_18-04_V2_R1_SECURITY_TECHNICAL_IMPLEMENTATION_GUIDE.PDF)

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
