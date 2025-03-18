<!-- 
---
title: "AIDE File Permission Monitoring Process - Proxmox Astronomy Lab"
description: "Documentation for the AIDE file permission monitoring implementation and process in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["security", "compliance", "file-permissions", "aide", "validation", "cisv8"]
category: "Security Validation"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **AIDE File Permission Monitoring Process**

## 🔍 **1. Overview**

File permissions are a **critical security control** in Linux systems that determine which users can read, write, or execute files. The Proxmox Astronomy Lab uses **Advanced Intrusion Detection Environment (AIDE)** to continuously monitor file permissions, detecting unauthorized changes that could indicate security compromises or misconfigurations.

This document details our AIDE implementation's permission monitoring capabilities, explaining how we verify and manage permission changes as part of our comprehensive security program.

---

## 📋 **2. Documentation Structure**

This section contains the following key documents:

| **Document** | **Purpose** | **Content** |
|--------------|-------------|------------|
| [**aide-file-permissions-results.md**](aide-file-permissions-results.md) | Latest scan results | Analysis of permission changes from recent AIDE scan |
| [**aide-permission-monitoring-procedure.md**](aide-permission-monitoring-procedure.md) | Verification procedure | Validation of permission monitoring implementation |
| **README.md** | Process overview | General information about the permission monitoring process |

---

## 🔐 **3. Permission Attributes Monitored**

AIDE tracks multiple permission-related file attributes:

| **Attribute** | **Flag** | **Command Equivalent** | **Security Relevance** |
|--------------|----------|------------------------|--------------------|
| **File Permissions** | p | `ls -l` mode bits | Detect unauthorized permission changes |
| **User Ownership** | u | `ls -l` user field | Detect ownership transfers |
| **Group Ownership** | g | `ls -l` group field | Detect group changes |
| **Inode** | i | `ls -i` | Detect file replacement |
| **Special Bits** | p (includes) | `ls -l` setuid/setgid/sticky | Detect privilege escalation vectors |
| **ACLs** | acl | `getfacl` | Detect complex permission changes |

Our AIDE configuration defines these attributes in rule sets:

```bash
# From /etc/aide/aide.conf
# Permission-specific monitoring rules
PERMS = p+i+u+g
NORMAL = R+PERMS+sha256
DATAONLY = sha256
```

---

## 🔍 **4. Permission Monitoring Examples**

AIDE reports permission-related attributes using specific formatting. Examples from our scan results:

### **4.1 No Permission Changes**

```bash
f =.... mci.-.. . : /usr/lib/tmpfiles.d/snapd.conf
```

The notation shows:

- `=` - file exists in both databases
- `.` in `p` position - no permission changes
- `.` in `u` and `g` positions - no ownership changes
- Changes in other attributes (`m`=mtime, `c`=ctime, `i`=inode)

### **4.2 Directory Permission Monitoring**

```bash
d =.... mc.. .. . : /usr/lib/udev
d =.... mc.. .. . : /usr/lib/udev/rules.d
```

The `d` prefix identifies directories with:

- Stable permissions (`.` in `p` position)
- Stable ownership (`.` in `u` and `g` positions)
- Only metadata changes (timestamps)

### **4.3 Permission Changes with Content**

```bash
File: /etc/security/limits.conf
 Size      : 2752                             | 2806
 Mtime     : 2024-04-10 15:19:22 -0400        | 2025-02-23 09:22:39 -0500
 Ctime     : 2025-02-22 20:57:57 -0500        | 2025-02-23 09:22:39 -0500
 SHA512    : p066os2GV0mDwcopSqKGDqwoD6RrEZDY | 18CedYRUmgccfBxdcPe4TAJ6vXRswmDy
```

This detailed comparison shows content changes while implicitly verifying permissions remained unchanged.

---

## 🔄 **5. Permission Monitoring Process**

### **5.1 Baseline Establishment**

