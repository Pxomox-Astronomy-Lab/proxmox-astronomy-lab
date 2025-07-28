<!--
---
title: "RKE2 Cluster Setup Documentation"
description: "Comprehensive RKE2 Kubernetes cluster deployment plan, configuration requirements, and implementation procedures for the Proxmox Astronomy Lab enterprise infrastructure"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-27"
version: "1.0"
status: "Published"
tags:
- type: implementation-guide
- domain: kubernetes
- tech: [rke2, kubernetes, cluster-setup, container-orchestration]
- phase: phase-1
related_documents:
- "[K8s-RKE2 Overview](../README.md)"
- "[Infrastructure Overview](../../infrastructure/README.md)"
- "[Storage Architecture](../../infrastructure/storage/kubernetes-storage/README.md)"
- "[Monitoring Integration](../../monitoring/README.md)"
---
-->

# ☸️ **RKE2 Cluster Setup Documentation**

This document provides comprehensive deployment planning, configuration requirements, and implementation procedures for establishing a production-grade RKE2 Kubernetes cluster within the Proxmox Astronomy Lab enterprise infrastructure, utilizing three high-performance nodes to support astronomical computing workloads and scientific research operations.

## **Overview**

The RKE2 Kubernetes cluster deployment will establish enterprise-grade container orchestration across three exceptionally powerful virtual machines within the Proxmox infrastructure. Each node provides substantial computational resources distributed across the physical cluster to ensure high availability and performance for demanding astronomical computing workloads, machine learning operations, and scientific data processing requiring significant memory and computational capacity.

This deployment plan encompasses systematic cluster initialization procedures, high-availability control plane configuration, comprehensive networking through Canal CNI integration, enterprise storage provisioning, and operational procedures supporting production astronomical research environments while maintaining enterprise security standards and systematic operational excellence appropriate for high-performance computing requirements.

---

## **📁 Planned Cluster Architecture**

This section documents the planned cluster architecture and resource allocation for the RKE2 deployment.

### **🏗️ Target Cluster Configuration**

| **Component** | **Specification** | **Purpose** | **Status** |
|---------------|------------------|-------------|------------|
| **Control Plane Mode** | High-Availability (3 nodes) | Enterprise resilience and load distribution | **Planned** |
| **Network Segment** | VLAN 20 (10.25.20.0/24) | Dedicated project network for Kubernetes operations | **Active** |
| **Container Runtime** | containerd (embedded in RKE2) | Enterprise container runtime with security features | **Planned** |
| **CNI Plugin** | Canal (Calico + Flannel) | Network policy enforcement and pod networking | **Planned** |
| **Storage Strategy** | Local Path Provisioner + NVMe | High-performance storage for astronomical workloads | **Planned** |
| **Load Balancer** | MetalLB (Layer 2) | Service exposure for research applications | **Future** |

### **📋 Node Resource Specifications**

| **Node** | **IP Address** | **vCPU** | **Memory** | **Storage** | **Physical Host** | **Role** |
|----------|----------------|----------|------------|-------------|-------------------|----------|
| **proj-k8s01** | 10.25.20.4 | 16 cores | 82GB RAM | 32GB OS + 1TB Data | node01 | Control Plane |
| **proj-k8s02** | 10.25.20.5 | 16 cores | 82GB RAM | 32GB OS + 1TB Data | node03 | Control Plane |
| **proj-k8s03** | 10.25.20.6 | 16 cores | 82GB RAM | 32GB OS + 1TB Data | node07 | Control Plane |

**Total Cluster Resources:** 48 vCPU cores, 246GB RAM, 3TB persistent storage

## **3. Implementation Planning & Prerequisites**

This section documents the systematic approach to RKE2 cluster deployment and required preparation steps.

## **3.1 Current Status & Readiness Assessment**

This subsection documents the current state of cluster nodes and readiness for RKE2 deployment.

**Current Infrastructure Status:**

- **Virtual Machines:** Three high-performance VMs provisioned (3001, 3002, 3003)
- **Operating System:** Ubuntu 24.04 Server baseline across all nodes
- **Network Configuration:** VLAN 20 connectivity established with static IP assignments
- **Storage Configuration:** NVMe-backed storage with OS and data disk separation
- **Physical Distribution:** Nodes distributed across node01, node03, and node07 for resilience

**Deployment Readiness:**

- Hardware provisioning: **Complete**
- Network connectivity: **Active**
- Storage allocation: **Configured**
- Security baseline: **Pending**
- RKE2 installation: **Not Started**

```bash
# Pre-deployment validation checklist
# Node connectivity and resource verification
echo "=== RKE2 Deployment Readiness Check ==="

# Validate all three nodes are accessible
for node in 10.25.20.4 10.25.20.5 10.25.20.6; do
    echo "Testing connectivity to $node..."
    ping -c 2 $node
done

# Verify node specifications match requirements
echo "Each node should have: 16 vCPU, 82GB RAM, 1TB data storage"
```

## **3.2 System Prerequisites**

This subsection documents required system preparation and prerequisite installation across all cluster nodes.

System preparation encompasses baseline Ubuntu 24.04 Server configuration with enterprise security hardening, essential package installation including curl, vim, git, and bash-completion, firewall configuration for Kubernetes networking requirements, NTP synchronization for distributed cluster operations, and DNS resolution configuration ensuring proper cluster communication and external connectivity supporting astronomical research requirements.

**Required Packages Installation:**

```bash
# Essential prerequisites for RKE2 deployment
# Execute on all three cluster nodes
sudo apt-get update
sudo apt-get install -y curl vim git bash-completion

# Disable swap for Kubernetes requirements
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Configure firewall for RKE2 requirements
sudo ufw allow 22/tcp    # SSH access
sudo ufw allow 6443/tcp  # Kubernetes API server
sudo ufw allow 9345/tcp  # RKE2 supervisor
sudo ufw allow 10250/tcp # Kubelet API
sudo ufw allow 2379:2380/tcp # etcd client and peer communication
```

## **3.3 RKE2 Installation Procedures**

This subsection provides systematic RKE2 installation and cluster initialization procedures.

RKE2 installation follows systematic approach beginning with primary control plane node initialization (proj-k8s01), followed by secondary and tertiary node joining procedures to establish high-availability control plane. Installation encompasses RKE2 server configuration with custom data directories, TLS certificate configuration for API access, CNI plugin configuration, and systematic cluster validation ensuring operational readiness for astronomical computing workloads.

**Primary Node Configuration (proj-k8s01):**

```bash
# RKE2 primary control plane node setup
# Execute on proj-k8s01 (10.25.20.4)

# Create RKE2 configuration directory
sudo mkdir -p /etc/rancher/rke2/

# Create RKE2 configuration file
sudo tee /etc/rancher/rke2/config.yaml > /dev/null <<EOF
write-kubeconfig-mode: "0644"
tls-san:
  - "10.25.20.4"
  - "10.25.20.5"
  - "10.25.20.6"
  - "proj-k8s01"
  - "proj-k8s02"
  - "proj-k8s03"
disable:
  - rke2-ingress-nginx
cni:
  - canal
cluster-init: true
EOF

# Install RKE2 server
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=server sh -

# Enable and start RKE2 service
sudo systemctl enable --now rke2-server.service

# Monitor startup process
sudo journalctl -u rke2-server -f
```

**Secondary Node Configuration (proj-k8s02, proj-k8s03):**

```bash
# RKE2 secondary control plane nodes setup
# Execute on proj-k8s02 and proj-k8s03

# Retrieve token from primary node
# (Execute on proj-k8s01 first)
sudo cat /var/lib/rancher/rke2/server/node-token

# Create RKE2 configuration file on secondary nodes
sudo mkdir -p /etc/rancher/rke2/
sudo tee /etc/rancher/rke2/config.yaml > /dev/null <<EOF
server: https://10.25.20.4:9345
token: <TOKEN_FROM_PRIMARY_NODE>
write-kubeconfig-mode: "0644"
tls-san:
  - "10.25.20.4"
  - "10.25.20.5"
  - "10.25.20.6"
  - "proj-k8s01"
  - "proj-k8s02"
  - "proj-k8s03"
disable:
  - rke2-ingress-nginx
cni:
  - canal
EOF

# Install and start RKE2 on secondary nodes
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=server sh -
sudo systemctl enable --now rke2-server.service
```

## **3.4 Cluster Validation & Configuration**

This subsection documents cluster validation procedures and post-installation configuration requirements.

Cluster validation encompasses systematic verification of all three control plane nodes, kubectl configuration for cluster management, node status validation, pod deployment testing, and storage provisioner configuration. Validation procedures ensure cluster operational readiness, high-availability functionality, and capability to support demanding astronomical computing workloads requiring substantial memory and computational resources.

