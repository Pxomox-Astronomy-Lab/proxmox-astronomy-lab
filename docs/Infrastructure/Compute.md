<!-- 
---
title: "Proxmox Astronomy Lab - Compute Infrastructure"
description: "Overview of the lab's compute resources, virtualization platform, and resource allocation strategy"
author: "VintageDon"
tags: ["compute", "proxmox", "virtualization", "vm", "hardware"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🖥️ **Proxmox Astronomy Lab - Compute Infrastructure**

Our compute infrastructure provides the foundation for all lab services, research workloads, and data processing capabilities through a carefully designed Proxmox virtualization environment.

## 🏢 **1. Proxmox Cluster Architecture**

The lab operates on a five-node Proxmox VE cluster designed to balance performance, resource efficiency, and specialized workload requirements within our small form-factor constraints.

| **Node** | **Hardware** | **Resources** | **Network** | **Primary Role** |
|---------|------------|--------------|------------|----------------|
| [**Node01**](node01-proxmox-compute.md) | Ryzen 5700U Mini PC | 8 cores, 64GB RAM, 1TB NVMe | 2.5G | Control plane services, K8S management |
| [**Node02**](node02-proxmox-compute.md) | Ryzen 5700U Mini PC | 8 cores, 64GB RAM, 1TB NVMe | 2.5G | Core services, monitoring, automation |
| [**Node03**](node03-proxmox-compute.md) | Ryzen 5700U Mini PC | 8 cores, 64GB RAM, 1TB NVMe | 2.5G | Database services, directory services |
| [**Node04**](node04-proxmox-gpu-hpc.md) | Ryzen 5950X Workstation | 16 cores, 128GB RAM, RTX 3080 | 10G | AI/ML workloads, GPU passthrough, HPC |
| [**Node05**](node05-proxmox-zfs-storage.md) | Ryzen 3700X Server | 8 cores, 128GB RAM, 24TB storage | 10G | ZFS storage, backup server, object store |

This architecture strategically distributes core services across three compact nodes while providing specialized capabilities through two performance-focused systems.

## 🧮 **2. Resource Allocation**

Our VM deployment follows a structured allocation strategy to ensure optimal resource distribution, redundancy, and performance.

### **2.1 Current Allocation**

| **Node** | **VMs Assigned** | **vCPU Used** | **RAM Used** | **Available** |
|--------|----------------|-------------|-----------|-------------|
| **node01** | proj-k8sm01, proj-k8sw01, dc01, lab-soc1 | 16/16 | 58/64GB | 0 vCPU, 6GB RAM |
| **node02** | proj-k8sm02, proj-k8sw02, lab-dns01, lab-mon01, lab-ansible01, lab-apps01 | 18/16 | 66/64GB | Over-allocated |
| **node03** | proj-k8sm03, proj-k8sw03, lab-db01, dc02, proj-dns01 | 16/16 | 64/64GB | 0 vCPU, 0GB RAM |
| **node04** | proj-k8sw04, proj-pg01, proj-pggis01, proj-pgts01, proj-rds01, proj-apps01, proj-fs01, lab-port01 | 28/32 | 86/128GB | 4 vCPU, 42GB RAM |
| **nas01** | proj-k8sw05, proj-kasm01 | 14/16 | 56/128GB | 2 vCPU, 72GB RAM |

This allocation prioritizes core infrastructure redundancy while reserving capacity on specialized nodes for performance-intensive workloads.

## 🔄 **3. High Availability Strategy**

Our HA approach focuses on service resiliency rather than VM-level failover, reflecting our practical infrastructure constraints.

### **3.1 Service Redundancy**

Critical services are deployed following N+1 redundancy principles:

- **Directory Services**: Primary and Read-Only Domain Controllers on separate nodes
- **DNS**: Primary and secondary DNS servers on isolated nodes
- **Kubernetes**: Management plane distributed across three nodes
- **Database Services**: Replicated across multiple nodes for availability

This approach ensures continuity of essential services even if a single node fails.

## 🔌 **4. Power Management & Efficiency**

The lab implements careful power management strategies to balance performance and efficiency:

- **CPU Governors**: Performance on demand, ondemand otherwise
- **VM Scheduling**: Strategic VM placement for balanced power load
- **Power Monitoring**: Performance-per-watt tracking via Grafana

These practices help optimize resource usage while maintaining required performance levels.

## 📊 **5. Performance Monitoring**

Comprehensive performance monitoring ensures optimal resource utilization and early detection of capacity issues:

- **Prometheus + Node Exporter**: Hardware-level metrics collection
- **Grafana Dashboards**: Real-time visualization of compute metrics
- **Proxmox Metrics API**: VM-level performance tracking
- **Alerting**: Automated notification of performance thresholds

For detailed monitoring configuration, see the [Monitoring Stack documentation](../control-plane/lab-mon01-prometheus-monitoring-logging-stack.md).

## 🔍 **6. Compute Documentation**

Each compute node has detailed documentation covering configuration, assigned VMs, and operational procedures:

- [**Node01 Documentation**](node01-proxmox-compute.md)
- [**Node02 Documentation**](node02-proxmox-compute.md)
- [**Node03 Documentation**](node03-proxmox-compute.md)
- [**Node04 Documentation**](node04-proxmox-gpu-hpc.md)
- [**Node05 Documentation**](node05-proxmox-zfs-storage.md)

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial compute README | VintageDon |
