<!-- 
---
title: "AIDE File Integrity Monitoring Process - Proxmox Astronomy Lab"
description: "Documentation for the AIDE file integrity monitoring implementation and process in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["security", "compliance", "file-integrity", "aide", "validation", "cisv8"]
category: "Security Validation"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **AIDE File Integrity Monitoring Process**

## 🔍 **1. Overview**

Advanced Intrusion Detection Environment (AIDE) is a **comprehensive file integrity monitoring tool** used in the Proxmox Astronomy Lab to **detect unauthorized changes to system files and configurations**. This section documents the **implementation, verification procedures, and monitoring process** that ensure system integrity and security.

AIDE creates a database of file attributes including **file permissions, ownership, content hashes, and timestamps**, then periodically checks these attributes against current system state to identify any modifications. This provides an **early warning system for possible intrusions or unauthorized changes**.

---

## 📋 **2. Documentation Structure**

This section contains the following key documents:

| **Document** | **Purpose** | **Content** |
|--------------|-------------|------------|
| [**aide-scan-results.md**](aide-scan-results.md) | Latest scan results | Detailed findings from the most recent AIDE scan |
| [**aide-verification-procedure.md**](aide-verification-procedure.md) | Verification procedure | Step-by-step instructions for verifying AIDE implementation |
| **README.md** | Process overview | General information about the AIDE process |

---

## 🔄 **3. Monitoring Process**

### **3.1 Scan Frequency**

AIDE scans are conducted at the following intervals:

| **Scan Type** | **Frequency** | **Trigger** |
|--------------|--------------|-------------|
| **Baseline** | Once | Initial system hardening |
| **Daily Check** | Daily | Scheduled via cron job |
| **Post-Update** | As needed | After system updates or changes |
| **On-Demand** | As needed | Security investigations |

### **3.2 Scan Execution Process**

The AIDE monitoring process follows these phases:

1. **Initialization Phase**
   - Initial database creation after system hardening
   - Comprehensive capture of file attributes

2. **Monitoring Phase**
   - Daily automated comparisons against baseline
   - Detection of file attribute changes

3. **Analysis Phase**
   - Classification of changes as expected or suspicious
   - Investigation of unexpected modifications

4. **Remediation Phase**
   - Addressing unauthorized changes
   - System recovery if necessary

5. **Update Phase**
   - Database updates after legitimate changes
   - Rebaselining as needed

---

## 🔐 **4. Implementation Details**

### **4.1 Installation and Configuration**

AIDE is installed on all systems with a standardized configuration:

```bash
# Installation
apt install aide aide-common

# Configuration file
/etc/aide/aide.conf

# Database locations
/var/lib/aide/aide.db
/var/lib/aide/aide.db.new
```

### **4.2 Monitored File Attributes**

AIDE is configured to monitor multiple file attributes:

| **Attribute** | **Code** | **Purpose** |
|--------------|----------|------------|
| **Permissions** | p | Detect permission changes that could enable privilege escalation |
| **Inode** | i | Identify file replacement or movement |
| **User/Group** | u/g | Detect ownership changes |
| **Size** | s | Identify content additions or removals |
| **Hash Values** | H | Detect content modifications (multiple algorithms) |
| **Access Time** | a | Track file access (disabled by default) |
| **Creation Time** | c | Track metadata changes |
| **Modification Time** | m | Track content modifications |

### **4.3 Monitored Locations**

AIDE focuses on critical system directories:

| **Location** | **Monitoring Level** | **Rationale** |
|--------------|---------------------|--------------|
| **/bin, /sbin, /usr/bin, /usr/sbin** | Full monitoring | System binaries integrity |
| **/etc** | Full monitoring | System configuration |
| **/boot** | Full monitoring | Boot integrity |
| **/lib, /lib64** | Full monitoring | System libraries |
| **/opt** | Full monitoring | Third-party applications |
| **/root** | Full monitoring | Root user environment |
| **/var/spool/cron** | Full monitoring | Scheduled tasks |
| **/home** | Excluded | User data (high change rate) |
| **/var/log** | Excluded | Log files (high change rate) |
| **/tmp, /var/tmp** | Excluded | Temporary files |