```bash
# Initialize AIDE database after secure configuration
aide --init
cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
```

This baseline captures the proper permission state after system hardening.

### **5.2 Daily Permission Verification**

```bash
# Daily check from cron job
/usr/bin/aide.wrapper --check
```

Daily checks verify all monitored files maintain their secure permission state.

### **5.3 Permission Change Analysis Process**

When AIDE detects changes, we follow this analysis workflow:

1. **Identify change type** - Permission, ownership, or combined with content
2. **Assess security impact** - Criticality based on file type and permission change
3. **Verify authorization** - Match against change records and approvals
4. **Take action** - Update database for authorized changes; revert unauthorized changes
5. **Document findings** - Record analysis and actions taken

---

## 📊 **6. CIS Benchmark Alignment**

AIDE permission monitoring directly supports numerous CIS controls:

| **CIS Control** | **Description** | **AIDE Monitoring** |
|-----------------|----------------|---------------------|
| **CIS 6.1.1** | /etc/passwd permissions (644) | Continuous verification |
| **CIS 6.1.2** | /etc/shadow permissions (640) | Continuous verification |
| **CIS 6.1.3-4** | /etc/group & gshadow permissions | Continuous verification |
| **CIS 6.1.5-8** | Authentication file ownership | Ownership monitoring |
| **CIS 6.1.9-12** | Various key file permissions | Comprehensive monitoring |

Implementation through specific monitoring rules:

```bash
# CIS benchmark file permission monitoring
/etc/passwd PERMS+CONTENT
/etc/shadow PERMS+CONTENT
/etc/group PERMS+CONTENT
/etc/gshadow PERMS+CONTENT
/etc/ssh PERMS+CONTENT
/etc/sudoers PERMS+CONTENT
/etc/sudoers.d PERMS+CONTENT
```

---

## 🔒 **7. Critical Permission Categories**

Our permission monitoring focuses on several critical categories:

### **7.1 System Binary Permissions**

```bash
# No permission changes detected on system binaries
Entry /usr/bin/kernel-install in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
Entry /usr/bin/kill in databases has different attributes: -md5-sha1-rmd160-tiger-crc32-haval-gost-crc32b-sha256-whirlpool
```

System binaries must maintain 755 permissions and root ownership. AIDE verifies permissions remain stable even after system updates.

### **7.2 Configuration File Permissions**

```bash
File: /etc/security/limits.conf
 Size      : 2752                             | 2806
 Mtime     : 2024-04-10 15:19:22 -0400        | 2025-02-23 09:22:39 -0500
 Ctime     : 2025-02-22 20:57:57 -0500        | 2025-02-23 09:22:39 -0500
```

Configuration files typically require 644 permissions. AIDE verifies these permissions remain intact despite content changes.

### **7.3 Authentication File Permissions**

```bash
File: /etc/shadow
 Size      : 1085                             | 1114
 Mtime     : 2025-02-22 21:06:58 -0500        | 2025-02-22 23:07:31 -0500
 Ctime     : 2025-02-22 21:06:58 -0500        | 2025-02-22 23:07:31 -0500
```

Authentication files have strict permission requirements (640 for shadow). AIDE continuously verifies these critical files maintain secure permissions.

### **7.4 Special Permission Bit Monitoring**

```bash
# Example monitoring of setuid binaries
f =.... mci.H.. . : /usr/bin/sudo
f =.... mci.H.. . : /usr/bin/passwd
```

Files with special permission bits (setuid/setgid) receive enhanced scrutiny. AIDE verifies these security-sensitive permissions remain unchanged.

### **7.5 Device and System Files**

```bash
f =.... .ci.-.. . : /usr/lib/udev/rules.d/50-apport.rules
f =.... mci.-.. . : /usr/lib/udev/rules.d/55-dm.rules
```

Device-related files require specific permissions to function securely. AIDE verifies these permissions remain stable across system updates.

---

## 🛠️ **8. Permission Change Detection**

