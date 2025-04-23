<!-- 
---
title: "Portainer Business Edition Documentation"
description: "Comprehensive documentation of the Portainer Business Edition service for container management in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "containers", "portainer", "docker", "gitops", "container-management"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Docker", "GitOps", "RKE2 Kubernetes", "Active Directory"]
implements_policies: ["Change Management Policy", "Access Management Policy", "Security Policy"]
phase: "phase-3"
cis_controls: ["CIS.4.1", "CIS.5.1", "CIS.12.1"]
iso27001_controls: ["A.9.2.3", "A.12.1.2", "A.12.5.1"]
nist_controls: ["AC-2", "CM-2", "CM-6"]
---
-->

# 🔧 **Portainer Business Edition Service**

This document provides the authoritative reference for the Portainer Business Edition service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Portainer Business Edition service, its operational parameters, and management procedures. It serves as the definitive reference for container management within the Proxmox Astronomy Lab environment, enabling simplified deployment, management, and monitoring of containerized workloads across multiple nodes.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Portainer architecture and server configuration | Application-specific container configurations |
| Agent configuration on managed nodes | Detailed container application troubleshooting |
| User access and role management | User training materials |
| GitOps integration and stack management | Integration with external systems outside lab |
| Operational procedures and maintenance | Container image security scanning details |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- DevOps Engineers
- Operations Team Members
- Development Team Members
- Security Personnel

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Portainer service within the lab's operational framework.

### **2.1 Service Description**

Portainer Business Edition provides a centralized web-based UI for managing Docker containers across multiple nodes in the Proxmox Astronomy Lab environment. It facilitates simplified container deployment, management, monitoring, and troubleshooting while enabling GitOps workflows for standardized deployments through infrastructure as code.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0024 |
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
| **UI Response Time** | < 2 seconds | Synthetic monitoring |
| **Container Deployment Time** | < 60 seconds | Deployment metrics logging |
| **Incident Response Time** | 30 minutes during support hours | GLPI ticket tracking |

### **3.2 Monitoring and Reporting**

Portainer and its managed nodes are monitored through a comprehensive observability stack:

- **Prometheus** collects metrics from Portainer server and all managed nodes
- **AlertManager** provides alert routing based on severity and service impact
- **Loki** aggregates logs from Portainer and container operations
- **Grafana** dashboards visualize Portainer health, container performance, and resource utilization
- **Wazuh** provides security monitoring and access auditing

Monthly service reports are generated through Grafana and distributed to stakeholders via the lab's reporting mechanism.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The Portainer Business Edition deployment follows a centralized management architecture with a primary Portainer server and distributed agents across managed nodes. It integrates with Active Directory for authentication and Gitea for GitOps-based deployment workflows.

![Portainer Architecture Diagram](../assets/images/portainer-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **Portainer Server** | Primary management server (lab-port01) with Business Edition license | VM-0016 |
| **App Node 1** | Application container host (lab-apps01) running Portainer agent | VM-0018 |
| **App Node 2** | Application container host (proj-apps01) running Portainer agent | VM-0021 |
| **Database Node** | Database container host (lab-db01) running Portainer agent | VM-0017 |
| **Gitea Repository** | GitOps source repository for stack definitions | SVC-0026 |
| **Active Directory** | Authentication provider for user access | SVC-0002 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox Virtualization | Complete service outage |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | Active Directory | Authentication failure |
| **Requires** | Gitea | GitOps deployment failure |
| **Required By** | Application Services | Deployment and management impact |
| **Required By** | Database Services | Deployment and management impact |
| **Required By** | Monitoring Services | Deployment and management impact |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Proxmox Backup Server: Daily snapshots of all VMs |
| **Backup Method** | Portainer configuration export: Weekly to secure storage |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Portainer Recovery Procedure](../itil-policies-and-procedures/Backup-Management/portainer-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| GRP_Admin_Engineers | Administrator | AD group membership, approved by Infrastructure Lead |
| GRP_Admin_Ops | User (start/stop/restart/logs) | AD group membership, approved by Operations Lead |
| GRP_Admin_Sysadmin | User (start/stop/restart/logs) | AD group membership, approved by Infrastructure Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| Portainer Server Failure | Critical | P1 | 15 minutes | 2 hours |
| Agent Disconnection | High | P2 | 30 minutes | 4 hours |
| Container Failure | Medium | P3 | 1 hour | 6 hours |
| UI Performance Degradation | Low | P4 | 4 hours | 24 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Version Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| GitOps Configuration | No | GitOps workflow approval | Business hours |
| Node Addition/Removal | Yes | Infrastructure Lead approval | Scheduled maintenance window |
| Stack Deployment | No | Team Lead approval in GitOps workflow | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Stack Health Verification | Daily | Operations Team | [Stack Health Check Procedure](../itil-policies-and-procedures/Monitoring/stack-health-verification.md) |
| Agent Connectivity Check | Daily | Infrastructure Team | [Agent Connectivity Procedure](../itil-policies-and-procedures/Monitoring/agent-connectivity-check.md) |
| License Validation | Monthly | Infrastructure Team | [License Validation Procedure](../itil-policies-and-procedures/Access-Management/license-validation-procedure.md) |
| Access Audit | Quarterly | Security Team | [Access Audit Procedure](../itil-policies-and-procedures/Security-Policies/access-audit-procedure.md) |
| Configuration Backup | Weekly | Infrastructure Team | [Configuration Backup Procedure](../itil-policies-and-procedures/Backup-Management/configuration-backup-procedure.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Agent Disconnection | Node unavailable in UI | [Agent Recovery Procedure](../itil-policies-and-procedures/Incident-Management/agent-recovery-procedure.md) | KEDB-0047 |
| Stack Deployment Failure | Failed deployment status | [Stack Deployment Troubleshooting](../itil-policies-and-procedures/Incident-Management/stack-deployment-troubleshooting.md) | KEDB-0048 |
| Authentication Failure | Unable to log in | [Authentication Troubleshooting](../itil-policies-and-procedures/Incident-Management/authentication-troubleshooting.md) | KEDB-0049 |
| Resource Exhaustion | Container errors, OOM kills | [Resource Management Guide](../itil-policies-and-procedures/Incident-Management/container-resource-management.md) | KEDB-0050 |
| GitOps Sync Failure | Stack out of sync with Git | [GitOps Troubleshooting Guide](../itil-policies-and-procedures/Incident-Management/gitops-troubleshooting.md) | KEDB-0051 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-01-20 |
| **Last Review Date** | 2025-03-15 |
| **Next Review Date** | 2025-06-15 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the Portainer Business Edition service:

1. **Upgrade to Latest Business Edition** (Q3 2025)
   - Implement new security features
   - Enhance GitOps capabilities

2. **Expand Node Coverage** (Q2 2025)
   - Add specialized nodes for specific workload types
   - Implement node tagging and affinity rules

3. **Enhanced Monitoring Integration** (Q2 2025)
   - Develop custom Grafana dashboards
   - Implement automated health checks

4. **Security Posture Enhancement** (Q3 2025)
   - Implement container image scanning
   - Enhance secrets management

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | AD integration with role-based access | Access audit logs |
| Network Segmentation | Nodes on isolated VLANs | Network scan verification |
| Authentication | LDAP with TLS for AD authentication | Security scan |
| Container Security | Private registries only | Registry configuration audit |
| GitOps Security | Signed commits, protected branches | GitOps workflow audit |
| Secrets Management | Externalized secrets management | Security audit |
| Logging and Auditing | Comprehensive event logging | Log review |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Access Control Management | ISO 27001 A.9.2.3 | Access review documentation |
| Change Management | CIS Controls 4.1 | Change management records |
| Configuration Management | NIST 800-53 CM-2, CM-6 | Configuration baseline documentation |
| Role Separation | ISO 27001 A.6.1.2 | Access control matrix |
| Secure Deployment | CIS Controls 12.1 | Deployment workflow documentation |
| Logging and Monitoring | CIS Controls 8.2 | Log configuration audit |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | Portainer Architecture | [Portainer Architecture](../Infrastructure/Applications/portainer-architecture.md) |
| Technical Guide | GitOps Configuration | [GitOps Configuration](../Infrastructure/Applications/gitops-configuration.md) |
| User Guide | Container Deployment Guide | [Container Deployment Guide](../Applications/Containerized-Services/container-deployment-guide.md) |
| Security Baseline | Container Security Posture | [Container Security](../Compliance-Security/CIS-Controls/container-security.md) |
| Integration Guide | AD Integration Configuration | [AD Integration](../Control-Plane/Identity-Management/portainer-ad-integration.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0024 | Portainer Business Edition | This service |
| CI | CI-0039 | Portainer Server | Component |
| CI | CI-0040 | Portainer Agents | Component |
| KB Article | KB-0090 | Portainer Upgrade Procedure | Procedure |
| Service Request | SRT-0015 | Container Deployment Request | Related process |
| Change Template | CHG-T-0009 | Portainer Version Upgrade | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
