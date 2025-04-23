<!-- 
---
title: "Linux File Server Documentation"
description: "Comprehensive documentation of the Linux File Server with NFSv4 multipath support and MinIO integration in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "storage", "linux", "nfs", "nfsv4", "file-server", "multipath", "high-availability", "minio"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["MinIO Object Storage", "Storage Services", "Kubernetes Services", "ZFS Storage"]
implements_policies: ["Data Storage Policy", "Infrastructure as Code Policy", "Container Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.3.1", "CIS.3.4", "CIS.9.4"]
iso27001_controls: ["A.8.2.1", "A.8.2.3", "A.12.1.2"]
nist_controls: ["SC-8", "SC-28", "CM-6"]
---
-->

# 🔧 **Linux File Server (NFSv4) Service**

This document provides the authoritative reference for the Linux File Server service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Linux File Server service, its operational parameters, and management procedures. It serves as the definitive reference for the NFSv4 file server with multipath support running on fs03, which also hosts the MinIO S3-compatible object storage service. Together, these services provide robust file sharing capabilities for Linux-based systems and containerized services within the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| NFSv4 server architecture and configuration | Windows-based file sharing (SMB) |
| Multipath implementation and redundancy | Application-specific storage configurations |
| MinIO container hosting | User training materials |
| Integration with lab infrastructure | External storage systems |
| Operational procedures and maintenance | Data content management |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Linux System Administrators
- Storage Team Members
- DevOps Engineers
- Operations Team Members

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Linux File Server service within the lab's operational framework.

### **2.1 Service Description**

The Linux File Server service provides high-performance NFSv4 file sharing with multipath support, running on fs03 (Ubuntu 24.04). This server also hosts the MinIO S3-compatible object storage service as a Docker container, leveraging the same underlying infrastructure. Both services provide critical storage capabilities for Linux-based systems, Kubernetes workloads, and various research applications that require either traditional file system access or S3-compatible object storage.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0032 |
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
| **Availability** | 99.9% | Prometheus uptime monitoring |
| **NFS Performance** | > 700 MB/s for reading, > 400 MB/s for writing | Performance testing |
| **MinIO Performance** | > 500 MB/s for reading, > 300 MB/s for writing | MinIO Prometheus metrics |
| **Response Time** | < 5ms for local storage access | System monitoring |
| **Incident Response Time** | 30 minutes during support hours | GLPI ticket tracking |

### **3.2 Monitoring and Reporting**

The Linux File Server service is monitored through a comprehensive observability stack:

- **Prometheus** collects metrics from both NFS server and MinIO
- **AlertManager** provides alert routing based on severity and service impact
- **Loki** aggregates logs from NFS, MinIO, and system services
- **Grafana** dashboards visualize storage utilization, performance metrics, and availability
- **Wazuh** provides security monitoring and access auditing

Monthly storage reports are generated and distributed to stakeholders, including capacity trends, performance statistics, and usage patterns.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The Linux File Server implementation consists of an Ubuntu 24.04 server (fs03) configured to provide both NFSv4 shares with multipath support and MinIO S3-compatible object storage as a containerized service. The system leverages high-performance local storage for NFS while providing access to the MinIO backend storage located on node05.

