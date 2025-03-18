<!-- 
---
title: "Proxmox Virtualization Infrastructure - Proxmox Astronomy Lab"
description: "Overview of the Proxmox virtualization infrastructure, node configuration, and management approach for the lab environment"
author: "VintageDon"
tags: ["proxmox", "virtualization", "infrastructure", "hypervisor", "cluster"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🌟 **Proxmox Virtualization Infrastructure**

## 🔍 **1. Overview**

The Proxmox infrastructure forms the **foundation of the entire Proxmox Astronomy Lab**, providing a **high-performance, resilient virtualization platform** for all services, applications, and research workloads. Our five-node Proxmox VE cluster balances **compute density, energy efficiency, and performance** while operating within the constraints of a small-form-factor lab environment.

This section documents the **architecture, configuration, and operational procedures** for the Proxmox infrastructure that powers our research lab.

---

## 🏢 **2. Architecture**

### **2.1 Cluster Design**

Our Proxmox cluster implements a distributed architecture with:

- **Five physical nodes** - Each with specialized roles and capabilities
- **High-availability configuration** - Ensuring service continuity
- **Distributed storage** - Mix of local NVMe and shared ZFS volumes
- **VLAN-segmented networking** - Secured with strict traffic control

### **2.2 Node Specifications**

| **Node** | **Hardware** | **CPU** | **RAM** | **Storage** | **Network** | **Role** |
|----------|-------------|---------|--------|------------|------------|---------|
| [**node01**](node01-proxmox-compute.md) | NUC-like SFF | Ryzen 5700U | 64GB | 2TB NVMe | 2.5G | Compute, K8s Management |
| [**node02**](node02-proxmox-compute.md) | NUC-like SFF | Ryzen 5700U | 64GB | 2TB NVMe | 2.5G | Compute, K8s Management |
| [**node03**](node03-proxmox-compute.md) | NUC-like SFF | Ryzen 5700U | 64GB | 2TB NVMe | 2.5G | Compute, K8s Management |
| [**node04**](node04-proxmox-gpu-hpc.md) | Tower | Ryzen 5950X | 128GB | 4TB NVMe, 2TB SSD | 10G | AI/ML, HPC, GPU |
| [**node05**](node05-proxmox-zfs-storage.md) | Tower | Ryzen 3700X | 128GB | 24TB ZFS | 10G | Storage, Backup |

---

## 💾 **3. Storage Architecture**

### **3.1 Storage Types**

The Proxmox cluster utilizes multiple storage technologies to balance performance and capacity:

- **Local NVMe storage** - High-performance VM storage on each node
- **ZFS storage pool** - Resilient, deduplicated storage on node05
- **Proxmox Backup Server (PBS)** - Dedicated backup infrastructure
- **S3-compatible object storage** - Research data and unstructured content

### **3.2 Storage Allocation**

| **Storage Type** | **Primary Use** | **Performance Characteristics** | **Backup Strategy** |
|-----------------|----------------|--------------------------------|-------------------|
| **Local NVMe** | OS disks, high-IOPS workloads | Low latency, high throughput | Daily PBS snapshots |
| **ZFS Pool** | Shared VM disks, large datasets | Data integrity, compression | PBS + file-level backup |
| **iSCSI LUNs** | Database volumes | Consistent performance | Transaction log backup |
| **S3 Storage** | Research data, media | Scalable, object-based | Cross-region replication |

---

## 🔄 **4. Networking Configuration**

### **4.1 Network Architecture**

The Proxmox cluster implements a structured networking approach:

- **Multiple VLANs** - Logical separation of traffic types
- **Physical network segregation** - Control plane vs. research networks
- **Software-defined networking** - OVS bridge implementation
- **Traffic shaping and QoS** - Prioritization for critical services

### **4.2 Network VLANs**

| **VLAN ID** | **Network** | **Purpose** | **Security Controls** |
|------------|------------|------------|----------------------|
| **VLAN10** | 10.25.10.0/24 | Infrastructure & Management | Strict ACLs, internal only |
| **VLAN20** | 10.25.20.0/24 | Research & Application | Controlled external access |
| **VLAN30** | 10.25.30.0/24 | Storage Network | Isolated, no routing |
| **VLAN40** | 10.25.40.0/24 | Backup Network | Isolated, node05 access only |

---

## 🔐 **5. Security Implementation**

### **5.1 Hypervisor Security**

The Proxmox infrastructure implements comprehensive security measures:

- **Proxmox VE hardening** - Following security best practices
- **Secured API access** - TLS, certificate-based authentication
- **Minimal attack surface** - Limited service exposure
- **Regular security patching** - Automated update process
- **CISv8-aligned controls** - Security baseline for all nodes

### **5.2 VM Security**

- **VM isolation** - Hardware virtualization boundary enforcement
- **Encrypted storage** - For sensitive data volumes
- **Template-based deployment** - Hardened base images
- **Resource limits** - Prevention of noisy neighbor issues

---

## 🛠️ **6. Management & Automation**

### **6.1 Operational Procedures**

The Proxmox cluster is managed through structured processes:

- **Change management** - Tracked in GLPI with approval workflows
- **Configuration management** - Ansible-driven for consistency
- **Capacity planning** - Regular resource monitoring and forecasting
- **Backup validation** - Scheduled recovery testing

### **6.2 Automation Strategy**

| **Task** | **Automation Tool** | **Frequency** | **Validation Method** |
|----------|------------------|-------------|----------------------|
| **Node patching** | Ansible | Monthly | Post-update validation playbook |
| **Template updates** | Ansible + Packer | Quarterly | Automated testing |
| **Configuration enforcement** | Ansible | Daily | Drift detection |
| **Backup verification** | PBS verification job | Weekly | Test recovery to isolation network |

---

## 📊 **7. Monitoring & Observability**

### **7.1 Monitoring Integration**

The Proxmox infrastructure is monitored through multiple layers:

- **Proxmox built-in monitoring** - Resource usage, health metrics
- **Prometheus integration** - Detailed performance metrics
- **Grafana dashboards** - Visual monitoring of cluster health
- **Alerting** - Multi-channel notifications for issues

### **7.2 Key Metrics**

| **Metric Type** | **Key Indicators** | **Alert Thresholds** |
|----------------|-------------------|----------------------|
| **Resource Utilization** | CPU, RAM, storage usage | 85% sustained utilization |
| **Performance** | IOPS, latency, throughput | Service-specific thresholds |
| **Availability** | Uptime, HA status | Any node unavailability |
| **Health** | Hardware status, ZFS health | Any degraded state |

---

## 🚀 **8. VM Operations**

### **8.1 VM Deployment**

Virtual machines are deployed through a standardized process:

- **Golden images** - CIS-hardened OS templates
- **Automated provisioning** - Ansible-driven configuration
- **Configuration validation** - Post-deployment testing
- **Documentation** - Automated CMDB updates

### **8.2 VM Types & Distribution**

| **VM Type** | **Typical Resources** | **Node Placement Strategy** | **Example VMs** |
|-------------|---------------------|----------------------------|----------------|
| **Infrastructure** | 2-4 vCPU, 4-8GB RAM | Distributed across nodes | DNS, monitoring, domain controllers |
| **Application** | 4-8 vCPU, 16-32GB RAM | Based on resource requirements | Databases, application servers |
| **Kubernetes** | 8 vCPU, 32GB RAM | Distributed with anti-affinity | K8s worker nodes |
| **HPC/GPU** | 6-12 vCPU, 24-64GB RAM | Primarily on node04 | AI/ML workloads, signal processing |

---

## 🔗 **9. Related Documentation**

| **Document** | **Description** |
|--------------|----------------|
| [Infrastructure Overview](../README.md) | High-level infrastructure documentation |
| [Storage Architecture](../storage/README.md) | Detailed storage implementation |
| [Networking](../networking/README.md) | Network design and implementation |
| [Kubernetes Nodes](../kubernetes/README.md) | K8s infrastructure on Proxmox |

---

## ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Proxmox README | VintageDon |
