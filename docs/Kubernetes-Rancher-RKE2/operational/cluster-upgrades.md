<!-- 
---
title: "RKE2 Cluster Upgrade Procedures"
description: "Standardized procedures for safely upgrading the RKE2 Kubernetes cluster in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["kubernetes", "rke2", "upgrades", "operations", "change-management"]
category: "Infrastructure"
kb_type: "Procedure"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["RKE2 Kubernetes Cluster", "Rancher Management", "NVIDIA GPU Operator"]
implements_policies: ["Change Management Policy", "Infrastructure Maintenance Policy"]
phase: "phase-3"
cis_controls: ["CIS.3.4", "CIS.4.3"]
iso27001_controls: ["A.12.1.2", "A.14.2.2"]
nist_controls: ["CM-3", "CM-6"]
---
-->

# RKE2 Cluster Upgrade Procedures

This document provides the standardized procedures for planning, implementing, and validating upgrades to the RKE2 Kubernetes cluster in the Proxmox Astronomy Lab. Following these procedures ensures minimal disruption to research workloads while maintaining security and stability.

## 1. Overview

Kubernetes upgrades are necessary to maintain security, stability, and access to new features. This document outlines the complete process for upgrading our RKE2 Kubernetes cluster, including preparation, implementation, testing, and rollback procedures if needed.

### 1.1 Purpose

This document defines the standardized procedures for upgrading the RKE2 Kubernetes cluster components while ensuring minimal disruption to research workloads and maintaining operational integrity. It serves as the authoritative reference for planning and executing Kubernetes version upgrades.

### 1.2 Scope

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| RKE2 Kubernetes version upgrades | Application-specific upgrades |
| Rancher management plane upgrades | Infrastructure hardware changes |
| Node OS patching during upgrades | Custom resource definitions |
| Pre and post-upgrade validation | Data migrations |
| Rollback procedures | Network topology changes |

### 1.3 Target Audience

This document is intended for:

- Infrastructure Administrators performing the upgrades
- DevOps Engineers supporting the upgrade process
- Change Advisory Board members approving upgrade changes
- Operations staff monitoring systems during upgrades

## 2. Dependencies & Relationships

This section maps how cluster upgrades relate to other elements within the Proxmox Astronomy Lab environment.

### 2.1 Related Services

This document **relates to**:

- [RKE2 Kubernetes Cluster](../../01-rke2-cluster-overview.md) - The target system for upgrades
- [Rancher Management](../service-docs/rancher-management.md) - Management plane that must be compatible
- [NVIDIA GPU Operator](../service-docs/gpu-operator.md) - Runtime components that may need version alignment
- [Traefik Ingress](../service-docs/traefik-ingress.md) - Ingress controller that may require configuration updates

### 2.2 Implements Policies

This document **implements**:

- [Change Management Policy](../../compliance-security/change-management-policy.md) - Defines change control procedures
- [Infrastructure Maintenance Policy](../../compliance-security/infrastructure-maintenance-policy.md) - Establishes maintenance windows and practices

### 2.3 Responsibility Matrix

| **Activity** | **Infrastructure Team** | **Change Advisory Board** | **DevOps Team** | **Operations** |
|--------------|-------------------|-------------------|--------------|----------------|
| Upgrade Planning | R/A | C | C | I |
| Change Request Approval | I | R/A | C | I |
| Pre-Upgrade Testing | R/A | I | C | I |
| Control Plane Upgrade | R/A | I | C | C |
| Worker Node Upgrade | R/A | I | C | C |
| Post-Upgrade Validation | R | I | C | R/A |
| Rollback (if necessary) | R/A | I | C | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

## 3. Technical Documentation

This section provides the technical details necessary for planning and implementing RKE2 cluster upgrades.

### 3.1 Upgrade Considerations

Before proceeding with any upgrade, the following considerations must be evaluated:

1. **Version Selection**:
   - Follow N-2 version policy (no more than 2 minor versions behind latest stable)
   - Only upgrade one minor version at a time (e.g., v1.25 → v1.26)
   - Verify Rancher compatibility with target RKE2 version
   - Check GPU Operator compatibility with target Kubernetes version

2. **Timing Factors**:
   - Schedule during defined maintenance windows (Sundays 01:00-05:00 UTC)
   - Ensure no critical research workloads are running
   - Allow minimum 4-hour maintenance window for complete upgrade

