<!-- 
---
title: "ArgoCD Documentation"
description: "Comprehensive documentation of the ArgoCD GitOps continuous delivery service for Kubernetes in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "kubernetes", "gitops", "continuous-delivery", "argocd", "devops"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["RKE2 Kubernetes", "Gitea", "CI/CD Pipeline"]
implements_policies: ["Change Management Policy", "Infrastructure as Code Policy", "Deployment Policy"]
phase: "phase-3"
cis_controls: ["CIS.4.1", "CIS.14.1", "CIS.14.2"]
iso27001_controls: ["A.12.1.2", "A.14.2.2", "A.14.2.5"]
nist_controls: ["CM-2", "CM-3", "SA-10"]
---
-->

# 🔧 **ArgoCD Service**

This document provides the authoritative reference for the ArgoCD service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the ArgoCD service, its operational parameters, and management procedures. It serves as the definitive reference for the declarative GitOps continuous delivery tool for Kubernetes that provides automated deployment, synchronization, and management of applications within the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| ArgoCD architecture and configuration | Application-specific configurations |
| Application deployment workflows | CI pipeline implementation details |
| Integration with Kubernetes and Git | User training materials |
| Operational procedures and maintenance | Non-Kubernetes deployments |
| Security and access controls | External CI/CD systems |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- DevOps Engineers
- Application Developers
- Operations Team Members
- Security Personnel

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the ArgoCD service within the lab's operational framework.

### **2.1 Service Description**

ArgoCD provides a declarative GitOps continuous delivery solution for Kubernetes, enabling automated deployment, synchronization, and lifecycle management of applications. It ensures that the deployed applications in the cluster always match the desired state defined in the Git repositories, providing a seamless workflow for deploying applications to the Kubernetes cluster.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0027 |
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
| **Sync Operation Time** | < 60 seconds | ArgoCD metrics |
| **Application Health Check** | Every 3 minutes | Built-in ArgoCD monitoring |
| **Incident Response Time** | 30 minutes during support hours | GLPI ticket tracking |

### **3.2 Monitoring and Reporting**

ArgoCD and its operations are monitored through a comprehensive observability stack:

- **Prometheus** collects ArgoCD metrics
- **AlertManager** provides alert routing based on severity and service impact
- **Loki** aggregates logs from ArgoCD components
- **Grafana** dashboards visualize sync status, application health, and resource utilization
- **Wazuh** provides security monitoring and access auditing

Monthly deployment reports are generated and distributed to stakeholders via the lab's reporting mechanism.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The ArgoCD deployment runs within the RKE2 Kubernetes cluster on lab01, providing continuous delivery capabilities through a GitOps approach. It consists of multiple components that work together to detect changes in Git repositories and synchronize them with the Kubernetes cluster.

