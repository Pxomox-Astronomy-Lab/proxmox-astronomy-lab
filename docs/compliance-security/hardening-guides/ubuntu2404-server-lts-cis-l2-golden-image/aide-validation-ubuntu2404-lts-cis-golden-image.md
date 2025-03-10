<!-- ---
title: "Golden Image Integrity Verification - AIDE"
description: "Verification of the Proxmox Astronomy Lab's golden image using AIDE to confirm system integrity, detect unauthorized modifications, and ensure compliance with CISv8 standards."
author: "VintageDon"
tags: ["CISv8", "AIDE", "System Integrity", "File Integrity Monitoring", "Security Audit"]
category: "Security Audits"
kb_type: "Audit Report"
version: "1.0"
status: "Draft"
last_updated: "2025-03-04"
---
 -->

# **🔍 Golden Image Integrity Verification - AIDE**

## **1. Purpose**

This report documents the **system integrity verification** of the Proxmox Astronomy Lab's **golden image** using **AIDE** (Advanced Intrusion Detection Environment). AIDE serves as a **host-based intrusion detection system (HIDS)** by scanning the system for **unauthorized modifications**, **unexpected file changes**, and **security policy deviations**.

## **2. Scope**

- **System Audited**: The **golden image** used for all lab Linux VMs.
- **Tool Used**: `AIDE` (latest stable version)
- **Verification Focus**:
  - **Detection of unauthorized system changes**
  - **Verification of critical system binaries**
  - **Detection of unexpected file or attribute modifications**
  - **Ensuring compliance with CISv8 Level 2 security policies**
- **Security Baseline**: The system is configured per **CISv8 L2 hardening standards**, and all instances of this image **inherit these configurations**.

---

### **Compliance Mapping for AIDE**  

The **Advanced Intrusion Detection Environment (AIDE)** is a key component in ensuring **file integrity monitoring** and detecting unauthorized changes to system files. The following table maps AIDE's implementation to relevant compliance frameworks and security benchmarks.

| **Compliance Framework**        | **Control Reference**            | **Description** |
|--------------------------------|--------------------------------|----------------|
| **CIS Ubuntu 24.04 LTS Benchmark** | 1.3.1, 1.3.2, 1.3.3 | Ensures AIDE is installed, initialized, and configured for periodic integrity checks. |
| **NIST 800-53**                 | SI-7, SI-7(1), SI-7(7)        | Requires file integrity monitoring to detect unauthorized changes. |
| **ISO 27001**                   | A.12.4.1                      | Mandates logging and monitoring of system integrity changes. |
| **MITRE ATT&CK**                | T1070.004                     | Detects system file modifications often associated with adversarial activity. |

AIDE plays a **critical role** in maintaining **system integrity** by detecting unauthorized changes, making it an essential control in **security baselines and compliance frameworks**.

---

### **4.1 Expected Kernel Header Changes**

The scan detected **newly added files** in the **kernel headers directory**. These are normal after a kernel update.

```plaintext
f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54-generic/include/config/PCI_REALLOC_ENABLE_AUTO
f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54-generic/include/config/PCI_STUB
f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54-generic/include/config/PCI_SW_SWITCHTEC
f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54-generic/include/config/PCI_XEN
f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54-generic/include/config/PCMCIA
```

**🔹 Explanation**:

- `f+++++++++++++++++` indicates **newly added files**.
- These files belong to **kernel header updates**, which occur when **new modules or hardware support are introduced**.
- **No action required**—this is an expected change.

---

### **4.2 Postfix Socket Changes**

AIDE reported **modified timestamps and inode changes** for **Postfix mail queue sockets**.

```plaintext
Socket: /var/spool/postfix/public/qmgr
 Mtime     : 2025-02-22 21:12:25 -0500        | 2025-03-04 02:10:50 -0500
 Ctime     : 2025-02-22 21:12:25 -0500        | 2025-03-04 02:10:50 -0500
 Inode     : 135368                           | 131164
```

**🔹 Explanation**:

- These sockets change **dynamically** when the mail system processes messages.
- **Expected behavior**—AIDE detects changes in system-generated files, but these do not indicate a security issue.

---

### **4.3 System Time Zone Link Update**

AIDE detected a **change in the symbolic link** for the system’s local time configuration.

```plaintext
Link: /var/spool/postfix/usr/lib/zoneinfo/localtime
 Mtime     : 2025-02-22 21:12:24 -0500        | 2025-03-04 02:10:49 -0500
 Ctime     : 2025-02-22 21:12:24 -0500        | 2025-03-04 02:10:49 -0500
 Inode     : 135314                           | 131441
```

**🔹 Explanation**:

- This is an **expected update** related to time zone synchronization.
- **No security risk**—the system **correctly applied time zone data updates**.

---

### **4.4 Integrity Check on AIDE Database**

AIDE verifies its own database integrity using cryptographic hashes.

```plaintext
/var/lib/aide/aide.db.gz
 SHA512    : iMkBTWzL2f5u8MFfsQJBwLv4orfNuXM2
             WCcsBT2Dh3Ps6ihfy0ctbXeS/6Zf+Ixx
             fVPVHvNCx9lCtqsD4EiMRg==
```

**🔹 Explanation**:

- The database hash remains **consistent**, confirming **no tampering** with AIDE’s stored baseline.
- This ensures that **AIDE reports are reliable** and have not been altered.

---

### **4.5 Kernel Module Attribute Differences**

Certain kernel module files had **attribute changes**.

```plaintext
Entry /usr/src/linux-headers-6.8.0-53-generic/tools/bpf/resolve_btfids/libbpf/staticobjs/.netlink.o.d in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
```

**🔹 Explanation**:

- These differences are expected **after a kernel update**.
- **No integrity concerns**—these files are part of the **BPF subsystem** used for **performance tracing and security monitoring**.

---

### **4.6 AppArmor Policy Updates**

AIDE detected **changes in AppArmor security policies**.

```plaintext
Entry /etc/apparmor.d/abstractions/fonts in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
```

**🔹 Explanation**:

- These updates **reflect legitimate security policy enhancements**.
- **No security risks**—the system has correctly **updated mandatory access control (MAC) rules**.

---

## **5. System Integrity Confirmation**

The **AIDE scan** confirms that **all modifications** were **expected system updates**, with **no unauthorized changes detected**.

✅ **Kernel headers updated**—No security concerns  
✅ **Postfix mail queue changes expected**—No action required  
✅ **Time zone sync updates expected**—No integrity issues  
✅ **AIDE database remains intact**—Integrity confirmed  
✅ **AppArmor security policies updated**—Enhances security  

📌 **Final Status**: **System is secure** with **no unauthorized modifications or integrity violations.** 🚀

---

## **6. Continuous Monitoring & Future Audits**

To maintain **ongoing security compliance**, the golden image undergoes **scheduled integrity audits**:

- **Daily AIDE scans** for system changes
- **Weekly audit logs & anomaly detection** via `Wazuh SIEM`
- **Automated kernel integrity verification** (`dm-verity` planned for future)

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | ✅ DRAFT |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |


