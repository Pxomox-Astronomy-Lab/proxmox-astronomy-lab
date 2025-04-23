<!-- 
---
title: "GPU Infrastructure in RKE2 Kubernetes Cluster"
description: "Detailed documentation of GPU node configuration, NVIDIA GPU Operator deployment, and GPU workload management in the Proxmox Astronomy Lab's Kubernetes cluster"
author: "VintageDon"
tags: ["kubernetes", "rke2", "gpu", "nvidia", "mps", "ai-ml", "infrastructure", "phase-3"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "GPU Computing", "AI/ML Platforms", "Container Orchestration"]
implements_policies: ["Infrastructure Security Policy", "Data Management Policy", "Research Computing Policy"]
phase: "phase-3"
cis_controls: ["CIS.1.1", "CIS.3.4", "CIS.5.1"]
iso27001_controls: ["A.8.1", "A.12.1", "A.13.1"]
nist_controls: ["CM-6", "SC-7", "AC-3"]
---
-->

# GPU Infrastructure in RKE2 Kubernetes Cluster

This document provides comprehensive information about the GPU infrastructure integrated with the RKE2 Kubernetes cluster in the Proxmox Astronomy Lab. It details the hardware, software, configurations, and operational procedures necessary to support GPU-accelerated workloads for AI/ML and radio astronomy signal processing.

# 1. Overview

This section establishes the foundational context for the GPU infrastructure, explaining its purpose within the broader Kubernetes architecture and how it supports AI/ML and scientific computing workloads in the Proxmox Astronomy Lab.

## 1.1 Purpose

This subsection clearly defines why GPU infrastructure exists in the cluster, what problems it addresses, and what value it delivers to research activities.

The GPU infrastructure in the RKE2 Kubernetes cluster provides accelerated computing capabilities for AI-powered Hydrogen Line signal processing, machine learning model training, and scientific data analysis. It serves as the computational foundation for enhancing radio astronomy signal detection, noise reduction, and pattern recognition through hardware acceleration.

## 1.2 Scope

This subsection defines the boundaries of what this document covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| GPU node hardware specifications | AI/ML application development |
| NVIDIA driver and GPU operator deployment | Scientific model design |
| MPS (Multi-Process Service) configuration | Deep learning framework specifics |
| GPU workload scheduling | Model training methodologies |
| Resource allocation and monitoring | Container image building |
| Performance optimization | Network optimization for distributed training |

The table above provides a clear delineation between included and excluded topics to prevent misunderstandings about document coverage.

## 1.3 Target Audience

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

- **Primary**: Infrastructure administrators and DevOps engineers managing the GPU resources
- **Secondary**: Research engineers deploying AI/ML workloads on the cluster
- **Tertiary**: Data scientists requiring GPU resources for model training and inference
- **Expected Knowledge**: Basic understanding of Kubernetes concepts, containerization, and GPU computing principles

# 2. Dependencies & Relationships

This section maps how the GPU infrastructure relates to other elements within the environment, capturing both upstream and downstream dependencies. These relationships form the basis for impact analysis and service maps.

## 2.1 Related Services

This subsection identifies other services that interact with the GPU infrastructure, establishing the service ecosystem and integration points.

This document **relates to**:

- [RKE2 Cluster Overview](01-rke2-cluster-overview.md) - The underlying Kubernetes platform
- [Node Configuration](02-node-configuration.md) - The base VM configuration for the GPU node
- [Storage Configuration](04-storage.md) - Persistent storage for AI/ML datasets and models
- [AI/ML Platforms](../applications/ai-ml-platforms/README.md) - Applications leveraging GPU resources
- [Radio Astronomy Applications](../applications/radio-astronomy/README.md) - Scientific workloads using GPU acceleration

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## 2.2 Implements Policies

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

This document **implements**:

- [Infrastructure Security Policy](../compliance-security/policies/infrastructure-security-policy.md) - Through secure GPU resource isolation
- [Research Computing Policy](../compliance-security/policies/research-computing-policy.md) - Through resource allocation for scientific workloads
- [Data Processing Policy](../compliance-security/policies/data-processing-policy.md) - Through accelerated data analysis capabilities

