<!-- 
---
title: "MinIO S3-Compatible Object Storage Documentation"
description: "Comprehensive documentation of the MinIO S3-compatible object storage service in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "storage", "s3", "minio", "object-storage", "container", "research-data"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["RKE2 Kubernetes", "Research Data Storage", "Backup Services"]
implements_policies: ["Data Storage Policy", "Data Retention Policy", "Infrastructure as Code Policy"]
phase: "phase-3"
cis_controls: ["CIS.3.1", "CIS.3.4", "CIS.10.1"]
iso27001_controls: ["A.8.2.1", "A.8.2.3", "A.12.3.1"]
nist_controls: ["SC-8", "SC-13", "CP-9"]
---
-->

# 🔧 **MinIO S3-Compatible Object Storage Service**

This document provides the authoritative reference for the MinIO S3-compatible object storage service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the MinIO S3-compatible object storage service, its operational parameters, and management procedures. It serves as the definitive reference for the object storage platform that provides scalable, API-compatible storage for a wide range of applications and services within the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| MinIO architecture and configuration | Application-specific storage configurations |
| Bucket management and policies | Detailed data lifecycle management |
| Integration with lab infrastructure | User training materials |
| Security and access controls | Data content management |
| Operational procedures and maintenance | External storage systems |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Storage Team Members
- DevOps Engineers
- Research Computing Staff
- Operations Team Members

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the MinIO service within the lab's operational framework.

### **2.1 Service Description**

MinIO provides S3-compatible object storage running as a containerized service on fs03, with 2TB of enterprise NVMe storage physically located on node05. It delivers high-performance, API-compatible storage for applications, research data, backups, and various services requiring object storage capabilities within the lab environment.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0030 |
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
| **API Response Time** | < 100ms | MinIO Prometheus metrics |
| **Throughput** | > 500 MB/s for reading, > 300 MB/s for writing | Performance testing |
| **Incident Response Time** | 30 minutes during support hours | GLPI ticket tracking |

### **3.2 Monitoring and Reporting**

MinIO and its operations are monitored through a comprehensive observability stack:

- **Prometheus** collects metrics from MinIO's built-in Prometheus endpoint
- **AlertManager** provides alert routing based on severity and service impact
- **Loki** aggregates logs from MinIO containers and operations
- **Grafana** dashboards visualize storage utilization, API operations, and performance metrics
- **Wazuh** provides security monitoring and access auditing

Monthly storage reports are generated and distributed to stakeholders, including capacity trends, performance statistics, and usage patterns.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The MinIO deployment consists of a containerized service running on fs03, with the actual storage residing on enterprise NVMe drives physically located on node05. It provides a RESTful API interface fully compatible with Amazon S3 standards.

