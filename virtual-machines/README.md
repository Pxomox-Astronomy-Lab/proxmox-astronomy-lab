<!--
---
title: "Virtual Machines"
description: "Comprehensive virtual machine asset documentation and management for enterprise infrastructure supporting research computing, database platforms, security services, and virtual desktop infrastructure across the Proxmox Astronomy Lab"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4 (claude-4-sonnet-20250514)"
date: "2025-08-15"
version: "1.0"
status: "Published"
tags:
- type: directory-overview
- domain: infrastructure
- domain: virtual-machines
- tech: proxmox-ve
- tech: ubuntu-2404
- tech: windows-11
- compliance: cis-benchmark
- phase: phase-0
related_documents:
- "[Infrastructure Overview](../infrastructure/README.md)"
- "[Hardware Platform](../hardware/README.md)"
- "[Security Framework](../security-assurance/README.md)"
---
-->

# 🖥️ **Virtual Machines**

Comprehensive virtual machine asset documentation and management repository supporting enterprise infrastructure across the Proxmox Astronomy Lab ecosystem. This directory provides systematic documentation for VM specifications, configurations, operational procedures, and lifecycle management across VLAN 10 control plane, VLAN 20 project workloads, and VLAN 30 VDI services, establishing the foundation for research computing, database platforms, security services, and virtual desktop infrastructure.

## **Overview**

The virtual machines directory represents the comprehensive documentation framework for our enterprise VM portfolio, encompassing 33 virtual machines across management infrastructure, research computing platforms, container orchestration, and virtual desktop services. This implementation supports our hybrid infrastructure approach combining strategic VM deployments for persistent services with RKE2 Kubernetes orchestration for dynamic workloads, establishing enterprise-grade computing capabilities with CIS Controls v8 Level 2 security baselines and professional operational procedures across all virtual machine assets.

This directory documentation enables systematic VM asset management through complete specifications, security configurations, operational procedures, and integration requirements ensuring consistent enterprise-grade virtual machine operations and comprehensive knowledge management across the astronomy research computing platform.

---

## **📂 Directory Contents**

This section provides systematic navigation to all VM asset documentation and operational guidance within this directory, ensuring complete coverage for knowledge graph connectivity.

### **Subdirectories**

| **Directory** | **Purpose** | **Documentation** |
|--------------|-------------|-------------------|
| **Management VMs (1002-1007)** | Control plane infrastructure and enterprise services | Individual VM documentation files |
| **Project VMs (2001-2023)** | Research computing and application workloads | Individual VM documentation files |
| **Kubernetes Cluster (3001-3003)** | Container orchestration platform with GPU acceleration | Individual VM documentation files |
| **Virtual Desktop Infrastructure (4001-4006)** | VDI services and workspace delivery platforms | Individual VM documentation files |