The list above shows how this document contributes to organizational compliance and governance objectives.

## 2.3 Responsibility Matrix

This subsection defines accountabilities and responsibilities for key activities related to the GPU infrastructure, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure Admin** | **Security Admin** | **Research Engineer** | **Data Scientist** |
|--------------|-------------------|-------------------|--------------|----------------|
| GPU Driver Updates | R/A | C | I | I |
| GPU Operator Maintenance | R/A | I | I | I |
| Resource Allocation | R/A | I | C | C |
| Workload Deployment | I | C | R/A | C |
| Performance Monitoring | R/A | I | C | I |
| Model Deployment | I | I | C | R/A |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 3. Technical Documentation

This section provides the technical details necessary for understanding, managing, and troubleshooting the GPU infrastructure. It serves as the authoritative technical reference for the GPU node architecture and configuration.

## 3.1 Architecture & Components

This subsection explains the technical architecture, component relationships, and design decisions that shape the GPU infrastructure implementation.

The GPU infrastructure in the RKE2 cluster is built around a dedicated GPU-enabled worker node (proj-k8sw04) hosting an NVIDIA RTX A4000 GPU. The architecture includes the NVIDIA GPU Operator for lifecycle management of NVIDIA software components and the Multi-Process Service (MPS) for improved GPU sharing among containers.

Key components include:

- **Hardware**: NVIDIA RTX A4000 (16GB VRAM) installed in the Node04 Proxmox host and passed through to the proj-k8sw04 VM
- **NVIDIA GPU Operator**: Deployed via Helm chart to automate driver, runtime, and device plugin management
- **NVIDIA MPS**: Multi-Process Service daemon for enhanced GPU sharing
- **NVIDIA Container Runtime**: Container runtime extension for GPU-aware containers
- **NVIDIA Device Plugin**: Kubernetes device plugin for GPU resource scheduling
- **NVIDIA DCGM**: Monitoring and management suite for GPU metrics

This architecture ensures GPU resources are properly managed, monitored, and efficiently shared among multiple workloads.

## 3.2 Configuration Details

This subsection provides specific configuration parameters, file locations, and settings required for understanding and managing the GPU infrastructure.

The GPU node and associated components are configured through a combination of Proxmox VM settings, Kubernetes manifests, and the NVIDIA GPU Operator. Key configuration details include:

**Proxmox VM Configuration for proj-k8sw04**

```text
# Proxmox VM configuration
args: -cpu host,+kvm_pv_unhalt,+kvm_pv_eoi,+hypervisor,force-avx,+vme,+nx
machine: q35
hostpci0: 0000:0b:00.0,pcie=1,x-vga=1
numa: 0
```

**GPU Operator Helm Values**

```yaml
# infrastructure/k8s-rancher-rke2/helm/gpu-operator-values.yaml
driver:
  enabled: true
  version: "525.105.17"
toolkit:
  enabled: true
devicePlugin:
  enabled: true
  config:
    name: "default"
    default: "0"
mps:
  enabled: true
```

**Node Labels and Taints**

```yaml
# Applied to proj-k8sw04
labels:
  gpu: "true"
  nvidia.com/gpu.present: "true"
taints:
  - key: nvidia.com/gpu
    value: "true"
    effect: NoSchedule
```

**NVIDIA MPS Configuration**

```bash
# /etc/systemd/system/nvidia-mps.service
[Unit]
Description=NVIDIA Multi-Process Service
After=nvidia-persistenced.service

[Service]
ExecStart=/usr/bin/nvidia-cuda-mps-control -d
ExecStop=/usr/bin/nvidia-cuda-mps-control shutdown
Type=forking
User=nvidia-mps
Environment="CUDA_MPS_PIPE_DIRECTORY=/tmp/nvidia-mps"
Environment="CUDA_MPS_LOG_DIRECTORY=/var/log/nvidia-mps"

[Install]
WantedBy=multi-user.target
```

## 3.3 Implementation Steps

This subsection provides a high-level sequential procedure for understanding how the GPU infrastructure was implemented, including verification steps and expected outcomes.

The GPU infrastructure was implemented following this sequence:

