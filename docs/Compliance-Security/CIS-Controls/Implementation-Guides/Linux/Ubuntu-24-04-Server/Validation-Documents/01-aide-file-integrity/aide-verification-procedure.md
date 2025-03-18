<!-- 
---
title: "AIDE File Integrity Monitoring Validation - Ubuntu 24.04 LTS CIS Golden Image"
description: "Validation of AIDE file integrity monitoring implementation and baseline scan on the Ubuntu 24.04 LTS CIS hardened golden image"
author: "VintageDon"
tags: ["CISv8", "AIDE", "File Integrity", "Security Validation", "Ubuntu 24.04"]
category: "Security Validation"
kb_type: "Validation Report"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🕵️ **AIDE File Integrity Monitoring Validation - Ubuntu 24.04 LTS CIS Golden Image**

## 🎯 **1. Purpose**

This document validates the implementation of **Advanced Intrusion Detection Environment (AIDE)**, a file integrity monitoring tool, on the **Ubuntu 24.04 LTS CIS golden image**. AIDE creates a baseline of file attributes and monitors for unauthorized changes to system files, providing early detection of potential security incidents.

The validation confirms that:

- AIDE is **properly installed and configured**
- A **baseline database** has been created
- **Daily checks** are scheduled for continuous monitoring
- The monitored file set is **properly defined**
- The system complies with **CIS benchmark requirements** for file integrity monitoring

---

## 📋 **2. Scope**

This validation covers the AIDE file integrity monitoring implementation on the Ubuntu 24.04 LTS golden image.

| **Component** | **Description** | **Validation Approach** |
|--------------|----------------|------------------------|
| **AIDE Package** | File integrity monitoring software | Confirm installation and version |
| **Configuration** | AIDE monitoring settings | Review configuration file |
| **Database** | Baseline file attributes database | Verify database creation |
| **Scheduled Execution** | Automated daily checks | Validate cron job configuration |
| **Monitored Paths** | Critical system files and directories | Review scope of monitoring |

This validation ensures the system complies with **CIS Control 3.3** (File Integrity Checking) and related requirements.

---

## 🔄 **3. Compliance Mapping**

The AIDE implementation maps to several security frameworks and compliance standards:

| **Framework** | **Control Reference** | **Requirement** |
|--------------|----------------------|----------------|
| **CIS Ubuntu 24.04** | 1.4.1 | Ensure AIDE is installed |
| **CIS Ubuntu 24.04** | 1.4.2 | Ensure filesystem integrity is regularly checked |
| **NIST 800-53 Rev5** | SI-7 | Software, firmware, and information integrity |
| **ISO 27001:2022** | A.8.9 | Configuration management |
| **CIS Controls v8** | 3.3 | Configure automatic file integrity assessments |

---

## ✅ **4. Validation Checks**

### **4.1 AIDE Installation Verification**

Verify AIDE is installed:

```bash
dpkg -l aide aide-common
```

**Expected Output:**

```bash
ii  aide        0.18.6-1  amd64  Advanced Intrusion Detection Environment - static binary
ii  aide-common 0.18.6-1  all    Advanced Intrusion Detection Environment - configuration files
```

✅ **AIDE is properly installed**.

### **4.2 AIDE Configuration Review**

Review the AIDE configuration:

```bash
grep -v "^#" /etc/aide/aide.conf | grep -v "^$"
```

**Key Configuration Elements:**

```bash
database=file:/var/lib/aide/aide.db
database_out=file:/var/lib/aide/aide.db.new
gzip_dbout=yes
report_url=file:/var/log/aide/aide.log
report_url=stdout
NORMAL = R+sha256
PERMS = p+i+u+g
CONTENT = sha256+ftype
ALLXTRAHASHES = sha256+sha512+rmd160+tiger+haval+gost+crc32+whirlpool
EVERYTHING = R+ALLXTRAHASHES
LSPP = NORMAL+acl+selinux+xattrs
DATAONLY = sha256
```

✅ **AIDE configuration includes appropriate file attributes to monitor**.

### **4.3 Monitored Locations Review**

Verify critical system paths are monitored:

```bash
/boot   CONTENT
/bin    NORMAL
/sbin   NORMAL
/lib    NORMAL
/lib64  NORMAL
/opt    NORMAL
/usr    NORMAL
/etc    PERMS+CONTENT
!/var/log
!/var/spool/anacron
!/var/spool/cron/atjobs
!/var/lib/aide/aide.db*
```

✅ **AIDE is configured to monitor critical system files and directories**.

### **4.4 Database Initialization Verification**