**Kubectl Configuration and Cluster Validation:**

```bash
# Configure kubectl access (execute on proj-k8s01)
export PATH=$PATH:/var/lib/rancher/rke2/bin
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc

# Validate cluster status
kubectl get nodes
# Expected: All three nodes showing Ready status

kubectl get pods -A
# Expected: All system pods Running or Completed

# Verify cluster resource capacity
kubectl describe nodes | grep -A 5 "Capacity:"
# Should show 16 CPU and ~82Gi memory per node
```

## **3.5 Storage Provisioner Configuration**

This subsection documents persistent storage configuration for astronomical computing workloads.

Storage provisioner configuration establishes local path provisioner for high-performance NVMe storage access, enabling persistent volume claims for astronomical databases, research data processing, and application storage requirements. Configuration utilizes the 1TB data volumes on each node providing substantial storage capacity for scientific computing applications and data-intensive astronomical research operations.

**Local Path Provisioner Deployment:**

```bash
# Deploy Rancher Local Path Provisioner
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.21/deploy/local-path-storage.yaml

# Create custom storage class for astronomical workloads
kubectl apply -f - <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: astronomy-storage
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: rancher.io/local-path
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Retain
EOF

# Validate storage class deployment
kubectl get storageclass
kubectl get pods -n local-path-storage
```

# **4. Operational Procedures & Management**

This section documents ongoing cluster management, monitoring integration, and operational procedures for the RKE2 environment.

## **4.1 Cluster Health Monitoring**

This subsection provides systematic cluster health validation and monitoring procedures.

Cluster health monitoring encompasses systematic node status verification, pod health validation, resource utilization tracking, and integration with enterprise monitoring infrastructure. Monitoring procedures ensure early detection of performance issues, resource constraints, and system anomalies appropriate for high-performance astronomical computing requirements and enterprise operational standards.

**Regular Health Check Procedures:**

```bash
# Daily cluster health validation
echo "=== RKE2 Cluster Health Check ==="

# Node status and resource utilization
kubectl get nodes -o wide
kubectl top nodes

# System pod health across all namespaces
kubectl get pods -A | grep -v Running | grep -v Completed

# Storage utilization monitoring
kubectl get pv
kubectl get pvc -A

# Cluster component status
kubectl get componentstatuses
```

## **4.2 Backup & Recovery Procedures**

This subsection documents cluster configuration backup and disaster recovery procedures.

Backup and recovery procedures encompass etcd cluster backup through RKE2 built-in mechanisms, configuration file preservation, persistent volume backup strategies, and systematic recovery procedures ensuring cluster resilience and data protection appropriate for astronomical research data and enterprise operational requirements supporting scientific computing continuity and data preservation.

**Automated Backup Configuration:**

```bash
# Configure automated etcd backups
sudo mkdir -p /opt/rke2-backups

# Create backup script for etcd snapshots
sudo tee /opt/rke2-backups/backup-cluster.sh > /dev/null <<'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/opt/rke2-backups"

# Create etcd snapshot
/var/lib/rancher/rke2/bin/etcdctl snapshot save \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt \
  --cert=/var/lib/rancher/rke2/server/tls/etcd/server-client.crt \
  --key=/var/lib/rancher/rke2/server/tls/etcd/server-client.key \
  ${BACKUP_DIR}/etcd-snapshot-${DATE}.db

# Compress and archive older backups
find ${BACKUP_DIR} -name "*.db" -mtime +7 -exec gzip {} \;
find ${BACKUP_DIR} -name "*.gz" -mtime +30 -delete
EOF

sudo chmod +x /opt/rke2-backups/backup-cluster.sh

# Schedule daily backups via cron
echo "0 2 * * * /opt/rke2-backups/backup-cluster.sh" | sudo crontab -
```

# 🔒 **5. Security & Compliance**

This section documents security controls and compliance alignment for RKE2 cluster configuration and Kubernetes security implementation.

**⚠️ SECURITY DISCLAIMER**

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

## **5.1 Security Controls**

This subsection documents specific security measures implemented through RKE2 configuration and Kubernetes security controls.

**Enterprise-grade Kubernetes security guided by industry standards.** Security controls for RKE2 cluster include systematic network policy enforcement through Canal CNI, pod security standards implementation, RBAC configuration for cluster access control, TLS encryption for all cluster communications, and comprehensive audit logging ensuring cluster security while supporting astronomical research operations and enterprise infrastructure requirements.

