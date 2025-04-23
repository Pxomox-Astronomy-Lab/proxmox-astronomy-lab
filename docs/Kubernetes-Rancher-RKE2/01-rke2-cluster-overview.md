<!--
---
title: "RKE2 Cluster Architecture Overview"
description: "Detailed layout of the Rancher-managed RKE2 cluster including node roles, network assignments, VLAN segmentation, and GPU topology."
author: "VintageDon"
tags: ["rke2", "architecture", "cluster", "networking", "proxmox", "gpu"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
---
-->

# 🧭 **RKE2 Cluster Architecture Overview**

---

# 1. 📘 **Overview**

This document provides a structural overview of the RKE2 cluster deployed in the Proxmox Astronomy Lab. It captures the node topology, IP assignments, physical and virtual layer segmentation, and GPU layout. The purpose is to document the exact state of the base Kubernetes control plane and worker node layout prior to application onboarding.

This reference supports storage alignment, network routing, ingress planning, and GPU workload targeting.

---

# 2. 🧱 **Node Roles and Layout**

## 2.1 Control Plane Nodes

This subsection documents the three control plane nodes participating in the RKE2 cluster quorum.

| Hostname      | Role            | IP Address     | VLAN | Notes               |
|---------------|------------------|----------------|------|---------------------|
| proj-k8sm01   | control-plane    | 10.25.20.4     | 20   | Cluster initiator   |
| proj-k8sm02   | control-plane    | 10.25.20.5     | 20   | Joined via token    |
| proj-k8sm03   | control-plane    | 10.25.20.6     | 20   | Joined via token    |

## 2.2 Worker Nodes

This subsection lists all general-purpose and specialized worker nodes in the cluster.

| Hostname      | Role         | IP Address     | VLAN | Special Use        |
|---------------|--------------|----------------|------|--------------------|
| proj-k8sw01   | worker       | 10.25.20.7     | 20   | General workloads  |
| proj-k8sw02   | worker       | 10.25.20.8     | 20   | General workloads  |
| proj-k8sw03   | worker       | 10.25.20.9     | 20   | General workloads  |
| proj-k8sw04   | worker       | 10.25.20.10    | 20   | GPU node (A4000)   |
| proj-k8sw05   | worker       | 10.25.20.11    | 20   | General workloads  |

---

# 3. 🌐 **Networking and VLAN Segmentation**

All nodes reside on the `10.25.20.0/24` subnet (VLAN 20). This subnet is used for management, ingress, and inter-node communication. Each node is provisioned in Proxmox with static IPs and either manual network configuration or DHCP reservation.

Planned VLANs for segmentation:

- `VLAN 30` — Application workload traffic
- `VLAN 40` — Observatory pipeline ingestion
- `VLAN 50` — Monitoring and out-of-band access

Additional VLAN tagging will be added via `netplan` and handled at the interface level.

---

# 4. 🎮 **GPU Node Configuration**

Node `proj-k8sw04` is the only GPU-enabled worker node in the cluster. It is configured as follows:

- **GPU**: NVIDIA RTX A4000 (Ampere)
- **Driver**: Manually installed, pre-containerized
- **MPS**: Enabled using systemd-managed `nvidia-mps.service`
- **Node Labels**: `gpu=true`
- **Taints**: Can be tainted for exclusive scheduling as needed

This node is targeted for accelerated workloads such as LLM inference, sRAG vectorization, and observatory signal pre-processing.

---

# 5. 🧩 **Reference Links**

| Document | Purpose |
|----------|---------|
| [virtual-machine-infrastructure-list.md](../../infrastructure/virtual-machine-infrastructure-list.md) | Source of truth for node IPs, specs, and provisioning notes |
| [rke2-installation.md](./rke2-installation.md) | Bootstrap process and token join commands |
| [gpu-node-configuration.md](./gpu-node-configuration.md) | GPU setup and systemd integration |
| [pvs-local-nodes.md](./pvs-local-nodes.md) | Local PV layout and StorageClass bindings |

---

# 6. ✅ **Approval & Review**

| Reviewer    | Role            | Approval Date | Status        |
|-------------|------------------|----------------|----------------|
| VintageDon | Lead Engineer    | 2025-04-21     | ✅ Approved     |

---

# 7. 📜 **Change Log**

| Version | Date       | Author      | Description                             |
|---------|------------|-------------|-----------------------------------------|
| 1.0     | 2025-04-21 | VintageDon  | Initial architecture overview baseline  |