### **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|-------------|----------|
| **vm-1002-mgmt-ansible01.md** | Ansible automation and configuration management platform | [vm-1002-mgmt-ansible01.md](vm-1002-mgmt-ansible01.md) |
| **vm-1003-radio-dc01.md** | Primary domain controller for enterprise authentication | [vm-1003-radio-dc01.md](vm-1003-radio-dc01.md) |
| **vm-1004-mgmt-veeam01.md** | Veeam backup and disaster recovery platform | [vm-1004-mgmt-veeam01.md](vm-1004-mgmt-veeam01.md) |
| **vm-1005-mgmt-docker01.md** | Docker container platform for management services | [vm-1005-mgmt-docker01.md](vm-1005-mgmt-docker01.md) |
| **vm-1006-mgmt-sec01.md** | Security monitoring and compliance platform | [vm-1006-mgmt-sec01.md](vm-1006-mgmt-sec01.md) |
| **vm-1007-mgmt-agents01.md** | Agent orchestration and distributed services platform | [vm-1007-mgmt-agents01.md](vm-1007-mgmt-agents01.md) |
| **vm-2001-proj-dp01.md** | Data processing and analysis platform | [vm-2001-proj-dp01.md](vm-2001-proj-dp01.md) |
| **vm-2002-proj-pg01.md** | Primary PostgreSQL database for DESI research | [vm-2002-proj-pg01.md](vm-2002-proj-pg01.md) |
| **vm-2003-radio-dc02.md** | Secondary domain controller for project networks | [vm-2003-radio-dc02.md](vm-2003-radio-dc02.md) |
| **vm-2004-proj-dev01.md** | Primary development and testing environment | [vm-2004-proj-dev01.md](vm-2004-proj-dev01.md) |
| **vm-2005-proj-gpu01.md** | GPU-accelerated computing platform | [vm-2005-proj-gpu01.md](vm-2005-proj-gpu01.md) |
| **vm-2007-proj-fs01.md** | File services and distributed storage platform | [vm-2007-proj-fs01.md](vm-2007-proj-fs01.md) |
| **vm-2008-proj-mon01.md** | Monitoring and observability platform | [vm-2008-proj-mon01.md](vm-2008-proj-mon01.md) |
| **vm-2009-port01.md** | Portainer container management platform | [vm-2009-port01.md](vm-2009-port01.md) |
| **vm-2010-proj-fs03.md** | File services and distributed storage platform | [vm-2010-proj-fs03.md](vm-2010-proj-fs03.md) |
| **vm-2011-proj-fs02.md** | File services and distributed storage platform | [vm-2011-proj-fs02.md](vm-2011-proj-fs02.md) |
| **vm-2012-proj-pgsql02.md** | General-purpose PostgreSQL database platform | [vm-2012-proj-pgsql02.md](vm-2012-proj-pgsql02.md) |
| **vm-2014-proj-docker01.md** | Docker container platform for project workloads | [vm-2014-proj-docker01.md](vm-2014-proj-docker01.md) |
| **vm-2015-proj-fs04.md** | Distributed file services platform | [vm-2015-proj-fs04.md](vm-2015-proj-fs04.md) |
| **vm-2016-proj-mongo01.md** | MongoDB document database platform | [vm-2016-proj-mongo01.md](vm-2016-proj-mongo01.md) |
| **vm-2017-proj-milvus01.md** | Milvus vector database for RAG operations | [vm-2017-proj-milvus01.md](vm-2017-proj-milvus01.md) |
| **vm-2018-proj-node4j01.md** | Neo4j graph database platform | [vm-2018-proj-node4j01.md](vm-2018-proj-node4j01.md) |
| **vm-2019-proj-docker02.md** | Secondary Docker container platform | [vm-2019-proj-docker02.md](vm-2019-proj-docker02.md) |
| **vm-2020-proj-ztna01.md** | Zero Trust Network Access gateway | [vm-2020-proj-ztna01.md](vm-2020-proj-ztna01.md) |
| **vm-2021-proj-dev02.md** | Secondary development environment | [vm-2021-proj-dev02.md](vm-2021-proj-dev02.md) |
| **vm-2022-proj-cisbench.md** | CIS benchmarking and compliance validation | [vm-2022-proj-cisbench.md](vm-2022-proj-cisbench.md) |
| **vm-2023-proj-oscal01.md** | OSCAL compliance automation platform | [vm-2023-proj-oscal01.md](vm-2023-proj-oscal01.md) |
| **vm-3001-proj-k8s01.md** | RKE2 Kubernetes cluster node 1 (Primary) | [vm-3001-proj-k8s01.md](vm-3001-proj-k8s01.md) |
| **vm-3002-proj-k8s02.md** | RKE2 Kubernetes cluster node 2 (Secondary) | [vm-3002-proj-k8s02.md](vm-3002-proj-k8s02.md) |
| **vm-3003-proj-k8s03.md** | RKE2 Kubernetes cluster node 3 with GPU | [vm-3003-proj-k8s03.md](vm-3003-proj-k8s03.md) |
| **vm-4001-radio-vdi01.md** | Windows 11 Enterprise virtual desktop 1 | [vm-4001-radio-vdi01.md](vm-4001-radio-vdi01.md) |
| **vm-4002-radio-vdi02.md** | Windows 11 Enterprise virtual desktop 2 | [vm-4002-radio-vdi02.md](vm-4002-radio-vdi02.md) |
| **vm-4003-radio-vdi03.md** | Windows 11 Enterprise virtual desktop 3 | [vm-4003-radio-vdi03.md](vm-4003-radio-vdi03.md) |
| **vm-4004-radio-vdi04.md** | Windows 11 Enterprise virtual desktop 4 | [vm-4004-radio-vdi04.md](vm-4004-radio-vdi04.md) |
| **vm-4005-radio-vdi05.md** | Windows 11 Intune policy testing platform | [vm-4005-radio-vdi05.md](vm-4005-radio-vdi05.md) |
| **vm-4006-proj-kasm01.md** | KASM Workspaces virtual desktop platform | [vm-4006-proj-kasm01.md](vm-4006-proj-kasm01.md) |

---

## **📁 Repository Structure**