3. **Resource Requirements**:
   - Ensure minimum 30% free capacity on control plane nodes
   - Verify backup system has sufficient space for pre-upgrade snapshots
   - Ensure monitoring dashboards are accessible from separate infrastructure

### 3.2 Pre-Upgrade Checklist

Complete the following checklist before beginning any upgrade:

```text
□ Verify current cluster health with `kubectl cluster-info`
□ Update local kubeconfig file with `rke2 kubeconfig`
□ Check for any pending CSRs or stuck resources
□ Verify all nodes are in Ready state with `kubectl get nodes`
□ Verify resource utilization is within acceptable limits
□ Take Proxmox VM snapshots of all Kubernetes nodes
□ Take etcd backup using Rancher UI or CLI
□ Document current versions:
  □ RKE2 Version: __________
  □ Rancher Version: __________
  □ Kubernetes Version: __________
□ Verify control plane node anti-affinity (nodes on separate Proxmox hosts)
□ Check target version compatibility with critical operators:
  □ GPU Operator: __________
  □ Cert-Manager: __________
  □ Traefik: __________
□ Create change management record with detailed plan
□ Notify all stakeholders about maintenance window
```

### 3.3 Upgrade Procedure

The upgrade follows a sequential process to ensure stability:

#### 3.3.1 Control Plane Upgrade

First, upgrade the control plane nodes one at a time:

1. **Prepare the first control plane node (proj-k8sm01)**:

   ```bash
   # Connect to node
   ssh admin@proj-k8sm01
   
   # Verify current version
   sudo rke2 --version
   
   # Create backup of config
   sudo cp -p /etc/rancher/rke2/config.yaml /etc/rancher/rke2/config.yaml.bak
   ```

2. **Update the RKE2 version**:

   ```bash
   # Install new version (replace X.Y.Z with target version)
   curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION="vX.Y.Z" sh -
   
   # Restart RKE2 service
   sudo systemctl restart rke2-server.service
   
   # Monitor logs for successful startup
   sudo journalctl -u rke2-server -f
   ```

3. **Verify node upgrade success**:

   ```bash
   # Verify server version
   sudo rke2 --version
   
   # Check node status
   kubectl get nodes -o wide
   
   # Verify all pods are running
   kubectl get pods -A -o wide | grep proj-k8sm01
   ```

4. **Repeat for remaining control plane nodes**:
   - Follow steps 1-3 for proj-k8sm02
   - Follow steps 1-3 for proj-k8sm03
   - Wait for all control plane nodes to be Ready before proceeding

#### 3.3.2 Worker Node Upgrade

After all control plane nodes have been successfully upgraded, proceed with worker nodes:

1. **Prepare for worker node upgrade**:

   ```bash
   # Cordon the first worker node to prevent new workloads
   kubectl cordon proj-k8sw01
   
   # Drain workloads (with grace period and pod eviction timeout)
   kubectl drain proj-k8sw01 --ignore-daemonsets --grace-period=120 --timeout=300s
   ```

2. **Upgrade worker node**:

   ```bash
   # Connect to worker node
   ssh admin@proj-k8sw01
   
   # Install new version (replace X.Y.Z with target version)
   curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION="vX.Y.Z" sh -
   
   # Restart RKE2 service
   sudo systemctl restart rke2-agent.service
   
   # Monitor logs for successful startup
   sudo journalctl -u rke2-agent -f
   ```

3. **Verify and uncordon node**:

   ```bash
   # Return to control node
   exit
   
   # Verify node upgrade
   kubectl get nodes -o wide | grep proj-k8sw01
   
   # Uncordon node
   kubectl uncordon proj-k8sw01
   ```

4. **Wait for node to be Ready**:

   ```bash
   # Monitor node status
   kubectl get nodes -o wide
   
   # Monitor pod status
   kubectl get pods -A -w | grep proj-k8sw01
   ```