### **8.1 Permission Change Flags**

AIDE uses a detailed notation system to flag permission changes:

| **Symbol** | **Position** | **Meaning** | **Example** |
|------------|------------|------------|------------|
| `.` | p position | Permissions unchanged | `=....` |
| `+` | p position | Permissions added | `=+...` |
| `-` | p position | Permissions removed | `=-...` |
| `.` | u position | User unchanged | `=.....` |
| `+` | u position | User changed | `=....+` |
| `.` | g position | Group unchanged | `=......` |
| `+` | g position | Group changed | `=.......+` |

This precise flagging ensures accurate identification of permission changes.

### **8.2 Permission Change Patterns**

AIDE detects several common permission change patterns:

| **Pattern** | **Security Concern** | **Detection Method** |
|-------------|---------------------|---------------------|
| **Privilege Escalation** | Adding setuid/setgid bits | Permission flag changes |
| **Permission Relaxation** | Making restricted files world-readable | Permission flag changes |
| **Ownership Transfer** | Changing file ownership | User/group flag changes |
| **Permission with Content** | Combined permission and content changes | Multiple flag changes |
| **Permission-only** | Permission changes without content changes | Isolated permission flags |

### **8.3 Verification Commands**

Critical permission monitoring tasks use these commands:

```bash
# Verify file permissions manually
ls -la /path/to/file

# Check extended attributes
getfacl /path/to/file

# Verify AIDE database entry for a file
aide --check --config=/etc/aide/aide.conf /path/to/file

# Update AIDE database after verified permission changes
aide --update
cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
```

---

## 🔄 **9. Integration with Security Framework**

Permission monitoring integrates with our broader security controls:

| **Integration Point** | **Implementation** | **Example** |
|-----------------------|-------------------|------------|
| **CIS Hardening** | Validates CIS permission requirements | Shadow file permission validation |
| **Change Management** | Permission changes require approval | Database updates after changes |
| **Incident Response** | Permission issues trigger alerts | Unauthorized setuid bit addition |
| **Compliance Reporting** | Permission status in reports | CIS compliance verification |
| **Risk Management** | Categorizes issues by risk level | Critical for sensitive files |

---

## 🔬 **10. Advanced Permission Monitoring**

### **10.1 Complex Permission Structures**

For systems with complex permissions, additional AIDE configurations monitor:

```bash
# Monitor ACLs for specific directories
/srv/data PERMS+acl+xattrs
/opt/custom PERMS+acl+xattrs
```

### **10.2 Large-Scale Permission Management**

For directories with many files, we balance comprehensive monitoring with performance:

```bash
# Top-level monitoring for efficiency
/var PERMS
# Detailed monitoring for sensitive subdirectories
/var/log PERMS+sha256
/var/spool/cron PERMS+sha256
```

### **10.3 Permissions for Special File Types**

AIDE monitors permissions on special file types:

```bash
# Socket file permission monitoring
s =.... mci.-.. . : /var/run/example.sock

# Device file permission monitoring 
b =.... mci.-.. . : /dev/sda
c =.... mci.-.. . : /dev/tty0
```

The file type prefix (`s`, `b`, `c`) allows specialized handling of different file types.

---

## 🔗 **11. Related Documentation**

| **Documentation** | **Description** | **Link** |
|-------------------|----------------|---------|
| **AIDE Overview** | Complete AIDE implementation | [AIDE Documentation](../aide-overview/README.md) |
| **CIS Hardening Guide** | File permission requirements | [CIS Documentation](../../compliance-security/cis-controls/README.md) |
| **System Permissions** | Ubuntu permission standards | [System Permissions](../../hardening-guides/ubuntu-24-04/file-permissions.md) |
| **Permission Audit** | Manual verification process | [Audit Procedures](../../compliance-security/audit-procedures/permission-audit.md) |

---

## ✅ **12. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **13. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial permission monitoring documentation | VintageDon |
