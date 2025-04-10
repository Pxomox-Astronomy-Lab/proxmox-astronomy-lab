# 🖥️ **Compute Resources**

# 🔍 **1. Overview**

This section documents the compute infrastructure that forms the foundation of the Proxmox Astronomy Lab. Our compute environment consists of five strategically configured Proxmox nodes, designed to balance performance, efficiency, and specialized capabilities while working within the constraints of small form-factor hardware. This architecture supports our virtualized workloads including Kubernetes clusters, database services, AI/ML processing, and radio astronomy data analysis.

The compute infrastructure is designed with an emphasis on resilience through service redundancy rather than hardware redundancy, reflecting our practical approach to home lab infrastructure while maintaining production-quality service availability.

---

# 🏗️ **2. Virtualization Platform**

## **2.1 Proxmox Cluster**

The foundation of our compute infrastructure is built on Proxmox Virtual Environment (VE).

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Proxmox Cluster** | Centralized management of all compute nodes | [Proxmox Cluster Configuration](Proxmox/proxmox-cluster-configuration.md) |
| **Storage Integration** | ZFS, NFS, and Ceph storage backends | [Storage Integration](Proxmox/storage-configuration.md) |
| **Network Configuration** | VLAN setup and network virtualization | [Network Setup](Proxmox/network-configuration.md) |

## **2.2 VM Templates**

Standardized templates ensure consistency and security compliance across all VMs.

| **Template** | **Purpose** | **Documentation** |
|-------------|------------|-------------------|
| **Ubuntu 24.04 L1** | CISv8 Level 1 compliant base image | [Ubuntu L1 Template](Proxmox/templates/ubuntu2404-l1-template.md) |
| **Ubuntu 24.04 L2** | CISv8 Level 2 compliant hardened image | [Ubuntu L2 Template](Proxmox/templates/ubuntu2404-l2-template.md) |
| **Windows Server 2025** | CISv9 compliant server template | [Windows Server Template](Proxmox/templates/winserver2025-template.md) |

---

# 🧩 **3. Node Architecture**

## **3.1 Compute Nodes**

Our environment consists of five specialized nodes, each with specific roles.

| **Node** | **Hardware Specifications** | **Primary Role** | **Documentation** |
|---------|---------------------------|----------------|-------------------|
| **Node01** | Ryzen 5700U, 64GB RAM, 2.5G NIC | Control plane services | [Node01 Details](Proxmox/node01-proxmox-compute.md) |
| **Node02** | Ryzen 5700U, 64GB RAM, 2.5G NIC | Application services | [Node02 Details](Proxmox/node02-proxmox-compute.md) |
| **Node03** | Ryzen 5700U, 64GB RAM, 2.5G NIC | Database services | [Node03 Details](Proxmox/node03-proxmox-compute.md) |
| **Node04** | Ryzen 5950X, 128GB RAM, RTX A4000, 10G NIC | AI/ML workloads | [Node04 Details](Proxmox/node04-proxmox-gpu-hpc.md) |
| **Node05** | Ryzen 3700X, 128GB RAM, 24TB ZFS, 10G NIC | Storage services | [Node05 Details](Proxmox/node05-proxmox-zfs-storage.md) |

## **3.2 Resource Allocation**

Current VM allocation and resource distribution across the cluster.

| **Node** | **VMs Assigned** | **vCPU Used** | **RAM Used** | **Available Resources** |
|--------|-----------------|-------------|------------|------------------------|
| **Node01** | proj-k8sm01, proj-k8sw01, dc01, lab-soc1 | 16/16 | 58/64GB | 0 vCPU, 6GB RAM |
| **Node02** | proj-k8sm02, proj-k8sw02, lab-dns01, lab-mon01, lab-ansible01, lab-apps01 | 18/16 | 66/64GB | -2 vCPU, -2GB RAM (overcommitted) |
| **Node03** | proj-k8sm03, proj-k8sw03, lab-db01, dc02, proj-dns01 | 16/16 | 64/64GB | 0 vCPU, 0GB RAM |
| **Node04** | proj-k8sw04, proj-pg01, proj-pggis01, proj-pgts01, proj-rds01, proj-apps01 | 28/32 | 86/128GB | 4 vCPU, 42GB RAM |
| **Node05** | proj-k8sw05, proj-kasm01 | 14/16 | 56/128GB | 2 vCPU, 72GB RAM |

