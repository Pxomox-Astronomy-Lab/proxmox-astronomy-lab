<!-- 
---
title: "Node Configuration in RKE2 Kubernetes Cluster"
description: "Detailed documentation of Kubernetes node configuration, resource allocation, and roles within the Proxmox Astronomy Lab's RKE2 cluster"
author: "VintageDon"
tags: ["kubernetes", "rke2", "nodes", "infrastructure", "compute", "phase-3"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "Proxmox", "Compute Resources", "VM Management"]
implements_policies: ["Infrastructure Security Policy", "Resource Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.1.1", "CIS.2.1", "CIS.5.1"]
iso27001_controls: ["A.8.1.1", "A.8.1.2", "A.12.1.3"]
nist_controls: ["CM-8", "CM-3", "SC-7"]
---
-->

# Node Configuration in RKE2 Kubernetes Cluster

This document provides comprehensive information about the node configuration within the RKE2 Kubernetes cluster in the Proxmox Astronomy Lab. It details the node roles, resource allocation, hardware specifications, and operational aspects of the virtualized Kubernetes infrastructure.

# 1. Overview

This section establishes the foundational context for the Kubernetes node infrastructure, explaining how the nodes are distributed, their roles within the cluster, and how they support the overall research and application needs of the Proxmox Astronomy Lab.

## 1.1 Purpose

This subsection clearly defines why specific node configurations exist, what problems they address, and what value they deliver to the organization and its research activities.

The RKE2 cluster node infrastructure provides a balanced distribution of compute resources for containerized applications, ensuring high availability, workload isolation, and optimized resource allocation based on application needs. Node configurations are strategically designed to provide specialized resources for different workload profiles, including control plane services, general workloads, and GPU-accelerated AI/ML processing.

## 1.2 Scope

This subsection defines the boundaries of what this document covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Kubernetes node roles and functions | Proxmox host configuration details |
| VM resource allocation and sizing | Physical hardware specifications |
| Node-level software configuration | Container-level configuration |
| Node labels and taints | Application deployment specifics |
| Node maintenance procedures | Network topology details |
| Node monitoring and health checks | Storage backend implementation |

The table above provides a clear delineation between included and excluded topics to prevent misunderstandings about document coverage.

## 1.3 Target Audience

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

- **Primary**: Infrastructure administrators and Kubernetes operators managing the cluster
- **Secondary**: DevOps engineers deploying applications to the cluster
- **Tertiary**: Capacity planners and resource administrators
- **Expected Knowledge**: Basic understanding of Kubernetes architecture, virtualization concepts, and resource management principles

# 2. Dependencies & Relationships

This section maps how the node configuration relates to other elements within the environment, capturing both upstream and downstream dependencies. These relationships form the basis for impact analysis and service maps.

## 2.1 Related Services

This subsection identifies other services that interact with the node configuration, establishing the service ecosystem and integration points.

This document **relates to**:

- [RKE2 Cluster Overview](01-rke2-cluster-overview.md) - The overall Kubernetes architecture
- [Proxmox Cluster Configuration](../infrastructure/proxmox-cluster-configuration.md) - The underlying virtualization platform
- [Storage Configuration](04-storage.md) - Storage resources allocated to nodes
- [Networking Configuration](03-networking.md) - Network connectivity for nodes
- [GPU Infrastructure](06-gpu-infrastructure.md) - Specialized GPU node configuration

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## 2.2 Implements Policies

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

This document **implements**:

- [Infrastructure Security Policy](../compliance-security/policies/infrastructure-security-policy.md) - Through secure node configuration
- [Resource Management Policy](../compliance-security/policies/resource-management-policy.md) - Through appropriate sizing and allocation
- [High Availability Policy](../compliance-security/policies/high-availability-policy.md) - Through redundant control plane nodes

The list above shows how this document contributes to organizational compliance and governance objectives.

## 2.3 Responsibility Matrix

