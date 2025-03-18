<!-- 
---
title: "File System Configuration - CIS Ubuntu 24.04 L1 Implementation"
description: "Documentation of the file system security controls implemented for Ubuntu 24.04 servers in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["hardening", "security", "cisv8", "ubuntu", "file-system", "tenable"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# **File System Configuration - CIS Ubuntu 24.04 L1 Implementation**

## **1. Overview**

### **1.1 Purpose**

This document details the specific implementation of CIS Ubuntu 24.04 Level 1 file system security controls within the Proxmox Astronomy Lab environment. It documents our partitioning scheme, mount options, and file permission configurations as implemented in our golden image. These controls address CIS controls 1.1.1 through 1.1.14 and form the foundation of our system hardening strategy.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Partition layout on Ubuntu 24.04 server images | Desktop Ubuntu configurations |
| Mount options implemented for all system partitions | Application-specific filesystems |
| File system permissions and ownership | Runtime mount adjustments |
| Sticky bit implementation on world-writable directories | Custom storage configurations |

### **1.3 Target Audience**

This document is intended for System Engineers responsible for maintaining the golden images, Security Administrators verifying compliance, and Compliance Auditors reviewing Tenable scan results.

---

## **2. Partition Implementation**

### **2.1 Current Partition Layout**

Our Ubuntu 24.04 server implementation uses the following partition layout to satisfy CIS requirements:

```bash
Filesystem     Type      Size  Used Avail Use% Mounted on
/dev/sda3      ext4      7.8G  3.0G  4.5G  40% /
tmpfs          tmpfs     983M     0  983M   0% /dev/shm
/dev/sda6      ext4      4.9G  424M  4.2G  10% /var
/dev/sda5      ext4      7.8G   22M  7.4G   1% /home
/dev/sda4      ext4      2.0G   84K  1.8G   1% /tmp
/dev/sda2      ext4      974M  186M  721M  21% /boot
/dev/sda8      ext4      974M  142M  765M  16% /var/log
/dev/sda7      ext4      2.0G   72K  1.8G   1% /var/tmp
/dev/sda1      vfat      1.1G  6.2M  1.1G   1% /boot/efi
/dev/sda9      ext4      974M   30M  877M   4% /var/log/audit
```

This layout satisfies CIS requirements 1.1.1 through 1.1.13 by implementing separate partitions for critical directories.

### **2.2 Mount Options**

The following secure mount options have been configured in `/etc/fstab`:

```bash
# Root filesystem - must be mounted securely with default options.
# Controls: CIS 1.1.1, ISO 27001 A.11.2.5, NIST CM-6
/dev/disk/by-uuid/63a4b01b-fc1a-475b-bfe7-87d97a7b33c5 / ext4 defaults 0 1

# Secure /tmp mount - Prevents execution of binaries and device files.
# Controls: CIS 1.1.2, ISO 27001 A.12.1.3, NIST CM-6, SI-16
/dev/disk/by-uuid/c08646e5-c863-4ef1-8bcb-43522d9f56a3 /tmp ext4 defaults,nodev,noexec,nosuid 0 1

# /var mount - NOT set as noexec to prevent dpkg-related issues.
# Controls: CIS 1.1.3, ISO 27001 A.11.2.5, NIST CM-6
/dev/disk/by-uuid/f03346fe-2745-405c-ab9f-ecdb7c884476 /var ext4 defaults 0 1

# Secure /var/tmp mount - Same restrictions as /tmp.
# Controls: CIS 1.1.4, ISO 27001 A.12.1.3, NIST CM-6, SI-16
/dev/disk/by-uuid/2d751f60-638b-4d93-9410-6123fa5e9fb8 /var/tmp ext4 defaults,nodev,noexec,nosuid 0 1

# Secure /var/log mount - Critical for log integrity.
# Controls: CIS 1.1.5, ISO 27001 A.12.4.3, NIST AU-9
/dev/disk/by-uuid/e9e17709-5953-4dd8-a9c2-2f683398d3a0 /var/log ext4 defaults,nodev,noexec,nosuid 0 1

# Secure /var/log/audit mount - Prevents unauthorized modification.
# Controls: CIS 1.1.6, ISO 27001 A.12.4.3, NIST AU-9
/dev/disk/by-uuid/ed3f0a97-e4d3-4fb2-b560-fba05ee6ac59 /var/log/audit ext4 defaults,nodev,noexec,nosuid 0 1

# Secure /home mount - Prevent execution of binaries.
# Controls: CIS 1.1.8, ISO 27001 A.11.2.5, NIST CM-6
/dev/disk/by-uuid/1434d62f-eaf7-484e-861a-2dc0a4c2fa17 /home ext4 defaults,nodev 0 1

# Secure /boot mount - Protects bootloader.
# Controls: CIS 1.1.9, ISO 27001 A.12.1.3, NIST CM-6
/dev/disk/by-uuid/b44d3bfa-cc88-4440-9ae3-9b27a568ec0a /boot ext4 defaults,nodev,noexec,nosuid 0 1

# Secure /boot/efi mount - Prevents unauthorized modifications.
# Controls: CIS 1.1.10, ISO 27001 A.12.1.3, NIST CM-6
/dev/disk/by-uuid/097C-0EAF /boot/efi vfat defaults,nodev,noexec,nosuid 0 1

# /dev/shm should be mounted as tmpfs with nodev, noexec, nosuid to prevent execution of unauthorized binaries.
tmpfs /dev/shm tmpfs defaults,nodev,noexec,nosuid 0 0
```