Our allocation strategy prioritizes balanced workload distribution while allowing for some resource overcommitment on Node02 based on VM usage patterns.

---

# 🚀 **4. Specialized Computing Resources**

## **4.1 GPU Computing**

GPU resources for AI/ML workloads and scientific computing.

| **Resource** | **Specifications** | **Access Method** | **Documentation** |
|-------------|-------------------|----------------|-------------------|
| **RTX A4000** | 16GB VRAM, 6144 CUDA cores | Passthrough to VM | [GPU Passthrough](Proxmox/gpu-passthrough-configuration.md) |
| **Kubernetes GPU** | k8s GPU operator | Device plugin | [K8s GPU Setup](Kubernetes/gpu-operator-deployment.md) |

## **4.2 Kubernetes Cluster**

RKE2 Kubernetes cluster for containerized workloads.

| **Component** | **Distribution** | **Documentation** |
|--------------|----------------|-------------------|
| **Control Plane** | 3 management nodes | [K8s Control Plane](Kubernetes/Control-Plane/README.md) |
| **Worker Nodes** | 5 worker nodes | [K8s Worker Nodes](Kubernetes/Worker-Nodes/README.md) |
| **Deployments** | Application workloads | [K8s Deployments](Kubernetes/Deployments/README.md) |

---

# 🛡️ **5. Security & Compliance**

## **5.1 Security Controls**

Compute-specific security measures implemented across our environment.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|-------------------------|
| **Host Hardening** | CIS-compliant Proxmox configuration | Automated compliance scanning |
| **VM Security** | CIS-compliant VM templates | Lynis and CIS-CAT Pro scans |
| **Network Isolation** | VLAN segmentation, firewall rules | Network scanning and validation |

## **5.2 Compliance Mapping**

Compliance controls implemented on compute resources.

| **CIS Control** | **Implementation** | **Evidence Location** |
|-----------------|-------------------|----------------------|
| **CIS 4.1** | Secure configuration of compute nodes | Compliance scanning reports |
| **CIS 5.2** | Privileged access management | Access control documentation |
| **CIS 8.2** | Audit logging for compute actions | Centralized logging system |

---

# 🔍 **6. Monitoring & Operations**

## **6.1 Performance Monitoring**

Monitoring solutions for compute resources.

| **Tool** | **Metrics Monitored** | **Dashboard** |
|----------|----------------------|--------------|
| **Prometheus** | CPU, memory, disk, network utilization | [Compute Dashboard](../Observability/Grafana/Dashboards/compute-resources.md) |
| **Node Exporter** | System-level metrics | [System Dashboard](../Observability/Grafana/Dashboards/node-metrics.md) |
| **Proxmox API** | VM-specific performance metrics | [VM Dashboard](../Observability/Grafana/Dashboards/proxmox-vm-performance.md) |

## **6.2 Operational Procedures**

Regular maintenance and operational procedures.

| **Procedure** | **Frequency** | **Documentation** |
|---------------|--------------|-------------------|
| **VM Backups** | Daily | [Backup Procedures](../Infrastructure/Storage/Backup-Strategy/vm-backup-procedures.md) |
| **Performance Tuning** | Monthly | [Tuning Guide](Proxmox/performance-tuning.md) |
| **Capacity Planning** | Quarterly | [Capacity Management](Proxmox/capacity-planning.md) |

---

# 🔗 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Proxmox** | Proxmox virtualization platform configuration | [Proxmox README](Proxmox/README.md) |
| **Kubernetes** | Kubernetes cluster documentation | [Kubernetes README](Kubernetes/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **VM Allocation Strategy** | Guidelines for VM placement and resource allocation | [VM Allocation](vm-allocation-strategy.md) |
| **Performance Monitoring Guide** | Procedures for monitoring compute performance | [Performance Monitoring](performance-monitoring-guide.md) |
| **Resource Planning** | Capacity planning and growth strategy | [Resource Planning](resource-planning.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Parent directory for compute resources | [Infrastructure README](../README.md) |
| **Networking** | Network connectivity for compute resources | [Networking README](../Networking/README.md) |
| **Storage** | Storage services for compute resources | [Storage README](../Storage/README.md) |
| **Observatory-Hardware** | Scientific hardware utilizing compute resources | [Observatory Hardware README](../Observatory-Hardware/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 2.0 | 2025-04-04 | Updated to standardized format with expanded sections | VintageDon |
| 1.0 | 2025-03-16 | Initial compute README | VintageDon |
