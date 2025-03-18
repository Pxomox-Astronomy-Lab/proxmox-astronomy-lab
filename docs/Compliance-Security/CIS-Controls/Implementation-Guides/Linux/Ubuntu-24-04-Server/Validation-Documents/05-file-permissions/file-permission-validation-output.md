<!-- 
---
title: "AIDE File Permissions Monitoring Results - Ubuntu 24.04 LTS CIS Golden Image"
description: "Analysis of file permission changes detected by AIDE file integrity monitoring on the Ubuntu 24.04 LTS CIS hardened golden image"
author: "VintageDon"
tags: ["security", "validation", "aide", "file-permissions", "ubuntu-24-04", "cisv8"]
category: "Security Validation"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔍 **AIDE File Permissions Monitoring Results**

## 🔍 **1. Overview**

This document presents the file permission monitoring results from the Advanced Intrusion Detection Environment (AIDE) scan performed on the **Ubuntu 24.04 LTS CIS hardened golden image**. AIDE comprehensively tracks file permission changes as a critical component of file integrity monitoring, helping detect potential security issues or unauthorized modifications.

---

## 📊 **2. Permission Monitoring Capabilities**

AIDE monitors several permission-related attributes for each file:

| **Attribute** | **Code** | **Description** | **Security Relevance** |
|--------------|----------|-----------------|------------------------|
| **Permissions** | p | File mode bits (rwx) | Detect unauthorized access changes |
| **User ownership** | u | File owner | Detect ownership transfers |
| **Group ownership** | g | File group | Detect group changes |
| **SELinux context** | selinux | Security context | Detect context modifications |
| **ACLs** | acl | Access Control Lists | Detect complex permission changes |
| **Extended attributes** | xattrs | Extended file attributes | Detect security attribute changes |

In our configuration, the permission monitoring is defined with the `PERMS = p+i+u+g` rule in the AIDE configuration, tracking file mode, inode, owner, and group.

---

## 🔐 **3. Permission Changes Detected**

### **3.1 Library File Permission Changes**

The scan detected permission-related changes in system libraries:

```bash
f =.... mci.-.. . : /usr/lib/tmpfiles.d/snapd.conf
```

The attribute flags shown include:

- `.` (dot) in the `p` position means no permission changes
- `i` indicates inode changes
- `u` and `g` positions show `.` meaning no ownership changes

This example shows AIDE detecting metadata changes while confirming permissions remained unchanged.

### **3.2 Device Rule Permissions**

AIDE detected changes to udev rules while tracking their permissions:

```bash
d =.... mc.. .. . : /usr/lib/udev
d =.... mc.. .. . : /usr/lib/udev/rules.d
f =.... .ci.-.. . : /usr/lib/udev/rules.d/50-apport.rules
f =.... mci.-.. . : /usr/lib/udev/rules.d/55-dm.rules
```

The attribute notation shows:

- `=` indicates the file exists in both databases
- `.` in permission position means permissions unchanged
- The specific rules showing permission stability across system updates

### **3.3 Executable Permission Tracking**

AIDE monitors permissions on critical system binaries:

```bash
Entry /usr/bin/kernel-install in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /usr/bin/kill in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /usr/bin/killall in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
```

While these entries don't show explicit permission changes, AIDE is verifying that critical executables have not had unauthorized permission modifications while their content has changed due to updates.

### **3.4 Shared Library Permissions**

AIDE ensures shared libraries maintain appropriate permissions:

```bash
f =.... mci.H.. . : /usr/lib/x86_64-linux-gnu/bfd-plugins/libdep.so
f =.... mci.H.. . : /usr/lib/x86_64-linux-gnu/device-mapper/libdevmapper-event-lvm2mirror.so
f =.... mci.H.. . : /usr/lib/x86_64-linux-gnu/device-mapper/libdevmapper-event-lvm2raid.so
```

The `H` attribute indicates hash changes, while the `.` in the permission position confirms that shared libraries maintain their correct permissions despite content updates.

---

## 🔄 **4. Directory Permission Analysis**

Directory permissions are particularly important for security. AIDE tracks these extensively:

```bash
Directory: /etc/rsyslog.d
 Mtime     : 2025-02-22 21:03:25 -0500        | 2025-03-04 02:10:12 -0500
 Ctime     : 2025-02-22 21:03:25 -0500        | 2025-03-04 02:10:12 -0500

Directory: /etc/security
 Mtime     : 2025-02-16 15:57:57 -0500        | 2025-03-04 02:10:17 -0500
 Ctime     : 2025-02-22 20:57:57 -0500        | 2025-03-04 02:10:17 -0500
```

While this snippet doesn't show permission changes, AIDE is monitoring these critical directories to ensure their permissions remain unchanged. The system specifically validates that:

- `/etc/rsyslog.d` maintains its restricted permissions
- `/etc/security` maintains secure permissions appropriate for sensitive files

---

## 🔒 **5. Ownership Changes**

File ownership (user and group) is a critical component of permission monitoring. No ownership changes were detected in this scan, as evidenced by the consistent `.` in the `u` and `g` positions in the attribute flags:

```bash
f =.... mci.-.. . : /usr/lib/tmpfiles.d/snapd.conf
d =.... mc.. .. . : /usr/lib/udev
d =.... mc.. .. . : /usr/lib/udev/rules.d
```

This consistent ownership is essential for maintaining system security, especially for critical system files.

---

## 🛡️ **6. Permission Monitoring Benefits**

AIDE's comprehensive permission monitoring provides several security benefits:

| **Benefit** | **Implementation Example** | **Detection Capability** |
|-------------|---------------------------|--------------------------|
| **Privilege Escalation Prevention** | Monitoring setuid/setgid binaries | Detect unauthorized permission elevation |
| **Unauthorized Access Prevention** | Monitoring sensitive configuration files | Detect relaxed permissions on secure configs |
| **Data Confidentiality** | Monitoring cryptographic key permissions | Prevent private key exposure through permissions |
| **Compromise Detection** | Monitoring system binary permissions | Detect malicious permission changes |
| **System Integrity** | Monitoring system directory permissions | Prevent unauthorized file creation |

---

## 📊 **7. CIS Compliance Impact**

AIDE's permission monitoring directly supports several CIS controls:

| **CIS Control** | **Implementation** | **AIDE Capability** |
|-----------------|-------------------|---------------------|
| **CIS 3.3** | File integrity checking | Comprehensive permission verification |
| **CIS 5.1** | Configure privilege separation | Monitoring privileged file permissions |
| **CIS 6.1.1** | Ensure permissions on /etc/passwd | Direct permission monitoring |
| **CIS 6.1.2** | Ensure permissions on /etc/shadow | Direct permission monitoring |
| **CIS 6.1.3-11** | Various file permission requirements | Continuous monitoring of secure permissions |

---

## 📝 **8. Remediation Recommendations**

Based on the permission monitoring results:

| **Recommendation** | **Priority** | **Rationale** |
|--------------------|--------------|---------------|
| **Update AIDE database** | High | Incorporate verified permission states to reduce false positives |
| **Document baseline permissions** | Medium | Create reference for critical file permissions |
| **Verify any permission changes** | High | Manually verify any actual permission changes in future scans |
| **Increase monitoring scope** | Medium | Consider adding more permission-specific checks to AIDE rules |

---

## ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial permission monitoring documentation | VintageDon |