1. **Hardware Setup**
   - Installed NVIDIA RTX A4000 in the Node04 physical server
   - Configured IOMMU and VFIO for PCI passthrough in the Proxmox host

2. **VM Configuration**
   - Created proj-k8sw04 VM with PCI passthrough for the GPU
   - Allocated 8 vCPUs and 32GB RAM to ensure adequate resources
   - Applied optimizations for GPU workloads in VM settings

3. **Kubernetes Integration**
   - Added the node to the RKE2 cluster as a worker
   - Applied the "gpu=true" label to enable affinity scheduling
   - Applied a taint to prevent non-GPU workloads from scheduling

4. **GPU Operator Deployment**
   - Added the NVIDIA Helm repository
   - Deployed the GPU Operator with custom configuration:

     ```bash
     helm install gpu-operator nvidia/gpu-operator \
       -n gpu-operator --create-namespace \
       -f infrastructure/k8s-rancher-rke2/helm/gpu-operator-values.yaml
     ```

   - Verified all pods reached Running state

5. **MPS Configuration**
   - Enabled and configured the NVIDIA MPS daemon
   - Created appropriate directory permissions
   - Verified MPS functionality with test workloads

6. **Validation**
   - Deployed test pods with GPU requests
   - Verified GPU acceleration was functioning
   - Conducted performance benchmarks to establish baselines

Each step included validation testing to ensure proper functionality before proceeding to the next phase.

# 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for the GPU infrastructure. It provides the practical guidance needed for ongoing maintenance and support.

## 4.1 Routine Procedures

