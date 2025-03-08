---
title: "Moving Docker Default Storage to a Separate NVMe Volume"
description: "Step-by-step guide on partitioning, formatting, and mounting an NVMe volume for Docker storage, ensuring compliance with CIS security controls."
author: "VintageDon"
tags: ["Docker", "NVMe", "Storage", "Linux", "CIS"]
category: "Containerization"
kb_type: "Implementation"
version: "1.2"
status: "Published"
last_updated: "2025-03-02"
---

# **Moving Docker Default Storage to a Separate NVMe Volume**

## **1. Introduction**

Docker’s default storage directory (`/var/lib/docker`) can consume large amounts of space, potentially impacting system performance. Moving it to a dedicated **NVMe volume** improves **performance, disk longevity, and manageability**.

This guide details **how to partition, format, and mount an NVMe volume for Docker storage** while ensuring **CIS security compliance** without interfering with container functionality.

---

## **2. Scope**

| **Category**        | **Description** |
|---------------------|----------------|
| **In-Scope**       | Partitioning, formatting, mounting an NVMe volume, moving Docker storage, ensuring CIS compliance. |
| **Out-of-Scope**   | Configuring RAID, networked storage (NFS, iSCSI, etc.). |
| **Applicable OS**  | Ubuntu, Debian-based systems. |

---

## **3. Implementation Steps**

### **Step 1: Identify the New NVMe Drive**

Check for available disks:

```bash
lsblk
```

Look for an **unpartitioned disk**, typically `/dev/sdb` if it's the second drive.

---

### **Step 2: Partition the NVMe Drive**

Create a new partition using `fdisk`:

```bash
fdisk /dev/sdb
```

Inside `fdisk`, follow these steps:

1. Press **`n`** (new partition).
2. Press **`p`** (primary partition).
3. Accept defaults (full disk usage).
4. Press **`w`** (write changes).

Verify the partition:

```bash
lsblk /dev/sdb
```

It should now show `/dev/sdb1`.

---

### **Step 3: Format the Partition**

Format `/dev/sdb1` as **ext4**:

```bash
mkfs.ext4 /dev/sdb1
```

---

### **Step 4: Create & Mount the Docker Storage Directory**

Create the mount point:

```bash
mkdir -p /mnt/docker
```

Mount the partition:

```bash
mount /dev/sdb1 /mnt/docker
```

Ensure it persists on reboot by adding it to `/etc/fstab`:

```bash
echo "/dev/sdb1 /mnt/docker ext4 defaults,noatime,nodev,nosuid 0 2" >> /etc/fstab
```

Verify the mount:

```bash
df -h | grep docker
```

---

### **Step 5: Stop Docker Services**

Before moving the storage, stop Docker:

```bash
systemctl stop docker
systemctl stop docker.socket
```

Confirm it's stopped:

```bash
systemctl status docker
```

---

### **Step 6: Move Docker Storage**

Move existing data:

```bash
mv /var/lib/docker /mnt/docker/
```

Verify the data move:

```bash
ls -lah /mnt/docker/
```

---

### **Step 7: Update Docker Configuration**

Modify Docker’s `daemon.json`:

```bash
nano /etc/docker/daemon.json
```

Add the following:

```json
{
  "data-root": "/mnt/docker"
}
```

---

### **Step 8: Set Permissions**

Ensure proper permissions:

```bash
chown -R root:docker /mnt/docker
chmod -R 755 /mnt/docker
```

Security settings:

- **Apply `nodev` and `nosuid`**, as recommended by CIS, to prevent unauthorized execution of device files and SUID binaries.
- **Do not use `noexec`**, as it can interfere with Docker functionality.

Remount the partition with updated security settings:

```bash
mount -o remount /mnt/docker
```

---

### **Step 9: Restart Docker**

Reload systemd and restart Docker:

```bash
systemctl daemon-reexec
systemctl start docker.socket
systemctl start docker
```

Confirm Docker is running:

```bash
systemctl status docker
docker info | grep "Docker Root Dir"
```

Expected output:

```
Docker Root Dir: /mnt/docker
```

---

## **4. Troubleshooting & Validation**

| **Issue**                      | **Possible Cause**                           | **Solution** |
|---------------------------------|---------------------------------------------|-------------|
| Docker fails to start           | Incorrect permissions on `/mnt/docker/`    | Run `chown -R root:docker /mnt/docker` and `chmod -R 755 /mnt/docker` |
| `docker info` shows old path    | `daemon.json` not updated or misconfigured | Verify `/etc/docker/daemon.json` and restart Docker |
| Storage move failed             | Docker was running during the move         | Ensure `docker` and `docker.socket` are fully stopped before moving |
| Data loss on reboot             | `/etc/fstab` missing entry                 | Ensure `/dev/sdb1 /mnt/docker ext4 defaults,noatime,nodev,nosuid 0 2` is present |

---

## **5. Compliance & Security Considerations**

This implementation aligns with **CIS Docker and Linux Benchmarks** for security best practices.

| **Framework**        | **Requirement** | **Implementation** |
|----------------------|----------------|---------------------|
| **CIS 1.1.1.1**     | Ensure separate partition for Docker | `/mnt/docker` is a dedicated NVMe partition |
| **CIS 1.1.1.2**     | Set `nodev` and `nosuid` on Docker storage | `/etc/fstab` enforces these options |
| **CIS 2.2**         | Configure Docker daemon securely | `daemon.json` explicitly sets `data-root` |
| **CIS 5.1.2**       | Restrict file permissions on Docker data | `chmod 755 /mnt/docker` |

---

## **6. Documentation & Revision Control**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.2       | 2025-03-02 | Removed `noexec`, updated CIS security settings | VintageDon |
| 1.1       | 2025-03-02 | Added partitioning, CIS security enhancements | VintageDon |
| 1.0       | 2025-03-02 | Initial KB version | VintageDon |

---

## **7. Summary**

This guide ensures **Docker’s default storage is moved to a dedicated NVMe volume** while maintaining **security best practices** aligned with **CIS controls**.

### ✅ **Key Takeaways**

- **Partition, format, and mount NVMe storage**
- **Move Docker storage without data loss**
- **Apply CIS security settings (`nodev, nosuid`)**
- **Persist changes across reboots**

🚀 **Next Steps:** Consider separating **Docker images, volumes, and logs** into distinct storage locations for **even finer control over disk performance and security**.

```bash
docker ps
```

✅ **Final Check:** Ensure all containers are running as expected.
