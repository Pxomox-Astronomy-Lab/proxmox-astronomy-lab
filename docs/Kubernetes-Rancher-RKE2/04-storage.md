<!-- 
---
title: "Storage Configuration in RKE2 Kubernetes Cluster"
description: "Comprehensive documentation of storage architecture, persistent volume configuration, and data management in the Proxmox Astronomy Lab's Kubernetes cluster"
author: "VintageDon"
tags: ["kubernetes", "rke2", "storage", "persistent-volumes", "storage-classes", "infrastructure", "phase-3"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "Storage Infrastructure", "Persistent Storage", "Data Management"]
implements_policies: ["Infrastructure Security Policy", "Data Management Policy", "Backup & Recovery Policy"]
phase: "phase-3"
cis_controls: ["CIS.3.11", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.8.2.3", "A.12.3.1", "A.17.2.1"]
nist_controls: ["CP-9", "CP-10", "SC-28"]
---
-->

# Storage Configuration in RKE2 Kubernetes Cluster

This document provides comprehensive information about the storage architecture and configuration implemented in the RKE2 Kubernetes cluster within the Proxmox Astronomy Lab. It details the storage classes, persistent volumes, data management practices, and backup procedures for the containerized workloads running in the cluster.

# 1. Overview

This section establishes the foundational context for the Kubernetes storage architecture, explaining its purpose within the broader infrastructure and how it supports application data persistence and scientific data management in the Proxmox Astronomy Lab.

## 1.1 Purpose

This subsection clearly defines why the storage configuration exists, what problems it addresses, and what value it delivers to the organization and its research activities.

The Kubernetes storage infrastructure provides resilient, high-performance storage solutions for containerized applications in the Proxmox Astronomy Lab. It ensures data persistence for stateful applications, efficient storage for AI/ML models and datasets, and reliable storage for radio astronomy observations and processed results. The storage architecture is designed to balance performance, reliability, and capacity to meet the diverse needs of research workloads.

## 1.2 Scope

This subsection defines the boundaries of what this document covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Storage Classes configuration | Physical storage hardware details |
| Persistent Volume management | VM-level storage configuration |
| Local node storage | SAN/NAS integration details |
| Volume snapshot capabilities | Filesystem-level tuning |
| Storage resource quotas | Block-level encryption |
| Backup integration | External backup architecture |

The table above provides a clear delineation between included and excluded topics to prevent misunderstandings about document coverage.

## 1.3 Target Audience

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

- **Primary**: Infrastructure administrators and storage engineers managing the Kubernetes storage
- **Secondary**: DevOps engineers deploying applications that require persistent storage
- **Tertiary**: Data scientists and researchers working with large datasets
- **Expected Knowledge**: Basic understanding of Kubernetes concepts, storage principles, and data management

# 2. Dependencies & Relationships

This section maps how the storage configuration relates to other elements within the environment, capturing both upstream and downstream dependencies. These relationships form the basis for impact analysis and service maps.

## 2.1 Related Services

This subsection identifies other services that interact with the storage configuration, establishing the service ecosystem and integration points.

This document **relates to**:

- [RKE2 Cluster Overview](01-rke2-cluster-overview.md) - The underlying Kubernetes platform
- [Node Configuration](02-node-configuration.md) - The base VM storage allocation
- [Backup & Recovery](07-backup-disaster-recovery.md) - Backup procedures for persistent volumes
- [Database Services](../applications/databases/README.md) - Applications requiring persistent storage
- [AI/ML Platforms](../applications/ai-ml-platforms/README.md) - Applications requiring large dataset storage

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## 2.2 Implements Policies

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

This document **implements**:

- [Data Management Policy](../compliance-security/policies/data-management-policy.md) - Through structured storage provisioning and isolation
- [Backup & Recovery Policy](../compliance-security/policies/backup-recovery-policy.md) - Through volume snapshot and backup procedures
- [Data Classification Policy](../compliance-security/policies/data-classification-policy.md) - Through segregated storage for different data types

The list above shows how this document contributes to organizational compliance and governance objectives.

## 2.3 Responsibility Matrix

This subsection defines accountabilities and responsibilities for key activities related to the storage configuration, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure Admin** | **Storage Admin** | **Application Owner** | **Data Scientist** |
|--------------|-------------------|-------------------|--------------|----------------|
| StorageClass Management | R/A | C | I | I |
| PV Provisioning | R/A | C | I | I |
| Capacity Planning | R/A | C | C | C |
| Performance Monitoring | R/A | C | I | I |
| Snapshot Management | R/A | C | I | I |
| Data Restoration | C | R/A | C | I |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 3. Technical Documentation

This section provides the technical details necessary for understanding, managing, and troubleshooting the storage configuration. It serves as the authoritative technical reference for the Kubernetes storage architecture.

## 3.1 Architecture & Components

This subsection explains the technical architecture, component relationships, and design decisions that shape the storage configuration implementation.

The RKE2 cluster storage architecture is built around local NVMe storage on worker nodes, configured as static Persistent Volumes (PVs) with various StorageClasses for different workload types. This architecture provides high-performance local storage for IO-intensive applications while ensuring data isolation between workloads.

Key components include:

- **Local Storage Provisioner**: Uses the `kubernetes.io/no-provisioner` to manage local volumes
- **Storage Classes**: Defined for specific workload types (ollama, openwebui, observatory, etc.)
- **Persistent Volumes**: Static PVs defined on each worker node, mapped to specific directories
- **Volume Binding Mode**: WaitForFirstConsumer to ensure pod and volume co-location
- **Resource Quotas**: Namespace-level storage limits to prevent resource contention
- **Backup Integration**: Proxmox Backup Server for volume snapshots and backups

The storage layout is as follows:

- **Worker Nodes (01-03)**: Each has 1TB NVMe storage allocated for PVs
- **GPU Node (04)**: 1.8TB NVMe storage for AI/ML workloads and model storage
- **Storage Node (05)**: 1TB NVMe storage plus access to ZFS storage pool

This architecture ensures high-performance storage for IO-intensive workloads while maintaining data isolation and security. Local storage was chosen over networked storage for performance reasons, with proper backup mechanisms in place to ensure data durability.

## 3.2 Configuration Details

This subsection provides specific configuration parameters, file locations, and settings required for understanding and managing the storage configuration.

The Kubernetes storage components are configured through a combination of StorageClass definitions, Persistent Volume manifests, and namespace resource quotas. Key configuration details include:

**Storage Classes Configuration**

```yaml
# infrastructure/k8s-rancher-rke2/manifests/storage-classes.yaml

apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-ollama
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Retain

---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-openwebui
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Retain

---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-observatory
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Retain

# Additional storage classes for other workloads...
```

**Persistent Volume Configuration**

```yaml
# infrastructure/k8s-rancher-rke2/manifests/persistent-volumes.yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv-k8sw01
spec:
  capacity:
    storage: 950Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-shared
  local:
    path: /mnt/data
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - proj-k8sw01

# Similar configurations for each worker node...

apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv-k8sw04-gpu
spec:
  capacity:
    storage: 1800Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-gpu
  local:
    path: /mnt/data
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - proj-k8sw04
```

**Namespace Resource Quotas**

```yaml
# Applied to each namespace

apiVersion: v1
kind: ResourceQuota
metadata:
  name: storage-quota
spec:
  hard:
    requests.storage: 500Gi
    persistentvolumeclaims: 10
```

**Storage Directory Preparation on Nodes**

```bash
# Executed on each worker node during setup

# Create storage directory
mkdir -p /mnt/data

# Set permissions
chmod 755 /mnt/data
chown 1000:1000 /mnt/data

# Add to fstab (if separate partition)
echo "UUID=<disk-uuid> /mnt/data ext4 defaults 0 2" >> /etc/fstab
```

## 3.3 Implementation Steps

This subsection provides a high-level sequential procedure for understanding how the storage configuration was implemented, including verification steps and expected outcomes.

The storage infrastructure was implemented following this sequence:

1. **Storage Preparation on Nodes**
   - Created storage directories on each worker node:

     ```bash
     ssh proj-k8sw01 "mkdir -p /mnt/data && chmod 755 /mnt/data"
     ssh proj-k8sw02 "mkdir -p /mnt/data && chmod 755 /mnt/data"
     ssh proj-k8sw03 "mkdir -p /mnt/data && chmod 755 /mnt/data"
     ssh proj-k8sw04 "mkdir -p /mnt/data && chmod 755 /mnt/data"
     ssh proj-k8sw05 "mkdir -p /mnt/data && chmod 755 /mnt/data"
     ```

   - Verified storage availability and permissions

2. **Storage Class Definition**
   - Created StorageClass manifests for various workload types:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/storage-classes.yaml
     ```

   - Verified StorageClass creation:

     ```bash
     kubectl get storageclass
     ```

3. **Persistent Volume Creation**
   - Deployed PV manifests for each node:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/persistent-volumes.yaml
     ```

   - Verified PV creation and status:

     ```bash
     kubectl get pv -o wide
     ```

4. **Resource Quota Implementation**
   - Applied storage quotas to each namespace:

     ```bash
     for ns in ollama openwebui observatory-core data-pipeline monitoring; do
       kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/storage-quota.yaml -n $ns
     done
     ```

   - Verified quota application:

     ```bash
     kubectl get resourcequota -A
     ```

5. **Validation Testing**
   - Created test PVCs in each namespace
   - Deployed test pods to verify storage functionality
   - Performed IO benchmarks to establish baseline performance

Each step included validation testing to ensure proper functionality before proceeding to the next phase.

# 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for the storage configuration. It provides the practical guidance needed for ongoing maintenance and support.

## 4.1 Routine Procedures

This subsection documents regular maintenance and operational tasks required to keep the storage infrastructure functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Storage Capacity Monitoring | Daily | Infrastructure Admin | Automated Liongard change detection alert via email to <alerts@radioastronomy.io> (monitored by GLPI) |
| Volume Health Check | Weekly | Infrastructure Admin | [Volume Health Check Procedure](../procedures/volume-health-check.md) |
| Storage Performance Analysis | Monthly | Infrastructure Admin | [Storage Performance Analysis](../procedures/storage-performance-analysis.md) |
| PV Cleanup of Unused Volumes | Monthly | Infrastructure Admin | [PV Cleanup Procedure](../procedures/pv-cleanup.md) |
| Backup Validation | Every 90 days | Infrastructure Admin | [Backup Validation Procedure](../procedures/backup-validation.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and performance, along with their required cadence.

## 4.2 Troubleshooting

This subsection provides guidance for identifying and resolving common issues with the storage configuration, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| PVC stuck in "Pending" state | Volume binding issue or capacity constraints | Check available PVs, verify StorageClass, check for resource quotas | [PVC Troubleshooting](../troubleshooting/pvc-pending-issues.md) |
| Pod can't mount volume | Permission issues or node failure | Check node status, verify volume exists, check mount permissions | [Volume Mount Issues](../troubleshooting/volume-mount-issues.md) |
| Storage performance degradation | Disk contention or filesystem fragmentation | Run IO tests, check node resource utilization, verify no disk errors | [Storage Performance Issues](../troubleshooting/storage-performance.md) |
| Volume full error | Insufficient capacity planning | Add capacity if possible, clean up unused data, adjust resource quotas | [Volume Capacity Issues](../troubleshooting/volume-capacity.md) |
| Data loss or corruption | Filesystem errors or application bugs | Restore from backup, run filesystem checks, verify application behavior | [Data Recovery Procedure](../troubleshooting/data-recovery.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## 4.3 Monitoring & Metrics

This subsection defines what aspects of the storage configuration should be monitored, normal operating parameters, alert thresholds, and how to access monitoring dashboards.

The storage resources are monitored using Prometheus and Grafana deployed on lab-mon01. Key metrics and monitoring parameters include:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| PV Capacity Utilization | 0-80% | >90% for >1 hour | [PV Capacity Dashboard](http://grafana.lab.internal/d/storage-capacity) |
| IO Operations/Sec | 0-5000 IOPS | >10000 IOPS for >30 min | [Storage IO Dashboard](http://grafana.lab.internal/d/storage-io) |
| IO Latency | <5ms | >20ms for >15 min | [Storage Latency Dashboard](http://grafana.lab.internal/d/storage-latency) |
| Kubelet Volume Mounts | Stable count | Any unexpected changes | [Volume Mount Dashboard](http://grafana.lab.internal/d/volume-mounts) |
| Filesystem Errors | 0 | Any non-zero value | [Storage Errors Dashboard](http://grafana.lab.internal/d/storage-errors) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure storage health and performance.

Additionally, the following storage-specific metrics are collected:

- Storage throughput per workload
- Top consuming applications
- Volume snapshot status
- Node disk health status
- Backup job completion status

# 5. Security & Compliance

This section documents how security controls are implemented in the storage configuration and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

The RKE2 cluster storage infrastructure is secured according to security best practices with a focus on data protection, access control, and encryption. The implementation aligns with CIS Kubernetes Security Benchmark recommendations and the organizational Data Management Policy.

## 5.1 Security Controls

This subsection documents specific security measures implemented in the storage configuration, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Access Control | PV access mode restrictions, namespace isolation | Review PV/PVC manifests, test cross-namespace access | CIS.5.7, NIST AC-3 |
| Data Protection | System volumes LUKS encrypted, reclaim policies | Verify encryption status, review PV configurations | CIS.10.2, NIST SC-28 |
| Backup & Recovery | Automated backups, validated restore process | Test restore procedures, verify backup integrity | CIS.10.1, NIST CP-9 |
| Resource Protection | Storage quotas, limits on PVC counts | Review ResourceQuota objects, test enforcement | CIS.5.4, NIST SC-6 |
| Secrets Management | Separation of credentials from storage configuration | Audit manifests for secrets, review secret usage | CIS.5.1, NIST SC-12 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps storage configuration implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.3.11 | Encrypt data on end-user devices | System volumes LUKS encrypted | Compliant |
| CIS.10.1 | Ensure regular automated backups | Scheduled PV backups | Compliant |
| CIS.10.2 | Perform recovery tests | 90-day restore testing | Compliant |
| CIS.13.6 | Collect detailed audit logs | Volume access monitoring | Compliant |
| CIS.16.4 | Establish and maintain a data recovery capability | Backup procedures and testing | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## 5.3 Related Framework Mappings

This subsection shows how controls map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.3.11 | A.8.2.3 | PR.DS-1 | System volumes LUKS encrypted |
| CIS.10.1 | A.12.3.1 | PR.IP-4 | Scheduled PV backups |
| CIS.10.2 | A.17.2.1 | RC.RP-1 | 90-day restore testing |
| CIS.13.6 | A.12.4.1 | PR.PT-1 | Volume access monitoring |
| CIS.16.4 | A.17.1.2 | RC.CO-3 | Backup procedures and testing |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 5.4 Risk Assessment

This subsection documents identified security risks, implemented mitigations, and any accepted residual risk associated with the storage configuration.

The storage infrastructure has undergone a security risk assessment to identify potential vulnerabilities and apply appropriate mitigations:

1. **Risk**: Unauthorized access to persistent volume data
   - **Mitigation**: Namespace isolation, RBAC controls, volume permissions
   - **Residual Risk**: Low - Limited to potential privilege escalation vulnerabilities

2. **Risk**: Data loss due to node failure
   - **Mitigation**: Regular backups, tested recovery procedures
   - **Residual Risk**: Low - Some data loss possible between backup intervals

3. **Risk**: Data exfiltration via compromised container
   - **Mitigation**: Network policies, restricted container capabilities, volume mount controls
   - **Residual Risk**: Medium - Advanced attackers may find alternate exfiltration paths

4. **Risk**: Encryption key management for system volumes
   - **Mitigation**: Secure key management, limited access to encryption keys
   - **Residual Risk**: Low - Keys protected by multiple security layers

These risks are actively managed through continuous monitoring, regular security scanning, and timely updates to all storage-related components.

# 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures for the storage configuration. It provides the guidance needed to ensure business continuity and disaster recovery capabilities.

## 6.1 Backup Procedure

This subsection details how data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Persistent Volumes: Daily at 03:00 UTC, Configuration: Daily at 01:00 UTC |
| **Backup Method** | PVs: Proxmox Backup Server, Configurations: GitOps repository |
| **Retention Policy** | 7 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | Primary: proj-pg01:/backup, Secondary: S3 Glacier Deep Archive |
| **Verification Process** | Every 90 days test restoration to validate backups |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

Storage-specific considerations:

- Backups are performed at the node level to capture all PV data
- Application-consistent backups are coordinated with stateful applications
- Critical data is prioritized in the backup schedule
- Separate backup streams for configuration and data

## 6.2 Recovery Procedure

This subsection provides recovery steps for various failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Single PV corruption | 30 minutes | 24 hours | Restore PV from backup, reconnect to application | Infrastructure Admin |
| Node storage failure | 60 minutes | 24 hours | Rebuild node storage, restore PVs from backup | Infrastructure Admin |
| StorageClass configuration error | 15 minutes | 0 data loss | Restore configuration from Git, reapply | Infrastructure Admin |
| Complete storage system failure | 4 hours | 24 hours | Restore node storage, recover PVs, verify applications | Infrastructure Admin |
| Application data corruption | 45 minutes | Varies by application | Application-specific recovery, potential point-in-time restore | Infrastructure Admin |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

# 7. References & Related Resources

This section provides links to related documentation and external resources. It establishes the connections between this document and other knowledge sources both internal and external.

## 7.1 Internal References

This subsection identifies other internal documents related to the storage configuration, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Architecture | RKE2 Cluster Overview | [01-rke2-cluster-overview.md](01-rke2-cluster-overview.md) | Parent architecture |
| Technical | Node Configuration | [02-node-configuration.md](02-node-configuration.md) | Base VM storage allocation |
| Technical | Backup & Recovery | [07-backup-disaster-recovery.md](07-backup-disaster-recovery.md) | Backup procedures |
| Operational | Volume Health Check | [../procedures/volume-health-check.md](../procedures/volume-health-check.md) | Maintenance procedure |
| Operational | Storage Performance Analysis | [../procedures/storage-performance-analysis.md](../procedures/storage-performance-analysis.md) | Performance monitoring |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## 7.2 External References

This subsection provides links to external resources that provide additional context, technical details, or supporting information for the storage configuration.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Kubernetes Storage | <https://kubernetes.io/docs/concepts/storage/> | [k8s-storage-docs-2025-04.pdf](../archive/k8s-storage-docs-2025-04.pdf) | 2025-04-01 |
| Local PV Documentation | <https://kubernetes.io/docs/concepts/storage/volumes/#local> | [k8s-local-pv-docs-2025-04.pdf](../archive/k8s-local-pv-docs-2025-04.pdf) | 2025-04-01 |
| StorageClass Reference | <https://kubernetes.io/docs/concepts/storage/storage-classes/> | [k8s-storageclass-docs-2025-04.pdf](../archive/k8s-storageclass-docs-2025-04.pdf) | 2025-04-01 |
| Volume Snapshots | <https://kubernetes.io/docs/concepts/storage/volume-snapshots/> | [k8s-snapshots-docs-2025-03.pdf](../archive/k8s-snapshots-docs-2025-03.pdf) | 2025-03-15 |
| Resource Quotas | <https://kubernetes.io/docs/concepts/policy/resource-quotas/> | [k8s-quotas-docs-2025-03.pdf](../archive/k8s-quotas-docs-2025-03.pdf) | 2025-03-20 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## 7.3 Change Request References

This subsection documents formal change requests that have modified the storage configuration, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** |
|--------------|----------------|------------------------|
| CR-2025-042 | Initial RKE2 cluster deployment | 2025-04-10 |
| CR-2025-051 | Implemented storage classes | 2025-04-18 |
| CR-2025-052 | Created persistent volumes | 2025-04-18 |
| CR-2025-053 | Implemented resource quotas | 2025-04-19 |

The change request table above tracks formal changes that have affected the storage configuration, supporting troubleshooting and audit activities.

# 8. Approval & Review

This section documents the formal review and approval process for the storage configuration documentation. It ensures accountability and tracks who has verified the accuracy of the content.

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
