<!-- 
---
title: "Kubernetes Control Plane - Proxmox Astronomy Lab"
description: "Overview of the Kubernetes control plane nodes, their configuration, and role in the RKE2 cluster"
author: "VintageDon"
tags: ["kubernetes", "control-plane", "rke2", "infrastructure"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🎛️ **1. Kubernetes Control Plane**

## 🔍 **1.1 Overview**

The Kubernetes Control Plane consists of three dedicated nodes that provide **cluster management services** and ensure **high availability** for the RKE2 deployment. These nodes host critical components including the **API server, scheduler, controller manager, and etcd database**.

This section documents the **architecture, configuration, and operations** of the control plane that powers our research workloads.

---

## 🏢 **2. Architecture**

### **2.1 Control Plane Components**

Our RKE2 control plane implements a HA architecture with:

- **Three dedicated nodes** - Ensuring no single point of failure
- **Embedded etcd database** - Distributed cluster state storage
- **CIS-hardened configuration** - Security-first implementation
- **Network isolation** - Protected on dedicated VLAN20

### **2.2 Node Specifications**

| **Node** | **IP Address** | **vCPU** | **RAM** | **Disk 1** | **Disk 2** | **Proxmox Host** |
|----------|---------------|----------|--------|-----------|-----------|----------------|
| [**proj-k8sm01**](proj-k8sm01-rancher-rke2-master-node-01.md) | 10.25.20.4 | 2 | 8GB | 32GB | 250GB | node01 |
| [**proj-k8sm02**](proj-k8sm02-rancher-rke2-master-node-02.md) | 10.25.20.5 | 2 | 8GB | 32GB | 250GB | node02 |
| [**proj-k8sm03**](proj-k8sm03-rancher-rke2-master-node-03.md) | 10.25.20.6 | 2 | 8GB | 32GB | 250GB | node03 |

---

## 🔐 **3. Security Configuration**

### **3.1 Hardening Measures**

The control plane implements multiple security measures:

- **RKE2 CIS profile** - Default configuration meets CIS Kubernetes Benchmark v1.8
- **Ubuntu 24.04 (CISv8 Level 2)** - Hardened base operating system
- **Network Policy Enforcement** - Cilium-based microsegmentation
- **RBAC Implementation** - Strict role-based access control
- **etcd Encryption** - Encrypted secrets storage

### **3.2 Certificate Management**

RKE2 manages all cluster certificates with:

- **Automatic certificate rotation** - Managed by RKE2
- **TLS for all communication** - Secured control plane traffic
- **Custom CA integration** - Lab internal PKI integration

---

## 🔄 **4. High Availability**

### **4.1 HA Implementation**

The control plane ensures continuous operation through:

- **Leader election** - Automatic failover for API components
- **Distributed consensus** - etcd quorum-based state management
- **Node distribution** - Control plane nodes on separate physical hosts
- **Load balanced API** - Distributed access to control plane services

### **4.2 Failure Scenarios**

The control plane continues operating in these scenarios:

- **Single node failure** - Automatic failover, no service disruption
- **Two node failures** - Degraded but operational (requires quorum recovery)
- **Network partition** - Partition-aware consensus prevents split-brain

---

## 🛠️ **5. Management**

### **5.1 Administrative Access**

The control plane is managed through:

- **kubeconfig access** - Role-based administrative credentials
- **SSH bastion access** - Controlled through Ansible playbooks
- **Proxmox console** - Emergency access via hypervisor

### **5.2 Updates & Maintenance**

Control plane updates follow a structured process:

- **Staged updates** - Progressive rollout across nodes
- **Proxmox backups** - Pre-update snapshots for recovery
- **Change management** - All updates tracked through CAB process
- **Automated validation** - Post-update verification of cluster health

---

## 📈 **6. Monitoring**

### **6.1 Observability Implementation**

The control plane is monitored through:

- **Prometheus metrics** - Performance and health telemetry
- **Loki logs** - Centralized logging for all components
- **Grafana dashboards** - Visual status and performance tracking
- **AlertManager** - Proactive notification of issues

---

## 🔗 **7. Related Documentation**

| **Document** | **Description** |
|--------------|----------------|
| [Worker Nodes](../worker-nodes/README.md) | Kubernetes compute resources |
| [RKE2 Security](../security/rke2-security-controls.md) | Detailed security implementation |
| [HA Implementation](../high-availability/kubernetes-ha.md) | Control plane HA details |

---

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Control Plane README | VintageDon |
