<!-- 
---
title: "Backup & Disaster Recovery in RKE2 Kubernetes Cluster"
description: "Comprehensive documentation of backup procedures, recovery strategies, and business continuity planning for the Proxmox Astronomy Lab's RKE2 Kubernetes cluster"
author: "VintageDon"
tags: ["kubernetes", "rke2", "backup", "disaster-recovery", "business-continuity", "infrastructure", "phase-3"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "Backup", "Disaster Recovery", "Business Continuity"]
implements_policies: ["Backup & Recovery Policy", "Business Continuity Policy", "Data Protection Policy"]
phase: "phase-3"
cis_controls: ["CIS.10.1", "CIS.10.2", "CIS.10.5"]
iso27001_controls: ["A.12.3.1", "A.17.1.1", "A.17.2.1"]
nist_controls: ["CP-9", "CP-10", "AU-11"]
---
-->

# Backup & Disaster Recovery in RKE2 Kubernetes Cluster

This document provides comprehensive information about the backup procedures, disaster recovery strategies, and business continuity planning implemented for the RKE2 Kubernetes cluster within the Proxmox Astronomy Lab. It details the technical approaches, operational procedures, and recovery methodologies that ensure system resilience and data protection.

# 1. Overview

This section establishes the foundational context for the Kubernetes backup and disaster recovery architecture, explaining the resilience principles, recovery objectives, and continuity strategies that drive the implementation in the Proxmox Astronomy Lab.

## 1.1 Purpose

This subsection clearly defines why backup and disaster recovery procedures exist, what problems they address, and what value they deliver to the organization and its research activities.

The RKE2 cluster backup and disaster recovery framework provides comprehensive data protection, system resilience, and operational continuity for the Kubernetes infrastructure and applications. It ensures that critical research data and systems can be restored in the event of failures, corruption, or disasters, minimizing potential downtime and data loss while maintaining the integrity of the lab's scientific output and infrastructure.

## 1.2 Scope

This subsection defines the boundaries of what this document covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Kubernetes cluster backup procedures | Physical facility disaster recovery |
| Etcd data protection | Business impact analysis |
| Persistent volume backup strategy | Detailed application recovery |
| Recovery time and point objectives | Financial continuity planning |
| Disaster recovery procedures | External system integrations |
| Recovery testing methodology | Specific application data backup details |

The table above provides a clear delineation between included and excluded topics to prevent misunderstandings about document coverage.

## 1.3 Target Audience

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

- **Primary**: Infrastructure administrators and disaster recovery specialists
- **Secondary**: Application owners and DevOps engineers
- **Tertiary**: Business continuity planners and compliance officers
- **Expected Knowledge**: Basic understanding of Kubernetes architecture, backup concepts, and disaster recovery principles

# 2. Dependencies & Relationships

This section maps how the backup and disaster recovery configuration relates to other elements within the environment, capturing both upstream and downstream dependencies. These relationships form the basis for impact analysis and service maps.

## 2.1 Related Services

This subsection identifies other services that interact with the backup and disaster recovery configuration, establishing the service ecosystem and integration points.

This document **relates to**:

- [RKE2 Cluster Overview](01-rke2-cluster-overview.md) - The overall Kubernetes architecture
- [Node Configuration](02-node-configuration.md) - VM-level recovery considerations
- [Storage Configuration](04-storage.md) - Persistent volume backup strategy
- [Proxmox Backup Server](../infrastructure/proxmox-backup-server.md) - Underlying backup infrastructure
- [S3 Storage Gateway](../infrastructure/s3-storage-gateway.md) - Offsite backup repository

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## 2.2 Implements Policies

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

This document **implements**:

- [Backup & Recovery Policy](../compliance-security/policies/backup-recovery-policy.md) - Through structured backup procedures
- [Business Continuity Policy](../compliance-security/policies/business-continuity-policy.md) - Through disaster recovery planning
- [Data Protection Policy](../compliance-security/policies/data-protection-policy.md) - Through data preservation strategies

The list above shows how this document contributes to organizational compliance and governance objectives.

## 2.3 Responsibility Matrix