Note that these configurations are implemented during system deployment via Ansible in the Ubuntu 24.04 golden image creation process.

---

## **3. Implementation Status**

The following table summarizes our implementation status for CIS file system security controls:

| **Control ID** | **Description** | **Implementation Status** | **Notes** |
|----------------|----------------|------------|-----------|
| 1.1.1.1 | Ensure /tmp is a separate partition | ✅ Implemented | 2.0GB ext4 partition |
| 1.1.1.2 | Ensure nodev option set on /tmp | ✅ Implemented | Applied via fstab |
| 1.1.1.3 | Ensure nosuid option set on /tmp | ✅ Implemented | Applied via fstab |
| 1.1.1.4 | Ensure noexec option set on /tmp | ✅ Implemented | Applied via fstab |
| 1.1.2 | Ensure /var is a separate partition | ✅ Implemented | 4.9GB ext4 partition |
| 1.1.3 | Ensure /var/tmp is a separate partition | ✅ Implemented | 2.0GB ext4 partition |
| 1.1.4 | Ensure nodev option set on /var/tmp | ✅ Implemented | Applied via fstab |
| 1.1.5 | Ensure nosuid option set on /var/tmp | ✅ Implemented | Applied via fstab |
| 1.1.6 | Ensure noexec option set on /var/tmp | ✅ Implemented | Applied via fstab |
| 1.1.7 | Ensure /var/log is a separate partition | ✅ Implemented | 974MB ext4 partition |
| 1.1.8 | Ensure /var/log/audit is a separate partition | ✅ Implemented | 974MB ext4 partition |
| 1.1.9 | Ensure /home is a separate partition | ✅ Implemented | 7.8GB ext4 partition |
| 1.1.10 | Ensure nodev option set on /home | ✅ Implemented | Applied via fstab |
| 1.1.11 | Ensure nodev option set on /dev/shm | ✅ Implemented | tmpfs with nodev |
| 1.1.12 | Ensure nosuid option set on /dev/shm | ✅ Implemented | tmpfs with nosuid |
| 1.1.13 | Ensure noexec option set on /dev/shm | ✅ Implemented | tmpfs with noexec |
| 1.1.14 | Ensure sticky bit on world-writable directories | ✅ Implemented | Applied via Ansible |

---

## **4. World-Writable Directories**

### **4.1 Sticky Bit Implementation**

CIS control 1.1.14 requires the sticky bit be set on all world-writable directories to prevent users from deleting or renaming files in these directories that they do not own.

This control is implemented during system initialization via Ansible:

```yaml
# From roles/ubuntu-hardening/tasks/filesystem.yml
- name: Set sticky bit on all world-writable directories
  ansible.builtin.shell: |
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d -perm -0002 -not -perm -1000 -exec chmod +t {} \;
  changed_when: false
  tags:
    - security
    - cis_1_1_14
```

Additionally, this control is checked during weekly compliance scans using the following command:

```bash
find / -path /proc -prune -o -type d -perm -0002 -not -perm -1000 -ls 2>/dev/null
```

Deviations trigger alerts in Wazuh and are reported to the Security team.

---

## **5. Boot Security**

### **5.1 Bootloader File Security**

The following controls ensure that bootloader files are properly secured:

