<!-- 
---
title: "CIS Ubuntu 24.04 Level 2 Filesystem Configuration"
description: "Detailed guidance for implementing CIS Level 2 filesystem configuration controls for Ubuntu Server 24.04"
author: "VintageDon"
tags: ["security", "hardening", "ubuntu", "cisv8", "compliance", "filesystem", "partitioning"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **CIS Ubuntu 24.04 Level 2 Filesystem Configuration**

## 🔍 **1. Overview**

This section provides detailed guidance for implementing **CIS Level 2 filesystem security controls** for Ubuntu Server 24.04 systems. These controls extend beyond Level 1 requirements to provide enhanced security through proper partitioning, restrictive mount options, and filesystem integrity verification.

Level 2 filesystem hardening focuses on **comprehensive partition isolation** with strict mount options, ensuring each critical filesystem component has appropriate security attributes to prevent privilege escalation and protect system integrity.

---

## 📊 **2. Control Objectives**

The filesystem security controls address several key security objectives:

1. **Isolation of system components** through separate partitions
2. **Prevention of privilege escalation** via nosuid, nodev, and noexec options
3. **Protection of critical filesystem areas** from overflow and abuse
4. **Regular integrity checking** to detect unauthorized modifications
5. **Secure boot configuration** to prevent unauthorized system access

These controls collectively reduce the attack surface and limit the impact of compromises.

---

## 🔒 **3. Required Partitioning Structure**

The CIS Level 2 benchmark requires a more comprehensive partitioning scheme than Level 1. The following table outlines the required partition structure and mount options:

| **Partition** | **Purpose** | **Required Mount Options** | **CIS Control** |
|---------------|-------------|---------------------------|----------------|
| **/tmp** | Temporary file storage | nodev, nosuid, noexec | 1.1.1.x |
| **/var** | Variable data | nosuid | 1.1.15 |
| **/var/tmp** | Persistent temporary storage | nodev, nosuid, noexec | 1.1.5-7 |
| **/var/log** | System logs | nodev, nosuid, noexec | 1.1.16-18 |
| **/var/log/audit** | Audit logs | nodev, nosuid, noexec | 1.1.19-21 |
| **/home** | User data | nodev | 1.1.11 |
| **/dev/shm** | Shared memory | nodev, nosuid, noexec | 1.1.2.x |

This partitioning scheme provides defense-in-depth by limiting the impact of various attacks:

- Prevents executable files in user-writable areas
- Blocks device file creation in non-system partitions
- Mitigates privilege escalation via SUID/SGID binaries

---

## 💻 **4. Implementation Guidelines**

### **4.1 Creating a Properly Partitioned System**

For new installations, the partitioning should be performed during the initial setup:

1. Use the Ubuntu Server installer's manual partitioning option
2. Create separate partitions for each required mount point
3. Apply appropriate filesystem types (typically ext4)
4. Configure mount options according to CIS requirements

For existing systems, repartitioning is challenging but can be accomplished by:

- Backing up data to external storage
- Using tools like GParted from a live environment
- Recreating the partition scheme
- Restoring data to appropriate partitions

### **4.2 Configuring Mount Options**

To apply the required mount options, edit `/etc/fstab`:

```bash
# Example /etc/fstab entries with CIS L2 compliant mount options
UUID=xxxx-xxxx  /tmp        ext4  defaults,noexec,nosuid,nodev  0 0
UUID=xxxx-xxxx  /var        ext4  defaults,nosuid               0 0
UUID=xxxx-xxxx  /var/tmp    ext4  defaults,noexec,nosuid,nodev  0 0
UUID=xxxx-xxxx  /var/log    ext4  defaults,noexec,nosuid,nodev  0 0
UUID=xxxx-xxxx  /var/log/audit ext4 defaults,noexec,nosuid,nodev 0 0
UUID=xxxx-xxxx  /home       ext4  defaults,nodev                0 0
tmpfs          /dev/shm    tmpfs defaults,noexec,nosuid,nodev  0 0
```

After modifying `/etc/fstab`, apply the changes:

```bash
mount -o remount /path/to/filesystem
```

### **4.3 Filesystem Integrity Checking**

CIS Level 2 requires regular filesystem integrity verification:

1. **Install AIDE**:

   ```bash
   apt install aide aide-common
   ```

2. **Initialize the AIDE database**:

   ```bash
   aideinit
   ```

3. **Configure daily checks**:

   ```bash
   echo "0 5 * * * root /usr/bin/aide.wrapper --config /etc/aide/aide.conf --check" > /etc/cron.d/aide
   ```

### **4.4 Secure Boot Configuration**

Protect the bootloader:

1. **Set proper permissions**:

   ```bash
   chown root:root /boot/grub/grub.cfg
   chmod 400 /boot/grub/grub.cfg
   ```

2. **Configure bootloader password**:

   ```bash
   # Generate password hash
   grub-mkpasswd-pbkdf2
   
   # Add to /etc/grub.d/40_custom
   cat << EOF >> /etc/grub.d/40_custom
   set superusers="root"
   password_pbkdf2 root <password-hash>
   EOF
   
   # Update grub
   update-grub
   ```

---

## 🔄 **5. Verification Methods**

Use the provided verification script to assess compliance:

```bash
sudo ./01-CISv81-L2-ubuntu2404-verify-filesystem.sh
```

Manual verification can also be performed with:

```bash
# Check partitions and mount options
mount | grep -E '/tmp|/var|/home|/dev/shm'

# Verify AIDE installation and configuration
dpkg -s aide
grep -r aide /etc/cron.*

# Check bootloader security
stat -L -c "%a %u %g" /boot/grub/grub.cfg
```

---

## 🔍 **6. Level 2 vs Level 1 Controls**

Level 2 extends the Level 1 requirements with these additional controls. These additional controls provide enhanced security particularly important for high-security environments.

| **Level 2 Control** | **Description** | **Not in Level 1** |
|---------------------|----------------|-------------------|
| 1.1.15 | Ensure nosuid option set on /var | ✓ Level 2 only |
| 1.1.16-18 | Set noexec, nodev, nosuid on /var/log | ✓ Level 2 only |
| 1.1.19-21 | Set noexec, nodev, nosuid on /var/log/audit | ✓ Level 2 only |
| 1.4.3 | Ensure prelink is disabled | ✓ Level 2 only |
| 1.4.4 | Ensure ASLR is enabled | ✓ Level 2 only |

## 🔄 **6.1 Compliance Framework Mapping**

The filesystem configuration controls map to several NIST 800-53 Rev 5 and ISO 27001:2022 controls. This mapping helps demonstrate how CIS controls satisfy requirements across multiple compliance frameworks and provides traceability for audit purposes.

| **CIS Control** | **NIST 800-53 Control** | **ISO 27001:2022 Control** |
|-----------------|--------------------------|----------------------------|
| 1.1.x (Partition Layout) | SC-2: Separation of System and User Functionality | A.8.9: Configuration management |
| 1.1.x (Mount Options) | SC-39: Process Isolation | A.8.9: Configuration management |
| 1.2.x (Filesystem Integrity) | SI-7: Software, Firmware, and Information Integrity | A.8.11: Information deletion |
| 1.3.x (Secure Boot) | AC-3: Access Enforcement | A.5.15: Secure authentication |
| 1.4.x (Process Hardening) | SC-39: Process Isolation | A.8.8: Management of technical vulnerabilities |

---

## ⚠️ **7. Common Issues and Troubleshooting**

| **Issue** | **Solution** |
|-----------|-------------|
| **Insufficient disk space** | Use LVM for flexible partition sizing |
| **Application compatibility with noexec** | Create exceptions for specific paths if absolutely necessary |
| **Performance impact of separate partitions** | Balance security with performance requirements |
| **AIDE false positives** | Customize AIDE rules to exclude frequently changing files |

Document any exceptions to the CIS controls in the security exceptions register with appropriate justification and compensating controls.

---

## 🔗 **8. Related Documentation**

| **Document** | **Purpose** | **Location** |
|--------------|------------|-------------|
| **CIS Ubuntu 24.04 L1 Filesystem Guide** | Less restrictive baseline | [L1 Guide](../../Ubuntu-24-04-CISv81-L1-Hardening-Guide/01-File-System-Configuration/README.md) |
| **Filesystem Recovery Procedures** | Recovery guidance | [Recovery Guide](../../../disaster-recovery/filesystem-recovery.md) |
| **Ansible Filesystem Hardening Role** | Automation | [Ansible Roles](../../../security-automation/ansible/roles/cis-filesystem-hardening/README.md) |

---

## ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Filesystem Configuration documentation | VintageDon |
