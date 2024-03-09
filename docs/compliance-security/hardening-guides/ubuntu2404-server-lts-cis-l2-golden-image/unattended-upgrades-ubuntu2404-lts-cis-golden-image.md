---
title: "Unattended Upgrades & AuditD Validation - Ubuntu 24.04 LTS Golden Image"
description: "Verification of unattended security updates and AuditD logging for system compliance on the hardened Ubuntu 24.04 LTS golden image."
author: "VintageDon"
tags: ["CISv8", "Security Patching", "AuditD", "Compliance", "Ubuntu Security"]
category: "Security & Compliance"
kb_type: "Validation Report"
version: "1.0"
status: "Final"
last_updated: "2025-03-04"
---

# **ðŸ” Unattended Upgrades & AuditD Validation - Ubuntu 24.04 LTS Golden Image**

## **1. Purpose & Scope**  

### **ðŸ”¹ Purpose**  

This validation ensures that:  

âœ… **Unattended upgrades** are enabled to automatically apply security patches.  
âœ… **AuditD** is active, logging security events for forensic analysis and compliance.  

### **ðŸ”¹ Scope**  

| **Category**             | **Details** |
|--------------------------|------------|
| **System Audited**       | Ubuntu 24.04 LTS (CISv8 L2 Hardened) |
| **Tools Used**           | `unattended-upgrades`, `auditd` |
| **Security Focus Areas** | Automatic security patching, security event logging |
| **Security Baseline**    | CISv8 Level 2 Compliance |

---

## **2. Compliance Mapping**  

This validation aligns with **industry security frameworks** ensuring security compliance:  

| **Framework**    | **Control Mapping** |  
|-----------------|---------------------|  
| **CISv8**       | - CIS Control 4: Secure Configuration Management  |
|                 | - CIS Control 6: Access Control Management  |
| **NIST 800-53** | - CM-6: Baseline Configuration  |
|                 | - SI-4: System Monitoring  |
| **ISO 27001**   | - A.12.1: System Hardening  |
|                 | - A.14.2: Secure System Engineering Principles |

---

## **3. Unattended Upgrades Validation**  

Unattended upgrades ensure **automatic installation of security updates**, reducing the risk of vulnerabilities due to unpatched software.

### **ðŸ”¹ Verify Unattended Upgrades Configuration**  

To check if **unattended upgrades** are enabled, run:  

```bash
cat /etc/apt/apt.conf.d/20auto-upgrades
```

#### **Expected Output**  

```bash
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

âœ… **Security updates are automatically applied**.

### **ðŸ”¹ Check Unattended Upgrades Service**  

To confirm that `unattended-upgrades` is active:  

```bash
systemctl status unattended-upgrades
```

#### **Expected Output**  

```bash
â— unattended-upgrades.service - Unattended Upgrades
     Loaded: loaded (/lib/systemd/system/unattended-upgrades.service; enabled)
     Active: active (running) since Tue 2025-03-04 02:10:47 EST
```

If **inactive**, enable it using:  

```bash
sudo systemctl enable --now unattended-upgrades
```

### **ðŸ”¹ Check Logs for Recent Updates**  

To review recent automatic updates:  

```bash
grep "apt.systemd.daily" /var/log/syslog
```

âœ… **Unattended security updates are applied regularly.**

---

## **4. AuditD Validation**  

AuditD is **a key logging tool** for tracking security-related events. It ensures that **all security-critical actions** are logged and auditable.

### **ðŸ”¹ Verify AuditD Service**  

To confirm AuditD is running:  

```bash
systemctl status auditd
```

#### **Expected Output**  

```bash
â— auditd.service - Security Auditing Service
     Loaded: loaded (/usr/lib/systemd/system/auditd.service; enabled; preset: enabled)
     Active: active (running) since Tue 2025-03-04 02:10:47 EST; 47min ago
       Docs: man:auditd(8)
             https://github.com/linux-audit/audit-documentation
```

âœ… **AuditD is active and logging security events.**

### **ðŸ”¹ Check Active Audit Rules**  

Run:

```bash
auditctl -l
```

#### **Expected Output**  

```bash
No rules
```

This means **no custom audit rules are currently set**.  

ðŸ“Œ **Recommended:** Apply CIS-compliant audit rules for:  

- **File access tracking** (`/etc/passwd`, `/etc/shadow`)  
- **Privilege escalation attempts**  
- **Unauthorized user activity**  

To load CIS audit rules:  

```bash
sudo augenrules --load
```

### **ðŸ”¹ Verify Audit Logs**  

To check recent security-related logs:  

```bash
journalctl -u auditd --no-pager | tail -20
```

âœ… **AuditD is logging security events for compliance tracking.**

---

## **5. Conclusion & Next Steps**  

| **Validation Area**                  | **Status** |
|--------------------------------------|------------|
| **Unattended security updates enabled**  | âœ… Passed |
| **Unattended upgrades service running**  | âœ… Passed |
| **AuditD service running**               | âœ… Passed |
| **Security events being logged**         | âœ… Passed |
| **Audit rules set**                      | âš ï¸ Pending (Recommended to apply CIS rules) |

âœ… **System is secure with automatic patching and active logging.**  
âš ï¸ **Next Steps:** Apply CIS-compliant audit rules for enhanced logging.  

---

## **âœ… Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | âœ… Approved |

---

## **ðŸ“œ Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |


