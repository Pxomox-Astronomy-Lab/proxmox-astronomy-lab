---
title: "AppArmor & Mandatory Access Controls - Ubuntu 24.04 LTS Golden Image"
description: "Validation of AppArmor, Auditd, and automatic security updates on the CIS L2 Ubuntu 24.04 LTS golden image."
category: "Security & Compliance"
version: "1.0"
status: "Draft"
author: "VintageDon"
last_updated: "2025-03-04"
compliance_mappings:
  - "CIS Ubuntu 24.04 LTS Benchmark: 1.6.1, 1.6.2, 1.6.3"
  - "NIST 800-53: AC-3, AC-6, SI-3, SI-4"
  - "ISO 27001: A.14.2.5, A.13.1.1"
  - "MITRE ATT&CK: T1055.012, T1203"
---
# **AppArmor & Mandatory Access Controls - Ubuntu 24.04 LTS Golden Image**  

## **1. Purpose**  

This document validates the **AppArmor security framework** on the **Ubuntu 24.04 LTS CIS Level 2 Golden Image**. It ensures that:  

- **AppArmor** is **installed, enabled, and enforcing security policies**.  
- **Auditd** is **active** to log security-related system events.  
- **Automatic security updates** are **enabled** for compliance.  

---

### **Section 2: Scope**

The **scope** of this validation includes **three core security components** that must be enforced in the Ubuntu 24.04 LTS CIS Level 2 Golden Image:

| **Component**                 | **Validation Objective**                                          | **Relevance** |
|--------------------------------|------------------------------------------------------------------|--------------|
| **AppArmor Security Profiles** | Ensures application-level mandatory access control is enforced. | Prevents unauthorized execution. |
| **Auditd Logging**             | Validates system audit service is running and logging events.  | Provides forensic evidence and compliance tracking. |
| **Unattended Security Updates** | Confirms automatic updates for security patches are enabled.  | Ensures continuous vulnerability remediation. |

Each component contributes to **hardened system security** and **compliance with CIS benchmarks and regulatory standards**.

---

## **3. Compliance Mapping**  

The following table outlines how AppArmor aligns with various security frameworks:

| **Compliance Framework**         | **Control Reference**           | **Description** |
|----------------------------------|--------------------------------|----------------|
| **CIS Ubuntu 24.04 LTS Benchmark** | 1.6.1, 1.6.2, 1.6.3 | Ensures AppArmor is installed, enabled, and protecting critical services. |
| **NIST 800-53**                 | AC-3, AC-6, SI-3, SI-4        | Implements least privilege, controls application execution, and enforces process security. |
| **ISO 27001**                   | A.14.2.5, A.13.1.1           | Supports secure system development and network segmentation. |
| **MITRE ATT&CK**                | T1055.012, T1203             | Mitigates process injection and unauthorized execution attempts. |

**AppArmor enforces process-level security**, reducing the attack surface and ensuring compliance with best practices.

---

## **4. AppArmor Validation**  

### **4.1. Check AppArmor Status**  

To validate AppArmor is active and enforcing policies, run:  

```bash
aa-status
```

#### **Expected Output**  

```bash
apparmor module is loaded.
120 profiles are loaded.
25 profiles are in enforce mode.
4 profiles are in complain mode.
0 profiles are in prompt mode.
0 profiles are in kill mode.
91 profiles are in unconfined mode.
```

#### **Key Validations:**  

- **âœ… AppArmor is enabled** (`apparmor module is loaded`).  
- **âœ… Critical applications have security profiles (`enforce mode`).**  
- **âš ï¸ Unconfined applications** may require additional policy enforcement.  

---

## **5. Auditd Validation**  

### **5.1. Check Auditd Service**  

Auditd logs security-relevant events such as authentication failures, file modifications, and system calls.  

Run:  

```bash
systemctl status auditd
```

#### **Expected Output**  

```bash
â— auditd.service - Security Auditing Service
     Loaded: loaded (/usr/lib/systemd/system/auditd.service; enabled; preset: enabled)
     Active: active (running) since Tue 2025-03-04 02:10:47 EST; 47min ago
```

- **âœ… Auditd is running and enabled on boot (`Active: active (running)`).**  

### **5.2. Validate Audit Rules**  

Check active audit rules:  

```bash
auditctl -l
```

If **no rules** are configured, add security monitoring policies:  

```bash
echo "-w /etc/passwd -p wa -k passwd_changes" >> /etc/audit/rules.d/audit.rules
echo "-w /var/log/auth.log -p wa -k auth_logs" >> /etc/audit/rules.d/audit.rules
augenrules --load
```

âœ… **Auditd is logging security-related system activity.**  

---

## **6. Automatic Security Updates Validation**  

To ensure **critical security patches** are applied automatically, verify the unattended upgrade settings.

### **6.1. Check Auto-Upgrade Configuration**  

Run:  

```bash
cat /etc/apt/apt.conf.d/20auto-upgrades
```

#### **Expected Output**  

```bash
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

âœ… **Automatic security updates are enabled.**  
âš ï¸ **If missing, enable with:**  

```bash
echo 'APT::Periodic::Update-Package-Lists "1";' | tee /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::Unattended-Upgrade "1";' | tee -a /etc/apt/apt.conf.d/20auto-upgrades
```

---

## **7. Conclusion**  

- âœ… **AppArmor is enforcing security policies.**  
- âœ… **Auditd is active and logging security events.**  
- âœ… **Unattended security updates are enabled.**  

âš ï¸ **Action Required**: Review unconfined applications and define additional AppArmor profiles as necessary.

---

## **8. Approval & Review**  

| **Reviewer** | **Role**          | **Approval Date** | **Status** |
|-------------|-----------------|------------------|------------|
| VintageDon  | Lead Engineer    | 2025-03-04       | âœ… DRAFT |

---

## **9. Change Log**  

| **Version** | **Date**       | **Changes**          | **Author**     |
|------------|--------------|----------------------|---------------|
| 1.0        | 2025-03-04   | Initial version     | VintageDon   |

