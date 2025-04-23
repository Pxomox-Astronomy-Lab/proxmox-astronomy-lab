<!-- 
---
title: "Proxmox Backup Server Documentation"
description: "Comprehensive documentation for the Proxmox Backup Server (PBS) in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["proxmox", "backup", "pbs", "infrastructure", "disaster-recovery"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["Proxmox VE", "Iperius Backup", "Azure Blob Storage", "AWS Deep Glacier"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Disaster Recovery Policy"]
phase: "phase-1"
cis_controls: ["CIS.10.1", "CIS.10.2", "CIS.11.1", "CIS.11.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "CP-10", "SI-12"]
---
-->

# 💾 **Proxmox Backup Server Documentation**

This document provides comprehensive information about the Proxmox Backup Server (PBS) deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the Proxmox Backup Server service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of PBS in the Proxmox Astronomy Lab environment, focusing on its role in providing reliable backup and recovery capabilities for virtual machines, containers, and critical data.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| PBS hardware and software configuration | Guest VM internal configurations |
| Backup datastore management | Application-specific backup procedures |
| Backup schedules and retention policies | Storage capacity planning |
| Restore and verification procedures | End-user data recovery |
| Integration with long-term storage | Business continuity planning |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Engineers
- System Administrators
- Operations Personnel
- DR Team Members
- IT Management

## 🔍 **2. Service Overview**

### **2.1 Service Description**

Proxmox Backup Server provides enterprise-grade backup and recovery services for the Proxmox Astronomy Lab's virtualized environment. It enables efficient, scheduled backups with deduplication and compression, ensuring data integrity through client-side encryption and verification. As the primary backup solution for VM and container workloads, PBS supports the lab's data protection and disaster recovery requirements with a structured retention policy.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | INFRA-PBS-001 |
| **Service Type** | Core |
| **Service Category** | Infrastructure |
| **Business Criticality** | High |
| **Service Owner** | Infrastructure Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 (Always available) |
| **Support Hours** | Monday-Friday, 08:00-17:00 EST |
| **Maintenance Windows** | Fridays, 10:00-11:00 EST |

## 📊 **3. Technical Architecture**

### **3.1 Hardware Configuration**

Proxmox Backup Server is deployed on dedicated physical hardware:

| **Component** | **Specification** | **Notes** |
|---------------|-------------------|-----------|
| **System** | Intel N100 Mini PC | Low-power, dedicated backup device |
| **CPU** | Intel N100 Processor (4C/4T) | Adequate for backup operations |
| **Memory** | 16GB DDR4 RAM | Sufficient for deduplication operations |
| **Boot Drive** | 256GB NVMe SSD | Operating system and PBS installation |
| **Backup Storage** | 2TB NVMe SSD | Dedicated to backup datastores |
| **Network** | 2.5G Ethernet | Provides adequate backup throughput |

The hardware is optimized for reliability and performance while maintaining energy efficiency as a dedicated backup appliance.

### **3.2 Software Configuration**

| **Component** | **Version** | **Configuration Details** |
|---------------|-------------|---------------------------|
| **Operating System** | Debian 12 | Minimal installation with regular security updates |
| **Proxmox Backup Server** | PBS 3.x | Latest stable version |
| **Authentication** | Integrated with Proxmox VE | Shared authentication and permissions |
| **Web Interface** | HTTPS (443) | Certificate secured web interface |
| **Backup Protocol** | Encrypted/Deduplicated | Client-side encryption, server-side deduplication |

### **3.3 Storage Architecture**

The following storage configuration ensures robust backup capabilities:

| **Datastore Name** | **Location** | **Capacity** | **Usage** |
|-------------------|--------------|--------------|-----------|
| **vm-backup** | 2TB NVMe | 1.8TB usable | Primary VM backups |
| **container-backup** | 2TB NVMe | 200GB allocation | Container backups |
| **external-archive** | AWS Deep Glacier | Unlimited (pay per use) | Long-term archival storage |

### **3.4 Network Configuration**

| **Interface** | **IP Address** | **Network Segment** | **Purpose** |
|---------------|----------------|---------------------|-------------|
| **enp1s0** | 10.25.10.20 | VLAN10 | Management access |
| **backup-vlan60** | 10.25.60.20 | VLAN60 | Backup traffic (isolated) |

## 🔧 **4. Management & Operations**

### **4.1 Backup Schedule**

The following backup schedule has been implemented:

| **Backup Type** | **Schedule** | **Retention** | **Target Systems** |
|-----------------|--------------|---------------|-------------------|
| **Daily VM Backups** | Daily at 09:00 EST | 14 days | All production VMs |
| **Weekly VM Backups** | Sundays at 01:00 EST | 4 weeks | All production VMs |
| **Monthly VM Backups** | First Sunday of month | 6 months | All production VMs |
| **Container Backups** | Daily at 12:00 EST | 14 days | All production containers |
| **AWS Deep Glacier Sync** | Weekly | 6 months | Weekly and monthly backups |

### **4.2 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Backup Verification | Weekly | Infrastructure Team | [PBS-MAINT-001](../Procedures/PBS-MAINT-001.md) |
| Storage Pruning | Monthly | Infrastructure Team | [PBS-MAINT-002](../Procedures/PBS-MAINT-002.md) |
| PBS Software Updates | Quarterly | Infrastructure Team | [PBS-MAINT-003](../Procedures/PBS-MAINT-003.md) |
| Restore Testing | Monthly | Infrastructure Team | [PBS-MAINT-004](../Procedures/PBS-MAINT-004.md) |
| System Updates | Monthly (3rd Friday) | Infrastructure Team | [itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md](../../../../itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md) |

### **4.3 Monitoring Configuration**

PBS is monitored through Prometheus using custom exporters:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Storage Utilization | >75% capacity | >90% capacity | [PBS-RESP-001](../Procedures/PBS-RESP-001.md) |
| Backup Job Status | Warning on job failure | Critical on consecutive failures | [PBS-RESP-002](../Procedures/PBS-RESP-002.md) |
| Datastore Health | Warning on verification issue | Critical on corruption detection | [PBS-RESP-003](../Procedures/PBS-RESP-003.md) |
| Backup Age | >36 hours for daily | >48 hours for daily | [PBS-RESP-004](../Procedures/PBS-RESP-004.md) |

All metrics are exposed to Prometheus and visualized through dedicated Grafana dashboards on lab-mon01, following procedures defined in [itil-policies-and-procedures/Monitoring/MON-PROC-001.md](../../../../itil-policies-and-procedures/Monitoring/MON-PROC-001.md).

### **4.4 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Backup Job Failure | Failed job notification, log errors | Check source VM access, storage space | KEDB-PBS-001 |
| Storage Space Issues | High utilization alerts | Verify pruning, expand storage if needed | KEDB-PBS-002 |
| Verification Errors | Datastore verification failure | Run manual verification, check storage health | KEDB-PBS-003 |
| AWS Sync Failure | Failed archival notification | Check network connectivity, AWS credentials | KEDB-PBS-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | Role-based with Entra ID MFA | [itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md) |
| API Access | Token-based with minimal privileges | [itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md) |
| Remote Access | SSL/TLS with certificate validation | [itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md](../../../../itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the Proxmox Backup Server:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based with Entra integration | Quarterly access review |
| Network Security | VLAN segmentation (dedicated backup VLAN) | Monthly security scans |
| Data Encryption | Client-side encryption for all backups | Weekly verification checks |
| Backup Security | Encryption key management, secure storage | Monthly security reviews |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.10.1 (Deploy and maintain anti-malware) | Wazuh agent with active scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 (Configure automatic updates) | Scheduled patching process | Patch Management Records | Compliant |
| CIS.11.1 (Establish and maintain data recovery practices) | Structured backup schedule and retention | PBS Dashboard | Compliant |
| CIS.11.2 (Perform automated backups) | Automated daily, weekly, and monthly backups | PBS Job Logs | Compliant |

The compliance mapping follows guidelines outlined in [itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md](../../../../itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md).

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

The Proxmox Backup Server itself follows a comprehensive backup strategy to ensure its own recoverability:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|-----------------|-------------|--------------|----------------------|
| PBS Configuration | Daily | 30 days | Azure Blob Storage |
| Catalog Export | Weekly | 90 days | Azure Blob Storage |
| System Snapshot | Monthly | 6 months | Proxmox VE node |

The backup strategy follows the principles defined in [itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md](../../../../itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md).

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Single Backup Corruption | 30 minutes | 24 hours | [DR-PBS-001](../DR/DR-PBS-001.md) | Infrastructure Team |
| PBS Service Failure | 2 hours | 24 hours | [DR-PBS-002](../DR/DR-PBS-002.md) | Infrastructure Team |
| Complete PBS System Failure | 4 hours | 48 hours | [DR-PBS-003](../DR/DR-PBS-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 72 hours | [DR-PBS-004](../DR/DR-PBS-004.md) | DR Team |

The recovery procedures align with the incident management process defined in [itil-policies-and-procedures/Incident-Management/INC-PROC-001.md](../../../../itil-policies-and-procedures/Incident-Management/INC-PROC-001.md).

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | PBS Administration Guide | [docs/PBS-Admin-Guide.md](../Guides/PBS-Admin-Guide.md) | Administration procedures |
| Procedure | VM Restore Procedure | [docs/VM-Restore-Procedure.md](../Procedures/VM-Restore-Procedure.md) | Operational procedure |
| Architecture | Backup Architecture Overview | [docs/Backup-Architecture.md](../Architecture/Backup-Architecture.md) | Overall context |
| Policy | Data Retention Policy | [itil-policies-and-procedures/Backup-Management/Data-Retention-Policy.md](../../../../itil-policies-and-procedures/Backup-Management/Data-Retention-Policy.md) | Governance requirements |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Proxmox Backup Server Documentation | <https://pbs.proxmox.com/docs/> | [Local Copy](../References/PBS-Documentation.pdf) | 2025-04-01 |
| Proxmox Backup Best Practices | <https://pbs.proxmox.com/wiki/Backup_Best_Practices> | [Local Copy](../References/PBS-Best-Practices.pdf) | 2025-04-01 |
| AWS Glacier Deep Archive Documentation | <https://docs.aws.amazon.com/glacier/index.html> | [Local Copy](../References/AWS-Glacier-Guide.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-PBS-2025-001 | PBS 3.x Upgrade | 2025-02-10 | [GLPI-CR-PBS-001](https://glpi.lab.local/CR-PBS-2025-001) |
| CR-PBS-2025-002 | Storage Expansion | 2025-03-15 | [GLPI-CR-PBS-002](https://glpi.lab.local/CR-PBS-2025-002) |
| CR-PBS-2025-003 | Retention Policy Update | 2025-04-01 | [GLPI-CR-PBS-003](https://glpi.lab.local/CR-PBS-2025-003) |

All changes follow the process defined in [itil-policies-and-procedures/Change-Management/CHG-PROC-001.md](../../../../itil-policies-and-procedures/Change-Management/CHG-PROC-001.md).

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| BackupAdmin | Backup Administrator | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |
