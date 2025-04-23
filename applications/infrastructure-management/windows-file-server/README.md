<!-- 
---
title: "Windows File Server Documentation"
description: "Comprehensive documentation of the Windows Scale Out File Server services with SMB3 multichannel and DFS replication in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "storage", "windows", "smb3", "file-server", "dfs", "replication", "high-availability"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Storage Services", "Backup Services", "Research Data Services", "ZFS Storage"]
implements_policies: ["Data Storage Policy", "Data Replication Policy", "Backup Policy"]
phase: "phase-3"
cis_controls: ["CIS.3.1", "CIS.3.4", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.8.2.1", "A.8.2.3", "A.12.3.1"]
nist_controls: ["SC-8", "SC-28", "CP-9"]
---
-->

# 🔧 **Windows File Server (SMB3) Service**

This document provides the authoritative reference for the Windows File Server service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Windows File Server service, its operational parameters, and management procedures. It serves as the definitive reference for the Scale Out File Server (SOFS) infrastructure providing SMB3 file sharing with multichannel capabilities, DFS replication, and integrated backup solutions for the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Scale Out File Server architecture and configuration | VM storage (Hyper-V) services |
| SMB3 multichannel implementation | Detailed backup recovery procedures |
| DFS replication configuration | User training materials |
| ZFS-backed bulk storage | External storage systems |
| Iperius Backup configuration | Application-specific storage requirements |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Storage Team Members
- Windows Server Administrators
- Research Computing Staff
- Operations Team Members

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Windows File Server service within the lab's operational framework.

### **2.1 Service Description**

The Windows File Server service provides high-performance, redundant file sharing through Windows Server 2025 Standard Scale Out File Server (SOFS) implementation running on fs01 and fs02. This service offers SMB3 file sharing with multichannel capabilities, DFS replication for high availability, and dedicated backup services for databases through Iperius Backup on fs03. Additionally, fs02 provides access to bulk storage from the ZFS pool on node05.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0031 |
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
| **Availability** | 99.9% | Windows System Monitor |
| **Performance (NVMe Storage)** | > 800 MB/s for reading, > 500 MB/s for writing | Performance monitoring |
| **Performance (ZFS Storage)** | > 500 MB/s for reading, > 300 MB/s for writing | Performance monitoring |
| **Replication Latency** | < 15 minutes | DFS diagnostic tools |
| **Incident Response Time** | 30 minutes during support hours | GLPI ticket tracking |

### **3.2 Monitoring and Reporting**

The Windows File Server service is monitored through a comprehensive observability stack:

- **Windows System Monitor** tracks performance, resource utilization, and service availability
- **DFS Diagnostics** monitors replication health and synchronization status
- **SNMP Integration** provides metrics to the lab's Prometheus instance
- **Grafana** dashboards visualize storage utilization, performance metrics, and availability
- **Wazuh Agent** provides security monitoring and access auditing

Monthly storage reports are generated and distributed to stakeholders, including capacity trends, performance statistics, and usage patterns.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The Windows File Server deployment consists of two primary servers (fs01 and fs02) configured as a Scale Out File Server with DFS replication between them for high availability. Both servers provide access to local NVMe storage, while fs02 additionally serves as a gateway to ZFS-based bulk storage on node05. A third server (fs03) is dedicated to database backups using Iperius Backup.

![Windows File Server Architecture Diagram](../assets/images/windows-file-server-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **fs01** | Windows Server 2025 Standard SOFS | VM-0019 |
| **fs02** | Windows Server 2025 Standard SOFS with ZFS access | VM-0022 |
| **fs03** | Windows Server 2025 Standard with Iperius Backup | VM-0024 |
| **NVMe Storage** | High-performance local storage for fs01/fs02 | ST-0040 |
| **ZFS Storage** | Bulk storage pool on node05 | ST-0020 |
| **DFS Replication** | Replication service between fs01 and fs02 | CI-0110 |
| **SMB3 Multichannel** | High-performance file sharing protocol | CI-0111 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox Virtualization | Complete service outage |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | Active Directory | Authentication failure |
| **Requires** | ZFS Storage (for bulk storage) | Bulk storage unavailable |
| **Required By** | Research Data Services | Data access unavailable |
| **Required By** | User Home Directories | Home directory unavailable |
| **Required By** | Database Backup Services | Backup failure |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Server Backup Schedule** | Daily VM backups via Proxmox Backup Server |
| **Database Backup Schedule** | Daily full backups via Iperius Backup on fs03 |
| **Retention Policy** | 14 days daily, 4 weeks weekly, 1 month monthly, 180 days in AWS Deep Glacier |
| **Recovery Time Objective (RTO)** | 4 hours for servers, 2 hours for data |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Windows File Server Recovery Procedure](../itil-policies-and-procedures/Backup-Management/windows-file-server-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Storage Administrator | Full administrative access | Approved by Infrastructure Lead |
| File Server Administrator | Server management access | Approved by Windows Team Lead |
| Share Owner | Per-share administrative access | Approved by Storage Lead |
| Research Staff | Read/write access to designated shares | Approved by Research Lead |
| General Users | Read-only or restricted write access | Approved by Team Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| Server Failure | Critical | P1 | 15 minutes | 2 hours |
| Replication Failure | High | P2 | 30 minutes | 4 hours |
| Share Access Issues | Medium | P3 | 1 hour | 6 hours |
| Performance Degradation | Medium | P3 | 1 hour | 6 hours |
| Backup Failure | Medium | P3 | 1 hour | 6 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| OS Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| Storage Expansion | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| Share Configuration Change | No | Storage Lead approval | Business hours |
| DFS Topology Change | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| Backup Configuration Change | No | Backup Administrator approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| DFS Replication Health Check | Daily | Windows Team | [DFS Health Check Procedure](../itil-policies-and-procedures/Monitoring/dfs-health-check.md) |
| Storage Performance Monitoring | Weekly | Storage Team | [Storage Performance Monitoring](../itil-policies-and-procedures/Monitoring/windows-storage-performance-monitoring.md) |
| Capacity Planning | Monthly | Storage Team | [Capacity Planning Procedure](../itil-policies-and-procedures/Monitoring/storage-capacity-planning.md) |
| Share Permission Audit | Quarterly | Security Team | [Share Permission Audit](../itil-policies-and-procedures/Security-Policies/share-permission-audit.md) |
| Backup Verification | Weekly | Backup Team | [Backup Verification Procedure](../itil-policies-and-procedures/Backup-Management/iperius-backup-verification.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| SMB Access Failures | "Access Denied" errors | [SMB Access Troubleshooting](../itil-policies-and-procedures/Incident-Management/smb-access-troubleshooting.md) | KEDB-0110 |
| DFS Replication Issues | Replication backlog or errors | [DFS Replication Troubleshooting](../itil-policies-and-procedures/Incident-Management/dfs-replication-troubleshooting.md) | KEDB-0111 |
| Performance Issues | Slow file operations | [Performance Troubleshooting](../itil-policies-and-procedures/Incident-Management/windows-file-server-performance-troubleshooting.md) | KEDB-0112 |
| ZFS Mount Issues | Bulk storage unavailable | [ZFS Mount Troubleshooting](../itil-policies-and-procedures/Incident-Management/zfs-mount-troubleshooting.md) | KEDB-0113 |
| Iperius Backup Failures | Failed backup jobs | [Iperius Backup Troubleshooting](../itil-policies-and-procedures/Incident-Management/iperius-backup-troubleshooting.md) | KEDB-0114 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-02-01 |
| **Last Review Date** | 2025-03-15 |
| **Next Review Date** | 2025-06-15 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the Windows File Server service:

1. **Storage Expansion** (Q3 2025)
   - Increase NVMe capacity
   - Expand bulk storage tiers

2. **Performance Optimization** (Q2 2025)
   - Optimize SMB3 multichannel configuration
   - Implement improved caching strategies

3. **Enhanced Monitoring** (Q2 2025)
   - Develop custom monitoring dashboards
   - Implement predictive capacity planning

4. **Backup Enhancement** (Q3 2025)
   - Optimize cloud archival processes
   - Implement improved retention management

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | NTFS permissions with AD integration | Permission audit |
| Share Security | SMB share permissions | Share audit |
| Data Encryption | SMB encryption for sensitive shares | Configuration audit |
| Network Security | Restricted network access | Network scan verification |
| Server Hardening | CIS L1 baseline for Windows Server | Security scan |
| Audit Logging | File access auditing enabled | Log review |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Data Protection | CIS Controls 3.1, 3.4 | Security configuration audit |
| Access Control | ISO 27001 A.8.2.3 | Permission documentation |
| Backup Management | CIS Controls 10.1, 10.2 | Backup verification reports |
| Change Management | NIST 800-53 CM-3 | Change documentation |
| Secure Communication | NIST 800-53 SC-8 | SMB encryption audit |
| Storage Security | NIST 800-53 SC-28 | Security configuration review |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | Windows File Server Architecture | [Windows File Server Architecture](../Infrastructure/Storage/windows-file-server-architecture.md) |
| Technical Guide | DFS Replication Configuration | [DFS Replication Guide](../Infrastructure/Storage/dfs-replication-guide.md) |
| User Guide | SMB Share Access Guide | [SMB Share Access Guide](../Applications/User-Tools/smb-share-access-guide.md) |
| Technical Guide | Iperius Backup Configuration | [Iperius Backup Guide](../Infrastructure/Backup/iperius-backup-guide.md) |
| Security Baseline | Windows File Server Security | [Windows File Server Security](../Compliance-Security/CIS-Controls/windows-file-server-security.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0031 | Windows File Server | This service |
| CI | CI-0110 | DFS Replication | Component |
| CI | CI-0111 | SMB3 Multichannel | Component |
| KB Article | KB-0115 | Windows Server Patching Procedure | Procedure |
| Service Request | SRT-0022 | File Share Creation Request | Related process |
| Change Template | CHG-T-0017 | Windows Server Update | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