This subsection defines accountabilities and responsibilities for key activities related to the node configuration, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure Admin** | **Kubernetes Admin** | **Security Admin** | **Application Owner** |
|--------------|-------------------|-------------------|--------------|----------------|
| Node Provisioning | R/A | C | C | I |
| Resource Allocation | R/A | C | I | C |
| Node Maintenance | R/A | C | I | I |
| Security Hardening | C | C | R/A | I |
| Monitoring & Alerting | R/A | C | C | I |
| Scaling Decisions | C | R/A | I | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 3. Technical Documentation

This section provides the technical details necessary for understanding, managing, and troubleshooting the node configuration. It serves as the authoritative technical reference for the Kubernetes node architecture.

## 3.1 Architecture & Components

This subsection explains the technical architecture, component relationships, and design decisions that shape the node configuration implementation.

The RKE2 Kubernetes cluster is built on a balanced architecture of dedicated control plane nodes and specialized worker nodes, all running as virtual machines on the Proxmox virtualization platform. The architecture provides separation of concerns through role specialization while ensuring redundancy for high availability.

The cluster consists of eight nodes distributed across five Proxmox hosts:

**Control Plane Nodes**:

- Three dedicated control plane nodes (proj-k8sm01, proj-k8sm02, proj-k8sm03) running the Kubernetes API server, etcd, and controller manager
- Distributed across three physical hosts for high availability
- Sized for control plane workloads with moderate resource allocation

**Worker Nodes**:

- Five worker nodes for application workloads with different specializations:
  - General Purpose Workers (proj-k8sw01, proj-k8sw02, proj-k8sw03): Standard workloads
  - GPU-Enabled Worker (proj-k8sw04): AI/ML and compute-intensive workloads
  - Storage-Optimized Worker (proj-k8sw05): Data-intensive and storage-centric workloads

This architecture ensures appropriate resource allocation for different workload profiles while maintaining separation between control plane and application workloads for stability and security.

## 3.2 Configuration Details

This subsection provides specific configuration parameters, file locations, and settings required for understanding and managing the node configuration.

All nodes in the RKE2 cluster are provisioned as virtual machines with specific resource allocations, operating system configurations, and RKE2-specific settings. Key configuration details include:

**Node Specifications Table**

| **Node** | **Role** | **IP Address** | **vCPU** | **RAM** | **Storage** | **Host** | **Special Features** |
|----------|----------|----------------|----------|---------|-------------|----------|----------------------|
| proj-k8sm01 | Control Plane | 10.25.20.4 | 2 | 8GB | 32GB + 250GB | node01 | Bootstrapped node |
| proj-k8sm02 | Control Plane | 10.25.20.5 | 2 | 8GB | 32GB + 250GB | node02 | - |
| proj-k8sm03 | Control Plane | 10.25.20.6 | 2 | 8GB | 32GB + 250GB | node03 | - |
| proj-k8sw01 | Worker | 10.25.20.7 | 8 | 32GB | 150GB + 1000GB | node01 | - |
| proj-k8sw02 | Worker | 10.25.20.8 | 8 | 32GB | 150GB + 1000GB | node02 | - |
| proj-k8sw03 | Worker | 10.25.20.9 | 8 | 32GB | 150GB + 1000GB | node03 | - |
| proj-k8sw04 | Worker (GPU) | 10.25.20.10 | 8 | 32GB | 150GB + 2000GB | node04 | RTX A4000 GPU passthrough |
| proj-k8sw05 | Worker | 10.25.20.11 | 8 | 32GB | 150GB + 1000GB | nas01 | - |

**Operating System Configuration**:

- Ubuntu 24.04 LTS with CISv8 Level 2 hardening
- Minimal installation with only required packages
- Automatic security updates enabled
- Hardened kernel parameters as per CIS benchmarks

**RKE2 Server Configuration (Control Plane Nodes)**:

