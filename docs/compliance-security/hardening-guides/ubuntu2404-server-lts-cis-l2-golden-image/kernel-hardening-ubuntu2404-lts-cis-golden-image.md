<!-- ---
title: "Kernel Hardening & SSH Security - Ubuntu 24.04 LTS Golden Image"  
description: "Verification and validation of kernel security hardening and SSH access restrictions on the Ubuntu 24.04 CIS L2 Golden Image."  
author: "VintageDon"  
tags: ["Kernel Security", "SSH Hardening", "Ubuntu 24.04", "CIS L2", "Compliance"]  
category: "System Hardening"  
kb_type: "Validation Report"  
version: "1.0"  
status: "Draft"  
last_updated: "2025-03-04"  
---
 -->

# **🔒 Kernel Hardening & SSH Security - Ubuntu 24.04 LTS Golden Image**  

## **1. Purpose**  

Kernel security settings and SSH access restrictions are vital for protecting system integrity and preventing unauthorized access. This validation ensures:  

| **Objective**              | **Description** |  
|---------------------------|----------------|  
| **Kernel Security**       | Sysctl hardening to mitigate exploits and unauthorized modifications. |  
| **SSH Access Control**    | Enforcement of SSH security settings, including root access restrictions and key-based authentication. |  
| **Logging & Compliance**  | Security-related events are logged and monitored for anomalies. |  

✅ **Ensuring the Ubuntu 24.04 LTS CIS Level 2 Golden Image is hardened and meets security compliance standards.**  

---

## **2. Scope**  

This validation applies to all **Ubuntu 24.04 LTS CIS Level 2 Golden Image** deployments within the **Proxmox Astronomy Lab**.  

| **Component**        | **Scope Details** |  
|---------------------|------------------|  
| **System Audited**  | Ubuntu 24.04 LTS CIS L2 Golden Image |  
| **Tools Used**      | `sysctl`, `sshd_config`, `issue.net` |  
| **Verification Focus** | Kernel hardening parameters, SSH security enforcement, and logging settings. |  
| **Security Baseline** | Configured according to **CISv8 Level 2** recommendations. |  

✅ **Ensuring all lab systems inherit hardened configurations from the golden image.**  

---

## **3. Compliance Mapping**  

Kernel hardening and SSH security measures align with multiple security frameworks, ensuring system integrity, access control, and secure network management.  

| **Framework**    | **Control Mapping** |  
|-----------------|---------------------|  
| **CISv8**       | - CIS Control 4: Secure Configuration Management |
|                 | - CIS Control 6: Access Control Management |
| **NIST 800-53** | - AC-6: Least Privilege |
|                 | - CM-7: Least Functionality |
|                 | - SC-7: Boundary Protection |
| **ISO 27001**   | - A.9.2: User Access Management |
|                 | - A.13.1: Network Security |

---

## **4. Kernel Hardening Validation**  

Kernel parameters directly impact system security, networking, and process isolation. The following checks confirm security enforcement.  

### **4.1 Verify Kernel Hardening Parameters**  

Run the following command to check key security settings:  

```bash
sysctl -a | grep -E "kernel.randomize_va_space|net.ipv4.conf.all.accept_redirects|net.ipv4.conf.all.log_martians"
```  

#### **Expected Output**  

```bash
kernel.randomize_va_space = 2
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.log_martians = 1
```  

#### **Explanation**  

| **Parameter**                              | **Security Purpose** |  
|-------------------------------------------|---------------------|  
| `kernel.randomize_va_space = 2`          | Enables **Address Space Layout Randomization (ASLR)** for memory exploit mitigation. |  
| `net.ipv4.conf.all.accept_redirects = 0` | Prevents rogue **ICMP redirects**, mitigating **MITM** attack risks. |  
| `net.ipv4.conf.all.log_martians = 1`     | Logs invalid packets, **detecting spoofing and network anomalies**. |  

✅ **Verification Passed: Kernel security settings are properly configured.**  

---

### **4.2 Ensure Settings Persist Across Reboots**  

Run the following command to verify settings are permanently stored:  

```bash
grep -E "kernel.randomize_va_space|net.ipv4.conf.all.accept_redirects|net.ipv4.conf.all.log_martians" /etc/sysctl.conf
```  

If missing, apply the correct settings:  

```bash
echo "
kernel.randomize_va_space = 2
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.log_martians = 1
" >> /etc/sysctl.conf && sysctl -p
```  

✅ **Verification Passed: Kernel security settings persist across reboots.**  

---

## **5. SSH Security Validation**  

SSH is a **primary attack vector** if misconfigured. The following checks validate SSH security enforcement.  

### **5.1 Verify SSH Authentication Settings**  

Run:  

```bash
cat /etc/ssh/sshd_config | grep -E "PermitRootLogin|PasswordAuthentication"
```  

#### **Expected Output**  

```bash
PasswordAuthentication no
PermitRootLogin no
    PasswordAuthentication no
```  

#### **Explanation**  

| **SSH Parameter**                | **Security Purpose** |  
|----------------------------------|---------------------|  
| `PermitRootLogin no`            | **Prevents root login**, requiring non-root user authentication. |  
| `PasswordAuthentication no`      | **Disables password authentication**, enforcing key-based authentication. |  

✅ **Verification Passed: SSH authentication settings restrict unauthorized access.**  

---

### **5.2 Verify SSH Warning Banner**  

A security banner provides legal notice to unauthorized users. Verify with:  

```bash
cat /etc/issue.net
```  

#### **Expected Output**  

```bash
***************************************************************************
* WARNING: Unauthorized access to this system is strictly prohibited.     *
* This system is for authorized users only. Unauthorized access, use,     *
* or modification may result in disciplinary action and/or legal action.  *
* All activities are logged and monitored. By accessing this system, you  *
* consent to such monitoring.                                             *
***************************************************************************
```  

✅ **Verification Passed: SSH warning banner is displayed before login attempts.**  

---

### **5.3 Verify SSH Timeout Setting**  

To prevent **persistent inactive SSH sessions**, verify the timeout setting:  

```bash
echo $TMOUT
```  

If unset or set to `0`, apply the recommended setting:  

```bash
echo "TMOUT=600" >> /etc/profile
```  

This **logs out inactive SSH sessions after 10 minutes** for compliance.  

✅ **Verification Passed: SSH session timeout is enforced.**  

---

## **6. Conclusion**  

| **Test**                                         | **Status** |  
|-------------------------------------------------|------------|  
| Kernel hardening settings are correctly applied | ✅ Passed |  
| SSH security settings prevent unauthorized access | ✅ Passed |  
| SSH legal notice banner is enabled | ✅ Passed |  
| SSH session timeout is enforced | ✅ Passed |  

🚀 **Kernel and SSH security measures are properly enforced on the Ubuntu 24.04 LTS CIS L2 Golden Image.**  

---

## ✅ Approval & Review  

| **Reviewer** | **Role** | **Approval Date** | **Status** |  
|-------------|---------|------------------|------------|  
| VintageDon | Lead Engineer | 2025-03-04 | ✅ DRAFT |  

---

## 📜 Change Log  

| **Version** | **Date** | **Changes** | **Author** |  
|------------|---------|-------------|------------|  
| 1.0 | 2025-03-04 | Initial version | VintageDon |


