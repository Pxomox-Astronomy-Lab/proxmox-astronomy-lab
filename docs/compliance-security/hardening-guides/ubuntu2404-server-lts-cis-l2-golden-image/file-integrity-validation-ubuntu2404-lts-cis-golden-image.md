<!-- ---
title: "File Integrity Monitoring with AIDE - Ubuntu 24.04 LTS Golden Image"
description: "Validation and verification of AIDE file integrity monitoring (FIM) on the hardened Ubuntu 24.04 LTS golden image."
author: "VintageDon"
tags: ["AIDE", "File Integrity Monitoring", "Security", "Golden Image", "Intrusion Detection"]
category: "Security Monitoring"
kb_type: "Validation Report"
version: "1.0"
status: "Draft"
last_updated: "2025-03-04"
---
 -->

# **📜 File Integrity Monitoring with AIDE - Ubuntu 24.04 LTS Golden Image**  

## **1. Purpose**  

The **Advanced Intrusion Detection Environment (AIDE)** provides **file integrity monitoring (FIM)** by detecting **unauthorized modifications to system files**. It ensures the **Ubuntu 24.04 LTS CIS Level 2 Golden Image** maintains a secure baseline.  

The following objectives are met through AIDE:  

| **Objective** | **Description** |  
|--------------|----------------|  
| **Integrity Verification** | Monitors critical system files for unauthorized changes. |  
| **Baseline Enforcement** | Ensures the system state remains consistent with CIS hardening standards. |  
| **Automated Monitoring** | Scheduled scans detect unexpected modifications. |  
| **Compliance Support** | AIDE aligns with security benchmarks for auditability. |  

✅ **This validation confirms AIDE is installed, configured, and actively monitoring file integrity.**  

---

## **2. Scope**  

This validation applies to all **Ubuntu 24.04 LTS CIS Level 2 Golden Image** deployments used in the Proxmox Astronomy Lab.  

| **Component** | **Scope Details** |  
|--------------|------------------|  
| **System Audited** | Ubuntu 24.04 LTS Golden Image |  
| **Tool Used** | AIDE (Latest Stable Version) |  
| **Verification Focus** | Detecting file modifications, unauthorized changes, and integrity violations. |  
| **Security Baseline** | Hardened per **CISv8 Level 2** compliance. |  

✅ **Ensuring AIDE enforces file integrity protection across all deployed instances.**

---

## **3. Compliance Mapping**  

AIDE supports **security monitoring and compliance** under multiple security frameworks:  

| **Framework**  | **Control Mapping** |
|--------------|------------------|
| **CISv8**  | - CIS Control 13: Network Monitoring and Defense  |  
|            | - CIS Control 9: Secure Configuration Management  |  
| **NIST 800-53**  | - SI-7: Software, Firmware, and Information Integrity  |  
|                | - CM-3: Configuration Change Control  |  
| **ISO 27001**  | - A.12.4: Logging and Monitoring  |  
|                | - A.14.2: Security in Development and Maintenance  |  

✅ **AIDE enhances security posture by monitoring and alerting on unauthorized file changes.**  

---

## **4. Validation Steps**  

### **4.1 Verify AIDE Installation**  

To confirm that AIDE is installed:  

```bash
dpkg -l | grep aide
```

#### **Expected Output:**  

```plaintext
ii  aide  0.17.4-3ubuntu2  amd64  Advanced Intrusion Detection Environment - static binary
```

✅ **AIDE is installed and ready for use.**  

---

### **4.2 Check AIDE Database Integrity**  

Run the following command to compare the current system state against the last known **secure state**:  

```bash
aide --check
```

#### **Example Output:**  

```plaintext
Entry /usr/src/linux-headers-6.8.0-53-generic/tools/bpf/resolve_btfids/libbpf/staticobjs/.netlink.o.d in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /etc/apparmor.d/abstractions/fonts in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
```

#### **Key Validations:**  

- **If no changes are detected**, the system **matches the integrity database** ✅  
- **If modifications are detected**, review the logs to determine if they are expected or unauthorized ⚠️  

---

### **4.3 Review AIDE Report Logs**  

To inspect recent file modifications, view the AIDE database:  

```bash
zcat /var/lib/aide/aide.db.gz | less
```

#### **Example Entry:**  

```plaintext
/var/lib/aide/aide.db.gz
 SHA512    : iMkBTWzL2f5u8MFfsQJBwLv4orfNuXM2
             WCcsBT2Dh3Ps6ihfy0ctbXeS/6Zf+Ixx
             fVPVHvNCx9lCtqsD4EiMRg==
```

✅ **Database integrity verified.**  
⚠️ **Investigate any unexpected changes.**  

---

### **4.4 Update AIDE Database**  

If system modifications (such as package updates) are **expected and authorized**, update the database:  

```bash
aide --init
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
```

✅ **AIDE database updated with a known-good system state.**  

---

### **4.5 Automating AIDE Scans**  

To schedule daily AIDE integrity checks, configure a cron job:  

```bash
echo "0 3 * * * root /usr/bin/aide --check | /bin/mail -s 'AIDE Integrity Check' admin@example.com" | tee /etc/cron.d/aide-check
```

✅ **AIDE will automatically scan for unauthorized changes daily and send alerts.**  

---

## **5. Conclusion**  

| **Validation Step** | **Status** |
|--------------------|------------|
| AIDE is installed and configured | ✅ Passed |
| File integrity database is up to date | ✅ Passed |
| System modifications are being tracked | ✅ Passed |
| AIDE reports are logged for analysis | ✅ Passed |
| Automatic integrity checks are scheduled | ✅ Passed |

🚀 **AIDE is fully functional on the Ubuntu 24.04 golden image, ensuring file integrity and compliance with CIS hardening standards.**  

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


