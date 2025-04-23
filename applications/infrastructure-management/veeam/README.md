<!-- 
---
title: "Veeam Community Edition Documentation"
description: "Comprehensive documentation of the Veeam Community Edition backup service in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "backup", "veeam", "windows-server", "disaster-recovery", "zfs", "s3-archive"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Proxmox Backup Server", "Windows Server", "ZFS Storage"]
implements_policies: ["Backup Management Policy", "Disaster Recovery Policy", "Data Retention Policy"]
phase: "phase-3"
cis_controls: ["CIS.10.1", "CIS.10.2", "CIS.10.5"]
iso27001_controls: ["A.12.3.1", "A.17.1.2", "A.18.1.3"]
nist_controls: ["CP-9", "CP-10", "AU-11"]
---
-->

# 🔧 **Veeam Community Edition Service**

This document provides the authoritative reference for the Veeam Community Edition service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Veeam Community Edition service, its operational parameters, and management procedures. It serves as a complementary backup solution for Windows servers within the Proxmox Astronomy Lab, providing staff with operational experience on industry-standard enterprise backup software while ensuring secondary protection for critical Windows systems.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Veeam server architecture and configuration | Primary VM backup strategy (Proxmox Backup Server) |
| Backup job configuration for Windows servers | Domain Controller backups |
| SOBR configuration with S3 Deep Glacier | Full disaster recovery procedures |
| Backup verification and restoration procedures | User training materials |
| Operational procedures and maintenance | Backup strategy for Linux VMs |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Windows Server Administrators
- Storage Team Members
- Operations Team Members
- Disaster Recovery Coordinators

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Veeam service within the lab's operational framework.

### **2.1 Service Description**

Veeam Community Edition provides a secondary backup solution for Windows servers in the Proxmox Astronomy Lab environment. While not the primary backup system (which is Proxmox Backup Server), Veeam offers staff experience with industry-standard enterprise backup software and provides an alternative recovery path for critical Windows systems. The system includes local ZFS storage and cloud-based archival using S3 Deep Glacier.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0025 |
| **Service Type** | Supporting |
| **Service Category** | Infrastructure |
| **Business Criticality** | Medium |
| **Service Owner** | Infrastructure Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 |
| **Support Hours** | Monday-Friday, 9:00-17:00 ET |
| **Backup Windows** | Daily: 01:00-05:00 ET |
| **Maintenance Windows** | Every 3rd Sunday, 01:00-05:00 ET |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Backup Success Rate** | 98% | Veeam reporting and monitoring |
| **Recovery Time Objective (RTO)** | 4 hours | Recovery testing exercises |
| **Recovery Point Objective (RPO)** | 24 hours | Backup schedule adherence |
| **Backup Verification** | Weekly | Automated SureBackup jobs |

### **3.2 Monitoring and Reporting**

Veeam Community Edition and its backup operations are monitored through:

- **Veeam built-in reporting** for backup job success/failure
- **Email notifications** for job completion and failures
- **Prometheus exporter** for backup metrics collection
- **Grafana dashboards** for visualization of backup metrics
- **Wazuh agent** for security monitoring of the Veeam server

Weekly backup status reports are generated and distributed to stakeholders via the lab's reporting mechanism.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The Veeam Community Edition deployment consists of a Windows Server 2025 VM running Veeam Backup & Replication Community Edition, backing up to local ZFS storage with additional cloud tiering via Scale-Out Backup Repository (SOBR) to S3 Deep Glacier for long-term retention.

![Veeam Architecture Diagram](../assets/images/veeam-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **Veeam Server** | Windows Server 2025 VM running Veeam B&R Community Edition | VM-0030 |
| **Local Repository** | ZFS-based backup storage pool on Node05 | ST-0020 |
| **SOBR Configuration** | Scale-Out Backup Repository with cloud tiering | CI-0050 |
| **S3 Deep Glacier** | Cloud-based archival storage | CI-0051 |
| **Protected Servers** | Windows servers (excluding DCs) and fs03 | Various |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox Virtualization | Complete service outage |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | ZFS Storage | Local backup repository unavailable |
| **Requires** | Internet Connectivity | Cloud tiering unavailable |
| **Required By** | Disaster Recovery Procedures | Alternative recovery option unavailable |
| **Required By** | Windows Server Admins | Training environment unavailable |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily incremental backups at 01:00 ET |
| **Full Backup Schedule** | Weekly full backups on Sunday at 01:00 ET |
| **Retention Policy** | 14 days on local storage, 1 year in S3 Deep Glacier |
| **Recovery Procedure** | [Veeam Recovery Procedure](../itil-policies-and-procedures/Backup-Management/veeam-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Backup Administrator | Full administrative access | Approved by Infrastructure Lead |
| Windows Server Administrator | Job execution and recovery | Approved by Infrastructure Lead |
| Audit/Compliance Role | Read-only access | Approved by Security Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| Veeam Server Failure | High | P2 | 30 minutes | 4 hours |
| Backup Job Failure | Medium | P3 | 2 hours | 8 hours |
| Repository Issues | Medium | P3 | 2 hours | 8 hours |
| Cloud Tiering Failure | Low | P4 | 4 hours | 24 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Version Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| Job Configuration | No | Infrastructure Lead approval | Business hours |
| Repository Expansion | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| Protected Server Addition | No | Team Lead approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Backup Verification | Weekly | Infrastructure Team | [Backup Verification Procedure](../itil-policies-and-procedures/Backup-Management/veeam-verification-procedure.md) |
| Test Restoration | Monthly | Infrastructure Team | [Test Restoration Procedure](../itil-policies-and-procedures/Backup-Management/veeam-test-restoration.md) |
| Capacity Planning | Monthly | Infrastructure Team | [Capacity Planning Procedure](../itil-policies-and-procedures/Backup-Management/backup-capacity-planning.md) |
| License Verification | Quarterly | Infrastructure Team | [License Verification Procedure](../itil-policies-and-procedures/Access-Management/license-verification-procedure.md) |
| Log Rotation | Weekly | Infrastructure Team | [Log Management Procedure](../itil-policies-and-procedures/Monitoring/log-management-procedure.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Backup Job Failure | Failed job status in console | [Backup Job Troubleshooting](../itil-policies-and-procedures/Incident-Management/veeam-job-troubleshooting.md) | KEDB-0052 |
| Repository Access Issues | Repository unavailable error | [Repository Troubleshooting](../itil-policies-and-procedures/Incident-Management/veeam-repository-troubleshooting.md) | KEDB-0053 |
| Cloud Tiering Failure | Failed tiering task | [Cloud Tiering Troubleshooting](../itil-policies-and-procedures/Incident-Management/veeam-cloud-tiering-troubleshooting.md) | KEDB-0054 |
| Restore Failures | Unable to restore backup | [Restore Troubleshooting](../itil-policies-and-procedures/Incident-Management/veeam-restore-troubleshooting.md) | KEDB-0055 |
| Space Usage Alerts | Low free space warnings | [Space Management Guide](../itil-policies-and-procedures/Incident-Management/backup-space-management.md) | KEDB-0056 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-03-01 |
| **Last Review Date** | 2025-04-15 |
| **Next Review Date** | 2025-07-15 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the Veeam Community Edition service:

1. **Enhanced Reporting** (Q3 2025)
   - Develop custom reports for backup statistics
   - Integrate with central reporting platform

2. **Additional Protected Systems** (Q2 2025)
   - Evaluate adding critical Linux systems within CE limits
   - Optimize backup job scheduling

3. **Recovery Testing Automation** (Q3 2025)
   - Develop automated recovery testing scripts
   - Implement regular recovery verification

4. **Documentation Enhancement** (Q2 2025)
   - Develop comprehensive training materials
   - Create detailed recovery playbooks

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based access with AD integration | Access audit logs |
| Network Security | Restricted network access to backup server | Network scan verification |
| Data Encryption | AES-256 encryption for backups | Configuration audit |
| Immutability | S3 object lock for cloud tier | S3 policy verification |
| System Hardening | Windows Server hardened to CIS L1 | CIS benchmark scan |
| Audit Logging | Comprehensive activity logging | Log review |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Backup Management | CIS Controls 10.1, 10.2 | Backup success reporting |
| Data Recovery Capability | ISO 27001 A.12.3.1 | Recovery testing documentation |
| Retention Compliance | Lab Data Retention Policy | Retention configuration audit |
| System Hardening | Windows Server Baseline | Security scan reports |
| Access Control | CIS Controls 5.1 | Access review documentation |
| Logging and Monitoring | CIS Controls 8.2 | Log configuration audit |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | Veeam Architecture | [Veeam Architecture](../Infrastructure/Backup/veeam-architecture.md) |
| Technical Guide | SOBR Configuration | [SOBR Configuration](../Infrastructure/Backup/sobr-configuration.md) |
| User Guide | Backup and Recovery Guide | [Backup and Recovery Guide](../Infrastructure/Backup/backup-recovery-guide.md) |
| Limitations | Community Edition Limitations | [CE Limitations](../Infrastructure/Backup/community-edition-limitations.md) |
| Integration Guide | ZFS Integration Configuration | [ZFS Integration](../Infrastructure/Storage/zfs-veeam-integration.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0025 | Veeam Community Edition | This service |
| CI | CI-0052 | Veeam Backup Server | Component |
| CI | CI-0053 | Veeam Backup Repositories | Component |
| KB Article | KB-0091 | Veeam Upgrade Procedure | Procedure |
| Service Request | SRT-0016 | Backup Restoration Request | Related process |
| Change Template | CHG-T-0010 | Veeam Configuration Change | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