![ArgoCD Architecture Diagram](../assets/images/argocd-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **ArgoCD API Server** | Central API server for the ArgoCD service | CI-0070 |
| **Repository Server** | Service for caching Git repositories | CI-0071 |
| **Application Controller** | Controller for managing sync operations | CI-0072 |
| **Dex Server** | OAuth2 provider for authentication | CI-0073 |
| **Redis** | Cache for application data | CI-0074 |
| **Gitea Integration** | Source control for application manifests | SVC-0026 |
| **RKE2 Kubernetes** | Target deployment platform | SVC-0023 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | RKE2 Kubernetes | Complete service outage |
| **Requires** | Gitea | Source repository unavailable |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | Active Directory | Authentication failure |
| **Required By** | Application Deployments | Automated deployment unavailable |
| **Required By** | Cluster Configuration | Configuration drift management unavailable |
| **Required By** | Monitoring Stack | Monitoring deployments unavailable |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily ArgoCD application configuration backups |
| **Backup Method** | Export of ArgoCD application definitions to Git |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [ArgoCD Recovery Procedure](../itil-policies-and-procedures/Backup-Management/argocd-recovery-procedure.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| ArgoCD Administrator | Full administrative access | Approved by Infrastructure Lead |
| Application Developer | Namespace-scoped access | Approved by Development Lead |
| Operations Engineer | Read access to all applications | Approved by Operations Lead |
| Security Analyst | Read-only audit access | Approved by Security Lead |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| ArgoCD Service Failure | Critical | P1 | 15 minutes | 2 hours |
| Sync Failure | High | P2 | 30 minutes | 4 hours |
| Application Health Degradation | Medium | P3 | 1 hour | 6 hours |
| UI/Access Issues | Low | P4 | 4 hours | 24 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Version Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| Configuration Change | No | Infrastructure Lead approval | Business hours |
| New Application Onboarding | No | Development Lead approval | Business hours |
| Policy Change | Yes | Security Lead approval | Scheduled maintenance window |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Application Sync Verification | Daily | Operations Team | [Sync Verification Procedure](../itil-policies-and-procedures/Monitoring/argocd-sync-verification.md) |
| Repository Health Check | Weekly | Infrastructure Team | [Repository Check Procedure](../itil-policies-and-procedures/Monitoring/argocd-repository-check.md) |
| Access Review | Quarterly | Security Team | [Access Review Procedure](../itil-policies-and-procedures/Security-Policies/argocd-access-review.md) |
| Backup Verification | Monthly | Infrastructure Team | [Backup Verification Procedure](../itil-policies-and-procedures/Backup-Management/argocd-backup-verification.md) |
| Configuration Audit | Monthly | Security Team | [Configuration Audit Procedure](../itil-policies-and-procedures/Security-Policies/argocd-configuration-audit.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Sync Failures | Application out of sync | [Sync Troubleshooting](../itil-policies-and-procedures/Incident-Management/argocd-sync-troubleshooting.md) | KEDB-0070 |
| Repository Connection Issues | Repository unavailable | [Repository Troubleshooting](../itil-policies-and-procedures/Incident-Management/argocd-repository-troubleshooting.md) | KEDB-0071 |
| Authentication Problems | Unable to log in | [Authentication Troubleshooting](../itil-policies-and-procedures/Incident-Management/argocd-authentication-troubleshooting.md) | KEDB-0072 |
| Application Health Issues | Degraded application status | [Health Troubleshooting](../itil-policies-and-procedures/Incident-Management/argocd-health-troubleshooting.md) | KEDB-0073 |
| Controller Issues | Controller not processing applications | [Controller Troubleshooting](../itil-policies-and-procedures/Incident-Management/argocd-controller-troubleshooting.md) | KEDB-0074 |

## 📈 **7. Lifecycle Management**

This section documents the current status and future plans for the service.

### **7.1 Lifecycle Status**

The current position in the service lifecycle:

| **Attribute** | **Details** |
|--------------|------------|
| **Current Status** | Production |
| **Implementation Date** | 2025-02-10 |
| **Last Review Date** | 2025-04-01 |
| **Next Review Date** | 2025-07-01 |
| **End-of-Life Date** | Not planned |

### **7.2 Improvement Plans**

The following improvements are planned for the ArgoCD service:

1. **Application of Applications Pattern** (Q3 2025)
   - Implement hierarchical application management
   - Streamline multi-team application onboarding

2. **Enhanced Notifications** (Q2 2025)
   - Integrate with chat platforms
   - Develop custom notification templates

3. **Custom Health Checks** (Q2 2025)
   - Implement application-specific health checks
   - Integrate with external monitoring systems

4. **Advanced Deployment Strategies** (Q3 2025)
   - Implement blue/green deployments
   - Configure canary releases

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | RBAC with AD integration | Access audit logs |
| Repository Security | Secure repository connections | Configuration audit |
| Authentication | SSO with OIDC | Security scan |
| Network Security | Internal network only | Network scan verification |
| Configuration Security | YAML validation, Kustomize security | Configuration scan |
| Secrets Management | External secrets provider | Security audit |
| Audit Logging | Comprehensive event logging | Log review |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Change Management | CIS Controls 4.1 | Deployment history |
| Configuration Management | NIST 800-53 CM-2, CM-3 | Configuration baseline documentation |
| Separation of Duties | ISO 27001 A.6.1.2 | Access control matrix |
| Secure Deployment | CIS Controls 12.1 | Deployment workflow documentation |
| Approval Process | ISO 27001 A.14.2.2 | Change approval records |
| Audit Logging | CIS Controls 8.2 | Log configuration audit |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | ArgoCD Architecture | [ArgoCD Architecture](../Infrastructure/Applications/argocd-architecture.md) |
| Technical Guide | GitOps Workflow | [GitOps Workflow](../Infrastructure/Applications/gitops-workflow.md) |
| User Guide | Application Deployment Guide | [Application Deployment Guide](../Applications/Containerized-Services/application-deployment-guide.md) |
| Integration Guide | Kubernetes Integration | [Kubernetes Integration](../Infrastructure/Compute/argocd-kubernetes-integration.md) |
| Security Baseline | ArgoCD Security Posture | [ArgoCD Security](../Compliance-Security/CIS-Controls/argocd-security.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0027 | ArgoCD | This service |
| CI | CI-0070 | ArgoCD API Server | Component |
| CI | CI-0071 | ArgoCD Repository Server | Component |
| KB Article | KB-0095 | ArgoCD Upgrade Procedure | Procedure |
| Service Request | SRT-0018 | Application Onboarding Request | Related process |
| Change Template | CHG-T-0012 | ArgoCD Version Upgrade | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