![MinIO Architecture Diagram](../assets/images/minio-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **MinIO Container** | Docker container running on fs03 | CI-0100 |
| **Storage Backend** | 2TB Enterprise NVMe on node05 | ST-0035 |
| **NFS Mount** | Connects fs03 to node05 storage | CI-0101 |
| **Prometheus Integration** | Metrics collection endpoint | CI-0102 |
| **Bucket Notifications** | Event-driven notification system | CI-0103 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | fs03 VM | Complete service outage |
| **Requires** | node05 Storage System | Complete service outage |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | Authentication Services | Authorization failure |
| **Required By** | RKE2 Kubernetes | Storage backend unavailable |
| **Required By** | Research Data Services | Data storage unavailable |
| **Required By** | Backup Services | Backup storage unavailable |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily configuration backups |
| **Backup Method** | Configuration export to git repository |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours for service, varies by bucket |
| **Recovery Procedure** | [MinIO Recovery Procedure](../itil-policies-and-procedures/Backup-Management/minio-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Storage Administrator | Full administrative access | Approved by Infrastructure Lead |
| Bucket Owner | Per-bucket administrative access | Approved by Storage Lead |
| Application Service | API access with service credentials | Approved by DevOps Lead |
| Research Staff | Read/write access to designated buckets | Approved by Research Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| MinIO Service Failure | Critical | P1 | 15 minutes | 2 hours |
| Storage Performance Degradation | High | P2 | 30 minutes | 4 hours |
| Bucket Access Issues | Medium | P3 | 1 hour | 6 hours |
| API Inconsistency | Low | P4 | 4 hours | 24 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Version Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| Storage Expansion | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| Configuration Change | No | Storage Lead approval | Business hours |
| Bucket Policy Change | No | Bucket Owner approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Storage Health Check | Daily | Infrastructure Team | [Storage Health Check Procedure](../itil-policies-and-procedures/Monitoring/minio-health-check.md) |
| Capacity Planning | Monthly | Storage Team | [Capacity Planning Procedure](../itil-policies-and-procedures/Monitoring/storage-capacity-planning.md) |
| Performance Testing | Quarterly | Infrastructure Team | [Performance Testing Procedure](../itil-policies-and-procedures/Monitoring/minio-performance-testing.md) |
| Access Audit | Quarterly | Security Team | [Access Audit Procedure](../itil-policies-and-procedures/Security-Policies/minio-access-audit.md) |
| Configuration Backup | Weekly | Infrastructure Team | [Configuration Backup Procedure](../itil-policies-and-procedures/Backup-Management/minio-configuration-backup.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| API Access Failures | 403/401 errors | [API Troubleshooting](../itil-policies-and-procedures/Incident-Management/minio-api-troubleshooting.md) | KEDB-0100 |
| Storage Performance Issues | Slow response times | [Performance Troubleshooting](../itil-policies-and-procedures/Incident-Management/minio-performance-troubleshooting.md) | KEDB-0101 |
| Container Restart Issues | Container fails to start | [Container Troubleshooting](../itil-policies-and-procedures/Incident-Management/minio-container-troubleshooting.md) | KEDB-0102 |
| Storage Mount Issues | Backend storage unavailable | [Storage Mount Troubleshooting](../itil-policies-and-procedures/Incident-Management/minio-mount-troubleshooting.md) | KEDB-0103 |
| Notification Failures | Event notifications not firing | [Notification Troubleshooting](../itil-policies-and-procedures/Incident-Management/minio-notification-troubleshooting.md) | KEDB-0104 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-02-15 |
| **Last Review Date** | 2025-04-01 |
| **Next Review Date** | 2025-07-01 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the MinIO service:

1. **Storage Expansion** (Q3 2025)
   - Increase capacity to 4TB
   - Implement improved erasure coding

2. **Enhanced Integration** (Q2 2025)
   - Implement Kubernetes Operator
   - Develop tighter integration with research workflows

3. **Automated Lifecycle Management** (Q2 2025)
   - Implement policy-based object lifecycle rules
   - Develop automated tiering to cold storage

4. **Multi-Site Replication** (Q4 2025)
   - Explore replication capabilities for disaster recovery
   - Implement site-to-site synchronization

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | IAM-compatible policies | Policy audit |
| Data Encryption | TLS for transit, AES-256 for rest | Configuration audit |
| Authentication | API keys, JWT tokens | Security scan |
| Network Security | Internal network access only | Network scan |
| Bucket Policies | Least privilege per bucket | Policy review |
| Audit Logging | Comprehensive API operation logging | Log review |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Data Protection | CIS Controls 3.1, 3.4 | Encryption configuration audit |
| Access Control | ISO 27001 A.8.2.3 | Access control documentation |
| Backup Management | CIS Controls 10.1 | Backup verification reports |
| Change Management | NIST 800-53 CM-3 | Change documentation |
| Secure Communication | NIST 800-53 SC-8 | TLS configuration audit |
| Storage Encryption | NIST 800-53 SC-13 | Encryption verification |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | MinIO Architecture | [MinIO Architecture](../Infrastructure/Storage/minio-architecture.md) |
| Technical Guide | S3 API Usage Guidelines | [S3 API Guidelines](../Infrastructure/Storage/s3-api-guidelines.md) |
| User Guide | Research Data Storage Guide | [Research Data Storage Guide](../Applications/Research-Tools/research-data-storage-guide.md) |
| Integration Guide | Kubernetes Integration | [Kubernetes Integration](../Infrastructure/Compute/minio-kubernetes-integration.md) |
| Security Baseline | Object Storage Security | [Object Storage Security](../Compliance-Security/CIS-Controls/object-storage-security.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0030 | MinIO Object Storage | This service |
| CI | CI-0100 | MinIO Container | Component |
| CI | CI-0101 | NFS Mount | Component |
| KB Article | KB-0110 | MinIO Upgrade Procedure | Procedure |
| Service Request | SRT-0021 | Bucket Creation Request | Related process |
| Change Template | CHG-T-0016 | MinIO Version Upgrade | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
