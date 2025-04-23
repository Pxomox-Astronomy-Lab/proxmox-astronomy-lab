<!-- 
---
title: "Ansible/AWX Documentation"
description: "Comprehensive documentation of the Ansible/AWX configuration management and automation service in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "automation", "ansible", "awx", "configuration-management", "idempotent", "iac"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Proxmox VE", "RKE2 Kubernetes", "Windows Server"]
implements_policies: ["Change Management Policy", "Infrastructure as Code Policy", "Configuration Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.4.1", "CIS.4.2", "CIS.11.1"]
iso27001_controls: ["A.12.1.2", "A.12.5.1", "A.14.2.2"]
nist_controls: ["CM-2", "CM-3", "CM-6"]
---
-->

# 🔧 **Ansible/AWX Service**

This document provides the authoritative reference for the Ansible/AWX service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Ansible/AWX service, its operational parameters, and management procedures. It serves as the definitive reference for the configuration management and automation platform that provides consistent, repeatable, and auditable infrastructure operations within the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Ansible/AWX architecture and configuration | Detailed playbook implementation |
| Automation workflow definitions | CI/CD pipeline specifics |
| Integration with lab infrastructure | User training materials |
| Role and access management | External system integrations |
| Operational procedures and maintenance | Specific automation use cases |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- System Engineers
- Operations Team Members
- Security Team Members
- Automation Specialists

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Ansible/AWX service within the lab's operational framework.

### **2.1 Service Description**

Ansible/AWX provides a comprehensive configuration management and automation platform for the Proxmox Astronomy Lab. It enables consistent, version-controlled, and auditable management of infrastructure components through infrastructure-as-code practices, reducing manual intervention and ensuring configuration consistency across the environment.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0028 |
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
| **Job Execution Success Rate** | 98% | AWX built-in reporting |
| **Job Execution Performance** | < 5 minutes for standard jobs | Job execution metrics |
| **Incident Response Time** | 30 minutes during support hours | GLPI ticket tracking |

### **3.2 Monitoring and Reporting**

Ansible/AWX and its operations are monitored through a comprehensive observability stack:

- **Prometheus** collects metrics from AWX API endpoints
- **AlertManager** provides alert routing based on severity and service impact
- **Loki** aggregates logs from Ansible/AWX operations
- **Grafana** dashboards visualize job success rates, performance, and resource utilization
- **Wazuh** provides security monitoring and access auditing

Weekly automation reports are generated through AWX and distributed to stakeholders via the lab's reporting mechanism.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The Ansible/AWX deployment runs on a dedicated VM (lab-ansible01) with connections to all managed systems. It leverages version-controlled playbooks stored in Gitea and includes task-specific automation modules for various infrastructure components.

![Ansible/AWX Architecture Diagram](../assets/images/ansible-awx-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **AWX Server** | Core automation platform (lab-ansible01) | VM-0015 |
| **Ansible Engine** | Execution environment for playbooks | CI-0080 |
| **Gitea Repository** | Source control for playbooks and roles | SVC-0026 |
| **PostgreSQL Database** | Backend database for AWX | CI-0081 |
| **Custom Modules** | Specialized automation modules | CI-0082 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox Virtualization | Complete service outage |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | Gitea | Unable to retrieve playbooks |
| **Required By** | Configuration Management | Automated configuration unavailable |
| **Required By** | OS Patching | Automated patching unavailable |
| **Required By** | Security Compliance | Automated compliance checks unavailable |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily VM snapshots and database backups |
| **Backup Method** | Proxmox Backup Server and database dumps |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Ansible/AWX Recovery Procedure](../itil-policies-and-procedures/Backup-Management/ansible-awx-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| AWX Administrator | Full administrative access | Approved by Infrastructure Lead |
| Automation Engineer | Template and job template management | Approved by Infrastructure Lead |
| Operations Team | Job execution only | Approved by Operations Lead |
| Security Team | Security-related job execution | Approved by Security Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| AWX Service Failure | Critical | P1 | 15 minutes | 2 hours |
| Job Execution Failure | High | P2 | 30 minutes | 4 hours |
| Performance Degradation | Medium | P3 | 1 hour | 6 hours |
| UI Access Issues | Low | P4 | 4 hours | 24 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Version Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| New Core Playbook | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| Playbook Update | No | Team Lead approval | Business hours |
| Inventory Update | No | Team Lead approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Job Execution Audit | Weekly | Infrastructure Team | [Job Audit Procedure](../itil-policies-and-procedures/Monitoring/ansible-job-audit-procedure.md) |
| Inventory Verification | Monthly | Infrastructure Team | [Inventory Verification Procedure](../itil-policies-and-procedures/Monitoring/ansible-inventory-verification.md) |
| Playbook Validation | Before deployment | Automation Team | [Playbook Validation Procedure](../itil-policies-and-procedures/Change-Management/ansible-playbook-validation.md) |
| Access Review | Quarterly | Security Team | [Access Review Procedure](../itil-policies-and-procedures/Security-Policies/ansible-access-review.md) |
| Database Maintenance | Monthly | Infrastructure Team | [Database Maintenance Procedure](../itil-policies-and-procedures/Monitoring/ansible-database-maintenance.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Job Execution Failures | Failed job status | [Job Troubleshooting](../itil-policies-and-procedures/Incident-Management/ansible-job-troubleshooting.md) | KEDB-0080 |
| Connection Issues | Unable to connect to managed nodes | [Connection Troubleshooting](../itil-policies-and-procedures/Incident-Management/ansible-connection-troubleshooting.md) | KEDB-0081 |
| Authentication Problems | SSH/WinRM authentication errors | [Authentication Troubleshooting](../itil-policies-and-procedures/Incident-Management/ansible-authentication-troubleshooting.md) | KEDB-0082 |
| AWX Performance Issues | Slow UI/API response | [Performance Troubleshooting](../itil-policies-and-procedures/Incident-Management/ansible-performance-troubleshooting.md) | KEDB-0083 |
| Database Connection Issues | Database errors | [Database Troubleshooting](../itil-policies-and-procedures/Incident-Management/ansible-database-troubleshooting.md) | KEDB-0084 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-01-10 |
| **Last Review Date** | 2025-03-15 |
| **Next Review Date** | 2025-06-15 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the Ansible/AWX service:

1. **Enhanced Reporting** (Q3 2025)
   - Develop custom reporting dashboards
   - Implement scheduled report generation

2. **Expanded Infrastructure Coverage** (Q2 2025)
   - Develop playbooks for additional infrastructure components
   - Implement new device integrations

3. **Self-Service Automation** (Q2 2025)
   - Develop user-friendly automation workflows
   - Implement approval processes for self-service tasks

4. **Security Scanning Integration** (Q3 2025)
   - Integrate with security scanning tools
   - Automate compliance verification

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based access with AD integration | Access audit logs |
| Credential Management | Secure credential vault | Configuration audit |
| Network Security | Secure connection to managed hosts | Network scan verification |
| Code Security | Version-controlled playbooks with review | Code audit |
| Execution Control | Job templates with approval workflows | Access audit |
| Logging and Auditing | Comprehensive job execution logs | Log review |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Configuration Management | CIS Controls 4.1, 4.2 | Configuration baseline documentation |
| Change Management | NIST 800-53 CM-3 | Change approval records |
| Secure Configuration | CIS Controls 11.1 | Configuration audit results |
| Separation of Duties | ISO 27001 A.6.1.2 | Access control matrix |
| Audit Logging | CIS Controls 8.2 | Log configuration audit |
| Documentation Standards | ISO 27001 A.14.2.2 | Documentation audit |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | Ansible/AWX Architecture | [Ansible Architecture](../Infrastructure/Applications/ansible-architecture.md) |
| Technical Guide | Playbook Development Guidelines | [Playbook Guidelines](../Infrastructure/Applications/ansible-playbook-guidelines.md) |
| User Guide | Automation Request Procedure | [Automation Request Guide](../Applications/Automation-Tools/automation-request-guide.md) |
| Integration Guide | Infrastructure Integration | [Infrastructure Integration](../Infrastructure/Compute/ansible-infrastructure-integration.md) |
| Security Baseline | Ansible Security Posture | [Ansible Security](../Compliance-Security/CIS-Controls/ansible-security.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0028 | Ansible/AWX | This service |
| CI | CI-0080 | Ansible Engine | Component |
| CI | CI-0081 | AWX Database | Component |
| KB Article | KB-0100 | Ansible/AWX Upgrade Procedure | Procedure |
| Service Request | SRT-0019 | Automation Request | Related process |
| Change Template | CHG-T-0013 | AWX Version Upgrade | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