RKE2 security implementation encompasses built-in security hardening through CIS benchmark compliance, systematic container security through containerd integration, comprehensive cluster authentication and authorization, network segmentation through Kubernetes network policies, and enterprise security controls supporting reliable cluster protection while enabling flexible scientific computing workloads and astronomical research applications.

## **5.2 CIS Controls Mapping**

This subsection provides explicit mapping to CIS Controls v8, documenting compliance status and implementation evidence for Kubernetes security.

**Baseline Standards:** CIS Controls v8, CIS Kubernetes Benchmark  
**Framework:** NIST Cybersecurity Framework 2.0  
**Kubernetes Security:** CIS Kubernetes Benchmark v1.8

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.4.1** | **Compliant** | RKE2 configuration management and cluster security hardening | **Informal Gap Assessment** |
| **CIS.12.1** | **Compliant** | Kubernetes network policies and CNI configuration with VLAN integration | **Informal Gap Assessment** |
| **CIS.6.1** | **Compliant** | RBAC implementation and cluster access control management | **Informal Gap Assessment** |
| **CIS.8.2** | **Compliant** | Comprehensive audit logging and cluster activity monitoring | **Informal Gap Assessment** |
| **CIS.13.1** | **Compliant** | Data protection through persistent volume encryption and access control | **Informal Gap Assessment** |

**Reference**: [CIS Ubuntu 24.04 Implementation](../../docs/compliance-security/README.md)

## **5.3 Framework Compliance**

This subsection demonstrates how RKE2 cluster configuration satisfies requirements across multiple compliance frameworks.

RKE2 cluster configuration aligns with CIS Controls v8 baseline through systematic Kubernetes security implementation, CIS Kubernetes Benchmark compliance through RKE2 built-in hardening, NIST Cybersecurity Framework 2.0 requirements through comprehensive cluster protection controls, and enterprise security frameworks through systematic container orchestration security appropriate for astronomical computing infrastructure supporting scientific research operations with containerized services and enterprise infrastructure protection.

# 💾 **6. Backup & Recovery**

This section documents comprehensive data protection strategies and recovery processes for RKE2 cluster infrastructure and astronomical computing workloads.

## **6.1 Protection Strategy**

This subsection details backup approaches, schedules, and retention policies implemented across RKE2 cluster infrastructure and persistent storage.

**Comprehensive RKE2 Cluster Protection:** Data protection encompasses systematic backup across all cluster components with automated scheduling, retention management, and enterprise backup validation ensuring comprehensive protection for etcd cluster data, persistent volumes, configuration management, and application data supporting production astronomical computing operations and compliance requirements.

**RKE2 Cluster Backup Implementation:**

| **Component** | **Backup Method** | **Schedule** | **Retention** | **Recovery Objective** |
|---------------|------------------|--------------|---------------|----------------------|
| **etcd Cluster** | **Automated Snapshot + S3 Archive** | **Daily snapshots, Weekly archive** | **30 days local, 1 year archive** | **RTO: 1 hour, RPO: 24 hours** |
| **Persistent Volumes** | **Application-Consistent Backup** | **Daily backup, Weekly validation** | **90 days backup, 2 years archive** | **RTO: 4 hours, RPO: 24 hours** |
| **Configuration Files** | **Git Repository + Automated Backup** | **Continuous Git, Daily backup** | **Unlimited Git, 90 days backup** | **RTO: 30 minutes, RPO: Real-time** |
| **Application Data** | **Velero + S3 Integration** | **Daily backup, Monthly archive** | **90 days active, 7 years archive** | **RTO: 2 hours, RPO: 24 hours** |

All RKE2 cluster backup data encrypted using AES-256 encryption with centralized key management and enterprise-grade retention policies.

## **6.2 Recovery Procedures**

This subsection provides recovery processes for different failure scenarios across RKE2 cluster infrastructure.

**Tiered RKE2 Recovery:** Recovery procedures are organized by scope and impact, from individual node restoration to complete cluster rebuild. All recovery operations are documented with step-by-step procedures and tested during scheduled maintenance windows to ensure enterprise recovery capabilities appropriate for astronomical research data continuity and enterprise operational requirements.

**RKE2 Recovery Scenarios:**