This subsection documents regular maintenance and operational tasks required to keep the GPU infrastructure functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| GPU Driver Updates | Quarterly | Infrastructure Admin | [GPU Driver Update Procedure](../procedures/gpu-driver-update.md) |
| GPU Operator Updates | Quarterly | Infrastructure Admin | [GPU Operator Update Procedure](../procedures/gpu-operator-update.md) |
| Performance Benchmarking | Monthly | Infrastructure Admin | [GPU Benchmark Procedure](../procedures/gpu-benchmark.md) |
| Resource Utilization Review | Weekly | Infrastructure Admin | Automated Liongard change detection alert via email to <alerts@radioastronomy.io> (monitored by GLPI) |
| VRAM Leak Monitoring | Weekly | Infrastructure Admin | [VRAM Monitoring Procedure](../procedures/vram-monitoring.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and performance, along with their required cadence.

## 4.2 Troubleshooting

This subsection provides guidance for identifying and resolving common issues with the GPU infrastructure, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Pods stuck in "Pending" with GPU request | Resource exhaustion or plugin issue | Check GPU allocation with `nvidia-smi`, restart device plugin if needed | [GPU Scheduling Issues](../troubleshooting/gpu-scheduling.md) |
| CUDA errors in container logs | Driver/CUDA version mismatch | Verify container CUDA compatibility with node driver version | [CUDA Compatibility Issues](../troubleshooting/cuda-compatibility.md) |
| MPS server not accepting connections | MPS service failure | Restart MPS daemon, check service logs for errors | [MPS Troubleshooting](../troubleshooting/mps-issues.md) |
| Performance degradation | Thermal throttling or concurrent workloads | Check GPU temperatures and utilization patterns, adjust workload scheduling | [GPU Performance Issues](../troubleshooting/gpu-performance.md) |
| VM fails to start with GPU passthrough | Passthrough configuration issue | Verify IOMMU settings and VFIO binding in Proxmox host | [GPU Passthrough Issues](../troubleshooting/gpu-passthrough.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## 4.3 Monitoring & Metrics

This subsection defines what aspects of the GPU infrastructure should be monitored, normal operating parameters, alert thresholds, and how to access monitoring dashboards.

The GPU node is monitored using the NVIDIA DCGM exporter integrated with Prometheus and Grafana deployed on lab-mon01. Key metrics and monitoring parameters include:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| GPU Utilization | 0-90% | >95% for >30 min | [GPU Utilization Dashboard](http://grafana.lab.internal/d/gpu-utilization) |
| GPU Memory Usage | 0-14GB | >15GB for >10 min | [GPU Memory Dashboard](http://grafana.lab.internal/d/gpu-memory) |
| GPU Temperature | 30-75°C | >80°C for >5 min | [GPU Thermal Dashboard](http://grafana.lab.internal/d/gpu-thermal) |
| GPU Power Draw | 50-160W | >180W for >10 min | [GPU Power Dashboard](http://grafana.lab.internal/d/gpu-power) |
| GPU ECC Errors | 0 | Any non-zero value | [GPU Health Dashboard](http://grafana.lab.internal/d/gpu-health) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure GPU health and performance.

Additionally, workload-specific metrics are collected via custom exporters:

- Model inference latency
- Batch processing throughput
- CUDA kernel execution time
- Queue wait times for GPU access

# 5. Security & Compliance

This section documents how security controls are implemented in the GPU infrastructure and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

## 5.1 Security Controls

This subsection documents specific security measures implemented in the GPU infrastructure, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Access Control | Kubernetes RBAC, node taints | Review RBAC bindings, verify non-GPU workloads cannot schedule | CIS.5.1, NIST AC-3 |
| Resource Isolation | MPS configuration, namespace limits | Test concurrent workload isolation | CIS.5.2, NIST SC-7 |
| Secure Drivers | Signed NVIDIA drivers | Verify driver signatures | CIS.5.3, NIST SI-7 |
| Container Security | Restricted container capabilities | Review securityContext settings | CIS.5.4, NIST AC-6 |
| Privilege Management | Non-root container execution | Verify containers run as non-root | CIS.6.1, NIST AC-6 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps GPU infrastructure implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.1.1 | GPU hardware inventory in CMDB | GLPI Asset Management | Compliant |
| CIS.3.4 | Automated driver updates via GPU Operator | GPU Operator configuration | Compliant |
| CIS.5.1 | Secure GPU node configuration | Node hardening documentation | Compliant |
| CIS.6.8 | GPU access and utilization logging | Prometheus metrics | Compliant |
| CIS.16.4 | GPU security benchmarks | Monthly security scan reports | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## 5.3 Related Framework Mappings

This subsection shows how controls map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.1.1 | A.8.1 | ID.AM-1 | GPU hardware inventory in CMDB |
| CIS.3.4 | A.12.6 | PR.IP-3 | Automated driver updates via GPU Operator |
| CIS.5.1 | A.12.1.1 | PR.IP-1 | Secure GPU node configuration |
| CIS.6.8 | A.12.4 | DE.CM-3 | GPU access and utilization logging |
| CIS.16.4 | A.18.2 | ID.RA-1 | GPU security benchmarks |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 5.4 Risk Assessment

This subsection documents identified security risks, implemented mitigations, and any accepted residual risk associated with the GPU infrastructure.

The GPU infrastructure has undergone a security risk assessment to identify potential vulnerabilities and apply appropriate mitigations:

1. **Risk**: Unauthorized access to GPU resources
   - **Mitigation**: RBAC controls, namespace isolation, and resource quotas
   - **Residual Risk**: Low - Limited to potential privilege escalation vulnerabilities

2. **Risk**: Malicious code execution via GPU compute
   - **Mitigation**: Container security policies, read-only filesystems where possible
   - **Residual Risk**: Medium - GPU execution environments have limited isolation options

3. **Risk**: Side-channel attacks between containers
   - **Mitigation**: MPS configuration with strict isolation, workload scheduling practices
   - **Residual Risk**: Medium - Some theoretical attack vectors remain in shared GPU environments

4. **Risk**: Resource exhaustion and denial of service
   - **Mitigation**: Resource limits, monitoring alerts, automated remediation
   - **Residual Risk**: Low - Comprehensive monitoring reduces impact

These risks are actively managed through continuous monitoring, regular security scanning, and timely updates to all GPU-related components.

# 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures for the GPU infrastructure. It provides the guidance needed to ensure business continuity and disaster recovery capabilities.

## 6.1 Backup Procedure

This subsection details how data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | GPU node VM: Daily at 02:00 UTC, NVIDIA configuration: Daily at 03:00 UTC |
| **Backup Method** | VM: Proxmox Backup Server, Configurations: GitOps repository |
| **Retention Policy** | 7 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | Primary: proj-pg01:/backup, Secondary: S3 Glacier Deep Archive |
| **Verification Process** | Every 90 days test restoration to validate backups |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

GPU-specific considerations:

- Model weights and training checkpoints stored on persistent volumes are backed up according to the standard PV backup schedule
- NVIDIA driver configurations are captured in configuration backups
- GPU Operator customizations are stored in Git and included in configuration backups

## 6.2 Recovery Procedure

This subsection provides recovery steps for various failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| GPU Hardware Failure | 8 hours | 24 hours | Replace hardware, restore VM from backup, rejoin cluster | Infrastructure Admin |
| GPU Driver Failure | 30 minutes | 0 data loss | Reinstall drivers via GPU Operator, restart affected pods | Infrastructure Admin |
| GPU Node VM Failure | 45 minutes | 24 hours | Restore VM from backup, rejoin cluster | Infrastructure Admin |
| MPS Service Failure | 15 minutes | 0 data loss | Restart MPS service, verify with test workloads | Infrastructure Admin |
| Full GPU Environment Corruption | 2 hours | 24 hours | Restore VM, reinstall GPU Operator, verify configurations | Infrastructure Admin |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

# 7. References & Related Resources

This section provides links to related documentation and external resources. It establishes the connections between this document and other knowledge sources both internal and external.

## 7.1 Internal References

This subsection identifies other internal documents related to the GPU infrastructure, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Architecture | RKE2 Cluster Overview | [01-rke2-cluster-overview.md](01-rke2-cluster-overview.md) | Parent architecture |
| Technical | Node Configuration | [02-node-configuration.md](02-node-configuration.md) | Base VM configuration |
| Technical | Kubernetes Storage | [04-storage.md](04-storage.md) | Persistent storage for models |
| Operational | GPU Driver Update Procedure | [../procedures/gpu-driver-update.md](../procedures/gpu-driver-update.md) | Maintenance procedure |
| Application | AI/ML Platform Documentation | [../applications/ai-ml-platforms/README.md](../applications/ai-ml-platforms/README.md) | Consuming applications |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## 7.2 External References

This subsection provides links to external resources that provide additional context, technical details, or supporting information for the GPU infrastructure.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| NVIDIA GPU Operator | <https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html> | [gpu-operator-docs-2025-04.pdf](../archive/gpu-operator-docs-2025-04.pdf) | 2025-04-01 |
| NVIDIA MPS Documentation | <https://docs.nvidia.com/deploy/mps/index.html> | [nvidia-mps-docs-2025-04.pdf](../archive/nvidia-mps-docs-2025-04.pdf) | 2025-04-01 |
| RTX A4000 Specifications | <https://www.nvidia.com/en-us/design-visualization/rtx-a4000/> | [rtx-a4000-specs-2025-03.pdf](../archive/rtx-a4000-specs-2025-03.pdf) | 2025-03-15 |
| Kubernetes Device Plugins | <https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/> | [k8s-device-plugins-2025-04.pdf](../archive/k8s-device-plugins-2025-04.pdf) | 2025-04-01 |
| GPU Isolation Best Practices | <https://github.com/NVIDIA/k8s-device-plugin/blob/master/README.md> | [gpu-isolation-practices-2025-03.md](../archive/gpu-isolation-practices-2025-03.md) | 2025-03-20 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## 7.3 Change Request References

This subsection documents formal change requests that have modified the GPU infrastructure, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** |
|--------------|----------------|------------------------|
| CR-2025-047 | Added GPU node to cluster | 2025-04-15 |
| CR-2025-048 | Deployed GPU Operator | 2025-04-16 |
| CR-2025-049 | Configured MPS for workload sharing | 2025-04-17 |
| CR-2025-050 | Implemented GPU monitoring | 2025-04-18 |

The change request table above tracks formal changes that have affected the GPU infrastructure, supporting troubleshooting and audit activities.

# 8. Approval & Review

This section documents the formal review and approval process for the GPU infrastructure documentation. It ensures accountability and tracks who has verified the accuracy of the content.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

# 9. Change Log

This section tracks the document's revision history. It provides transparency into how the document has evolved over time and who made the changes.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial version | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.
