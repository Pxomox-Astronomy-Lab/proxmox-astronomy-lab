# Adding a Second Drive for Data Storage on Ubuntu 24.04

Learn how to add, partition, format, and permanently mount a second drive on Ubuntu 24.04 for additional data storage. This is commonly done to separate system files from data files or to add more storage capacity to your server.

## Why We Do This

In the Proxmox Astronomy Lab, we use dedicated data volumes as a foundational pattern. While there are many ways to configure storage, we implement this approach because:

- **Compliance Separation**: Our CIS v8 Level 2 compliant system images maintain system-level compliance independently from workload compliance requirements
- **Workload Portability**: Since we typically run Docker with host directory mounts, placing everything on a dedicated volume makes the entire workload portable between systems
- **System Isolation**: Complete separation between system operations and application data reduces risk and simplifies troubleshooting across our infrastructure
- **Backup Strategy**: Our volume-based backup approach becomes much more efficient when all application data resides on dedicated volumes

This pattern is used consistently across lab infrastructure for these operational benefits.

## Prerequisites

- Ubuntu 24.04 server with root/sudo access
- A second physical drive already attached to the system (appears as `/dev/sdb` in this example)
- Basic familiarity with command line operations
- System should be rebooted after major updates before proceeding

## Step-by-Step Instructions

### Step 1: Create Mount Point

```bash
mkdir /mnt/data
```

Creates the directory where the new drive will be accessible. The `/mnt` directory is the standard location for temporarily mounted filesystems, though `/mnt/data` will become permanent.

### Step 2: Partition the Drive

```bash
fdisk /dev/sdb
```

Opens the fdisk partitioning tool for the second drive. In the interactive menu:

- Type `n` for new partition
- Press Enter to accept defaults for partition number (1)
- Press Enter to accept default first sector
- Press Enter to accept default last sector (uses entire drive)
- Type `w` to write changes and exit

This creates a single partition that uses the entire drive capacity.

### Step 3: Format the Partition

```bash
mkfs.ext4 /dev/sdb1
```

Formats the new partition with the ext4 filesystem, which is the standard for modern Linux systems. This process will take a few minutes depending on drive size and will display progress information.

### Step 4: Get the Partition UUID

```bash
blkid
```

Displays all block devices and their UUIDs. Look for the `/dev/sdb1` entry and copy its UUID value. You'll need this UUID for the next step to ensure the mount persists across reboots.

Example output:

```text
/dev/sdb1: UUID="9f72de53-abab-42e5-9751-e6f33228875a" TYPE="ext4"
```

### Step 5: Add to File System Table

```bash
nano /etc/fstab
```

Add this line to the end of the file, replacing the UUID with your actual UUID from Step 4:

```text
/dev/disk/by-uuid/9f72de53-abab-42e5-9751-e6f33228875a /mnt/data ext4 defaults 0 0
```

The format is: `device mountpoint filesystem options dump pass`

- `defaults` provides standard mount options
- First `0` means no dump backup needed
- Second `0` means no fsck check order

### Step 6: Reload and Mount

```bash
systemctl daemon-reload
mount -a
```

The first command reloads systemd to recognize fstab changes. The second command mounts all filesystems listed in fstab, including your new drive.

## Verification

Check that the drive is properly mounted and has the expected space:

```bash
df -h
```

You should see `/mnt/data` listed with the full capacity of your second drive. The mount point should show as much available space as your drive capacity (minus filesystem overhead).

## Troubleshooting

**Drive not detected:** Ensure the drive is properly connected and recognized by running `lsblk` to see all block devices.

**Permission issues:** The mount point will be owned by root. To allow other users access, you may need to adjust permissions:

```bash
chmod 755 /mnt/data
```

**Mount fails:** Double-check the UUID in `/etc/fstab` matches exactly what `blkid` shows. UUIDs are case-sensitive.

**Drive doesn't mount after reboot:** Verify the fstab entry syntax is correct and run `mount -a` to test mounting without rebooting.

## Related Articles

- Moving Docker Data Directory to Custom Location
- Setting Up Automated Backups to Secondary Storage
- Linux File Permissions and Ownership Management

---

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | [2025-07-19] |
| **Last Updated** | [2025-07-19] |
| **Version** | 1.0 |

---
Tags: ubuntu, storage, fdisk, mounting, filesystem, ext4, compliance, docker