### **4.4 Scheduled Execution**

AIDE is configured to run daily via a cron job:

```bash
# /etc/cron.daily/dailyaidecheck
#!/bin/sh
/usr/bin/aide.wrapper --check | /usr/bin/mail -s "Daily AIDE check on $(hostname)" security@lab
```

---

## 📊 **5. Interpreting Results**

### **5.1 Understanding AIDE Output**

AIDE scan results use specific formatting to indicate changes:

| **Symbol** | **Meaning** | **Example** |
|------------|------------|-------------|
| **f+++** | New file added | `f+++++++++++++++++: /usr/src/linux-headers-6.8.0-54/file.h` |
| **f---** | File removed | `f----------------: /etc/old-config.conf` |
| **====** | File changed | `File: /etc/passwd` followed by attribute details |
| **p+** | Permission added | `p+: /etc/shadow` |
| **p-** | Permission removed | `p-: /usr/bin/example` |
| **m** | Mtime changed | `m: /etc/hosts` |
| **c** | Ctime changed | `c: /etc/hostname` |
| **s** | Size changed | `s: /etc/resolv.conf` |

### **5.2 Change Classification**

Changes detected by AIDE are classified as follows:

| **Change Type** | **Characteristics** | **Response** |
|-----------------|---------------------|--------------|
| **Expected System Updates** | Package updates, kernel changes | Update database after verification |
| **Planned Configuration Changes** | Documented changes to configs | Update database after verification |
| **Normal Activity** | Log rotation, temp files | No action needed if in excluded paths |
| **Suspicious Changes** | Unexpected binary changes, config modifications | Investigate immediately |
| **Critical Changes** | Permission changes to secure files, modified boot files | Treat as security incident |

---

## 🛠️ **6. Maintenance Procedures**

### **6.1 Database Updates**

AIDE's database requires updates after legitimate system changes:

```bash
# Create new database
aide --update

# Accept changes and replace database
cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
```

### **6.2 Performance Optimization**

AIDE is configured for optimal performance:

| **Optimization** | **Implementation** | **Benefit** |
|------------------|-------------------|------------|
| **Path Exclusions** | Exclude high-change directories | Reduce false positives |
| **Selective Hashing** | Use specific hash combinations | Balance security and performance |
| **Scheduled Execution** | Run during low-activity periods | Minimize system impact |
| **Resource Limits** | Set appropriate nice values | Prevent system overload |

---

## 🔄 **7. Integration with Security Framework**

AIDE is integrated with the broader security monitoring framework:

| **Integration Point** | **Implementation** | **Benefit** |
|-----------------------|-------------------|------------|
| **Email Alerts** | Daily scan reports | Immediate awareness of changes |
| **SIEM Integration** | Wazuh monitoring of AIDE logs | Centralized security monitoring |
| **Change Management** | Verification after approved changes | Maintain accurate baseline |
| **Incident Response** | AIDE scans during investigations | Evidence gathering |

---

## 🔗 **8. Related Documentation**

| **Documentation** | **Description** | **Link** |
|-------------------|----------------|---------|
| **RKHunter Process** | Complementary rootkit detection | [RKHunter Documentation](../07-rkhunter-audit/README.md) |
| **Chkrootkit Process** | Complementary rootkit detection | [Chkrootkit Documentation](../03-chkrootkit-scan/README.md) |
| **Security Controls** | Overall security framework | [Security Documentation](../../compliance-security/README.md) |
| **Incident Response** | Security incident handling | [IR Documentation](../../compliance-security/incident-response/README.md) |

---

## ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial AIDE process documentation | VintageDon |
