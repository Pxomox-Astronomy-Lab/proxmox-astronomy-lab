<!-- 
---
title: "GLPI IT Service Management Platform Documentation"
description: "Comprehensive documentation of the GLPI ITSM platform and its dual role for operational ticketing and ITIL simulation in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "itsm", "itil", "glpi", "change-management", "incident-management", "ticketing", "service-desk"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Service Desk", "Change Management", "Incident Management", "Problem Management"]
implements_policies: ["ITIL Simulation Approach", "Change Management Policy", "Incident Management Policy", "Service Catalog Policy"]
phase: "phase-2"
cis_controls: ["CIS.4.1", "CIS.14.1", "CIS.14.6"]
iso27001_controls: ["A.12.1.2", "A.12.6.1", "A.16.1.1"]
nist_controls: ["CM-3", "IR-4", "CP-2"]
---
-->

# 🔧 **GLPI IT Service Management Platform**

This document provides the authoritative reference for the GLPI IT Service Management (ITSM) platform, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the GLPI ITSM platform, its operational parameters, and management procedures. It serves as the definitive reference for the service management tool that provides both operational ticketing functionality and ITIL simulation capabilities within the Proxmox Astronomy Lab environment. GLPI supports structured IT processes and provides a platform for staff and volunteers to rotate through various ITIL roles as part of the lab's educational and operational approach.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| GLPI architecture and configuration | Detailed ITIL methodologies |
| Ticketing and workflow management | External service integrations |
| ITIL role simulation framework | User training materials |
| CMDB/asset management | Financial management |
| Operational procedures and maintenance | Project management specifics |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Operations Team Members
- Service Desk Personnel
- ITIL Simulation Participants
- IT Volunteers

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the GLPI service within the lab's operational framework.

### **2.1 Service Description**

GLPI provides a comprehensive IT Service Management platform that serves a dual purpose in the Proxmox Astronomy Lab: it functions as the operational ticketing system for maintaining lab infrastructure and services, while simultaneously serving as the platform for ITIL role simulation where staff and volunteers rotate through various ITIL roles (CAB members, process owners, etc.) to gain practical experience with ITIL processes.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0029 |
| **Service Type** | Core |
| **Service Category** | Infrastructure |
| **Business Criticality** | High |
| **Service Owner** | Operations Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 |
| **Support Hours** | Monday-Friday, 9:00-17:00 ET |
| **Maintenance Windows** | Every 3rd Sunday, 01:00-05:00 ET |
| **ITIL Simulation Activity** | According to rotation schedule |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Prometheus uptime monitoring |
| **Response Time** | < 2 seconds | Synthetic monitoring |
| **Incident Response Time** | Priority-based (see Incident Management) | GLPI reporting |
| **Change Implementation Time** | Type-based (see Change Management) | GLPI reporting |

### **3.2 Monitoring and Reporting**

GLPI and its operations are monitored through a comprehensive observability stack:

- **Prometheus** collects metrics from GLPI application server
- **AlertManager** provides alert routing based on severity and service impact
- **Loki** aggregates logs from GLPI and database operations
- **Grafana** dashboards visualize ticket metrics, SLA compliance, and resource utilization
- **Wazuh** provides security monitoring and access auditing

Weekly ITSM reports are generated through GLPI and distributed to stakeholders as part of the ITIL simulation process. These reports include metrics on ticket volume, resolution times, SLA compliance, and process adherence.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The GLPI deployment consists of a web application server with a dedicated database backend, running as a containerized application managed through Portainer. It leverages Active Directory for authentication and integrates with the lab's email system for notifications.

