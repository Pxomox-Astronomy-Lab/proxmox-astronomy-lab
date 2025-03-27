<!--
---
title: "Add a Docker Volume to Ubuntu 24.04"
description: "Procedure for adding and mounting a dedicated volume for Docker data on Ubuntu 24.04 in the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["docker", "ubuntu", "volume", "virtual machine", "lab"]
category: "Infrastructure"
kb_type: "Procedure"
version: "1.0"
status: "Published"
last_updated: "2025-03-26"
---
-->

# 📄 **Add a Docker Volume to Ubuntu 24.04**

This KB outlines the procedure for provisioning and attaching a dedicated volume to be used for Docker container storage on Ubuntu 24.04. This is part of the standard practice in the Proxmox Astronomy Lab to ensure isolation and high-performance I/O for container workloads.

---

## 🔍 **1. Overview**

### **1.1 Purpose**

To guide lab engineers and Ops team personnel in setting up a **dedicated Docker volume** on Ubuntu 24.04 systems. This ensures that container storage is mounted on high-performance, easily upgradeable volumes separate from the root filesystem.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Partitioning and formatting new disk volumes | LVM configuration |
| Mounting Docker volume at `/mnt/docker` | Installing Docker engine |
| Ensuring persistence via `fstab` | Docker container management |

### **1.3 Target Audience**

This article is intended for **Lab Engineers, DevOps Administrators, and Infrastructure Operators** working within the Proxmox Astronomy Lab or any hybrid lab environment.

---

## ⚙️ **2. Technical Procedure**

### **2.1 Identify Attached Disk**

After attaching a virtual disk in Proxmox, verify its presence:

```bash
sudo fdisk -l
```

Look for the new disk (e.g., `/dev/sdb`).

---

### **2.2 Partition the Disk**

Launch `fdisk`:

```bash
sudo fdisk /dev/sdb
```

- Choose `n` to create a new partition.
- Use default options for primary partition and full disk.
- Write changes with `w`.

---

### **2.3 Format the Partition**

Format as ext4:

```bash
sudo mkfs.ext4 /dev/sdb1
```

---

### **2.4 Mount and Persist the Volume**

Create the mount point:

```bash
sudo mkdir -p /mnt/docker
```

Get the UUID of the new partition:

```bash
sudo blkid | grep sdb1
```

Edit `/etc/fstab`:

```bash
sudo nano /etc/fstab
```

Add the following line, replacing `UUID=xxxxx` with the actual UUID:

```fstab
UUID=9f0b170b-8a4f-4767-a8b5-4fda46c5ce5e /mnt/docker ext4 defaults 0 2
```

Reload the daemon and mount:

```bash
sudo systemctl daemon-reexec
sudo mount -a
```

Verify with:

```bash
df -hT
```

You should see `/dev/sdb1` mounted to `/mnt/docker`.

---

## 🔄 **3. Process Integration**

### **3.1 ITIL Process Relationship**

| **Process** | **Context** |
|-------------|------------|
| Change Management | Volume attachment must be tracked via Zammad ticket |
| Configuration Management | Disk UUID and mount point recorded in CMDB (GLPI) |

---

## 📎 **4. References & Related Resources**

### **4.1 Related KB Articles**

| **Article Title** | **Article ID** | **Relationship** |
|------------------|----------------|------------------|
| Docker VM Configuration | KB-VM-DKR | Host OS setup and hardening |
| Proxmox Disk Provisioning | KB-PMX-DISK | Creating disks in the GUI or CLI |

---

## ✅ **5. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|--------------|----------|-------------------|------------|
| VintageDon | Lead Engineer | 2025-03-26 | ✅ Approved |

---

## 📜 **6. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|-------------|----------|-------------|------------|
| 1.0 | 2025-03-26 | Initial version | VintageDon |
