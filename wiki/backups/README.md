# 💾 **Backups**

This wiki section provides practical how-to guides for backup and recovery operations across the Proxmox Astronomy Lab infrastructure. The documentation covers essential backup procedures using PBS, Veeam, and Iperius Backup systems with straightforward step-by-step instructions for common backup tasks.

## **Overview**

The backup wiki provides hands-on procedures for managing the multi-tier backup infrastructure supporting the 7-node cluster. Documentation focuses on practical tasks including PBS backup management, Iperius database backup operations running on proj-fs04, and basic recovery procedures. Each guide provides tested procedures for backup administrators and system engineers working with the enterprise backup systems protecting astronomical research data and infrastructure.

This wiki covers the core backup systems: Proxmox Backup Server for VM protection, Iperius Backup for database-specific protection with NFS storage, and Veeam for enhanced backup capabilities. All backup data follows the standard 4 weekly + 1 monthly retention with 90-day S3 Glacier archival.

---

## **📂 Directory Contents**

This section provides navigation to all backup how-to guides and procedures.

### **📋 Essential Backup Procedures**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[checking-pbs-backup-status.md](checking-pbs-backup-status.md)** | How to verify PBS backup job status and troubleshoot failures | Daily backup verification |
| **[restoring-vm-from-pbs.md](restoring-vm-from-pbs.md)** | Step-by-step VM restoration from Proxmox Backup Server | VM recovery procedures |
| **[managing-iperius-database-backups.md](managing-iperius-database-backups.md)** | Managing Iperius backup jobs on proj-fs04 for PostgreSQL databases | Database backup management |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[backup-troubleshooting-checklist.md](backup-troubleshooting-checklist.md)** | Quick troubleshooting steps for common backup issues | Operations teams |
| **[s3-glacier-retrieval.md](s3-glacier-retrieval.md)** | Retrieving archived data from S3 Glacier storage | Disaster recovery scenarios |

---

## **🏗️ Repository Structure**

```markdown
wiki/backups/
├── README.md                                    # This overview document
├── checking-pbs-backup-status.md               # PBS backup verification procedures
├── restoring-vm-from-pbs.md                    # VM restoration how-to
├── managing-iperius-database-backups.md        # Iperius backup management on fs04
├── backup-troubleshooting-checklist.md         # Common backup issue resolution
└── s3-glacier-retrieval.md                     # S3 Glacier data retrieval procedures
```

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **Backup Integration** |
|--------------|------------------|----------------------|
| **[databases/](../databases/README.md)** | Database protection | PostgreSQL backup and recovery with Iperius |
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Automated backup management | Ansible backup automation |

### **Platform Integration**

| **Category** | **Relationship** | **Backup Integration** |
|--------------|------------------|----------------------|
| **[monitoring/](../../monitoring/README.md)** | Backup monitoring | Backup job status monitoring and alerting |
| **[projects/](../../projects/README.md)** | Research data protection | Project-specific backup requirements |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within backup operations.

### **For Backup Administrators**

**Start Here:** [checking-pbs-backup-status.md](checking-pbs-backup-status.md)  
**Database Backups:** [managing-iperius-database-backups.md](managing-iperius-database-backups.md)  
**Troubleshooting:** [backup-troubleshooting-checklist.md](backup-troubleshooting-checklist.md)  
**Recovery:** [restoring-vm-from-pbs.md](restoring-vm-from-pbs.md)

### **For System Administrators**

**Start Here:** [restoring-vm-from-pbs.md](restoring-vm-from-pbs.md)  
**Status Checking:** [checking-pbs-backup-status.md](checking-pbs-backup-status.md)  
**Issue Resolution:** [backup-troubleshooting-checklist.md](backup-troubleshooting-checklist.md)  
**Archival Retrieval:** [s3-glacier-retrieval.md](s3-glacier-retrieval.md)

### **For Database Administrators**

**Start Here:** [managing-iperius-database-backups.md](managing-iperius-database-backups.md)  
**Recovery Procedures:** [restoring-vm-from-pbs.md](restoring-vm-from-pbs.md)  
**Troubleshooting:** [backup-troubleshooting-checklist.md](backup-troubleshooting-checklist.md)  
**Status Verification:** [checking-pbs-backup-status.md](checking-pbs-backup-status.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: pbs, iperius-backup, veeam, backup-procedures, vm-recovery