```yaml
# /etc/rancher/rke2/config.yaml
token: <redacted>
tls-san:
  - api.k8s.lab.internal
  - 10.25.20.4
  - 10.25.20.5
  - 10.25.20.6
write-kubeconfig-mode: 0640
cni: canal
disable: rke2-ingress-nginx
kube-apiserver-arg:
  - "enable-admission-plugins=NodeRestriction,PodSecurityPolicy"
  - "audit-log-path=/var/lib/rancher/rke2/server/logs/audit.log"
  - "audit-log-maxage=30"
  - "audit-log-maxbackup=10"
  - "audit-log-maxsize=100"
kubelet-arg:
  - "protect-kernel-defaults=true"
  - "make-iptables-util-chains=true"
  - "streaming-connection-idle-timeout=5m"
```

**RKE2 Agent Configuration (Worker Nodes)**:

```yaml
# /etc/rancher/rke2/config.yaml
server: https://api.k8s.lab.internal:6443
token: <redacted>
kubelet-arg:
  - "protect-kernel-defaults=true"
  - "make-iptables-util-chains=true"
  - "streaming-connection-idle-timeout=5m"
```

**Node Labels and Taints**:

Control Plane Node Labels:

```text
node-role.kubernetes.io/control-plane=true
node-role.kubernetes.io/master=true
```

Control Plane Node Taints:

```text
node-role.kubernetes.io/control-plane=true:NoSchedule
```

GPU Node Labels:

```text
node-role.kubernetes.io/worker=true
gpu=true
nvidia.com/gpu.present=true
```

GPU Node Taints:

```text
nvidia.com/gpu=true:NoSchedule
```

Standard Worker Node Labels:

```text
node-role.kubernetes.io/worker=true
```

## 3.3 Implementation Steps

This subsection provides a high-level sequential procedure for understanding how the node configuration was implemented, including verification steps and expected outcomes.

The node infrastructure was implemented following this sequence:

1. **VM Provisioning in Proxmox**
   - Created VM templates with Ubuntu 24.04 LTS
   - Applied CIS hardening to the templates
   - Cloned templates for each node with appropriate sizing:

     ```bash
     # Example for control plane node
     qm clone 9000 104 --name proj-k8sm01
     qm set 104 --memory 8192 --cores 2 --net0 virtio,bridge=vmbr0
     ```

   - Configured networking for each node

2. **Operating System Preparation**
   - Updated system packages:

     ```bash
     apt update && apt upgrade -y
     ```

   - Configured host settings for Kubernetes:

     ```bash
     # Disable swap
     swapoff -a
     sed -i '/swap/d' /etc/fstab
     
     # Load required modules
     cat > /etc/modules-load.d/k8s.conf << EOF
     overlay
     br_netfilter
     EOF
     
     # Set kernel parameters
     cat > /etc/sysctl.d/k8s.conf << EOF
     net.bridge.bridge-nf-call-iptables = 1
     net.bridge.bridge-nf-call-ip6tables = 1
     net.ipv4.ip_forward = 1
     EOF
     ```

   - Verified settings were applied:

     ```bash
     sysctl --system
     ```

3. **RKE2 Server Installation (Control Plane Nodes)**
   - Installed RKE2 server on first control plane node:

     ```bash
     curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=server sh -
     ```

   - Applied server configuration:

     ```bash
     mkdir -p /etc/rancher/rke2/
     cp config.yaml /etc/rancher/rke2/
     ```

   - Enabled and started the RKE2 server service:

     ```bash
     systemctl enable rke2-server.service
     systemctl start rke2-server.service
     ```

   - Verified control plane node initialization:

     ```bash
     export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
     kubectl get nodes
     ```

4. **Additional Control Plane Nodes**
   - Installed RKE2 server on remaining control plane nodes
   - Configured to join existing cluster using token
   - Verified etcd cluster health:

     ```bash
     kubectl get pods -n kube-system | grep etcd
     ```

5. **RKE2 Agent Installation (Worker Nodes)**
   - Installed RKE2 agent on all worker nodes:

     ```bash
     curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=agent sh -
     ```

   - Applied agent configuration:

     ```bash
     mkdir -p /etc/rancher/rke2/
     cp config.yaml /etc/rancher/rke2/
     ```

   - Enabled and started the RKE2 agent service:

     ```bash
     systemctl enable rke2-agent.service
     systemctl start rke2-agent.service
     ```

   - Verified worker nodes joined the cluster:

     ```bash
     kubectl get nodes -o wide
     ```

6. **GPU Node Configuration**
   - Configured GPU passthrough in Proxmox:

     ```bash
     # Added to VM config
     hostpci0: 0000:0b:00.0,pcie=1,x-vga=1
     ```

   - Installed NVIDIA drivers on GPU node
   - Applied GPU-specific labels and taints:

     ```bash
     kubectl label nodes proj-k8sw04 gpu=true nvidia.com/gpu.present=true
     kubectl taint nodes proj-k8sw04 nvidia.com/gpu=true:NoSchedule
     ```

   - Verified GPU availability in node:

     ```bash
     ssh proj-k8sw04 nvidia-smi
     ```

7. **Validation and Verification**
   - Verified all nodes are Ready:

     ```bash
     kubectl get nodes -o wide
     ```

   - Verified control plane components:

     ```bash
     kubectl get pods -n kube-system
     ```

   - Tested pod scheduling to different node types
   - Validated GPU visibility from containers

Each step included validation testing to ensure proper functionality before proceeding to the next phase.

# 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for the node configuration. It provides the practical guidance needed for ongoing maintenance and support.

## 4.1 Routine Procedures

This subsection documents regular maintenance and operational tasks required to keep the node infrastructure functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Node Health Check | Daily | Infrastructure Admin | Automated Liongard change detection alert via email to <alerts@radioastronomy.io> (monitored by GLPI) |
| OS Updates | Monthly | Infrastructure Admin | [OS Update Procedure](../procedures/os-update.md) |
| RKE2 Version Upgrades | Quarterly | Infrastructure Admin | [RKE2 Upgrade Procedure](../procedures/rke2-upgrade.md) |
| Resource Utilization Review | Weekly | Infrastructure Admin | [Resource Monitoring Procedure](../procedures/resource-monitoring.md) |
| Node Security Scanning | Monthly | Security Admin | [Security Scan Procedure](../procedures/security-scan.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and performance, along with their required cadence.

## 4.2 Troubleshooting

This subsection provides guidance for identifying and resolving common issues with the node configuration, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Node status NotReady | Kubelet service failure, network issue | Check kubelet status, verify network connectivity, restart services if needed | [Node Not Ready Troubleshooting](../troubleshooting/node-not-ready.md) |
| Control plane node unhealthy | etcd issues, API server problems | Check etcd cluster health, verify API server logs, restore from backup if needed | [Control Plane Troubleshooting](../troubleshooting/control-plane-issues.md) |
| Node resource constraints | Overallocation, resource leaks | Identify resource-intensive pods, adjust resource limits, potentially migrate workloads | [Resource Constraint Troubleshooting](../troubleshooting/resource-constraints.md) |
| GPU not available to containers | Driver issues, GPU operator problems | Verify GPU drivers, check NVIDIA device plugin status, restart components | [GPU Troubleshooting](../troubleshooting/gpu-issues.md) |
| Node communication failures | CNI issues, network policies | Verify CNI status, check network policies, test pod-to-pod connectivity | [Node Network Troubleshooting](../troubleshooting/node-network-issues.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## 4.3 Monitoring & Metrics

This subsection defines what aspects of the node configuration should be monitored, normal operating parameters, alert thresholds, and how to access monitoring dashboards.

The node infrastructure is monitored using Prometheus and Grafana deployed on lab-mon01. Key metrics and monitoring parameters include:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| Node CPU Utilization | 0-70% | >85% for >15 min | [Node Resource Dashboard](http://grafana.lab.internal/d/node-resources) |
| Node Memory Usage | 0-80% | >90% for >15 min | [Node Resource Dashboard](http://grafana.lab.internal/d/node-resources) |
| Node Disk Usage | 0-80% | >90% | [Node Storage Dashboard](http://grafana.lab.internal/d/node-storage) |
| Kubelet Status | Running | Not running for >5 min | [Kubernetes Component Dashboard](http://grafana.lab.internal/d/k8s-components) |
| Node Network Throughput | 0-500 Mbps | >800 Mbps for >10 min | [Node Network Dashboard](http://grafana.lab.internal/d/node-network) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure node health and performance.

Additionally, the following node-specific metrics are collected:

- Container runtime status
- System load averages
- Available pods per node
- Etcd health metrics (for control plane nodes)
- GPU utilization metrics (for GPU node)

# 5. Security & Compliance

This section documents how security controls are implemented in the node configuration and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

The RKE2 cluster node infrastructure is hardened according to CIS benchmarks and security best practices. The implementation aligns with the organizational security policies and compliance requirements.

## 5.1 Security Controls

This subsection documents specific security measures implemented in the node configuration, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Operating System Hardening | CISv8 Level 2 baseline for Ubuntu 24.04 | Regular CIS benchmark scans | CIS.5.1, NIST CM-6 |
| Access Control | SSH key-based authentication only, no password access | SSH configuration review | CIS.4.3, NIST AC-3 |
| Network Security | Host-based firewall, limited open ports | Network scan verification | CIS.9.4, NIST SC-7 |
| System Integrity | System volumes LUKS encrypted, verified boot chain | Disk encryption verification | CIS.3.11, NIST SC-28 |
| Vulnerability Management | Automated security updates, regular patching | Patch compliance reporting | CIS.2.2, NIST SI-2 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps node configuration implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.1.1 | Inventory of authorized devices | RKE2 node inventory in Rancher | Compliant |
| CIS.2.1 | Inventory of authorized software | APT package manifest, container image scanning | Compliant |
| CIS.3.4 | Deploy automated operating system patch management | Unattended-upgrades configuration | Compliant |
| CIS.4.1 | Secure configuration of enterprise assets and software | CIS hardening baseline | Compliant |
| CIS.5.1 | Establish secure configuration practices | Node template documentation | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## 5.3 Related Framework Mappings

This subsection shows how controls map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.1.1 | A.8.1.1 | ID.AM-1 | RKE2 node inventory in Rancher |
| CIS.2.1 | A.8.1.2 | ID.AM-2 | APT package manifest, container image scanning |
| CIS.3.4 | A.12.6.1 | PR.IP-3 | Unattended-upgrades configuration |
| CIS.4.1 | A.14.2.2 | PR.IP-1 | CIS hardening baseline |
| CIS.5.1 | A.12.1.2 | PR.IP-1 | Node template documentation |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 5.4 Risk Assessment

This subsection documents identified security risks, implemented mitigations, and any accepted residual risk associated with the node configuration.

The node infrastructure has undergone a security risk assessment to identify potential vulnerabilities and apply appropriate mitigations:

1. **Risk**: Unauthorized access to node systems
   - **Mitigation**: SSH key-based authentication, IP-based access restrictions, no direct external access
   - **Residual Risk**: Low - Multiple layers of access controls limit exposure

2. **Risk**: Operating system vulnerabilities
   - **Mitigation**: Regular security updates, CIS-hardened baseline, minimal installed packages
   - **Residual Risk**: Medium - Zero-day vulnerabilities remain a possibility

3. **Risk**: Container breakout to host
   - **Mitigation**: AppArmor profiles, seccomp filters, container security context restrictions
   - **Residual Risk**: Medium - Advanced container escape techniques may still pose a risk

4. **Risk**: Resource exhaustion attacks
   - **Mitigation**: Resource quotas, limits on pod resources, monitoring and alerting
   - **Residual Risk**: Low - Comprehensive resource controls mitigate most scenarios

These risks are actively managed through continuous monitoring, regular security scanning, and timely updates to all node-related components.

# 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures for the node configuration. It provides the guidance needed to ensure business continuity and disaster recovery capabilities.

## 6.1 Backup Procedure

This subsection details how data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Node VMs: Daily at 01:00 UTC, RKE2 configuration: Daily at 01:30 UTC, Etcd: Every 6 hours |
| **Backup Method** | VM: Proxmox Backup Server, RKE2: Configuration repository, Etcd: Automated snapshots |
| **Retention Policy** | 7 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | Primary: proj-pg01:/backup, Secondary: S3 Glacier Deep Archive |
| **Verification Process** | Every 90 days test restoration to validate backups |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

Node-specific considerations:

- Control plane node backups include etcd data
- VM-level snapshots capture complete node state
- Configuration backups maintain system settings
- Application data on persistent volumes is backed up separately

## 6.2 Recovery Procedure

This subsection provides recovery steps for various failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Single worker node failure | 30 minutes | 24 hours | Restore VM from backup, rejoin cluster | Infrastructure Admin |
| Single control plane node failure | 45 minutes | 6 hours | Restore VM including etcd data, rejoin cluster | Infrastructure Admin |
| Multiple control plane node failure | 2 hours | 6 hours | Restore all control plane nodes, recover etcd cluster | Infrastructure Admin |
| Complete cluster failure | 4 hours | 24 hours | Restore control plane first, then worker nodes | Infrastructure Admin |
| VM corruption without backup | 60 minutes | Variable | Rebuild node from template, rejoin cluster, restore configuration | Infrastructure Admin |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

# 7. References & Related Resources

This section provides links to related documentation and external resources. It establishes the connections between this document and other knowledge sources both internal and external.

## 7.1 Internal References

This subsection identifies other internal documents related to the node configuration, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Architecture | RKE2 Cluster Overview | [01-rke2-cluster-overview.md](01-rke2-cluster-overview.md) | Parent architecture |
| Technical | Proxmox VM Templates | [../infrastructure/proxmox-vm-templates.md](../infrastructure/proxmox-vm-templates.md) | Base VM configuration |
| Technical | GPU Infrastructure | [06-gpu-infrastructure.md](06-gpu-infrastructure.md) | GPU node specific details |
| Operational | RKE2 Upgrade Procedure | [../procedures/rke2-upgrade.md](../procedures/rke2-upgrade.md) | Node upgrade process |
| Operational | Node Scaling Procedure | [../procedures/node-scaling.md](../procedures/node-scaling.md) | Adding/removing nodes |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## 7.2 External References

This subsection provides links to external resources that provide additional context, technical details, or supporting information for the node configuration.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| RKE2 Installation | <https://docs.rke2.io/install/quickstart> | [rke2-install-docs-2025-04.pdf](../archive/rke2-install-docs-2025-04.pdf) | 2025-04-01 |
| Kubernetes Node Architecture | <https://kubernetes.io/docs/concepts/architecture/nodes/> | [k8s-node-docs-2025-04.pdf](../archive/k8s-node-docs-2025-04.pdf) | 2025-04-01 |
| CIS Ubuntu Linux Benchmark | <https://www.cisecurity.org/benchmark/ubuntu_linux> | [cis-ubuntu-benchmark-2025-03.pdf](../archive/cis-ubuntu-benchmark-2025-03.pdf) | 2025-03-15 |
| Proxmox VM Management | <https://pve.proxmox.com/wiki/Qemu/KVM_Virtual_Machines> | [proxmox-vm-docs-2025-03.pdf](../archive/proxmox-vm-docs-2025-03.pdf) | 2025-03-20 |
| NVIDIA GPU with Kubernetes | <https://docs.nvidia.com/datacenter/cloud-native/kubernetes/install-k8s.html> | [nvidia-k8s-docs-2025-03.pdf](../archive/nvidia-k8s-docs-2025-03.pdf) | 2025-03-20 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## 7.3 Change Request References

This subsection documents formal change requests that have modified the node configuration, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** |
|--------------|----------------|------------------------|
| CR-2025-042 | Initial RKE2 cluster node deployment | 2025-04-10 |
| CR-2025-047 | Added GPU node to cluster | 2025-04-15 |
| CR-2025-048 | Updated node security baseline | 2025-04-16 |
| CR-2025-050 | Optimized control plane resources | 2025-04-17 |

The change request table above tracks formal changes that have affected the node configuration, supporting troubleshooting and audit activities.

# 8. Approval & Review

This section documents the formal review and approval process for the node configuration documentation. It ensures accountability and tracks who has verified the accuracy of the content.

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