This subsection defines accountabilities and responsibilities for key activities related to the backup and disaster recovery configuration, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure Admin** | **Storage Admin** | **Application Owner** | **Compliance Officer** |
|--------------|-------------------|-------------------|--------------|----------------|
| Backup Execution | R/A | C | I | I |
| Backup Verification | R/A | C | C | I |
| Recovery Testing | R/A | C | C | I |
| Disaster Recovery Planning | R/A | C | C | C |
| Recovery Execution | R/A | C | C | I |
| Recovery Validation | R/A | C | R | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 3. Technical Documentation

This section provides the technical details necessary for understanding, managing, and troubleshooting the backup and disaster recovery configuration. It serves as the authoritative technical reference for the Kubernetes resilience architecture.

## 3.1 Architecture & Components

This subsection explains the technical architecture, component relationships, and design decisions that shape the backup and disaster recovery implementation.

The RKE2 Kubernetes cluster backup and disaster recovery architecture employs a multi-layered approach that protects different components of the infrastructure at appropriate levels. The architecture ensures comprehensive protection of both the control plane state and application data, with multiple backup destinations and recovery options.

The backup architecture includes:

**Control Plane Backup**:

- Etcd snapshot backups for Kubernetes state
- Configuration backups for RKE2 settings
- Certificate backups for security components

**Node-Level Backup**:

- Proxmox VM-level snapshots for complete node recovery
- System-level backups for node configurations
- Differential backups to reduce storage consumption

**Application Data Backup**:

- Persistent volume snapshots for application data
- Storage class-specific backup procedures
- Application-consistent backup coordination

**Backup Storage Tiers**:

- Primary: Local storage on proj-pg01:/backup
- Secondary: S3 Glacier Deep Archive for long-term retention
- Tertiary: Immutable backup copies for security-critical data

**Recovery Components**:

- Documented recovery procedures for various failure scenarios
- Recovery testing framework for validation
- Automated recovery scripts for common scenarios

This architecture ensures that all critical components of the Kubernetes infrastructure are protected with appropriate backup strategies, storage technologies, and recovery procedures to meet the lab's resilience requirements.

## 3.2 Configuration Details

This subsection provides specific configuration parameters, file locations, and settings required for understanding and managing the backup and disaster recovery configuration.

The backup and disaster recovery components are configured through a combination of RKE2 settings, Kubernetes resources, and infrastructure tools. Key configuration details include:

**Etcd Snapshot Configuration**

```yaml
# /etc/rancher/rke2/config.yaml (Control Plane Nodes)
etcd-snapshot-dir: /var/lib/rancher/rke2/server/db/snapshots
etcd-snapshot-schedule-cron: "0 */6 * * *"  # Every 6 hours
etcd-snapshot-retention: 10                  # Keep 10 snapshots
etcd-s3: true                               # Enable S3 backup
etcd-s3-endpoint: s3.internal:9000          # S3 endpoint
etcd-s3-bucket: rke2-etcd-backups           # S3 bucket
etcd-s3-folder: cluster1                    # S3 folder
```

**Persistent Volume Backup Configuration**

```yaml
# infrastructure/k8s-rancher-rke2/backup/volume-snapshot-class.yaml
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshotClass
metadata:
  name: local-snapshot-class
driver: kubernetes.io/no-provisioner
deletionPolicy: Retain
parameters:
  snapshot-path: /var/lib/rancher/rke2/storage/snapshots
```

**Volume Snapshot Schedule**

```yaml
# infrastructure/k8s-rancher-rke2/backup/volume-snapshot-schedule.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: volume-snapshot
  namespace: backup-system
spec:
  schedule: "0 1 * * *"  # Daily at 1 AM
  jobTemplate:
    spec:
      template:
        spec:
          serviceAccountName: volume-snapshot-sa
          containers:
          - name: volume-snapshot
            image: rancher/kubectl:v1.23.6
            command:
            - /bin/sh
            - -c
            - |
              kubectl get pvc --all-namespaces -l backup=enabled -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name --no-headers | while read ns pvc; do
                snapshot_name="$pvc-$(date +%Y%m%d)"
                kubectl create -n $ns VolumeSnapshot $snapshot_name --source-pvc=$pvc --snapshot-class=local-snapshot-class
              done
          restartPolicy: OnFailure
```

**Proxmox Backup Server Integration**

```bash
# PBS Client configuration (for VM-level backups)
# /etc/proxmox-backup/config.yaml
repository: pbs@pbs.internal:backup
```