Confirm the AIDE database exists:

```bash
ls -la /var/lib/aide/aide.db
```

**Expected Output:**

```bash
-rw------- 1 root root 12485632 Mar 16 10:00 /var/lib/aide/aide.db
```

✅ **AIDE database has been initialized**.

### **4.5 Scheduled Scan Verification**

Confirm that AIDE scans are scheduled:

```bash
ls -la /etc/cron.daily/dailyaidecheck
```

**Expected Output:**

```bash
-rwxr-xr-x 1 root root 123 Mar 16 10:00 /etc/cron.daily/dailyaidecheck
```

**Script Content:**

```bash
#!/bin/sh
/usr/bin/aide.wrapper --check | /usr/bin/mail -s "Daily AIDE check on $(hostname)" security@lab
```

✅ **Daily automated checks are properly configured**.

---

## 🔍 **5. Attribute Monitoring Validation**

AIDE is configured to monitor comprehensive file attributes:

| **Attribute** | **Flag** | **Validation Status** |
|--------------|----------|----------------------|
| **File content (sha256)** | sha256 | ✅ Configured |
| **Permissions** | p | ✅ Configured |
| **Inode** | i | ✅ Configured |
| **User/Group ownership** | u/g | ✅ Configured |
| **File type** | ftype | ✅ Configured |
| **Modification time** | m | ✅ Configured |
| **Size** | s | ✅ Configured |
| **Additional hashes** | ALLXTRAHASHES | ✅ Configured |

The configuration covers all critical file attributes that could indicate a security compromise.

---

## 🧪 **6. Validation Tests**

The following tests were performed to validate AIDE's effectiveness:

| **Test** | **Description** | **Result** |
|----------|----------------|------------|
| **File content modification** | Modified content of a test file | ✅ Detected successfully |
| **Permission change** | Changed permissions on a critical file | ✅ Detected successfully |
| **Ownership modification** | Changed owner of a system file | ✅ Detected successfully |
| **New file creation** | Added unauthorized file to monitored directory | ✅ Detected successfully |
| **File deletion** | Removed a monitored file | ✅ Detected successfully |

These tests confirm that **AIDE effectively detects various types of file system changes**.

---

## 🔄 **7. Database Update Procedure Validation**

Verify the database update procedure works correctly:

```bash
# Create test file
touch /etc/test-file
# Run AIDE update
aide --update
# Copy new database to active database
cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
# Verify test file is now in baseline
aide --check | grep test-file
```

**Expected Result:** No changes reported for the test file after database update.

✅ **Database update procedure functions correctly**.

---

## 🔒 **8. Security of AIDE Implementation**

The AIDE implementation includes measures to protect its integrity:

| **Security Measure** | **Implementation** | **Validation Status** |
|----------------------|-------------------|----------------------|
| **Database permissions** | 600 (root readable only) | ✅ Verified |
| **Configuration permissions** | 644 (root writable only) | ✅ Verified |
| **Script permissions** | 755 (root writable only) | ✅ Verified |
| **Database exclusion** | AIDE database excluded from monitoring | ✅ Verified |
| **Backup database** | Stored securely for recovery | ✅ Verified |

These measures ensure the file integrity monitoring system itself is protected from tampering.

---

## 🧩 **9. Integration with Security Framework**

AIDE is integrated with the broader security monitoring framework:

| **Integration** | **Implementation** | **Validation Status** |
|-----------------|-------------------|----------------------|
| **Email notifications** | Daily reports configured | ✅ Verified |
| **Log forwarding** | Logs sent to central SIEM | ✅ Verified |
| **Complementary tools** | Works alongside RKHunter and Chkrootkit | ✅ Verified |
| **Change management** | Process for expected changes | ✅ Verified |

This integration ensures comprehensive system integrity monitoring.

---

## 📋 **10. Raw Scan Output**

Below is a sample of the AIDE scan output. Due to length constraints, only a representative portion is shown:

```bash
# Sample of AIDE output - actual output contains thousands of lines
Entry /boot/efi/EFI/BOOT/BOOTX64.EFI in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /boot/efi/EFI/BOOT/fbx64.efi in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /boot/efi/EFI/BOOT/mmx64.efi in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /etc/cron.daily/chkrootkit in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /etc/cron.daily/dailyaidecheck in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54-generic/include/config/CHARGER_GPIO
f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54-generic/include/config/CHARGER_ISP1704
f =.... mci.-.. . : /usr/lib/tmpfiles.d/snapd.conf
```

The complete scan output is archived in the security log repository.

---

## ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial validation document | VintageDon |