5. **Repeat for remaining worker nodes**:
   - Follow steps 1-4 for worker nodes (proj-k8sw02, proj-k8sw03, etc.)
   - For GPU node (proj-k8sw04), follow [GPU Node Upgrade Steps](#334-gpu-node-special-considerations)

#### 3.3.3 Post-Upgrade Verification

After all nodes have been upgraded, perform these verification steps:

1. **Verify cluster health**:

   ```bash
   # Verify all nodes running correct version
   kubectl get nodes -o wide
   
   # Check component status
   kubectl get componentstatuses
   
   # Verify all pods are running
   kubectl get pods -A
   ```

2. **Test critical functionality**:

   ```bash
   # Test Traefik ingress
   curl -k https://rancher.radioastronomy.io/ping
   
   # Test pod deployment
   kubectl run test-nginx --image=nginx
   kubectl delete pod test-nginx
   ```

#### 3.3.4 GPU Node Special Considerations

The GPU node (proj-k8sw04) requires additional steps:

1. **Backup GPU workloads**:

   ```bash
   # List GPU workloads
   kubectl get pods -A -o wide | grep proj-k8sw04
   ```

2. **Update NVIDIA drivers if needed**:

   ```bash
   # Check compatibility matrix for target Kubernetes version
   # Update GPU Operator only after node upgrade is complete
   ```

3. **Follow standard worker node upgrade procedure with extended grace period**:

   ```bash
   kubectl drain proj-k8sw04 --ignore-daemonsets --grace-period=300 --timeout=600s
   ```

4. **Verify GPU functionality post-upgrade**:

   ```bash
   # Check GPU detection
   kubectl describe node proj-k8sw04 | grep nvidia.com
   
   # Verify GPU operator pods
   kubectl get pods -n gpu-operator
   ```

## 4. Management & Operations

This section covers operational procedures and troubleshooting for the upgrade process.

### 4.1 Monitoring During Upgrades

During the upgrade process, specific metrics should be monitored:

| **Metric** | **Tool** | **Expected Behavior** | **Concerning Signs** |
|------------|---------|----------------------|---------------------|
| Node Status | kubectl | Transition from NotReady to Ready | Stuck in NotReady >5 min |
| Pod Status | kubectl | Temporary disruption, then Running | Pending or CrashLoopBackOff |
| API Responsiveness | curl | <500ms response time | Timeouts or >2s response |
| etcd Health | etcdctl | All members healthy | Split brain or high latency |
| Resource Usage | Grafana | Temporary CPU spike, then normal | Sustained high CPU or memory |

### 4.2 Common Issues & Troubleshooting

| **Issue** | **Possible Cause** | **Resolution Steps** |
|-------------|-------------------|----------------------|
| Node fails to join cluster | Network issues or incorrect token | Check certificates, firewall rules, and token validity |
| Control plane pod failures | Version skew or resource constraints | Check logs with `kubectl logs -n kube-system [pod]` |
| etcd quorum lost | Multiple control plane nodes down | Restore from etcd backup, bring up one node at a time |
| Workloads fail to reschedule | Node pressure or resource constraints | Check taints, tolerations, and resource availability |
| GPU operator compatibility | Version mismatch with new K8s version | Update GPU operator after cluster upgrade complete |

### 4.3 Rollback Procedure

If critical issues are encountered that cannot be resolved within the maintenance window, follow these rollback steps:

1. **Decision Criteria for Rollback**:
   - Multiple control plane nodes in NotReady state >15 minutes
   - Critical workloads unable to schedule after upgrade
   - Data corruption detected
   - Inability to access cluster via kubectl or Rancher

2. **Control Plane Rollback**:

   ```bash
   # For each control plane node, restore previous version
   ssh admin@proj-k8sm01
   
   # Stop RKE2
   sudo systemctl stop rke2-server
   
   # Restore config
   sudo cp -p /etc/rancher/rke2/config.yaml.bak /etc/rancher/rke2/config.yaml
   
   # Restore previous version (replace X.Y.Z with previous version)
   curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION="vX.Y.Z" sh -
   
   # Start RKE2
   sudo systemctl start rke2-server
   ```

3. **Worker Node Rollback**:

   ```bash
   # For each worker node
   ssh admin@proj-k8sw01
   
   # Stop RKE2
   sudo systemctl stop rke2-agent
   
   # Install previous version
   curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION="vX.Y.Z" sh -
   
   # Start RKE2
   sudo systemctl start rke2-agent
   ```

4. **Verify Rollback Success**:

   ```bash
   # Check node versions
   kubectl get nodes -o wide
   
   # Check component status
   kubectl get componentstatuses
   ```

## 5. Security & Compliance

This section documents how security controls are implemented and how compliance requirements are met during the upgrade process.

### 5.1 Security Controls

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Change Management | Formal approval process | CR documentation review | CIS.4.3 |
| Backup Verification | Pre-upgrade snapshot testing | Snapshot restore test | CIS.10.2 |
| Configuration Validation | Post-upgrade security scan | CIS benchmark scan | CIS.4.1 |
| Access Control | Privileged access during maintenance | Access log review | CIS.5.1 |

### 5.2 CISv8.1 Compliance Mapping

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.3.4 | Automated inventory of components | Version manifest in GLPI | Compliant |
| CIS.4.3 | Documented change control process | Change ticket in GLPI | Compliant |
| CIS.10.2 | Data backup testing | Backup validation logs | Compliant |
| CIS.4.1 | Secure configuration practices | Post-upgrade scan results | Compliant |

### 5.3 Related Framework Mappings

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.3.4 | A.8.1.1 | ID.AM-1 | Automated inventory and version tracking |
| CIS.4.3 | A.12.1.2 | PR.IP-3 | Controlled change management process |
| CIS.10.2 | A.12.3.1 | PR.IP-4 | Backup and recovery testing |
| CIS.4.1 | A.14.2.2 | PR.IP-1 | Secure baseline configuration |

## 6. Backup & Recovery

This section documents data protection measures and recovery procedures specifically for the upgrade process.

### 6.1 Backup Procedure

Before any upgrade, the following backups must be taken:

| **Aspect** | **Details** |
|------------|------------|
| **Proxmox VM Snapshots** | Full VM snapshots of all RKE2 nodes using Proxmox interface |
| **etcd Backup** | Take etcd snapshot using Rancher backup or etcdctl |
| **Rancher Configuration** | Export Rancher configuration and state |
| **kubeconfig** | Backup kubeconfig file from control plane |
| **Verification Process** | Test snapshot restoration on a test VM |

### 6.2 Recovery Procedure

In case of a failed upgrade requiring full recovery:

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Control Plane Failure | 60 min | <15 min | Restore VM snapshots, verify etcd quorum | Infrastructure Team |
| Worker Node Failure | 30 min | 0 | Restore VM snapshot, rejoin cluster | Infrastructure Team |
| Full Cluster Failure | 120 min | <15 min | Restore all VMs, validate etcd data | Infrastructure Team |
| Partial Upgrade Failure | 90 min | <15 min | Roll back affected nodes, restore config | Infrastructure Team |

## 7. References & Related Resources

This section provides links to related documentation and external resources.

### 7.1 Internal References

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Procedure | Proxmox VM Backup & Restore | [Proxmox Backup Procedure](../../infrastructure/procedures/proxmox-backup-restore.md) | Required for VM snapshots |
| Configuration | RKE2 Cluster Configuration | [RKE2 Config](../../01-rke2-cluster-overview.md) | Reference configuration |
| Runbook | Disaster Recovery | [Kubernetes Recovery](../../07-backup-disaster-recovery.md) | Complete recovery options |
| Policy | Change Management | [Change Policy](../../compliance-security/change-management-policy.md) | Governance requirements |

### 7.2 External References

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| RKE2 Upgrade Documentation | [RKE2 Docs](https://docs.rke2.io/upgrade/basic_upgrade) | [Archived Copy](../../references/archived/rke2-upgrade-docs-2025-01.pdf) | 2025-04-01 |
| Kubernetes Version Skew Policy | [K8s Docs](https://kubernetes.io/docs/setup/release/version-skew-policy/) | [Archived Copy](../../references/archived/k8s-version-skew-2025-01.pdf) | 2025-04-01 |
| Rancher Version Matrix | [Rancher Docs](https://www.rancher.com/support-maintenance-terms/all-supported-versions) | [Archived Copy](../../references/archived/rancher-version-matrix-2025-01.pdf) | 2025-04-01 |
| NVIDIA Operator Compatibility | [NVIDIA Docs](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/platform-support.html) | [Archived Copy](../../references/archived/nvidia-compat-2025-01.pdf) | 2025-03-15 |

### 7.3 Change Request References

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-2025-068 | RKE2 v1.27 to v1.28 upgrade | 2025-02-18 | [GLPI-1268](http://glpi.lab/ticket/1268) |
| CR-2025-042 | RKE2 v1.26 to v1.27 upgrade | 2024-11-12 | [GLPI-1042](http://glpi.lab/ticket/1042) |
| CR-2024-156 | RKE2 v1.25 to v1.26 upgrade | 2024-07-28 | [GLPI-956](http://glpi.lab/ticket/956) |

## 8. Approval & Review

This section documents the formal review and approval process for this document.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |
| SecurityAdmin | Security Officer | 2025-04-20 | ✅ Approved |
| OpsManager | Operations Manager | 2025-04-19 | ✅ Approved |

## 9. Change Log

This section tracks the document's revision history.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial version | VintageDon |