**S3 Gateway Configuration for Offsite Backup**

```yaml
# infrastructure/s3-gateway/config.yaml
address: :9000
region: us-east-1
credentials:
  accessKey: <redacted>
  secretKey: <redacted>
storage:
  backend: s3
  bucketName: lab-backups
  region: us-east-1
```

**Recovery Testing Framework**

```yaml
# infrastructure/k8s-rancher-rke2/backup/recovery-test.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: recovery-test
  namespace: backup-system
spec:
  template:
    spec:
      serviceAccountName: recovery-test-sa
      containers:
      - name: recovery-test
        image: rancher/kubectl:v1.23.6
        command:
        - /bin/sh
        - -c
        - /scripts/recovery-test.sh
        volumeMounts:
        - name: recovery-scripts
          mountPath: /scripts
      volumes:
      - name: recovery-scripts
        configMap:
          name: recovery-scripts
      restartPolicy: Never
```

## 3.3 Implementation Steps

This subsection provides a high-level sequential procedure for understanding how the backup and disaster recovery configuration was implemented, including verification steps and expected outcomes.

The backup and disaster recovery framework was implemented following this sequence:

1. **Etcd Backup Configuration**
   - Configured etcd snapshot backups on all control plane nodes:

     ```bash
     # Edit RKE2 configuration on control plane nodes
     vim /etc/rancher/rke2/config.yaml
     # Add etcd snapshot configuration
     systemctl restart rke2-server.service
     ```

   - Verified snapshot generation:

     ```bash
     # Check for snapshot files
     ls -la /var/lib/rancher/rke2/server/db/snapshots
     ```

   - Configured S3 backup for etcd snapshots:

     ```bash
     # Add S3 configuration to RKE2 config
     vim /etc/rancher/rke2/config.yaml
     # Restart RKE2 server
     systemctl restart rke2-server.service
     ```

2. **Persistent Volume Backup Implementation**
   - Created the volume snapshot CRDs:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/snapshot-crds.yaml
     ```

   - Deployed the snapshot controller:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/snapshot-controller.yaml
     ```

   - Created the volume snapshot class:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/volume-snapshot-class.yaml
     ```

   - Deployed the snapshot scheduling system:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/volume-snapshot-schedule.yaml
     ```

   - Verified PV snapshot functionality:

     ```bash
     # Create a test snapshot
     kubectl create -n test VolumeSnapshot test-snapshot --source-pvc=test-pvc --snapshot-class=local-snapshot-class
     # Verify snapshot creation
     kubectl get volumesnapshot -n test
     ```

3. **Proxmox Backup Server Integration**
   - Configured Proxmox Backup Server (PBS) on Node05:

     ```bash
     # Install PBS
     apt install proxmox-backup-server
     # Configure PBS
     proxmox-backup-manager config set admin@pam --password <redacted>
     ```

   - Created backup datastore:

     ```bash
     proxmox-backup-manager datastore create local /mnt/pbs
     ```

   - Configured PBS clients on all nodes:

     ```bash
     apt install proxmox-backup-client
     proxmox-backup-client config create pbs.internal:8007 backup-user@pam <redacted>
     ```

   - Set up backup jobs in Proxmox for all VMs:

     ```bash
     # Add to VM configuration
     backup: 1
     backup-retention: 7d,4w,3m
     ```

4. **S3 Gateway Setup for Offsite Backup**
   - Deployed S3 gateway container:

     ```bash
     docker run -d --name s3-gateway \
       -p 9000:9000 \
       -v /etc/s3-gateway:/config \
       s3-gateway:latest
     ```

   - Configured offsite backup destinations:

     ```bash
     # Configure S3 client
     s3cmd --configure
     # Test connectivity
     s3cmd ls s3://lab-backups
     ```

   - Created backup scripts for offsite replication:

     ```bash
     # Deploy backup scripts
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/offsite-backup-scripts.yaml
     ```

