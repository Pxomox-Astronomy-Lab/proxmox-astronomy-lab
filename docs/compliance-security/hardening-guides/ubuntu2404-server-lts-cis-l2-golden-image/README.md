<!-- ---
title: "Ubuntu 24.04 LTS CIS Level 2 Golden Image Validation"
category: "Compliance & Security Hardening"
version: "1.0"
author: "Proxmox Astronomy Lab Documentation Team"
created: "2025-03-04"
updated: "2025-03-04"
compliance_mappings:
  - "CIS Ubuntu 24.04 LTS Level 2 Benchmark"
  - "NIST 800-53: SI-2, SI-6, CM-6, CM-7"
  - "ISO 27001: A.12.6.1, A.14.2.2"
tags: ["golden image", "CIS benchmark", "Linux hardening", "security validation", "compliance"]
---
 -->

## **1. Purpose**  

This directory contains security validation artifacts for the **Ubuntu 24.04 LTS CIS Level 2 Golden Image**. It documents security configurations and compliance checks performed before deployment.  

These measures ensure the **golden image** is hardened against security threats while aligning with **CIS benchmarks, NIST, and ISO 27001**.  

---

### **Scope of Validation**  

The following table outlines the key security validation areas covered in the **Ubuntu 24.04 LTS CIS Level 2 Golden Image**. These checks ensure the system is **hardened against security threats** and **aligned with compliance standards** before deployment.

| **Validation Area**            | **Description** |
|--------------------------------|----------------|
| **Mandatory Access Control (MAC)** | Enforces application confinement using **AppArmor** to restrict unauthorized actions. |
| **Host-based Intrusion Detection** | Implements **AIDE, chkrootkit, and rkhunter** to detect unauthorized modifications and malware. |
| **Logging & Auditing** | Ensures **auditd** and **rsyslog** are properly configured for security event logging. |
| **Automated Security Updates** | Verifies **unattended-upgrades** to ensure security patches are automatically applied. |
| **File Integrity Monitoring** | Validates system file integrity with **AIDE & rkhunter** scans. |
| **Network Hardening & SSH Security** | Enforces best practices for **SSH access control and system networking security**. |
| **Intrusion Prevention** | Ensures **Fail2Ban** is active to prevent brute-force attacks. |
| **Kernel Security Hardening** | Confirms **sysctl settings** are applied to enhance system resilience. |

These measures collectively **fortify the golden image against potential security threats**, ensuring a **secure and compliant baseline** for workloads.

---

## **3. Compliance Mappings**  

The following table shows how each validation step maps to established security frameworks:

| **Validation Area**          | **CIS Benchmark** | **NIST 800-53** | **ISO 27001** |
|-----------------------------|------------------|----------------|--------------|
| AppArmor MAC Enforcement    | 5.1.1 - 5.1.3    | AC-3, AC-6     | A.12.6.1     |
| File Integrity Monitoring   | 1.3.1 - 1.3.2    | SI-7           | A.12.6.1     |
| Logging & Auditing          | 4.1.1 - 4.1.3    | AU-3, AU-12    | A.12.4.1     |
| Automated Patch Management  | 1.9              | CM-6, CM-7     | A.12.5.1     |
| SSH Hardening               | 5.2.1 - 5.2.13   | AC-17          | A.14.2.2     |
| Kernel Hardening (Sysctl)   | 3.1.1 - 3.2.4    | SI-6           | A.12.6.1     |

---

## **4. Folder Structure**  

This directory follows the structure below:

```plaintext
golden-image-scan-results/
└── ubuntu2404-server-lts-cis-l2-golden-image/
    ├── app-armor-validation.md         # AppArmor security enforcement status
    ├── fail2ban-validation.md          # Intrusion prevention system logs
    ├── kernel-hardening.md             # Sysctl hardening & ASLR checks
    ├── unattended-upgrades.md          # Automated security patching validation
    ├── file-integrity.md               # AIDE file integrity scan results
    ├── rkhunter-scan.md                # Rootkit Hunter validation report
    ├── chkroot-scan.md                 # Chkrootkit malware detection results
    ├── lynis-scan-score.md             # System security audit score
    ├── README.md                       # This document
```

---

## **5. Validation Execution**  

To validate the golden image security posture, run the following commands.

### **5.1. AppArmor Status**  

```bash
aa-status
```

**Expected Output:**

```plaintext
apparmor module is loaded.
120 profiles are loaded.
25 profiles are in enforce mode.
4 profiles are in complain mode.
```

### **5.2. Fail2Ban Status**  

```bash
fail2ban-client status sshd
```

**Expected Output:**

```plaintext
Status for the jail: sshd
|- Filter
|  |- Currently failed: 0
|  |- Total failed:     3
|  `- File list:        /var/log/auth.log
`- Actions
   |- Currently banned: 1
   `- Banned IP list:   10.25.10.17
```

### **5.3. Kernel Hardening Check**  

```bash
sysctl -a | grep -E "kernel.randomize_va_space|net.ipv4.conf.all.accept_redirects|net.ipv4.conf.all.log_martians"
```

**Expected Output:**

```plaintext
kernel.randomize_va_space = 2
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.log_martians = 1
```

### **5.4. Audit Logging Status**  

```bash
systemctl status auditd
```

**Expected Output:**

```plaintext
● auditd.service - Security Auditing Service
   Loaded: loaded (/usr/lib/systemd/system/auditd.service; enabled; preset: enabled)
   Active: active (running) since Tue 2025-03-04 02:10:47 EST
   Main PID: 676 (auditd)
```

### **5.5. AIDE File Integrity Check**  

```bash
aide --check
```

**Expected Output:**

```plaintext
AIDE found NO differences between database and filesystem.
Looks okay!
```

### **5.6. Rootkit Hunter Scan**  

```bash
rkhunter --check
```

**Expected Output:**

```plaintext
System checks summary
---------------------
File properties checks...
   All hashes match
Rootkit checks...
   No rootkits detected
```

### **5.7. Chkrootkit Scan**  

```bash
chkrootkit
```

**Expected Output:**

```plaintext
ROOTDIR is `/'
Checking `passwd'... Not infected
Checking `sshd'... Not infected
Checking `hidden ports'... None found
```

### **5.8. Lynis Security Audit**  

```bash
lynis audit system
```

**Expected Output:**

```plaintext
Hardening index : 87
Tests performed : 243
```

### **5.9. Verify Unattended Upgrades**  

```bash
cat /etc/apt/apt.conf.d/20auto-upgrades
```

**Expected Output:**

```plaintext
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

---

## **6. Next Steps**  

- Configure a **cron job** to run security scans automatically.  
- Implement **centralized logging** using **ELK Stack** or **Graylog**.  
- Monitor **CIS benchmark updates** and apply necessary changes.  
- Review scan reports regularly and address any deviations from baseline security.  

---

## **7. Conclusion**  

The **Ubuntu 24.04 LTS CIS Level 2 Golden Image** provides a secure baseline for workloads by implementing **CIS-recommended security controls**.  

By following this validation process, we ensure that the **golden image is continuously monitored and maintained in a hardened state**.

---

## **8. References**  

- **CIS Benchmark for Ubuntu 24.04 LTS**: [https://www.cisecurity.org/benchmark/ubuntu_linux](https://www.cisecurity.org/benchmark/ubuntu_linux)  
- **NIST 800-53 Security Controls**: [https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)  

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | ✅ Approved |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |

