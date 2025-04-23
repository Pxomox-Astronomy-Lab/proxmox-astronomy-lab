<!-- 
---
title: "ZFS Storage Documentation"
description: "Comprehensive documentation of the ZFS Storage system on node05 in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "storage", "zfs", "rpool", "data-integrity", "mirror", "enterprise-storage"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Windows File Server", "Linux File Server", "MinIO Object Storage", "Backup Services"]
implements_policies: ["Data Storage Policy", "Data Protection Policy", "Backup Policy"]
phase: "phase-2"
cis_controls: ["CIS.3.1", "CIS.3.4", "CIS.10.1"]
iso27001_controls: ["A.8.2.1", "A.8.2.3", "A.12.3.1"]
nist_controls: ["SC-8", "SC-28", "CP-9"]
---
-->

# 🔧 **ZFS Storage Service**

This document provides the authoritative reference for the ZFS Storage service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the ZFS Storage service, its operational parameters, and management procedures. It serves as the definitive reference for the advanced storage infrastructure running on node05, providing high-integrity, redundant storage with data protection features for various services within the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| ZFS architecture and configuration | Application-specific storage implementations |
| Pool management and structure | VM storage provisioning details |
| Physical device configuration | User training materials |
| Storage sharing and export methods | External storage systems |
| Operational procedures and maintenance | Data content management |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Storage Team Members
- System Administrators
- Operations Team Members
- Disaster Recovery Coordinators

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the ZFS Storage service within the lab's operational framework.

### **2.1 Service Description**

The ZFS Storage service provides a robust, advanced filesystem with built-in data integrity, redundancy, and protection features. Running on node05, it consists of multiple ZFS pools with mirrored configuration across enterprise-grade HDDs and NVMe storage. This system serves as the backbone for bulk storage, file services, and provides storage to both the Windows and Linux file servers.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0033 |
| **Service Type** | Core |
| **Service Category** | Infrastructure |
| **Business Criticality** | High |
| **Service Owner** | Infrastructure Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 |
| **Support Hours** | Monday-Friday, 9:00-17:00 ET |
| **Maintenance Windows** | Every 3rd Sunday, 01:00-05:00 ET |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | ZFS pool status monitoring |
| **Performance (HDD)** | > 500 MB/s for reading, > 300 MB/s for writing | Performance testing |
| **Performance (NVMe)** | > 2 GB/s for reading, > 1 GB/s for writing | Performance testing |
| **Data Integrity** | 100% protection against silent data corruption | ZFS scrub verification |
| **Incident Response Time** | 30 minutes during support hours | GLPI ticket tracking |

### **3.2 Monitoring and Reporting**

The ZFS Storage service is monitored through a comprehensive observability stack:

- **ZFS Pool Status** constantly monitored for online/degraded/offline status
- **Prometheus** collects ZFS metrics including space usage, I/O operations, and scrub status
- **AlertManager** provides alert routing based on severity and service impact
- **Grafana** dashboards visualize storage utilization, performance metrics, and pool health
- **Wazuh** provides security monitoring and access auditing

Weekly scrub operations are performed to verify data integrity, with results logged and reported to stakeholders.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The ZFS Storage implementation runs on node05 and consists of the main rpool with mirrored vdevs across eight 8TB enterprise hard drives, configured in four mirror sets. Additionally, it includes an NVMe device used for special purposes such as ZIL (ZFS Intent Log) and L2ARC (Level 2 Adaptive Replacement Cache) to accelerate performance for frequently accessed data.

