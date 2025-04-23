<!-- 
---
title: "Rancher Management in Proxmox Astronomy Lab"
description: "Documentation for the Rancher management platform in the Proxmox Astronomy Lab, providing unified control over the RKE2 Kubernetes cluster"
author: "VintageDon"
tags: ["kubernetes", "rancher", "rke2", "management", "infrastructure", "cluster-management"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["RKE2 Kubernetes Cluster", "NVIDIA GPU Operator", "Monitoring Stack"]
implements_policies: ["Infrastructure Management Policy", "Change Management Policy", "Access Control Policy"]
phase: "phase-3"
cis_controls: ["CIS.4.1", "CIS.4.3", "CIS.5.1"]
iso27001_controls: ["A.12.1.2", "A.9.2.3", "A.12.6.1"]
nist_controls: ["CM-3", "AC-3", "CM-6"]
---
-->

# Rancher Management in Proxmox Astronomy Lab

This document provides the authoritative reference for the Rancher Management platform in the Proxmox Astronomy Lab, detailing its implementation, configuration, and operational parameters. Rancher provides unified management and governance for the lab's RKE2 Kubernetes cluster.

## 1. Overview

Rancher is a complete container management platform that simplifies Kubernetes operations. In the Proxmox Astronomy Lab, Rancher serves as the central control plane for managing the RKE2 Kubernetes cluster, enabling streamlined deployment of scientific and AI/ML workloads while maintaining security and governance controls.

### 1.1 Purpose

This document defines the Rancher Management service, its operational parameters, and management procedures. It serves as the definitive reference for all aspects of Kubernetes management within the Proxmox Astronomy Lab environment.

### 1.2 Scope

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Rancher deployment and configuration | Application-specific Kubernetes configurations |
| User access control and authentication | Individual workload deployments |
| Cluster monitoring and health checks | CI/CD pipelines (covered separately) |
| Catalog apps and Helm chart management | Container registry management |
| Backup and disaster recovery for Rancher | Data processing workflows |

### 1.3 Target Audience

This document is intended for:

- Infrastructure Administrators managing the Kubernetes environment
- DevOps Engineers deploying and maintaining workloads
- Security Administrators responsible for access controls
- Researchers needing to understand deployment workflows

## 2. Dependencies & Relationships

This section maps how Rancher relates to other elements within the Proxmox Astronomy Lab environment, capturing both upstream and downstream dependencies.

### 2.1 Related Services

This document **relates to**:

- [RKE2 Kubernetes Cluster](../infrastructure/rke2-kubernetes-cluster.md) - The managed Kubernetes distribution
- [NVIDIA GPU Operator](../infrastructure/gpu-operator.md) - GPU enablement managed through Rancher
- [Monitoring Stack](../applications/monitoring-stack.md) - Integrates with Rancher's monitoring capabilities
- [Helm Chart Management](../infrastructure/helm-chart-management.md) - Deployment methodology used by Rancher
- [External Authentication](../control-plane/external-authentication.md) - Entra ID integration for Rancher

### 2.2 Implements Policies

This document **implements**:

- [Infrastructure Management Policy](../compliance-security/infrastructure-management-policy.md) - Establishes governance for infrastructure changes
- [Change Management Policy](../compliance-security/change-management-policy.md) - Defines change control procedures
- [Access Control Policy](../compliance-security/access-control-policy.md) - Specifies authentication and authorization requirements

### 2.3 Responsibility Matrix

| **Activity** | **Infrastructure Team** | **Security Admin** | **Research Team** | **Operations** |
|--------------|-------------------|-------------------|--------------|----------------|
| Rancher Installation & Updates | R/A | C | I | I |
| Cluster Provisioning & Management | R/A | C | I | C |
| User Access Management | C | R/A | I | I |
| Catalog App Management | R | C | A | C |
| Monitoring & Alerting | R | I | I | R/A |
| Disaster Recovery | R/A | I | I | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

## 3. Technical Documentation

This section provides the technical details necessary for implementation, configuration, and troubleshooting of the Rancher Management platform.

### 3.1 Architecture & Components

Rancher is deployed using the Helm chart methodology on the RKE2 cluster in a high-availability configuration. The following diagram illustrates the architecture:

```markdown
┌─────────────────────────────────────────────────────────────┐
│                  Kubernetes Cluster (RKE2)                  │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                 Rancher Management                      ││
│  │                                                         ││
│  │  ┌────────────┐  ┌────────────┐  ┌────────────────┐     ││
│  │  │ Rancher UI │  │ Rancher API│  │ Rancher        │     ││
│  │  │ & Dashboard│  │ Server     │  │ Controllers    │     ││
│  │  └────────────┘  └────────────┘  └────────────────┘     ││
│  │         │              │               │                ││
│  │         └──────────────┼───────────────┘                ││
│  │                        │                                ││
│  │                        ▼                                ││
│  │      ┌────────────────────────────────────┐             ││
│  │      │       Rancher Project Structure    │             ││
│  │      │                                    │             ││
│  │      │  ┌───────────┐  ┌───────────────┐  │             ││
│  │      │  │ System    │  │ User Projects │  │             ││
│  │      │  │ Projects  │  │ & Namespaces  │  │             ││
│  │      │  └───────────┘  └───────────────┘  │             ││
│  │      └────────────────────────────────────┘             ││
│  │                                                         ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                Managed Components                       ││
│  │                                                         ││
│  │  ┌────────────┐  ┌────────────┐  ┌────────────────┐     ││
│  │  │ Monitoring │  │ Logging    │  │ CIS Scanning   │     ││
│  │  │ (Prometheus│  │ (Logging   │  │ & Benchmark    │     ││
│  │  │  Stack)    │  │  Operators)│  │ Operators      │     ││
│  │  └────────────┘  └────────────┘  └────────────────┘     ││
│  │                                                         ││
│  │  ┌────────────┐  ┌────────────┐  ┌────────────────┐     ││
│  │  │ Catalog    │  │ Backup     │  │ Certificate    │     ││
│  │  │ Apps       │  │ Operators  │  │ Management     │     ││
│  │  └────────────┘  └────────────┘  └────────────────┘     ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                  External Integration                   ││
│  │                                                         ││
│  │  ┌────────────┐  ┌─────────────┐  ┌────────────────┐    ││
│  │  │ Entra ID   │  │ Git         │  │ Monitoring     │    ││
│  │  │ Auth       │  │ Repositories│  │ Alerting       │    ││
│  │  └────────────┘  └─────────────┘  └────────────────┘    ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

The key architectural components include:

1. **Rancher Server**: Core functionality including UI, API, and controllers
2. **Project Structure**: Logical organization of workloads and resources
3. **Managed Components**: Built-in operators for monitoring, logging, etc.
4. **External Integrations**: Authentication and GitOps connections

### 3.2 Configuration Details

Rancher is deployed using the following key configuration parameters:

```yaml
# Partial values.yaml for Rancher deployment
hostname: rancher.radioastronomy.io
replicas: 3
bootstrapPassword: <redacted>

ingress:
  tls:
    source: secret
    secretName: rancher-tls-cert

auditLog:
  level: 2
  maxAge: 30
  maxBackup: 10
  maxSize: 100

resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 250m
    memory: 512Mi

# Project structure configuration
projects:
  - name: system-services
    namespaces:
      - monitoring
      - ingress-nginx
      - cert-manager
  - name: ai-ml
    namespaces:
      - ollama
      - tensorflowserving
      - openwebui
  - name: research
    namespaces:
      - observatory-core
      - data-pipeline
```

This configuration establishes a highly available Rancher deployment with structured projects and security controls.

### 3.3 Implementation Steps

1. **Prepare Namespace and TLS Certificate**:

   ```bash
   kubectl create namespace cattle-system
   kubectl create secret tls rancher-tls-cert \
     --cert=/path/to/tls.crt \
     --key=/path/to/tls.key \
     -n cattle-system
   ```

2. **Add Helm Repository**:

   ```bash
   helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
   helm repo update
   ```

3. **Install Rancher**:

   ```bash
   helm install rancher rancher-latest/rancher \
     --namespace cattle-system \
     --values values.yaml
   ```

4. **Configure Authentication**:
   - Set up Entra ID integration via Rancher UI
   - Map global permissions to Entra ID groups
   - Establish role bindings for cluster access

5. **Verify Installation**:

   ```bash
   kubectl get pods -n cattle-system
   curl -k https://rancher.radioastronomy.io/ping
   ```

These steps ensure a proper Rancher implementation with appropriate security controls and authentication integration.

## 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for Rancher Management.

### 4.1 Routine Procedures

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Rancher Version Updates | Quarterly | Infrastructure Team | [Rancher Update Procedure](../procedures/rancher-update.md) |
| Access Control Review | Monthly | Security Admin | [Access Review Procedure](../procedures/access-review.md) |
| CIS Benchmark Scanning | Bi-weekly | Security Admin | [CIS Scanning Procedure](../procedures/cis-scanning.md) |
| Backup Verification | Weekly | Operations Team | [Backup Verification](../procedures/backup-verification.md) |
| Monitoring Alert Review | Daily | Operations Team | [Alert Review Procedure](../monitoring/alert-review.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and security compliance.

### 4.2 Troubleshooting

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Rancher UI Inaccessible | Ingress or Pod issues | Check pod status, ingress configuration, and TLS certificate | [Rancher Access Issues](../troubleshooting/rancher-access.md) |
| Authentication Failures | Entra ID configuration or connectivity | Verify Entra ID settings and network connectivity | [Auth Troubleshooting](../troubleshooting/authentication-issues.md) |
| Cluster Agent Disconnection | Network issues or agent failure | Restart agent pods, check cluster network | [Agent Connectivity](../troubleshooting/cluster-agent-issues.md) |
| Project Creation Failures | RBAC permissions or quota issues | Check user permissions and namespace quotas | [Project Creation Issues](../troubleshooting/project-creation.md) |
| Monitoring Stack Alerts | Resource constraints or configuration | Review resource allocation and Prometheus configuration | [Monitoring Troubleshooting](../troubleshooting/monitoring-issues.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

### 4.3 Monitoring & Metrics

The following metrics should be monitored for Rancher health and performance:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| Rancher API Response Time | 0-500ms | >1s for >5 min | [Rancher Performance](http://grafana.lab/d/rancher-performance) |
| Rancher Pod CPU Usage | 0-80% | >90% for >10 min | [Rancher Resource Dashboard](http://grafana.lab/d/rancher-resources) |
| Rancher Pod Memory Usage | 0-80% | >90% for >10 min | [Rancher Resource Dashboard](http://grafana.lab/d/rancher-resources) |
| etcd DB Size | 0-500MB | >1GB | [etcd Metrics Dashboard](http://grafana.lab/d/etcd-metrics) |
| Authentication Success Rate | 95-100% | <90% | [Auth Metrics Dashboard](http://grafana.lab/d/auth-metrics) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure system health and performance.

## 5. Security & Compliance

This section documents how security controls are implemented and how compliance requirements are met for the Rancher management platform.

### 5.1 Security Controls

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Access Control | Role-based access with Entra ID integration | Regular access reviews | CIS.5.1 |
| Authentication | MFA enforcement via Entra ID | Authentication logs | CIS.4.5 |
| Network Security | TLS termination and encryption | TLS certificate audit | CIS.4.8 |
| Audit Logging | Comprehensive API action logging | Log review and retention check | CIS.4.3 |
| Vulnerability Management | Regular security scanning | CIS Benchmark scans | CIS.3.7 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

### 5.2 CISv8.1 Compliance Mapping

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.4.1 | Secure admin access with MFA | Entra ID authentication logs | Compliant |
| CIS.4.3 | Comprehensive audit logging | Rancher audit logs | Compliant |
| CIS.5.1 | RBAC for Kubernetes resources | Rancher role bindings | Compliant |
| CIS.3.7 | Regular Rancher updates | Change management records | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

### 5.3 Related Framework Mappings

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.4.1 | A.9.2.3 | PR.AC-7 | Secure authentication mechanisms |
| CIS.4.3 | A.12.4.1 | PR.PT-1 | Audit logging and monitoring |
| CIS.5.1 | A.9.4.1 | PR.AC-4 | Access control and authorization |
| CIS.3.7 | A.12.6.1 | ID.RA-1 | Vulnerability management |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

### 5.4 Risk Assessment

The following risks have been identified and mitigated related to Rancher operations:

1. **Unauthorized Access**: Mitigated through Entra ID integration and RBAC
2. **Configuration Drift**: Mitigated through GitOps and change management
3. **Service Disruption**: Mitigated through HA deployment and monitoring
4. **Data Exposure**: Mitigated through TLS encryption and access controls

Residual risk has been determined to be LOW based on implemented controls.

## 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures for the Rancher management platform.

### 6.1 Backup Procedure

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily Rancher state backups |
| **Backup Method** | Rancher Backup Operator with S3 storage |
| **Retention Policy** | 14 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | S3-compatible storage on proj-fs01 |
| **Verification Process** | Weekly restoration test to separate namespace |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

### 6.2 Recovery Procedure

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Rancher Pod Failures | 10 min | 0 | Allow Kubernetes to reschedule pods | Infrastructure Team |
| Certificate Expiration | 30 min | 0 | Deploy new certificate via Helm upgrade | Infrastructure Team |
| Database Corruption | 60 min | 24h | Restore from backup using Backup Operator | Infrastructure Team |
| Complete Cluster Failure | 4h | 24h | Follow [Rancher Disaster Recovery](../disaster-recovery/rancher-recovery.md) | Infrastructure Team |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

## 7. References & Related Resources

This section provides links to related documentation and external resources.

### 7.1 Internal References

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Infrastructure | RKE2 Cluster Documentation | [RKE2 Cluster](../infrastructure/rke2-kubernetes-cluster.md) | Underlying platform |
| Policy | Change Management Policy | [Change Management](../compliance-security/change-management-policy.md) | Governance framework |
| Procedure | Rancher Update Procedure | [Update Procedure](../procedures/rancher-update.md) | Operational process |
| Disaster Recovery | Rancher Recovery Plan | [Recovery Plan](../disaster-recovery/rancher-recovery.md) | Continuity plan |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

### 7.2 External References

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Rancher Documentation | [Rancher Docs](https://rancher.com/docs/rancher/v2.6/en/) | [Archived Copy](../references/archived/rancher-docs-2025-01.pdf) | 2025-04-01 |
| Kubernetes RBAC | [Kubernetes Docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) | [Archived Copy](../references/archived/k8s-rbac-2025-01.pdf) | 2025-04-01 |
| Entra ID Integration | [Entra ID Docs](https://learn.microsoft.com/en-us/entra/identity/) | [Archived Copy](../references/archived/entra-id-oauth-2025-01.pdf) | 2025-04-01 |
| CIS Kubernetes Benchmark | [CIS Benchmark](https://www.cisecurity.org/benchmark/kubernetes) | [Archived Copy](../references/archived/cis-k8s-2025-01.pdf) | 2025-03-15 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

### 7.3 Change Request References

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-2025-038 | Initial Rancher deployment | 2025-03-05 | [GLPI-1198](http://glpi.lab/ticket/1198) |
| CR-2025-062 | Entra ID integration | 2025-04-02 | [GLPI-1262](http://glpi.lab/ticket/1262) |
| CR-2025-075 | Backup Operator configuration | 2025-04-10 | [GLPI-1275](http://glpi.lab/ticket/1275) |
| CR-2025-082 | CIS Benchmark integration | 2025-04-18 | [GLPI-1282](http://glpi.lab/ticket/1282) |

The change request table above tracks formal changes that have affected this system, supporting troubleshooting and audit activities.

## 8. Approval & Review

This section documents the formal review and approval process for this document.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |
| SecurityAdmin | Security Officer | 2025-04-20 | ✅ Approved |
| OpsManager | Operations Manager | 2025-04-19 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

## 9. Change Log

This section tracks the document's revision history.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial version | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.
