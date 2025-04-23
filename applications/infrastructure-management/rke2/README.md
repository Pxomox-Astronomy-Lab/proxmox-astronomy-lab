<!-- 
---
title: "RKE2 Kubernetes Documentation"
description: "Comprehensive documentation of the RKE2 Kubernetes cluster deployment, configuration, and management in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "kubernetes", "rke2", "container-orchestration", "devops", "gpu", "traefik", "cert-manager"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Proxmox VE", "Monitoring Stack", "AI/ML Services"]
implements_policies: ["Change Management Policy", "Security Policy", "Backup Policy"]
phase: "phase-3"
cis_controls: ["CIS.4.1", "CIS.5.2", "CIS.12.1", "CIS.12.6"]
iso27001_controls: ["A.12.1.2", "A.12.5.1", "A.12.6.1"]
nist_controls: ["CM-2", "CM-6", "SI-2"]
---
-->

# 🔧 **RKE2 Kubernetes Service**

This document provides the authoritative reference for the RKE2 Kubernetes service, documenting its purpose, specifications, dependencies, and operational parameters within the Proxmox Astronomy Lab environment.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the RKE2 Kubernetes service, its operational parameters, and management procedures. It serves as the definitive reference for all aspects of container orchestration in the Proxmox Astronomy Lab environment, supporting research workflows, AI/ML workloads, and data processing pipelines.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Cluster architecture and node configuration | Application-specific configurations |
| Core infrastructure services (networking, storage, ingress) | Detailed application deployment procedures |
| Security, access controls, and compliance | User training materials |
| Operational procedures and maintenance | Integration with external systems |
| Monitoring and alerting | Research workflow specifics |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- DevOps Engineers
- Security Team Members
- Research Software Engineers
- Operations and Support Personnel

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the RKE2 Kubernetes service within the lab's operational framework.

### **2.1 Service Description**

RKE2 Kubernetes provides a secure, production-grade container orchestration platform that enables the deployment and management of containerized workloads across the lab environment. It serves as the foundation for research applications, data processing pipelines, and AI/ML services, offering scalability, resilience, and standardized deployment patterns.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | GLPI-SVC-0023 |
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
| **API Response Time** | < 500ms | Prometheus metrics |
| **Incident Response Time** | 30 minutes during support hours | Wazuh alert response tracking |
| **Change Implementation** | 48 hours for standard changes | GLPI change records |

### **3.2 Monitoring and Reporting**

The RKE2 cluster is monitored through a comprehensive observability stack:

- **Prometheus** collects metrics from all node exporters, kube-state-metrics, and service-specific exporters
- **AlertManager** provides alert routing based on severity and service impact
- **Loki** aggregates logs from all nodes and pods
- **Grafana** dashboards visualize cluster health, performance, and resource utilization
- **Wazuh** provides security monitoring and compliance reporting

Monthly service reports are generated through Grafana and distributed to stakeholders via the lab's reporting mechanism.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The RKE2 Kubernetes cluster follows a high-availability architecture with separated control plane and worker node functions. It employs Canal CNI for networking, local storage for performance-critical workloads, and integrates with various infrastructure services for security and external access.

![RKE2 Architecture Diagram](../assets/images/rke2-architecture-diagram.png)

### **4.2 Infrastructure Components**

The following components comprise the service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **Control Plane Nodes** | Three VM instances (proj-k8sm01, proj-k8sm02, proj-k8sm03) providing the Kubernetes API server, scheduler, and controller manager | VM-0004, VM-0005, VM-0006 |
| **Worker Nodes** | Five VM instances (proj-k8sw01 through proj-k8sw05) executing containerized workloads | VM-0007, VM-0008, VM-0009, VM-0010, VM-0011 |
| **GPU Worker Node** | Specialized worker (proj-k8sw04) with NVIDIA RTX A4000 GPU passthrough for AI/ML workloads | VM-0010 |
| **Storage Volumes** | Local NVMe storage on each worker node, configured as local persistent volumes | ST-0012 through ST-0017 |
| **Traefik Ingress** | Edge routing and TLS termination for all cluster services | SVC-0024 |
| **cert-manager** | Automated certificate management for all services | SVC-0025 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox Virtualization | Complete service outage |
| **Requires** | Network Infrastructure | Complete service outage |
| **Requires** | DNS Services | Partial degradation (external access) |
| **Requires** | Certificate Authority | Degraded security posture |
| **Required By** | AI/ML Services | Complete workload failure |
| **Required By** | Data Processing Pipelines | Complete workload failure |
| **Required By** | Observatory Services | Complete workload failure |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for this service:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Proxmox Backup Server: Daily snapshots of all VMs |
| **Backup Method** | etcd snapshots every 6 hours to external storage |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 6 hours |
| **Recovery Procedure** | [RKE2 Disaster Recovery Procedure](../itil-policies-and-procedures/Backup-Management/rke2-disaster-recovery.md) |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs this service:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Cluster Administrator | Full administrative access | Approved by Infrastructure Lead, uses Entra ID group membership |
| DevOps Engineer | Namespaced admin access | Approved by Team Lead, uses Entra ID group membership |
| Developer | Namespaced read/write access | Approved by Project Lead, uses Entra ID group membership |
| Security Auditor | Cluster-wide read access | Automatic for security team members |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| Control Plane Failure | Critical | P1 | 15 minutes | 2 hours |
| Worker Node Failure | High | P2 | 30 minutes | 4 hours |
| Network Connectivity | High | P2 | 30 minutes | 4 hours |
| Certificate Expiration | Medium | P3 | 2 hours | 8 hours |
| Resource Exhaustion | Medium | P3 | 2 hours | 8 hours |

