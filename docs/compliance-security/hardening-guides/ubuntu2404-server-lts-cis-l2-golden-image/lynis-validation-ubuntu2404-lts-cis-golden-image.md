---
title: "Lynis Security Audit - Ubuntu 24.04 Server LTS L2 Golden Image"
description: "Documents the security hardening applied to the Ubuntu 24.04 LTS Golden Image, validated by a Lynis scan score of 87."
author: "VintageDon"
tags: ["CISv8", "Lynis", "Security Benchmark", "Ubuntu 24.04", "Hardened Image"]
category: "Compliance & Security Audits"
kb_type: "Security Report"
version: "1.0"
status: "Final"
last_updated: "2025-03-04"
---

# **📜 Lynis Security Audit - Ubuntu 24.04 Server LTS L2 Golden Image**

## **1. Purpose & Scope**  

### **🔹 Purpose**  

The purpose of this validation is to:  
✅ **Verify** that the Ubuntu 24.04 LTS golden image meets **CISv8 Level 2 benchmarks**.  
✅ **Demonstrate** the system's **security hardening without impacting functionality**.  
✅ **Ensure consistency** across all **Linux-based virtual machines (VMs)** deployed in the lab.  

### **🔹 Scope**  

This validation applies to:  

| **Category**               | **Description** |
|----------------------------|----------------|
| **Target System**          | Ubuntu 24.04 LTS (CIS L2 Hardened) |
| **Environments Covered**   | Proxmox-based VM templates, Kubernetes nodes, standalone servers |
| **Security Benchmark**     | CISv8 Level 2, NIST 800-53, ISO 27001 |

---

## **2. Compliance Mapping**  

This audit aligns with **industry security frameworks** ensuring security compliance:  

| **Framework**    | **Control Mapping** |  
|-----------------|---------------------|  
| **CISv8**       | - CIS Control 4: Secure Configuration Management  |
|                 | - CIS Control 5: Account Management  |
|                 | - CIS Control 6: Access Control Management  |
| **NIST 800-53** | - CM-6: Baseline Configuration  |
|                 | - AU-2: Audit Logging  |
| **ISO 27001**   | - A.12.1: Baseline Security  |
|                 | - A.14.2: System Hardening  |

---

## **3. Security Hardening Summary**  

The **Ubuntu 24.04 LTS Golden Image** incorporates key security controls to **mitigate threats** while maintaining operational efficiency.  

| **Security Feature** | **Implementation** |
|----------------------|--------------------|
| **Audit Logging & System Integrity** | AIDE, auditd, journald enabled |
| **Mandatory Access Control (MAC)** | **AppArmor** enforced |
| **SSH Hardening** | Root login disabled, key-based auth only, Fail2Ban active |
| **Kernel Hardening** | ASLR, NX, StackProtector, sysctl tuning applied |
| **Filesystem & Boot Security** | Noexec, nosuid, nodev enforced on critical mounts |
| **Service & Package Hardening** | No legacy protocols (Telnet, rsh, etc.), minimal packages |
| **Firewall & Network Security** | UFW rules enforced, IPv6 disabled |

These settings **minimize attack surfaces** while keeping the OS fully operational.

---

## **4. Lynis Scan Results - Score: 87/100**  

The **Lynis security audit** was conducted using **Lynis 3.0.9** on the hardened Ubuntu 24.04 golden image.

### **🔹 Scan Summary**  

| **Category**                | **Status** |
|-----------------------------|------------|
| **System Hardening**         | ✅ Secure (No major issues) |
| **User & Authentication**    | ✅ Strong (Root login disabled, MFA enforced) |
| **Filesystem Security**      | ✅ Enforced (Critical partitions hardened) |
| **Network & Firewall**       | ✅ Configured (IPv6 disabled, UFW active) |
| **Kernel & Process Security**| ✅ Secure (Sysctl hardened, ASLR enforced) |
| **Logging & Monitoring**     | ✅ Active (auditd, journald, logrotate enabled) |
| **Malware & Intrusion Detection** | ✅ Installed (Fail2Ban, AIDE, chkrootkit, rkhunter) |

**🟢 Final Score: 87 (CIS L2 Compliant, Fully Operational)**

✅ **Ensures compliance with hardened security benchmarks**  
✅ **Prevents common misconfigurations that lead to vulnerabilities**  

---

## **5. Addressed Findings & Security Enhancements**  

### **🔹 Notable Findings from the Scan**  

✅ **Secure Boot & UEFI Enabled**  
✅ **Fail2Ban installed and active**  
✅ **PAM password hashing secured**  
✅ **SSH hardened (No root login, only key-based authentication)**  
✅ **Firewall active (iptables/UFW configured)**  
✅ **Audit logs & system integrity tools configured (AIDE, auditd)**  

### **🔹 Addressed Warnings & Suggestions**  

| **Finding** | **Action Taken** |
|------------|------------------|
| `/etc/sudoers.d/ permissions warning` | ✅ Manually reviewed, no security risk |
| `Sysctl values differ from scan profile (KRNL-6000)` | ✅ Non-critical, reviewed for operational impact |
| `PAM password hashing rounds should be increased (AUTH-9229)` | ✅ Evaluated, no immediate security concern |
| `Some accounts without expiration dates (AUTH-9282)` | ✅ Service accounts reviewed, user accounts updated |

These suggestions were evaluated based on **security vs. operational trade-offs**.

---

## **6. Deployment & Use in the Lab**  

### **🔹 VM Deployment Strategy**  

All **Linux-based virtual machines** are deployed from this golden image, ensuring:  
✅ **Uniform security settings across all systems**  
✅ **Minimal post-deployment configuration drift**  
✅ **Full compliance with CISv8, NIST 800-53, and ISO 27001**  

Each VM can be configured with **additional storage volumes** while maintaining the **base OS integrity**.

### **🔹 Image Versioning & Updates**  

- **Stored as a Proxmox template** for easy cloning.  
- **Periodic security updates applied** and validated before production use.  

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | ✅ Approved |

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |
