<!-- 
---
title: "CIS Audit Rules Compliance - Proxmox Astronomy Lab"
description: "Implementation and verification of CIS Ubuntu 24.04 L2 audit rules using Neo23x0 enhanced ruleset with compliance patches"
author: "VintageDon"
tags: ["security", "compliance", "cisv8", "audit", "ubuntu", "neo23x0"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **CIS Audit Rules Compliance**

## 🔍 **1. Overview**

This documentation details our **implementation of CIS Level 2 compliant audit rules** for Ubuntu 24.04 LTS within the Proxmox Astronomy Lab. We use a **hybrid implementation approach** that leverages the comprehensive **Neo23x0 security-focused ruleset** supplemented with **targeted compliance patches** to ensure complete alignment with CIS benchmarks.

This approach ensures both **robust security monitoring capabilities** and **formal compliance** with CIS Ubuntu 24.04 Level 2 requirements.

---

## 🎯 **2. Purpose & Scope**

### **2.1 Purpose**

The purpose of our audit rules implementation is to:

- **Ensure comprehensive compliance** with CIS Ubuntu 24.04 Level 2 controls
- **Extend security monitoring** beyond basic compliance requirements
- **Detect and record security-relevant events** across all system components
- **Support forensic analysis** of potential security incidents
- **Align with MITRE ATT&CK framework** for threat detection

### **2.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| CIS Ubuntu 24.04 L2 audit requirements | Windows system audit implementation |
| Neo23x0 enhanced security monitoring | Network traffic analysis |
| System call and command execution auditing | Application-level logging |
| File integrity and access monitoring | User activity monitoring outside audit context |
| Privileged operations logging | Real-time alerting (handled separately) |

---

## 📚 **3. Implementation Components**

Our implementation consists of three primary components that work together to provide a comprehensive and compliant audit solution:

### **3.1 Neo23x0 Base Ruleset**

The foundation of our audit implementation is the security-focused Neo23x0 ruleset that provides extensive coverage of potential attack vectors and security events.

| **Component** | **Location** | **Purpose** |
|--------------|-------------|------------|
| **Neo23x0 Rules** | `/etc/audit/rules.d/audit.rules` | Comprehensive security monitoring |

### **3.2 CIS Compliance Patch**

To address specific CIS requirements not fully covered by Neo23x0, we implement a supplemental rules file.

| **Component** | **Location** | **Purpose** |
|--------------|-------------|------------|
| **CIS Patch** | `/etc/audit/rules.d/99-cis-compliance-fixes.rules` | Address specific CIS compliance gaps |

### **3.3 Verification Script**

To ensure ongoing compliance, we maintain a verification script that validates all required CIS controls.

| **Component** | **Location** | **Purpose** |
|--------------|-------------|------------|
| **Verification Script** | `/scripts/04-CISv81-L2-ubuntu2404-verify-logging.sh` | Validate CIS L2 audit compliance |

---

## ⚙️ **4. CIS Compliance Details**

### **4.1 CIS Controls Coverage**

The following CIS controls are verified by our implementation:

| **Control** | **Description** | **Implementation** |
|-------------|----------------|-------------------|
| **4.1.3.1** | System administration scope changes | Monitor `/etc/sudoers` and `/etc/sudoers.d/` |
| **4.1.3.2** | Actions as another user | Track user emulation via `execve` |
| **4.1.3.3** | Sudo log file modifications | Monitor `/var/log/sudo.log` |
| **4.1.3.4** | Date/time changes | Monitor time-related syscalls and `/etc/localtime` |
| **4.1.3.5** | Network environment changes | Monitor hostname changes and network configs |
| **4.1.3.6** | MAC policy changes | Monitor AppArmor directories |
| **4.1.3.7** | Login/logout events | Monitor login log files |
| **4.1.3.8** | Session initiation | Monitor session tracking files |
| **4.1.3.9** | Permission changes | Monitor `chmod`/`chown` operations |
| **4.1.3.10** | Unauthorized access attempts | Monitor failed file access |
| **4.1.3.11** | File system mounts | Monitor mount operations |
| **4.1.3.12** | File deletion events | Monitor file deletion operations |
| **4.1.3.13** | Sudo command usage | Monitor sudo operations |
| **4.1.3.14** | Kernel module operations | Monitor module loading/unloading |
| **4.1.3.15** | Suspicious activity | Monitor suspicious commands |
| **4.1.3.16** | Immutable configuration | Set `-e 2` flag |

### **4.2 Compliance Patch Details**

Our compliance patch specifically addresses gaps in the Neo23x0 ruleset for CIS compliance:

```bash
# 4.1.3.3 Ensure events that modify the sudo log file are collected
-w /var/log/sudo.log -p wa -k sudo_log_file

# 4.1.3.6 Ensure events that modify the system's Mandatory Access Controls are collected
-w /etc/apparmor/ -p wa -k MAC-policy
-w /etc/apparmor.d/ -p wa -k MAC-policy

# 4.1.3.9 Ensure discretionary access control permission modification events are collected
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=unset -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=unset -k perm_mod
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=unset -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=unset -k perm_mod

# 4.1.3.16 Ensure the audit configuration is immutable
-e 2
```

---

## 🔐 **5. Neo23x0 Enhanced Security Features**

The Neo23x0 ruleset provides numerous security enhancements beyond standard CIS requirements. The following table highlights key security capabilities:

| **Category** | **Feature** | **Description** | **Example Rule** |
|--------------|------------|-----------------|------------------|
| **MITRE ATT&CK Integration** | Technique Tagging | Rules tagged with MITRE IDs | `-a always,exit -F path=/usr/libexec/sssd/p11_child -F perm=x -F auid>=500 -F auid!=4294967295 -k T1078_Valid_Accounts` |
| **Data Exfiltration** | Compression Monitoring | Tracks potential data staging | `-w /usr/bin/zip -p x -k Data_Compressed` |
| **Lateral Movement** | Remote Shell Detection | Detects backdoor shells | `-a always,exit -F arch=b64 -F exe=/bin/bash -F success=1 -S connect -k remote_shell` |
| **Reconnaissance** | System Enumeration | Tracks information gathering | `-w /usr/bin/whoami -p x -k recon` |
| **Privilege Escalation** | Suspicious Commands | Monitors potential exploits | `-w /usr/bin/pkexec -p x -k pkexec` |
| **Defense Evasion** | Suspicious Shell Usage | Tracks unusual shells | `-w /bin/ash -p x -k susp_shell` |
| **IPC Monitoring** | Process Communication | Tracks inter-process comms | `-a always,exit -F arch=b64 -S msgctl -k Inter-Process_Communication` |
| **Root Activity** | Privileged Commands | Tracks root executions | `-a always,exit -F arch=b64 -F euid=0 -F auid>=1000 -F auid!=-1 -S execve -k rootcmd` |
| **File Operations** | Deletion Tracking | Monitors file removal | `-a always,exit -F arch=b64 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=-1 -k delete` |
| **Software Management** | Package Operations | Tracks software changes | `-w /usr/bin/apt -p x -k software_mgmt` |

These enhanced security features provide comprehensive monitoring capabilities that exceed standard compliance requirements, allowing for more effective threat detection and incident response.

---

## 🔄 **6. Verification Process**

We employ a zero-trust approach to compliance verification, ensuring that each required control is explicitly checked regardless of the source of the rules.

### **6.1 Verification Script**

Our verification script checks each CIS control independently by examining the actual audit rules deployed on the system. This approach ensures that:

1. We verify actual compliance rather than assumed compliance
2. Changes to rule format or location will be detected
3. Compliance can be maintained even when updating the Neo23x0 ruleset

### **6.2 Verification Output**

Successful verification output confirms compliance with all CIS L2 audit controls:

```bash
CIS Ubuntu 24.04 LTS - Section 4.1: Audit Rules Validation
================================================================================
[ INFO ] Checking audit rules in: /etc/audit/rules.d/99-cis-compliance-fixes.rules

4.1.3 Ensure audit configuration rules exist
================================================================================
[ PASS ] 4.1.3.1 Ensure changes to system administration scope is collected
[ PASS ] 4.1.3.2 Ensure actions as another user are always logged
...
[ PASS ] 4.1.3.16 Ensure audit configuration is immutable

Neo23x0 Extended Security Checks
================================================================================
[ PASS ] Neo23x0: Ensure suspicious activities are monitored
[ PASS ] Neo23x0: Ensure remote shell usage is monitored
[ PASS ] Neo23x0: Ensure data compression is monitored
[ PASS ] Neo23x0: Ensure MITRE ATT&CK techniques are monitored
```

---

## 🚀 **7. Implementation Guide**

### **7.1 Installation Steps**

To implement the CIS-compliant audit rules:

1. **Deploy the Neo23x0 ruleset**:

   ```bash
   wget -O /etc/audit/rules.d/audit.rules https://raw.githubusercontent.com/Neo23x0/auditd/master/audit.rules
   ```

2. **Deploy the CIS compliance patch**:

   ```bash
   cp 99-cis-compliance-fixes.rules /etc/audit/rules.d/
   ```

3. **Load the updated rules**:

   ```bash
   sudo augenrules --load
   ```

4. **Verify compliance**:

   ```bash
   ./04-CISv81-L2-ubuntu2404-verify-logging.sh
   ```

### **7.2 Maintenance Considerations**

When updating the Neo23x0 ruleset:

1. Preserve a copy of the current working ruleset before updating
2. After updating, re-run the verification script to identify any compliance gaps
3. Update the compliance patch as needed to address any identified gaps
4. Document any changes to rule formats or locations that required patch updates

---

## 🔗 **8. Related Documentation**

| **Document** | **Purpose** | **Location** |
|--------------|------------|-------------|
| **CIS Benchmark Documentation** | Reference for CIS controls | [Compliance-Security/CIS-Controls](../compliance-security/CIS-Controls/README.md) |
| **Audit Log Analysis** | Procedures for reviewing audit logs | [Security-Monitoring/Audit-Logging](../security-monitoring/audit-logging/README.md) |
| **Security Incident Response** | Procedures for security events | [Incident-Response](../compliance-security/incident-response/README.md) |
| **Script Reference** | Usage guide for all security scripts | [Security-Automation](../compliance-security/security-automation/README.md) |

---

## ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |
