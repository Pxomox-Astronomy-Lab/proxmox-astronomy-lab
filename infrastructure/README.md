<!-- 
---
title: "Infrastructure Overview - Proxmox Astronomy Lab"
description: "High-level documentation of the core infrastructure components that support the Proxmox Astronomy Lab's research and IT operations"
author: "VintageDon"
tags: ["infrastructure", "architecture", "proxmox", "virtualization", "kubernetes", "networking", "storage", "observatory"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["Proxmox", "Kubernetes", "Storage", "Networking", "Control Plane"]
implements_policies: ["Infrastructure Security Policy", "High Availability Policy"]
phase: "phase-1"
---
-->

# 🏗️ **Infrastructure Overview - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

The Proxmox Astronomy Lab infrastructure provides a purpose-built hybrid research and IT environment that supports radio astronomy, AI-driven signal processing, and structured IT operations. This infrastructure forms the foundation for all lab capabilities, balancing performance, security, and modularity to create a cohesive system that bridges high-performance computing and scientific research.

This section offers a comprehensive overview of the lab's infrastructure components, from compute resources and virtualization to networking, storage, and specialized observatory hardware. Rather than being either a traditional enterprise stack or an ad-hoc home lab, this infrastructure represents a carefully designed middle ground that implements professional practices at an appropriate scale for research and education.

---

# 🖥️ **2. Core Infrastructure Components**

## **2.1 Compute & Virtualization**

The compute infrastructure provides the processing capabilities that power all lab services and research workloads.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Proxmox Cluster** | Five-node virtualization platform supporting all lab services | [Proxmox Documentation](./proxmox/README.md) |
| **Kubernetes (RKE2)** | Container orchestration for research applications and services | [Kubernetes Documentation](./kubernetes/README.md) |
| **Control Plane Services** | Core infrastructure services managing identity, security, and automation | [Control Plane Documentation](./control-plane/README.md) |

## **2.2 Networking & Connectivity**

The network infrastructure enables secure, high-performance communication between all lab components.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **VLAN Segmentation** | Logical separation of management, research, and observatory traffic | [Networking Documentation](./networking/README.md) |
| **Edge Security** | Perimeter protection and filtering for external communications | [Networking Documentation](./networking/README.md) |
| **Zero-Trust Access** | Secure remote connectivity via Entra ID and conditional access | [Entra Documentation](/entra-hybrid-cloud/README.md) |

## **2.3 Storage Infrastructure**

Multi-tiered storage solutions support various performance, capacity, and reliability requirements.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Local NVMe Storage** | High-performance storage for virtualization and databases | [Storage Documentation](./storage/README.md) |
| **ZFS Storage Pool** | Reliable, snapshot-capable storage for research data | [Storage Documentation](./storage/README.md) |
| **Object Storage** | S3-compatible storage for unstructured research data | [Storage Documentation](./storage/README.md) |

## **2.4 Research-Specific Infrastructure**

Specialized components dedicated to scientific research and data acquisition.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Observatory Hardware** | Radio astronomy equipment and signal processing chain | [Observatory Documentation](./observatory-hardware/README.md) |
| **Project Services** | Research databases, VDI, and application services | [Projects Documentation](./projects/README.md) |

---

# 📊 **3. Architecture Overview**

The infrastructure architecture follows a layered approach that enables both isolation and integration of various components.

![Infrastructure Diagram](/assets/diagrams/infrastructure-hardware-network-layer-2.png)

The architecture implements several key design principles:

- **High modularity** with structured VLAN segmentation
- **Defense-in-depth** security with layered controls
- **Performance optimization** for research workloads
- **Hybrid identity management** with on-premises and cloud integration
- **Comprehensive monitoring** and observability

---

# 🔄 **4. Implementation Status**

The infrastructure deployment follows a phased approach aligned with the overall lab roadmap.

| **Component** | **Status** | **Implementation Phase** |
|--------------|------------|-------------------------|
| **Proxmox Cluster** | ✅ Complete | Phase 1 |
| **Control Plane Services** | ✅ Complete | Phase 1 |
| **Networking & Security** | ✅ Complete | Phase 1 |
| **Storage Infrastructure** | ✅ Complete | Phase 1 |
| **Kubernetes Deployment** | ✅ Complete | Phase 2 |
| **Observatory Hardware** | ✅ Complete | Phase 2 |
| **Project Services** | 🚧 In Progress | Phase 3 |
| **AI/ML Infrastructure** | 🚧 In Progress | Phase 3 |
| **Public Data Services** | ⏳ Planned | Phase 4 |

---

# 🔗 **5. Directory Contents**

This section provides direct navigation to all subdirectories in the infrastructure category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Control Plane** | Core infrastructure services documentation | [Control Plane](./control-plane/README.md) |
| **Kubernetes** | Container orchestration documentation | [Kubernetes](./kubernetes/README.md) |
| **Networking** | Network architecture and components | [Networking](./networking/README.md) |
| **Observatory Hardware** | Radio astronomy equipment | [Observatory Hardware](./observatory-hardware/README.md) |
| **Projects** | Research-specific virtual machines and services | [Projects](./projects/README.md) |
| **Proxmox** | Virtualization platform documentation | [Proxmox](./proxmox/README.md) |
| **Storage** | Storage architecture and services | [Storage](./storage/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Hardware Overview** | Physical infrastructure summary | [Hardware Overview](./proxmox-astronomy-lab-hardware-overview.md) |
| **VM Infrastructure List** | Complete VM inventory | [VM Infrastructure List](/virtual-machine-infrastructure-list.md) |

---

# 🔄 **6. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Documentation Standards** | Documentation guidelines for infrastructure | [Documentation Standards](/docs/Documentation-Standards/README.md) |
| **Applications** | Services running on infrastructure | [Applications Documentation](/docs/Applications/README.md) |
| **Security & Compliance** | Security controls for infrastructure | [Security Documentation](/docs/Compliance-Security/README.md) |
| **ITIL Processes** | Management processes for infrastructure | [ITIL Documentation](/docs/ITIL-Processes/README.md) |
| **Research Projects** | Scientific work using infrastructure | [Research Documentation](/docs/Research-Projects/README.md) |

---

# ✅ **7. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **8. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for infrastructure overview | VintageDon |