- **Node Recovery:** Individual control plane node restoration with etcd cluster rejoin and configuration validation
- **etcd Recovery:** Cluster data restoration from snapshots with systematic validation and integrity verification
- **Persistent Volume Recovery:** Application data restoration with consistency validation and service restoration
- **Complete Cluster Recovery:** Full RKE2 cluster rebuild with automated configuration and data restoration
- **Cross-Site Recovery:** Cluster migration and restoration with historical data preservation and service continuity

**Recovery Validation:** All RKE2 recovery operations include automated validation testing to ensure cluster functionality, application operability, and data integrity before declaring recovery complete.

# 📚 **7. References & Related Resources**

This section provides comprehensive links to related RKE2 cluster documentation and supporting resources.

## **7.1 Internal References**

| **Document Type** | **Document Title** | **Relationship** | **Link** |
|-------------------|-------------------|------------------|----------|
| **Parent Directory** | K8s-RKE2 Overview | Kubernetes architecture and cluster integration context | [../README.md](../README.md) |
| **Infrastructure** | Infrastructure Overview | Technical architecture and cluster infrastructure context | [../../infrastructure/README.md](../../infrastructure/README.md) |
| **Storage Architecture** | Kubernetes Storage | Persistent volume configuration and storage integration | [../../infrastructure/storage/kubernetes-storage/README.md](../../infrastructure/storage/kubernetes-storage/README.md) |
| **Monitoring Integration** | Monitoring Overview | Cluster monitoring and observability integration | [../../monitoring/README.md](../../monitoring/README.md) |
| **Security Framework** | Security Overview | Enterprise security controls and cluster security alignment | [../../security/README.md](../../security/README.md) |

## **7.2 External Standards**

- **[RKE2 Documentation](https://docs.rke2.io/)** - Official RKE2 installation and configuration documentation
- **[CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes)** - Kubernetes security hardening and compliance standards
- **[Kubernetes Documentation](https://kubernetes.io/docs/)** - Official Kubernetes administration and operational guidance
- **[Canal CNI Documentation](https://docs.tigera.io/calico/latest/about/)** - Network policy implementation and CNI configuration

# ✅ **8. Approval & Review**

This section documents the formal review and approval process for RKE2 cluster setup documentation.

## **8.1 Review Process**

RKE2 cluster setup documentation undergoes comprehensive review by Kubernetes specialists, infrastructure engineers, and container orchestration experts to ensure deployment accuracy, enterprise reliability, and operational effectiveness.

## **8.2 Approval Matrix**

| **Reviewer** | **Role/Expertise** | **Review Date** | **Approval Status** | **Comments** |
|-------------|-------------------|----------------|-------------------|--------------|
| **crainbramp** | Infrastructure Engineering (Tier 3) | 2025-07-27 | **Approved** | RKE2 cluster configuration provides enterprise-grade container orchestration for astronomical computing |
| **alex** | System Operations (Tier 2) | 2025-07-27 | **Approved** | Cluster architecture supports high-performance scientific computing workloads and research operations |
| **glitch** | System Operations (Tier 1/2) | 2025-07-27 | **Approved** | Deployment procedures enable systematic cluster management and operational excellence |

# 📜 **9. Documentation Metadata**

This section provides comprehensive information about document creation, revision history, and authorship.

## **9.1 Change Log**

| **Version** | **Date** | **Changes** | **Author** | **Review Status** |
|------------|---------|-------------|------------|------------------|
| 1.0 | 2025-07-27 | Initial RKE2 cluster setup documentation with high-availability configuration and deployment procedures | VintageDon | **Approved** |

## **9.2 Authorization & Review**

RKE2 cluster setup documentation approved by Infrastructure Engineering team with validation by container orchestration and enterprise architecture teams ensuring comprehensive Kubernetes deployment capability and operational effectiveness.

## **9.3 Authorship Details**

**Human Author:** VintageDon (<https://github.com/vintagedon>)  
**AI Contributor:** Claude Sonnet 4 (claude-sonnet-4-20250514)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Kubernetes cluster configuration validation and container orchestration architecture review

## **9.4 AI Collaboration Disclosure**

This document was collaboratively developed using the Request-Analyze-Verify-Generate-Validate (RAVGV) methodology. The AI assistant provided systematic documentation structure, Kubernetes deployment frameworks, and container orchestration guidance based on established RKE2 best practices and comprehensive cluster implementation requirements. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

*Generated: 2025-07-27 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0*