``` markdown
virtual-machines/
├── 📚 Management VMs (VLAN 10)/         # Control plane infrastructure
│   ├── vm-1002-mgmt-ansible01.md       # Automation platform
│   ├── vm-1003-radio-dc01.md           # Primary domain controller
│   ├── vm-1004-mgmt-veeam01.md         # Backup platform
│   ├── vm-1005-mgmt-docker01.md        # Management containers
│   ├── vm-1006-mgmt-sec01.md           # Security platform
│   └── vm-1007-mgmt-agents01.md        # Agent orchestration
├── 🔬 Project VMs (VLAN 20)/            # Research and application workloads
│   ├── vm-2001-proj-dp01.md            # Data processing platform
│   ├── vm-2002-proj-pg01.md            # Primary PostgreSQL
│   ├── vm-2003-radio-dc02.md           # Secondary domain controller
│   ├── vm-2004-proj-dev01.md           # Primary development environment
│   ├── vm-2005-proj-gpu01.md           # GPU-accelerated computing
│   ├── vm-2007-proj-fs01.md            # File services (1.5TB)
│   ├── vm-2008-proj-mon01.md           # Monitoring platform
│   ├── vm-2009-port01.md               # Portainer management
│   ├── vm-2010-proj-fs03.md            # File services (1.5TB)
│   ├── vm-2011-proj-fs02.md            # File services
│   ├── vm-2012-proj-pgsql02.md         # General PostgreSQL
│   ├── vm-2014-proj-docker01.md        # Project containers
│   ├── vm-2015-proj-fs04.md            # Distributed file services
│   ├── vm-2016-proj-mongo01.md         # MongoDB document database
│   ├── vm-2017-proj-milvus01.md        # Vector database for RAG
│   ├── vm-2018-proj-node4j01.md        # Neo4j graph database
│   ├── vm-2019-proj-docker02.md        # Secondary Docker platform
│   ├── vm-2020-proj-ztna01.md          # Zero Trust Network Access
│   ├── vm-2021-proj-dev02.md           # Secondary development environment
│   ├── vm-2022-proj-cisbench.md        # CIS benchmarking platform
│   └── vm-2023-proj-oscal01.md         # OSCAL compliance automation
├── ☸️ Kubernetes Cluster (VLAN 20)/     # Container orchestration platform
│   ├── vm-3001-proj-k8s01.md           # RKE2 cluster node 1
│   ├── vm-3002-proj-k8s02.md           # RKE2 cluster node 2
│   └── vm-3003-proj-k8s03.md           # RKE2 cluster node 3 + GPU
├── 🖥️ VDI Infrastructure (VLAN 30)/     # Virtual desktop services
│   ├── vm-4001-radio-vdi01.md          # Windows 11 VDI 1
│   ├── vm-4002-radio-vdi02.md          # Windows 11 VDI 2
│   ├── vm-4003-radio-vdi03.md          # Windows 11 VDI 3
│   ├── vm-4004-radio-vdi04.md          # Windows 11 VDI 4
│   ├── vm-4005-radio-vdi05.md          # Intune policy testing
│   └── vm-4006-proj-kasm01.md          # KASM Workspaces platform
└── 📝 README.md                        # This file
```

### **Navigation Guide:**

- **[📚 Management VMs](vm-1002-mgmt-ansible01.md)** - Control plane infrastructure including automation, domain services, backup, and security platforms
- **[🔬 Project VMs](vm-2001-proj-dp01.md)** - Research computing including databases, development environments, security services, and compliance automation
- **[☸️ Kubernetes Cluster](vm-3001-proj-k8s01.md)** - Container orchestration platform with GPU acceleration for AI/ML workloads
- **[🖥️ VDI Infrastructure](vm-4001-radio-vdi01.md)** - Virtual desktop services including Windows 11 persistent desktops and KASM containerized workspaces

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the knowledge graph, connecting this directory to related domains.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Infrastructure](../infrastructure/README.md)** | VMs provide core infrastructure services and platform foundation | [../infrastructure/README.md](../infrastructure/README.md) |
| **[Hardware](../hardware/README.md)** | VMs deployed on 7-node Proxmox VE cluster infrastructure | [../hardware/README.md](../hardware/README.md) |
| **[Security Assurance](../security-assurance/README.md)** | CIS Controls v8 Level 2 baseline implementation across all VMs | [../security-assurance/README.md](../security-assurance/README.md) |
| **[Applications and Services](../applications-and-services/README.md)** | VMs host containerized applications and enterprise services | [../applications-and-services/README.md](../applications-and-services/README.md) |
| **[AI and Machine Learning](../ai-and-machine-learning/README.md)** | VMs provide GPU acceleration and specialized AI/ML database platforms | [../ai-and-machine-learning/README.md](../ai-and-machine-learning/README.md) |

---

## **Getting Started**

For new users approaching virtual machine management:

1. **Start Here:** [Infrastructure Overview](../infrastructure/README.md) - Understand the broader platform architecture and VM integration
2. **Background Reading:** [Hardware Platform](../hardware/README.md) - Learn about the underlying Proxmox VE cluster infrastructure
3. **Implementation:** [Security Framework](../security-assurance/README.md) - Review CIS Controls v8 implementation across VM assets
4. **Advanced Topics:** [Applications and Services](../applications-and-services/README.md) - Explore containerized services and application deployment

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-08-15 |
| **Last Updated** | 2025-08-15 |
| **Version** | 1.0 |

---
Tags: virtual-machines, vm-assets, infrastructure-documentation, enterprise-architecture, hybrid-kubernetes-vm