| **Control ID** | **Description** | **Implementation** |
|----------------|----------------|-------------------|
| 1.4.1 | Ensure bootloader entries are owned by root | File ownership set to root:root |
| 1.4.2 | Ensure bootloader entries have correct permissions | File permissions set to 0400 |

These controls are enforced via Ansible during system deployment:

```yaml
- name: Secure bootloader files
  ansible.builtin.file:
    path: "{{ item }}"
    owner: root
    group: root
    mode: '0400'
  loop:
    - /boot/grub/grub.cfg
    - /boot/grub/user.cfg
  tags:
    - security
    - cis_1_4_1
    - cis_1_4_2
```

---

## **6. Verification Methods**

### **6.1 Automated Verification Script**

The lab uses a standardized script for verifying compliance with CIS file system controls:

```bash
# Execute the filesystem verification script
sudo ./01-CISv81-l1-ubuntu2404-verify-filesystem.sh
```

This script provides a comprehensive check of all file system controls with clear pass/fail indicators:

```bash
CIS Ubuntu 24.04 File System Controls Verification
==================================================
✅ PASS: 1.1.1.1 - /tmp is a separate partition
✅ PASS: 1.1.1.2 - nodev option is set on /tmp
✅ PASS: 1.1.1.3 - nosuid option is set on /tmp
✅ PASS: 1.1.1.4 - noexec option is set on /tmp
✅ PASS: 1.1.2 - /var is a separate partition
✅ PASS: 1.1.3 - /var/tmp is a separate partition
✅ PASS: 1.1.4 - nodev option is set on /var/tmp
✅ PASS: 1.1.5 - nosuid option is set on /var/tmp
✅ PASS: 1.1.6 - noexec option is set on /var/tmp
✅ PASS: 1.1.7 - /var/log is a separate partition
✅ PASS: 1.1.8 - /var/log/audit is a separate partition
✅ PASS: 1.1.9 - /home is a separate partition
✅ PASS: 1.1.10 - nodev option is set on /home
✅ PASS: 1.1.11 - nodev option is set on /dev/shm
✅ PASS: 1.1.12 - nosuid option is set on /dev/shm
✅ PASS: 1.1.13 - noexec option is set on /dev/shm
Checking sticky bit on world-writable directories (1.1.14)...
✅ PASS: 1.1.14 - All world-writable directories have the sticky bit set
Checking bootloader file security...
✅ PASS: 1.4.1 - Bootloader is owned by root:root
✅ PASS: 1.4.2 - Bootloader has correct permissions (400)
=== Summary ===
All file system controls passed!
```

The script automatically checks:

- Separate partitions for critical directories
- Required mount options (nodev, nosuid, noexec)
- Sticky bit on world-writable directories
- Bootloader file ownership and permissions

If any control fails, the script will highlight it with a red ❌ indicator and provide details on the current state vs. required state.

### **6.2 Continuous Compliance Monitoring**

Weekly Tenable CIS benchmark scans verify ongoing compliance with these controls. Compliance reports are available in the Tenable SC dashboard at `https://tenable.proxastro.local`.

For on-demand verification across multiple systems, use the compliance check Ansible playbook:

```bash
ansible-playbook playbooks/security/cis-check-filesystem.yml -l [target_host]
```

### **6.3 Remediation Commands**

If verification identifies non-compliant settings, use these commands to remediate:

- **Fix bootloader permissions**: `sudo chmod 0400 /boot/grub/grub.cfg`
- **Set sticky bit on world-writable directories**: `sudo find / -path /proc -prune -o -type d -perm -0002 -not -perm -1000 -exec chmod +t {} \;`
- **Fix mount options**: Edit `/etc/fstab` and remount with `sudo mount -o remount [path]`

---

## **7. Process Integration**

### **7.1 ITIL Process Relationship**

| **ITIL Process** | **Relationship to File System Controls** |
|-----------------|----------------------------------------|
| Change Management | Changes to partition layout require RFC and CAB approval |
| Configuration Management | Golden image build process includes these controls |
| Release Management | New Ubuntu server versions require validation of these controls |
| Incident Management | Compliance failures trigger security incidents |

### **7.2 Role Responsibilities**

| **Role** | **Responsibility Related to This Article** |
|----------|--------------------------------------------|
| System Engineer | Implements partitioning during image creation |
| Security Administrator | Verifies compliance via Tenable scans |
| Change Manager | Reviews proposed changes to partitioning scheme |
| Release Manager | Ensures new server releases meet these controls |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial version | VintageDon |