5. **Recovery Testing Framework**
   - Deployed recovery testing infrastructure:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/recovery-test-rbac.yaml
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/recovery-scripts-cm.yaml
     kubectl apply -f infrastructure/k8s-rancher-rke2/backup/recovery-test.yaml
     ```

   - Conducted initial recovery testing:

     ```bash
     # Run recovery test
     kubectl create job --from=cronjob/recovery-test recovery-test-manual
     # Check results
     kubectl logs job/recovery-test-manual
     ```

Each step included validation testing to ensure proper functionality before proceeding to the next phase.

# 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for the backup and disaster recovery configuration. It provides the practical guidance needed for ongoing maintenance and support.

## 4.1 Routine Procedures

This subsection documents regular maintenance and operational tasks required to keep the backup and disaster recovery infrastructure functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Backup Verification | Weekly | Infrastructure Admin | [Backup Verification Procedure](../procedures/backup-verification.md) |
| Restore Testing | Every 90 days | Infrastructure Admin | [Restore Testing Procedure](../procedures/restore-testing.md) |
| Offsite Backup Validation | Monthly | Infrastructure Admin | [Offsite Backup Validation](../procedures/offsite-backup-validation.md) |
| Snapshot Management | Monthly | Infrastructure Admin | [Snapshot Management Procedure](../procedures/snapshot-management.md) |
| Backup Capacity Planning | Quarterly | Infrastructure Admin | Automated Liongard change detection alert via email to <alerts@radioastronomy.io> (monitored by GLPI) |

The table above outlines routine procedures that must be performed to maintain operational stability and recoverability, along with their required cadence.

## 4.2 Troubleshooting

This subsection provides guidance for identifying and resolving common issues with the backup and disaster recovery configuration, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Failed etcd snapshot | Disk space, permissions, etcd health | Check disk space, verify etcd health, check snapshot folder permissions | [Etcd Snapshot Troubleshooting](../troubleshooting/etcd-snapshot-issues.md) |
| Volume snapshot failure | Storage class issues, resource limits | Verify snapshot class configuration, check resource availability | [Volume Snapshot Troubleshooting](../troubleshooting/volume-snapshot-issues.md) |
| S3 backup failure | Network, authentication, bucket permissions | Check network connectivity, verify credentials, check bucket permissions | [S3 Backup Troubleshooting](../troubleshooting/s3-backup-issues.md) |
| Proxmox backup job failure | VM state, storage space, PBS connectivity | Check PBS connection, verify storage availability, review job parameters | [Proxmox Backup Troubleshooting](../troubleshooting/proxmox-backup-issues.md) |
| Restore failure | Backup integrity, version compatibility | Verify backup integrity, ensure version compatibility, check dependent components | [Restore Troubleshooting](../troubleshooting/restore-issues.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## 4.3 Monitoring & Metrics

This subsection defines what aspects of the backup and disaster recovery configuration should be monitored, normal operating parameters, alert thresholds, and how to access monitoring dashboards.

The backup and disaster recovery infrastructure is monitored using Prometheus and Grafana deployed on lab-mon01. Key metrics and monitoring parameters include:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| Backup Success Rate | 100% | <100% for >24 hours | [Backup Success Dashboard](http://grafana.lab.internal/d/backup-success) |
| Backup Storage Utilization | 0-80% | >90% | [Backup Storage Dashboard](http://grafana.lab.internal/d/backup-storage) |
| Backup Job Duration | 0-30 minutes | >45 minutes | [Backup Performance Dashboard](http://grafana.lab.internal/d/backup-performance) |
| Snapshot Retention Compliance | 100% | <100% | [Snapshot Retention Dashboard](http://grafana.lab.internal/d/snapshot-retention) |
| Restore Test Success Rate | 100% | <100% | [Restore Testing Dashboard](http://grafana.lab.internal/d/restore-testing) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure backup and recovery health and compliance.

Additionally, the following backup-specific metrics are collected:

- Time since last successful backup by type
- Backup size trends over time
- Restore simulation times
- Offsite replication status
- Backup data integrity verification results

# 5. Security & Compliance

This section documents how security controls are implemented in the backup and disaster recovery configuration and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

## 5.1 Security Controls

This subsection documents specific security measures implemented in the backup and disaster recovery configuration, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Backup Encryption | Encrypted backups at rest and in transit | Encryption verification testing | CIS.10.1, NIST CP-9 |
| Access Control | RBAC for backup operations, PBS authentication | Access control testing, log review | CIS.16.1, NIST AC-3 |
| Data Protection | Immutable backups, versioning | Backup modification testing | CIS.10.5, NIST CP-9 |
| Backup Integrity | Checksums, validation procedures | Integrity verification testing | CIS.10.2, NIST CP-9 |
| Secure Transport | TLS for all backup transfers | Network capture verification | CIS.14.4, NIST SC-8 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps backup and disaster recovery implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.10.1 | Automated backup schedules, offsite replication | Backup job configurations, S3 gateway logs | Compliant |
| CIS.10.2 | Regular recovery testing, validation procedures | Recovery test results, test schedule | Compliant |
| CIS.10.5 | Encryption of backups in transit and at rest | Encryption configuration, security scan results | Compliant |
| CIS.11.2 | Secure backup authentication and authorization | RBAC configurations, PBS authentication logs | Compliant |
| CIS.11.5 | Offsite backup storage separate from production | S3 gateway configuration, replication logs | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## 5.3 Related Framework Mappings

This subsection shows how controls map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.10.1 | A.12.3.1 | PR.IP-4 | Automated backup schedules, offsite replication |
| CIS.10.2 | A.17.2.1 | RC.RP-1 | Regular recovery testing, validation procedures |
| CIS.10.5 | A.8.2.3 | PR.DS-1 | Encryption of backups in transit and at rest |
| CIS.11.2 | A.9.4.2 | PR.AC-4 | Secure backup authentication and authorization |
| CIS.11.5 | A.17.1.2 | PR.DS-4 | Offsite backup storage separate from production |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 5.4 Risk Assessment

This subsection documents identified security risks, implemented mitigations, and any accepted residual risk associated with the backup and disaster recovery configuration.

The backup and disaster recovery infrastructure has undergone a security risk assessment to identify potential vulnerabilities and apply appropriate mitigations:

1. **Risk**: Unauthorized access to backup data
   - **Mitigation**: RBAC controls, encryption, PBS authentication
   - **Residual Risk**: Low - Multiple layers of access controls limit exposure

2. **Risk**: Backup integrity compromise
   - **Mitigation**: Checksums, integrity verification, immutable storage
   - **Residual Risk**: Low - Comprehensive integrity controls in place

3. **Risk**: Incomplete backup coverage
   - **Mitigation**: Multi-layer backup approach, automated verification
   - **Residual Risk**: Medium - New resources may not be automatically included in backup scope

4. **Risk**: Backup restoration failure
   - **Mitigation**: Regular testing, documented procedures, trained personnel
   - **Residual Risk**: Low - Proven restoration processes through periodic testing

These risks are actively managed through continuous monitoring, regular testing, and timely updates to all backup and recovery-related components.

# 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures in detail. It provides the guidance needed to ensure business continuity and disaster recovery capabilities.

## 6.1 Backup Procedure

This subsection details how data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Etcd: Every 6 hours, Persistent Volumes: Daily at 01:00 UTC, VM-level: Daily at 22:00 UTC |
| **Backup Method** | Etcd: Native snapshots, PVs: Volume snapshots, VMs: Proxmox Backup Server |
| **Retention Policy** | 7 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | Primary: proj-pg01:/backup, Secondary: S3 Glacier Deep Archive |
| **Verification Process** | Every 90 days test restoration to validate backups |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

Specific backup considerations:

- Etcd backups capture the entire Kubernetes cluster state
- Persistent volume backups are application-aware where possible
- VM-level backups provide complete system recovery options
- All backups are encrypted at rest and during transmission
- Offsite replication ensures geographic redundancy

## 6.2 Recovery Procedure

This subsection provides recovery steps for various failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Single etcd node failure | 30 minutes | 6 hours | Restore node from backup, rejoin etcd cluster | Infrastructure Admin |
| Complete etcd cluster failure | 60 minutes | 6 hours | Restore from etcd snapshot, rebuild cluster | Infrastructure Admin |
| PV data corruption | 45 minutes | 24 hours | Restore from volume snapshot | Infrastructure Admin |
| Single worker node failure | 30 minutes | 0 data loss | Rebuild node from template, rejoin cluster | Infrastructure Admin |
| Complete cluster failure | 4 hours | 24 hours | Restore control plane from backups, rebuild worker nodes | Infrastructure Admin |
| Offsite recovery | 8 hours | 24 hours | Provision new infrastructure, restore from S3 backups | Infrastructure Admin |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

### Detailed Recovery Process for Key Scenarios

**Etcd Cluster Recovery**:

1. Stop RKE2 server service on affected nodes
2. Identify the most recent valid snapshot
3. Restore the snapshot to each control plane node
4. Restart RKE2 server service on the first node
5. Verify etcd functionality and cluster state
6. Start RKE2 server on remaining nodes
7. Validate cluster functionality

**Complete Cluster Recovery**:

1. Rebuild control plane VMs from backups
2. Restore etcd snapshot data
3. Start RKE2 server on first control plane node
4. Verify API server functionality
5. Join remaining control plane nodes
6. Rebuild worker nodes
7. Restore persistent volume data
8. Validate application functionality

**Disaster Recovery from Offsite**:

1. Provision new infrastructure in recovery location
2. Set up RKE2 control plane nodes
3. Restore etcd data from S3 backups
4. Configure worker nodes
5. Restore persistent volume data from S3
6. Reconfigure networking and DNS
7. Validate functionality and performance

# 7. References & Related Resources

This section provides links to related documentation and external resources. It establishes the connections between this document and other knowledge sources both internal and external.

## 7.1 Internal References

This subsection identifies other internal documents related to the backup and disaster recovery configuration, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Architecture | RKE2 Cluster Overview | [01-rke2-cluster-overview.md](01-rke2-cluster-overview.md) | Parent architecture |
| Policy | Backup & Recovery Policy | [../compliance-security/policies/backup-recovery-policy.md](../compliance-security/policies/backup-recovery-policy.md) | Governing policy |
| Technical | Proxmox Backup Server | [../infrastructure/proxmox-backup-server.md](../infrastructure/proxmox-backup-server.md) | Backup infrastructure |
| Technical | S3 Storage Gateway | [../infrastructure/s3-storage-gateway.md](../infrastructure/s3-storage-gateway.md) | Offsite backup repository |
| Operational | Disaster Recovery Plan | [../procedures/disaster-recovery-plan.md](../procedures/disaster-recovery-plan.md) | Detailed recovery procedures |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## 7.2 External References

This subsection provides links to external resources that provide additional context, technical details, or supporting information for the backup and disaster recovery configuration.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| RKE2 Backup Documentation | <https://docs.rke2.io/backup_restore> | [rke2-backup-docs-2025-04.pdf](../archive/rke2-backup-docs-2025-04.pdf) | 2025-04-01 |
| Kubernetes Backup Best Practices | <https://kubernetes.io/docs/tasks/administer-cluster/backup-etcd/> | [k8s-backup-docs-2025-04.pdf](../archive/k8s-backup-docs-2025-04.pdf) | 2025-04-01 |
| Volume Snapshots | <https://kubernetes.io/docs/concepts/storage/volume-snapshots/> | [k8s-snapshot-docs-2025-04.pdf](../archive/k8s-snapshot-docs-2025-04.pdf) | 2025-04-01 |
| Proxmox Backup Server | <https://pbs.proxmox.com/docs/backup-client.html> | [pbs-docs-2025-03.pdf](../archive/pbs-docs-2025-03.pdf) | 2025-03-15 |
| Business Continuity Planning | <https://www.iso.org/standard/75106.html> | [iso22301-overview-2025-03.pdf](../archive/iso22301-overview-2025-03.pdf) | 2025-03-20 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## 7.3 Change Request References

This subsection documents formal change requests that have modified the backup and disaster recovery configuration, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** |
|--------------|----------------|------------------------|
| CR-2025-043 | Initial RKE2 cluster backup configuration | 2025-04-11 |
| CR-2025-046 | Implemented volume snapshot system | 2025-04-15 |
| CR-2025-059 | Configured S3 gateway for offsite backups | 2025-04-21 |
| CR-2025-060 | Implemented recovery testing framework | 2025-04-21 |

The change request table above tracks formal changes that have affected the backup and disaster recovery configuration, supporting troubleshooting and audit activities.

# 8. Approval & Review

This section documents the formal review and approval process for the backup and disaster recovery configuration documentation. It ensures accountability and tracks who has verified the accuracy of the content.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

# 9. Change Log

This section tracks the document's revision history. It provides transparency into how the document has evolved over time and who made the changes.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial version | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version