### **5.3 Change Management**

The following framework governs changes to this service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Version Upgrade | Yes | Full CAB review | Scheduled maintenance window |
| Configuration Change | No | Infrastructure Lead | Business hours |
| Security Patch | No | Security Team notification | Within 24 hours of availability |
| Node Scaling | No | Infrastructure Lead | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Node Health Verification | Daily | Infrastructure Team | [Node Health Check Procedure](../itil-policies-and-procedures/Monitoring/node-health-verification.md) |
| Certificate Validation | Weekly | Security Team | [Certificate Validation Procedure](../itil-policies-and-procedures/Security-Policies/certificate-validation.md) |
| etcd Backup Verification | Weekly | Infrastructure Team | [etcd Backup Verification](../itil-policies-and-procedures/Backup-Management/etcd-backup-verification.md) |
| Security Scanning | Weekly | Security Team | [Kubernetes Security Scan](../itil-policies-and-procedures/CIS-Security-Policies/kubernetes-security-scan.md) |
| Resource Utilization Review | Monthly | Infrastructure Team | [Resource Utilization Review](../itil-policies-and-procedures/Monitoring/resource-utilization-review.md) |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Node Not Ready | Node shows NotReady status in kubectl | [Node Recovery Procedure](../itil-policies-and-procedures/Incident-Management/node-recovery-procedure.md) | KEDB-0042 |
| etcd Quorum Loss | API server unavailable, 500 errors | [etcd Recovery Procedure](../itil-policies-and-procedures/Incident-Management/etcd-recovery-procedure.md) | KEDB-0043 |
| Certificate Expiration | TLS errors, ingress failures | [Certificate Renewal Procedure](../itil-policies-and-procedures/Incident-Management/certificate-renewal-procedure.md) | KEDB-0044 |
| Network Connectivity Issues | Intermittent pod communication | [CNI Troubleshooting Guide](../itil-policies-and-procedures/Incident-Management/cni-troubleshooting-guide.md) | KEDB-0045 |
| Resource Exhaustion | OOMKilled pods, scheduling failures | [Resource Management Guide](../itil-policies-and-procedures/Incident-Management/resource-management-guide.md) | KEDB-0046 |

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

The following improvements are planned for the RKE2 Kubernetes service:

1. **Upgrade to RKE2 v1.32.x** (Q3 2025)
   - Implement new security features
   - Enhance GPU support capabilities

2. **Implement ArgoCD for GitOps** (Q2 2025)
   - Transition all deployments to GitOps methodology
   - Implement progressive delivery patterns

3. **Expand Monitoring Coverage** (Q2 2025)
   - Enhance custom metrics collection
   - Implement predictive analytics for resource planning

4. **Implement Chaos Engineering** (Q4 2025)
   - Validate resilience capabilities
   - Identify failure modes and mitigation strategies

## 🔐 **8. Security and Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect this service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Network Segmentation | Cluster on isolated VLAN 20 | Network scan verification |
| Authentication | RBAC with Entra ID integration | Access review audits |
| Pod Security | Enforced Pod Security Standards | Kyverno policy validation |
| Image Security | Private registry with scanning | Harbor vulnerability reports |
| Secrets Management | Sealed Secrets for sensitive data | Security audit |
| Runtime Security | Falco runtime monitoring | Alert verification |
| Vulnerability Management | Regular scanning and patching | Vulnerability assessment reports |

### **8.2 Compliance Requirements**

Regulatory and policy requirements applicable to this service:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Infrastructure Hardening | CIS Kubernetes Benchmark | Weekly CIS-CAT scans |
| Configuration Management | NIST 800-53 CM-2, CM-6 | Change management records |
| Vulnerability Management | ISO 27001 A.12.6.1 | Scan reports and remediation tracking |
| Backup Management | Lab Backup Policy | Backup verification reports |
| Access Control | CIS Controls 5.2 | Access review documentation |
| Incident Response | NIST 800-53 IR-4 | Incident response documentation |

## 📚 **9. References**

### **9.1 Related Documentation**

Additional reference materials for this service:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Design Document | RKE2 Cluster Architecture | [RKE2 Architecture](../Infrastructure/Compute/rke2-architecture.md) |
| Technical Guide | RKE2 GPU Configuration | [GPU Configuration](../Infrastructure/Compute/rke2-gpu-configuration.md) |
| User Guide | Kubernetes Workflow Deployment | [Workflow Deployment Guide](../Applications/Containerized-Services/workflow-deployment-guide.md) |
| Security Baseline | Kubernetes Security Posture | [Kubernetes Security](../Compliance-Security/CIS-Controls/kubernetes-security.md) |
| Integration Guide | AI/ML Services on Kubernetes | [AI/ML Integration](../Applications/AI-ML-Platforms/kubernetes-integration.md) |

### **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| Service | SVC-0023 | RKE2 Kubernetes | This service |
| CI | CI-0037 | Kubernetes Control Plane | Component |
| CI | CI-0038 | Kubernetes Worker Nodes | Component |
| KB Article | KB-0089 | Kubernetes Upgrade Procedure | Procedure |
| Service Request | SRT-0014 | Kubernetes Access Request | Related process |
| Change Template | CHG-T-0008 | Kubernetes Version Upgrade | Change process |

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Infrastructure Lead | 2025-04-23 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial version | VintageDon |
