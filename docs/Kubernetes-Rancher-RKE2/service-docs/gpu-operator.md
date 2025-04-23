<!-- 
---
title: "NVIDIA GPU Operator in Proxmox Astronomy Lab"
description: "Documentation for the NVIDIA GPU Operator deployment in the Proxmox Astronomy Lab's RKE2 Kubernetes cluster, supporting AI/ML workloads and scientific computing"
author: "VintageDon"
tags: ["kubernetes", "gpu", "nvidia", "gpu-operator", "rke2", "ai-ml", "infrastructure"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["RKE2 Kubernetes Cluster", "AI/ML Workloads", "TensorFlow Serving"]
implements_policies: ["Infrastructure Resource Management Policy", "AI/ML Computing Policy"]
phase: "phase-3"
cis_controls: ["CIS.3.4", "CIS.3.1"]
iso27001_controls: ["A.8.1.1", "A.8.1.3"]
nist_controls: ["CM-8", "CM-3"]
---
-->

# NVIDIA GPU Operator in Proxmox Astronomy Lab

This document provides the authoritative reference for the NVIDIA GPU Operator service in the Proxmox Astronomy Lab, detailing its implementation, configuration, and operational parameters. The GPU Operator enables AI/ML workloads and scientific computing by integrating NVIDIA GPUs with the RKE2 Kubernetes cluster.

## 1. Overview

The GPU Operator is a critical service that enables GPU-accelerated workloads within our Kubernetes environment, supporting both AI/ML pipelines and SDR signal processing. It automates the provisioning of all NVIDIA software components needed to provision GPUs in Kubernetes, ensuring consistent and reliable GPU access across containerized workloads.

### 1.1 Purpose

This document defines the GPU Operator service, its operational parameters, and management procedures. It serves as the definitive reference for enabling and managing GPU capabilities in the Proxmox Astronomy Lab's containerized research environment.

### 1.2 Scope

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| GPU Operator deployment and configuration | Application-specific AI model implementation |
| Driver management and container runtime configuration | Custom CUDA programming details |
| GPU resource allocation and monitoring | Host-level GPU passthrough configuration |
| Multi-Instance GPU (MIG) and CUDA configurations | GPU hardware specifications |
| Operational procedures for GPU-enabled workloads | Specific AI/ML framework configurations |

### 1.3 Target Audience

This document is intended for:

- Infrastructure Administrators managing the Kubernetes cluster
- DevOps personnel deploying GPU-accelerated workloads
- Data Scientists and Researchers consuming GPU resources
- Automation Engineers integrating GPU capabilities into pipelines

## 2. Dependencies & Relationships

This section maps how the GPU Operator relates to other elements within the Proxmox Astronomy Lab environment, capturing both upstream and downstream dependencies.

### 2.1 Related Services

This document **relates to**:

- [RKE2 Kubernetes Cluster](../infrastructure/rke2-kubernetes-cluster.md) - The underlying platform hosting the GPU Operator
- [AI/ML Workloads](../applications/ai-ml-workloads.md) - Services that consume GPU resources
- [TensorFlow Serving](../applications/tensorflow-serving.md) - Inference engine dependent on GPU resources
- [SDR Signal Processing Pipeline](../research-projects/sdr-signal-processing.md) - Scientific workloads leveraging GPU acceleration

### 2.2 Implements Policies

This document **implements**:

- [Infrastructure Resource Management Policy](../compliance-security/resource-management-policy.md) - Ensures efficient allocation of GPU resources
- [AI/ML Computing Policy](../research-projects/ai-ml-computing-policy.md) - Establishes guidelines for GPU-accelerated research workloads

### 2.3 Responsibility Matrix

| **Activity** | **Infrastructure Team** | **Security Admin** | **Data Science Team** | **Operations** |
|--------------|-------------------|-------------------|--------------|----------------|
| Operator Installation & Updates | R/A | C | I | I |
| GPU Resource Allocation | R/A | I | C | I |
| Security Compliance | C | R/A | I | I |
| Performance Monitoring | R | I | C | R/A |
| Workload Deployment | I | I | R/A | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

## 3. Technical Documentation

This section provides the technical details necessary for implementation, configuration, and troubleshooting of the NVIDIA GPU Operator.

### 3.1 Architecture & Components

The GPU Operator follows a Kubernetes operator pattern to deploy and manage the following components:

1. **NVIDIA Driver**: Device driver for the GPU hardware
2. **NVIDIA Container Toolkit**: Enables containers to access GPU resources
3. **Device Plugin**: Advertises GPU resources to Kubernetes
4. **Data Center GPU Manager (DCGM)**: Monitoring and management of GPUs
5. **Node Feature Discovery (NFD)**: Detects hardware features and labels nodes
6. **GPU Feature Discovery (GFD)**: GPU-specific feature detection
7. **Multi-Instance GPU (MIG) Manager**: Manages partitioning of GPUs (when applicable)

These components work together to create a seamless GPU experience in Kubernetes:

```markdown
┌─────────────────────────────────────────────────────────────┐
│                  Kubernetes Cluster (RKE2)                  │
│                                                             │
│  ┌─────────────┐  ┌─────────────┐       ┌─────────────┐     │
│  │ Control     │  │ Worker Node │       │ GPU Node    │     │
│  │ Plane Nodes │  │             │       │ (k8sw04)    │     │
│  └─────────────┘  └─────────────┘       └─────────────┘     │
│                                          │                  │
│                                          ▼                  │
│                         ┌─────────────────────────────────┐ │
│                         │       GPU Operator Stack        │ │
│                         │                                 │ │
│ ┌─────────────────────┐ │ ┌─────────────┐ ┌────────────┐  │ │
│ │ Kubernetes API      │ │ │ NVIDIA      │ │ Container  │  │ │
│ │ (Resource Requests) │◄┼─┤ Device      │ │ Runtime    │  │ │
│ └─────────────────────┘ │ │ Plugin      │ │ (CRI-O)    │  │ │
│                         │ └─────────────┘ └────────────┘  │ │
│                         │        │               │        │ │
│                         │        ▼               ▼        │ │
│                         │ ┌─────────────┐ ┌────────────┐  │ │
│                         │ │ NVIDIA      │ │ DCGM       │  │ │
│                         │ │ Driver      │◄┤ Monitoring │  │ │
│                         │ │             │ │            │  │ │
│                         │ └─────────────┘ └────────────┘  │ │
│                         │        │                        │ │
│                         │        ▼                        │ │
│                         │ ┌─────────────────────────────┐ │ │
│                         │ │      GPU Hardware           │ │ │
│                         │ │      (RTX A4000)            │ │ │
│                         │ └─────────────────────────────┘ │ │
│                         └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 Configuration Details

The GPU Operator is deployed via Helm with the following key configurations:

```yaml
# Partial values.yaml configuration
operator:
  nodeSelector:
    gpu: "true"  # Only deploy on labeled nodes

driver:
  version: "525.85.05"  # Validated driver version
  enabled: true
  
devicePlugin:
  enabled: true
  config:
    name: "default"
    default: "0"  # Default timeSlicing value

toolkit:
  enabled: true
  
mig:
  enabled: false  # A4000 does not support MIG
  
gfd:
  enabled: true
  
dcgm:
  enabled: true
  
mps:
  enabled: true  # Enable CUDA Multi-Process Service
```

The configuration above enables all necessary components for GPU workloads while ensuring compatibility with our RTX A4000 hardware.

### 3.3 Implementation Steps

1. **Label GPU Nodes**:

   ```bash
   kubectl label nodes proj-k8sw04 gpu=true
   ```

2. **Add Helm Repository**:

   ```bash
   helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
   helm repo update
   ```

3. **Install GPU Operator**:

   ```bash
   helm install --generate-name \
     -n gpu-operator --create-namespace \
     nvidia/gpu-operator \
     -f values.yaml
   ```

4. **Verify Installation**:

   ```bash
   kubectl get pods -n gpu-operator
   kubectl get nodes -o json | jq '.items[].metadata.labels | select(."nvidia.com/gpu.present" == "true")'
   ```

The steps above should be followed sequentially to ensure proper implementation and minimize potential issues.

## 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for the GPU Operator.

### 4.1 Routine Procedures

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Driver Updates | Quarterly | Infrastructure Team | [Driver Update Procedure](../procedures/nvidia-driver-update.md) |
| Resource Utilization Review | Monthly | Operations Team | [Resource Utilization Report](../monitoring/gpu-resource-reports.md) |
| Version Compatibility Check | Before Kubernetes upgrades | Infrastructure Team | [Version Matrix](../compatibility-matrix.md) |
| Performance Benchmarking | Quarterly | Data Science Team | [GPU Benchmarking](../procedures/gpu-benchmarking.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and performance, along with their required cadence.

### 4.2 Troubleshooting

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Pods pending with GPU requests | Resource exhaustion | Check GPU allocation with `nvidia-smi dcgm-exporter` | [GPU Resource Troubleshooting](../troubleshooting/gpu-resources.md) |
| GPU Operator pods failing | Driver compatibility issues | Check logs and upgrade/downgrade as needed | [Operator Troubleshooting](../troubleshooting/gpu-operator.md) |
| CUDA errors in workloads | Memory exhaustion or CUDA version mismatch | Verify memory limits and CUDA compatibility | [CUDA Troubleshooting](../troubleshooting/cuda-errors.md) |
| Node showing as GPU-ready but workloads fail | Device plugin issues | Restart device plugin pods | [Device Plugin Issues](../troubleshooting/device-plugin.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

### 4.3 Monitoring & Metrics

The following metrics should be monitored for GPU health and performance:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| GPU Utilization | 0-95% | >98% for >10 min | [GPU Dashboard](http://grafana.lab/d/gpu-utilization) |
| GPU Memory Usage | 0-90% | >95% for >5 min | [GPU Memory Dashboard](http://grafana.lab/d/gpu-memory) |
| GPU Temperature | 30-75°C | >80°C | [GPU Health Dashboard](http://grafana.lab/d/gpu-health) |
| CUDA Errors | 0 | >0 | [CUDA Error Dashboard](http://grafana.lab/d/cuda-errors) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure system health and performance.

## 5. Security & Compliance

This section documents how security controls are implemented and how compliance requirements are met.

### 5.1 Security Controls

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Access Control | Namespace RBAC for GPU resources | Regular RBAC audits | CIS.3.1 |
| Resource Quotas | Hard limits on GPU request counts | Resource quota monitoring | CIS.3.4 |
| Vulnerability Management | Regular driver updates | Scheduled update process | CIS.3.2 |
| Privilege Management | Unprivileged container enforcement | Security scanning | CIS.5.2 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

### 5.2 CISv8.1 Compliance Mapping

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.3.1 | RBAC controls for GPU resource access | Kubernetes RBAC configurations | Compliant |
| CIS.3.4 | Automated inventory of GPU resources | DCGM monitoring records | Compliant |
| CIS.5.2 | Restricted container privileges | SecurityContext configurations | Compliant |
| CIS.5.4 | Restricted node access | Node tainting and GPU-specific tolerations | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

### 5.3 Related Framework Mappings

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.3.1 | A.8.1.1 | ID.AM-1 | GPU resource inventory and management |
| CIS.3.4 | A.8.1.3 | ID.AM-2 | Automated detection and registration of GPU capabilities |
| CIS.5.2 | A.9.4.1 | PR.AC-4 | Restricted access to GPU resources via RBAC |
| CIS.5.4 | A.9.2.3 | PR.AC-1 | Controlled privilege management for GPU workloads |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

### 5.4 Risk Assessment

The following risks have been identified and mitigated related to GPU operations:

1. **Resource Contention**: Mitigated through namespace quotas and priority classes
2. **Driver Compatibility**: Mitigated through validated driver versions
3. **Resource Exhaustion**: Mitigated through monitoring and alerts
4. **Privilege Escalation**: Mitigated through container security policies

Residual risk has been determined to be LOW based on implemented controls.

## 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures.

### 6.1 Backup Procedure

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily Helm values and configuration backups |
| **Backup Method** | Git-based configuration backup in infrastructure repository |
| **Retention Policy** | 90 days in Git history |
| **Backup Location** | Infrastructure Git repository with off-site replication |
| **Verification Process** | Monthly restoration test using alternative namespace |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

### 6.2 Recovery Procedure

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Driver Failure | 30 min | 24h | Reinstall GPU Operator with validated version | Infrastructure Team |
| Operator Pod Failures | 15 min | 0 | Restart affected pods | Operations Team |
| GPU Node Failure | 60 min | 0 | Restore from Proxmox backup | Infrastructure Team |
| Full Cluster Recovery | 4h | 24h | Follow [Cluster Disaster Recovery](../disaster-recovery/kubernetes-recovery.md) | Infrastructure Team |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

## 7. References & Related Resources

This section provides links to related documentation and external resources.

### 7.1 Internal References

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Infrastructure | RKE2 Cluster Documentation | [RKE2 Cluster](../infrastructure/rke2-kubernetes-cluster.md) | Parent platform |
| Node | GPU Node Configuration | [Node04 Documentation](../infrastructure/node04-proxmox-gpu-hpc.md) | Hardware configuration |
| Procedure | GPU Resource Allocation | [Resource Procedure](../procedures/gpu-resource-allocation.md) | Operational process |
| Policy | AI/ML Computing Policy | [Computing Policy](../research-projects/ai-ml-computing-policy.md) | Governance framework |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

### 7.2 External References

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| NVIDIA GPU Operator Documentation | [NVIDIA Docs](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html) | [Archived Copy](../references/archived/nvidia-operator-docs-2025-01.pdf) | 2025-04-01 |
| Kubernetes Device Plugin Framework | [Kubernetes Docs](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/) | [Archived Copy](../references/archived/k8s-device-plugins-2025-01.pdf) | 2025-04-01 |
| NVIDIA DCGM Documentation | [DCGM Docs](https://docs.nvidia.com/datacenter/dcgm/latest/index.html) | [Archived Copy](../references/archived/dcgm-docs-2025-01.pdf) | 2025-04-01 |
| RTX A4000 Product Specifications | [NVIDIA Product Page](https://www.nvidia.com/en-us/design-visualization/rtx-a4000/) | [Archived Copy](../references/archived/rtx-a4000-specs-2025-01.pdf) | 2025-03-15 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

### 7.3 Change Request References

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-2025-042 | Initial GPU Operator deployment | 2025-03-10 | [GLPI-1204](http://glpi.lab/ticket/1204) |
| CR-2025-056 | Driver version update to 525.85.05 | 2025-03-28 | [GLPI-1256](http://glpi.lab/ticket/1256) |
| CR-2025-078 | MPS enablement for shared GPU access | 2025-04-15 | [GLPI-1278](http://glpi.lab/ticket/1278) |

The change request table above tracks formal changes that have affected this system, supporting troubleshooting and audit activities.

## 8. Approval & Review

This section documents the formal review and approval process for this document.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |
| DataScienceManager | Research Lead | 2025-04-20 | ✅ Approved |
| SecurityAuditor | Security Officer | 2025-04-19 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

## 9. Change Log

This section tracks the document's revision history.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial version | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.