![GLPI Architecture Diagram](../assets/images/glpi-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **GLPI Application** | Docker container running the GLPI application | CI-0090 |
| **MariaDB Database** | Database for GLPI data and configuration | CI-0091 |
| **Persistent Storage** | Volume for GLPI documents and attachments | ST-0030 |
| **Active Directory** | Authentication provider for user access | SVC-0002 |
| **SMTP Service** | Email notification service | SVC-0010 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Portainer | Service deployment impact |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | Active Directory | Authentication failure |
| **Requires** | SMTP Service | Notification failure |
| **Required By** | Change Management Process | Process disruption |
| **Required By** | Incident Management Process | Process disruption |
| **Required By** | ITIL Simulation | Simulation disruption |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily database backups at 02:00 ET |
| **Backup Method** | Database dumps, volume snapshots |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [GLPI Recovery Procedure](../itil-policies-and-procedures/Backup-Management/glpi-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| GLPI Administrator | Full administrative access | Approved by Operations Lead |
| Service Desk Agent | Ticket management access | Approved by Service Desk Lead |
| Change Advisory Board | Change approval access | Rotational assignment per ITIL simulation |
| Problem Manager | Problem management access | Rotational assignment per ITIL simulation |
| Regular User | Self-service portal access | Automatic for all lab members |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| GLPI Service Failure | Critical | P1 | 15 minutes | 2 hours |
| Database Issues | High | P2 | 30 minutes | 4 hours |
| Performance Degradation | Medium | P3 | 1 hour | 8 hours |
| UI/Access Issues | Low | P4 | 4 hours | 24 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Version Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| Configuration Change | No | Service Owner approval | Business hours |
| Workflow Modification | Yes | Process Owner approval | Scheduled maintenance window |
| Plugin Installation | Yes | Service Owner approval | Scheduled maintenance window |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Database Optimization | Monthly | Infrastructure Team | [Database Optimization Procedure](../itil-policies-and-procedures/Monitoring/glpi-database-optimization.md) |
| Ticket Audit | Quarterly | Service Desk Lead | [Ticket Audit Procedure](../itil-policies-and-procedures/Monitoring/glpi-ticket-audit.md) |
| User Access Review | Quarterly | Security Team | [Access Review Procedure](../itil-policies-and-procedures/Security-Policies/glpi-access-review.md) |
| ITIL Role Rotation | According to schedule | Operations Lead | [ITIL Role Rotation Procedure](../itil-policies-and-procedures/ITIL-Simulation-Approach/role-rotation-procedure.md) |
| Knowledge Base Review | Monthly | Documentation Team | [KB Review Procedure](../itil-policies-and-procedures/Documentation/knowledge-base-review.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Authentication Issues | Unable to log in | [Authentication Troubleshooting](../itil-policies-and-procedures/Incident-Management/glpi-authentication-troubleshooting.md) | KEDB-0090 |
| Database Connection Issues | Database errors | [Database Troubleshooting](../itil-policies-and-procedures/Incident-Management/glpi-database-troubleshooting.md) | KEDB-0091 |
| Email Notification Failures | Notifications not received | [Notification Troubleshooting](../itil-policies-and-procedures/Incident-Management/glpi-notification-troubleshooting.md) | KEDB-0092 |
| Performance Issues | Slow response times | [Performance Troubleshooting](../itil-policies-and-procedures/Incident-Management/glpi-performance-troubleshooting.md) | KEDB-0093 |
| Workflow Issues | Incorrect ticket routing | [Workflow Troubleshooting](../itil-policies-and-procedures/Incident-Management/glpi-workflow-troubleshooting.md) | KEDB-0094 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-01-05 |
| **Last Review Date** | 2025-03-10 |
| **Next Review Date** | 2025-06-10 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the GLPI service:

1. **Enhanced Automation** (Q3 2025)
   - Implement automation for routine ticket processing
   - Develop self-service resolution capabilities

2. **ITIL Simulation Enhancement** (Q2 2025)
   - Develop scenario-based simulation exercises
   - Implement more complex approval workflows

3. **Reporting Enhancements** (Q2 2025)
   - Develop custom dashboards for ITIL KPIs
   - Implement automated report generation

4. **Integration Expansion** (Q3 2025)
   - Integrate with monitoring systems for automated ticket creation
   - Implement webhook capabilities for event-driven workflows

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | AD integration with role-based access | Access audit logs |
| Authentication | SSO with AD credentials | Security scan |
| Data Protection | TLS encryption for all connections | Configuration audit |
| Database Security | Restricted access, encrypted backups | Security scan |
| Audit Logging | Comprehensive activity logging | Log review |
| Session Management | Secure session handling | Security scan |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Change Management | CIS Controls 4.1 | Change records audit |
| Incident Management | ISO 27001 A.16.1.1 | Incident records audit |
| Documentation Management | CIS Controls 14.1 | Knowledge base audit |
| Access Control | CIS Controls 5.1 | Access review documentation |
| Audit Logging | CIS Controls 8.2 | Log configuration audit |
| Backup Management | CIS Controls 10.1 | Backup verification reports |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | GLPI Architecture | [GLPI Architecture](../Infrastructure/Applications/glpi-architecture.md) |
| Process Guide | ITIL Simulation Approach | [ITIL Simulation Approach](../itil-policies-and-procedures/ITIL-Simulation-Approach/README.md) |
| User Guide | Service Desk Agent Guide | [Service Desk Guide](../Applications/ITSM-Tools/service-desk-guide.md) |
| Integration Guide | AD Integration Configuration | [AD Integration](../Control-Plane/Identity-Management/glpi-ad-integration.md) |
| Security Baseline | GLPI Security Posture | [GLPI Security](../Compliance-Security/CIS-Controls/glpi-security.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0029 | GLPI ITSM Platform | This service |
| CI | CI-0090 | GLPI Application | Component |
| CI | CI-0091 | GLPI Database | Component |
| KB Article | KB-0105 | GLPI Upgrade Procedure | Procedure |
| Change Template | CHG-T-0015 | GLPI Version Upgrade | Change process |
| Service Request | SRT-0020 | ITIL Role Rotation Request | Related process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Operations Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