![Linux File Server Architecture Diagram](../assets/images/linux-file-server-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **fs03** | Ubuntu 24.04 server | VM-0024 |
| **NFS Server** | NFSv4 server with multipath configuration | CI-0120 |
| **Multipath Support** | Network redundancy for high availability | CI-0121 |
| **MinIO Container** | Docker container for S3-compatible storage | CI-0100 |
| **Local Storage** | High-performance storage for NFS shares | ST-0045 |
| **MinIO Storage Backend** | 2TB Enterprise NVMe on node05 | ST-0035 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox Virtualization | Complete service outage |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | Docker Engine | MinIO service outage |
| **Requires** | node05 Storage (for MinIO) | MinIO storage unavailable |
| **Required By** | Kubernetes Cluster | Persistent storage unavailable |
| **Required By** | Linux-based Applications | File storage unavailable |
| **Required By** | Research Computing | Data access unavailable |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Server Backup Schedule** | Daily VM backups via Proxmox Backup Server |
| **NFS Configuration Backup** | Weekly configuration backups to Git repository |
| **MinIO Configuration Backup** | Weekly configuration export to Git repository |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Linux File Server Recovery Procedure](../itil-policies-and-procedures/Backup-Management/linux-file-server-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Storage Administrator | Full administrative access | Approved by Infrastructure Lead |
| Linux Administrator | Server management access | Approved by Linux Team Lead |
| Export Owner | Per-export administrative access | Approved by Storage Lead |
| Application Service | API/mount access with service credentials | Approved by DevOps Lead |
| Research Staff | Read/write access to designated exports | Approved by Research Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| Server Failure | Critical | P1 | 15 minutes | 2 hours |
| NFS Service Failure | Critical | P1 | 15 minutes | 2 hours |
| MinIO Service Failure | Critical | P1 | 15 minutes | 2 hours |
| Performance Degradation | High | P2 | 30 minutes | 4 hours |
| Export Access Issues | Medium | P3 | 1 hour | 6 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| OS Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| Storage Expansion | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| NFS Configuration Change | No | Storage Lead approval | Business hours |
| MinIO Version Upgrade | Yes | Storage Lead approval | Scheduled maintenance window |
| Export Configuration Change | No | Export Owner approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| NFS Service Health Check | Daily | Linux Team | [NFS Health Check Procedure](../itil-policies-and-procedures/Monitoring/nfs-health-check.md) |
| MinIO Service Health Check | Daily | Infrastructure Team | [MinIO Health Check Procedure](../itil-policies-and-procedures/Monitoring/minio-health-check.md) |
| Storage Performance Monitoring | Weekly | Storage Team | [Storage Performance Monitoring](../itil-policies-and-procedures/Monitoring/linux-storage-performance-monitoring.md) |
| Capacity Planning | Monthly | Storage Team | [Capacity Planning Procedure](../itil-policies-and-procedures/Monitoring/storage-capacity-planning.md) |
| Export Permission Audit | Quarterly | Security Team | [Export Permission Audit](../itil-policies-and-procedures/Security-Policies/export-permission-audit.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| NFS Access Failures | "Permission denied" or mount errors | [NFS Access Troubleshooting](../itil-policies-and-procedures/Incident-Management/nfs-access-troubleshooting.md) | KEDB-0120 |
| Multipath Failures | Path failures or performance degradation | [Multipath Troubleshooting](../itil-policies-and-procedures/Incident-Management/nfs-multipath-troubleshooting.md) | KEDB-0121 |
| MinIO Service Issues | S3 API errors or service unavailability | [MinIO Troubleshooting](../itil-policies-and-procedures/Incident-Management/minio-troubleshooting.md) | KEDB-0100 |
| Performance Issues | Slow file operations | [NFS Performance Troubleshooting](../itil-policies-and-procedures/Incident-Management/nfs-performance-troubleshooting.md) | KEDB-0122 |
| Container Issues | Docker container failures | [Container Troubleshooting](../itil-policies-and-procedures/Incident-Management/minio-container-troubleshooting.md) | KEDB-0102 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-02-20 |
| **Last Review Date** | 2025-04-10 |
| **Next Review Date** | 2025-07-10 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the Linux File Server service:

1. **Storage Expansion** (Q3 2025)
   - Increase NFS storage capacity
   - Expand MinIO object storage capacity

2. **Performance Optimization** (Q2 2025)
   - Optimize NFS tuning parameters
   - Implement enhanced caching strategies

3. **Enhanced Integration** (Q2 2025)
   - Tighter integration with Kubernetes CSI drivers
   - Develop improved monitoring and alerting

4. **Security Enhancements** (Q3 2025)
   - Implement NFSv4 Kerberos authentication
   - Enhanced MinIO security policies

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Unix permissions and NFS export options | Permission audit |
| Authentication | Host-based authentication for NFS, IAM for MinIO | Configuration audit |
| Data Protection | In-flight encryption for sensitive data | Security scan |
| Server Hardening | CIS L2 baseline for Ubuntu 24.04 | Security scan |
| Network Security | IP-based export restrictions | Network scan verification |
| Audit Logging | Comprehensive system and access logging | Log review |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Server Hardening | CIS Controls 3.1, 3.4 | Security configuration audit |
| Access Control | ISO 27001 A.8.2.3 | Permission documentation |
| Configuration Management | CIS Controls 9.4 | Configuration baseline documentation |
| Change Management | NIST 800-53 CM-6 | Change documentation |
| Secure Communication | NIST 800-53 SC-8 | Encryption configuration audit |
| Storage Security | NIST 800-53 SC-28 | Security configuration review |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | Linux File Server Architecture | [Linux File Server Architecture](../Infrastructure/Storage/linux-file-server-architecture.md) |
| Technical Guide | NFS Configuration Guide | [NFS Configuration Guide](../Infrastructure/Storage/nfs-configuration-guide.md) |
| Technical Guide | NFS Multipath Setup | [NFS Multipath Setup](../Infrastructure/Storage/nfs-multipath-setup.md) |
| Technical Guide | MinIO Configuration | [MinIO Configuration Guide](../Infrastructure/Storage/minio-configuration-guide.md) |
| Security Baseline | Linux File Server Security | [Linux File Server Security](../Compliance-Security/CIS-Controls/linux-file-server-security.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0032 | Linux File Server | This service |
| CI | CI-0120 | NFS Server | Component |
| CI | CI-0121 | NFS Multipath | Component |
| CI | CI-0100 | MinIO Container | Component |
| KB Article | KB-0120 | NFS Server Configuration Guide | Procedure |
| Service Request | SRT-0025 | NFS Export Request | Related process |
| Change Template | CHG-T-0020 | Linux File Server Update | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