![ZFS Architecture Diagram](../assets/images/zfs-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **node05** | Physical hardware host | HW-0005 |
| **rpool** | Primary ZFS pool with mirrored configuration | ST-0050 |
| **mirror-0 through mirror-3** | Mirrored vdev pairs in rpool | ST-0051-0054 |
| **Enterprise HDDs** | 8 x 8TB enterprise HDDs from various manufacturers | ST-0055-0062 |
| **NVMe Storage** | Samsung MZ4LB3T8HALS-00003 3.84TB enterprise NVMe | ST-0063 |
| **ZFS Datasets** | Structured datasets for various storage needs | ST-0064 |

### **4.2.1 Physical Storage Devices**

| **Device Path** | **Model** | **Serial Number** | **Type** | **Size** |
|-----------------|-----------|-------------------|----------|----------|
| /dev/nvme0n1 | SAMSUNG MZ4LB3T8HALS-00003 | S40PNE0M901781 | NVMe | 3.84 TB |
| /dev/sda | ST8000NC0002-1XX112 | ZA11R9A1 | Hard Disk | 8.00 TB |
| /dev/sdb | SanDisk_SDSSDHII960G | 151870401296 | SSD | 960.20 GB |
| /dev/sdc | WDC_WD80EZAZ-11TDBA0 | 7JK9MUMC | Hard Disk | 8.00 TB |
| /dev/sdd | HGST_HUH728080ALE604 | 2EHLEZ2X | Hard Disk | 8.00 TB |
| /dev/sde | HGST_HUH728080ALE604 | 2EHME4GX | Hard Disk | 8.00 TB |
| /dev/sdf | ST8000DM004-2CX188 | WCT0ASY7 | Hard Disk | 8.00 TB |
| /dev/sdg | HUH728080ALE601 | VJGEXPHX | Hard Disk | 8.00 TB |
| /dev/sdh | TOSHIBA_HDWF180 | Y8AIK09RFB6G | Hard Disk | 8.00 TB |
| /dev/sdi | WDC_WD80EZAZ-11TDBA0 | 7JK8D3YC | Hard Disk | 8.00 TB |

### **4.3 Pool Configuration**

The ZFS pool configuration follows a structured approach with mirrored vdevs for redundancy:

| **Pool Component** | **Configuration** | **Physical Devices** |
|-------------------|-------------------|----------------------|
| **rpool** | Main storage pool | All mirrored vdevs |
| **mirror-0** | First mirror set | /dev/sda1 and /dev/sdc1 (8TB each) |
| **mirror-1** | Second mirror set | /dev/sdd1 and /dev/sde1 (8TB each) |
| **mirror-2** | Third mirror set | /dev/sdf1 and /dev/sdg1 (8TB each) |
| **mirror-3** | Fourth mirror set | /dev/sdh1 and /dev/sdi1 (8TB each) |
| **logs** | ZFS Intent Log (ZIL) | /dev/nvme0n1p1 partition |

The mirrored configuration ensures that data is protected against single-drive failures within each mirror set, while the NVMe device provides performance acceleration for write operations.

### **4.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | node05 Hardware | Complete service outage |
| **Requires** | Physical Storage Devices | Degraded service or outage |
| **Requires** | Network Infrastructure | Remote access unavailable |
| **Required By** | Windows File Server (fs02) | SMB bulk storage unavailable |
| **Required By** | Linux File Server (fs03) | NFS storage unavailable |
| **Required By** | MinIO Object Storage | Object storage backend unavailable |

### **4.5 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Pool Scrub Schedule** | Weekly, typically on Sundays |
| **Snapshot Schedule** | Hourly snapshots with 24-hour retention, daily snapshots with 14-day retention |
| **Pool Configuration Backup** | Weekly export of pool configuration |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [ZFS Recovery Procedure](../itil-policies-and-procedures/Backup-Management/zfs-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Storage Administrator | Full ZFS administrative access | Approved by Infrastructure Lead |
| System Administrator | Read-only monitoring access | Approved by Infrastructure Lead |
| File Server Administrator | Access to mount points | Approved by Storage Lead |
| Backup Administrator | Snapshot management access | Approved by Storage Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| Pool Degradation | Critical | P1 | 15 minutes | 2 hours |
| Drive Failure | High | P2 | 30 minutes | 4 hours |
| Performance Issues | Medium | P3 | 1 hour | 6 hours |
| Space Usage Alerts | Medium | P3 | 1 hour | 6 hours |
| Scrub Errors | Medium | P3 | 1 hour | 6 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Pool Expansion | Yes | Full CAB review | Scheduled maintenance window |
| Device Replacement | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| Dataset Configuration Change | No | Storage Lead approval | Business hours |
| Property Changes | No | Storage Lead approval | Business hours |
| Snapshot Configuration Change | No | Backup Lead approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Pool Status Check | Daily | Storage Team | [Pool Status Check Procedure](../itil-policies-and-procedures/Monitoring/zfs-pool-status-check.md) |
| Pool Scrub | Weekly | Storage Team | [Pool Scrub Procedure](../itil-policies-and-procedures/Monitoring/zfs-pool-scrub.md) |
| Capacity Planning | Monthly | Storage Team | [Capacity Planning Procedure](../itil-policies-and-procedures/Monitoring/storage-capacity-planning.md) |
| Performance Monitoring | Weekly | Storage Team | [Performance Monitoring Procedure](../itil-policies-and-procedures/Monitoring/zfs-performance-monitoring.md) |
| Snapshot Management | Weekly | Backup Team | [Snapshot Management Procedure](../itil-policies-and-procedures/Backup-Management/zfs-snapshot-management.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Degraded Pool | Mirror showing DEGRADED status | [Pool Recovery Procedure](../itil-policies-and-procedures/Incident-Management/zfs-pool-recovery.md) | KEDB-0130 |
| Device Replacement | Failed disk in mirror | [Device Replacement Procedure](../itil-policies-and-procedures/Incident-Management/zfs-device-replacement.md) | KEDB-0131 |
| Performance Degradation | Slow I/O operations | [Performance Troubleshooting](../itil-policies-and-procedures/Incident-Management/zfs-performance-troubleshooting.md) | KEDB-0132 |
| Space Exhaustion | High usage alerts | [Space Management Procedure](../itil-policies-and-procedures/Incident-Management/zfs-space-management.md) | KEDB-0133 |
| Scrub Errors | Data errors reported during scrub | [Data Error Recovery](../itil-policies-and-procedures/Incident-Management/zfs-data-error-recovery.md) | KEDB-0134 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-01-15 |
| **Last Review Date** | 2025-04-13 |
| **Next Review Date** | 2025-07-13 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the ZFS Storage service:

1. **Capacity Expansion** (Q3 2025)
   - Add additional mirror sets as needed
   - Evaluate upgrading to larger capacity drives

2. **Performance Enhancement** (Q2 2025)
   - Optimize ZFS parameters for specific workloads
   - Evaluate additional NVMe devices for caching

3. **Monitoring Enhancement** (Q2 2025)
   - Develop custom Grafana dashboards for ZFS metrics
   - Implement predictive failure analysis

4. **Replication Configuration** (Q4 2025)
   - Evaluate ZFS send/receive for off-site replication
   - Implement automated snapshot replication

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | UNIX permissions, ZFS ACLs | Permission audit |
| Dataset Security | Dataset-level encryption for sensitive data | Configuration audit |
| Physical Security | Secured server room access | Physical security audit |
| Network Security | Restricted network access to ZFS exports | Network scan verification |
| Audit Logging | Comprehensive ZFS operation logging | Log review |
| Snapshot Protection | Read-only snapshots | Configuration verification |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Data Protection | CIS Controls 3.1, 3.4 | ZFS configuration audit |
| Data Integrity | ISO 27001 A.8.2.1 | Scrub reports |
| Backup Management | CIS Controls 10.1 | Snapshot verification reports |
| Storage Security | NIST 800-53 SC-28 | Security configuration review |
| Access Control | ISO 27001 A.8.2.3 | Permission documentation |
| System Monitoring | CIS Controls 6.1 | Monitoring configuration audit |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | ZFS Storage Architecture | [ZFS Architecture](../Infrastructure/Storage/zfs-architecture.md) |
| Technical Guide | ZFS Pool Management | [ZFS Pool Management Guide](../Infrastructure/Storage/zfs-pool-management.md) |
| Technical Guide | ZFS Dataset Configuration | [ZFS Dataset Guide](../Infrastructure/Storage/zfs-dataset-configuration.md) |
| Technical Guide | ZFS Performance Tuning | [ZFS Performance Guide](../Infrastructure/Storage/zfs-performance-tuning.md) |
| Security Baseline | ZFS Storage Security | [ZFS Security](../Compliance-Security/CIS-Controls/zfs-security.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0033 | ZFS Storage | This service |
| CI | CI-0130 | ZFS rpool | Component |
| CI | CI-0131 | ZFS Mirror Sets | Component |
| KB Article | KB-0125 | ZFS Administration Guide | Procedure |
| Service Request | SRT-0026 | ZFS Dataset Creation Request | Related process |
| Change Template | CHG-T-0021 | ZFS Storage Expansion | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
