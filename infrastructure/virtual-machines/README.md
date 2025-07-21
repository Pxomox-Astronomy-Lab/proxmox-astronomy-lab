# 🖥️ **Virtual Machines**

Comprehensive documentation and asset management for all virtual machine deployments across the Proxmox Astronomy Lab enterprise infrastructure. This directory serves as the central knowledge repository for VM specifications, configurations, operational procedures, and lifecycle management supporting both VLAN 10 control plane and VLAN 20 project workloads.

## **Overview**

The virtual machines directory provides systematic documentation of our hybrid infrastructure approach, featuring strategic VM deployments for persistent services alongside our RKE2 Kubernetes cluster. Our VM portfolio includes enterprise databases, container orchestration platforms, specialized AI/ML services, and infrastructure coordination systems that form the foundation of our research computing environment.

This directory reflects our enterprise-grade approach to virtual machine management, implementing CIS Controls v8 Level 2 security baselines, comprehensive monitoring, and professional operational procedures across all VM assets. Each virtual machine is documented with complete specifications, security configurations, operational procedures, and integration requirements to ensure consistent management and operational excellence.

---

## **📂 Directory Contents**

This section provides systematic navigation to all VM asset documentation and operational guidance within this directory.

### **Management VMs (VLAN 10 - Control Plane)**

| **VM Asset** | **Purpose** | **Documentation** |
|--------------|-------------|-------------------|
| **[vm-1002-mgmt-ansible01.md](vm-1002-mgmt-ansible01.md)** | Ansible automation and configuration management platform | Enterprise automation orchestration |
| **[vm-1003-radio-dc01.md](vm-1003-radio-dc01.md)** | Primary domain controller for enterprise authentication | Active Directory services coordination |
| **[vm-1004-mgmt-veeam01.md](vm-1004-mgmt-veeam01.md)** | Veeam backup and disaster recovery platform | Enterprise backup management |
| **[vm-1005-mgmt-docker01.md](vm-1005-mgmt-docker01.md)** | Docker container platform for management services | Container orchestration platform |
| **[vm-1006-mgmt-sec01.md](vm-1006-mgmt-sec01.md)** | Security monitoring and compliance platform | Enterprise security coordination |
| **[vm-1007-mgmt-agents01.md](vm-1007-mgmt-agents01.md)** | Agent orchestration and distributed services platform | Management agent coordination |

### **Project VMs (VLAN 20 - Project Workloads)**

| **VM Asset** | **Purpose** | **Documentation** |
|--------------|-------------|-------------------|
| **[vm-2001-proj-dp01.md](vm-2001-proj-dp01.md)** | Data processing and analysis platform | Research computing environment |
| **[vm-2002-proj-pg01.md](vm-2002-proj-pg01.md)** | Primary PostgreSQL database for DESI research | Astronomical database platform |
| **[vm-2003-radio-dc02.md](vm-2003-radio-dc02.md)** | Secondary domain controller for project networks | Distributed authentication services |
| **[vm-2004-proj-dev01.md](vm-2004-proj-dev01.md)** | Development and testing environment | Research development platform |
| **[vm-2005-proj-kasm01.md](vm-2005-proj-kasm01.md)** | Kasm VDI workspace platform | Virtual desktop infrastructure |
| **[vm-2006-proj-rds01.md](vm-2006-proj-rds01.md)** | Remote desktop services platform | Enterprise RDP gateway |
| **[vm-2007-proj-fs01.md](vm-2007-proj-fs01.md)** | File services and distributed storage (1.5TB) | Project data storage platform |
| **[vm-2008-proj-mon01.md](vm-2008-proj-mon01.md)** | Monitoring and observability platform | Enterprise monitoring services |
| **[vm-2009-port01.md](vm-2009-port01.md)** | Portainer container management platform | Docker orchestration interface |
| **[vm-2010-proj-fs03.md](vm-2010-proj-fs03.md)** | File services and distributed storage (1.5TB) | Extended project storage |
| **[vm-2011-proj-fs02.md](vm-2011-proj-fs02.md)** | File services and distributed storage | Project file management |
| **[vm-2012-proj-pgsql02.md](vm-2012-proj-pgsql02.md)** | General-purpose PostgreSQL database platform | Application database services |
| **[vm-2014-proj-docker01.md](vm-2014-proj-docker01.md)** | Docker container platform for project workloads | Project container orchestration |
| **[vm-2015-proj-fs04.md](vm-2015-proj-fs04.md)** | Distributed file services platform | Project file storage coordination |
| **[vm-2016-proj-mongo01.md](vm-2016-proj-mongo01.md)** | MongoDB document database platform | NoSQL document storage services |
| **[vm-2017-proj-milvus01.md](vm-2017-proj-milvus01.md)** | Milvus vector database for RAG operations | Semantic search and AI/ML platform |
| **[vm-2018-proj-node4j01.md](vm-2018-proj-node4j01.md)** | Neo4j graph database platform | Relationship modeling and analytics |

### **Kubernetes Cluster VMs (VLAN 20 - Container Orchestration)**

| **VM Asset** | **Purpose** | **Documentation** |
|--------------|-------------|-------------------|
| **[vm-3001-proj-k8s01.md](vm-3001-proj-k8s01.md)** | RKE2 Kubernetes cluster node 1 (Primary) | Container orchestration foundation |
| **[vm-3002-proj-k8s02.md](vm-3002-proj-k8s02.md)** | RKE2 Kubernetes cluster node 2 (Secondary) | High-availability cluster coordination |
| **[vm-3003-proj-k8s03.md](vm-3003-proj-k8s03.md)** | RKE2 Kubernetes cluster node 3 with GPU | GPU-accelerated container platform |

---

## **📁 Repository Structure**

```
virtual-machines/
├── 📚 Management VMs (VLAN 10)/    # Control plane infrastructure
│   ├── 🤖 vm-1002-mgmt-ansible01.md    # Automation platform
│   ├── 🏢 vm-1003-radio-dc01.md        # Primary domain controller
│   ├── 💾 vm-1004-mgmt-veeam01.md      # Backup platform
│   ├── 🐳 vm-1005-mgmt-docker01.md     # Management containers
│   ├── 🔒 vm-1006-mgmt-sec01.md        # Security platform
│   └── 🔧 vm-1007-mgmt-agents01.md     # Agent orchestration
├── 🔬 Project VMs (VLAN 20)/       # Research and application workloads
│   ├── 📊 vm-2001-proj-dp01.md         # Data processing platform
│   ├── 🗄️ vm-2002-proj-pg01.md         # Primary PostgreSQL
│   ├── 🏢 vm-2003-radio-dc02.md        # Secondary domain controller
│   ├── 💻 vm-2004-proj-dev01.md        # Development environment
│   ├── 🖥️ vm-2005-proj-kasm01.md       # VDI workspace platform
│   ├── 🚪 vm-2006-proj-rds01.md        # RDP gateway
│   ├── 📁 vm-2007-proj-fs01.md         # File services (1.5TB)
│   ├── 📈 vm-2008-proj-mon01.md        # Monitoring platform
│   ├── 🌊 vm-2009-port01.md            # Portainer management
│   ├── 📁 vm-2010-proj-fs03.md         # File services (1.5TB)
│   ├── 📁 vm-2011-proj-fs02.md         # File services
│   ├── 🗄️ vm-2012-proj-pgsql02.md      # General PostgreSQL
│   ├── 🐳 vm-2014-proj-docker01.md     # Project containers
│   ├── 📁 vm-2015-proj-fs04.md         # Distributed file services
│   ├── 📄 vm-2016-proj-mongo01.md      # MongoDB document database
│   ├── 🧠 vm-2017-proj-milvus01.md     # Vector database for RAG
│   └── 🕸️ vm-2018-proj-node4j01.md     # Neo4j graph database
├── ☸️ Kubernetes Cluster/          # Container orchestration platform
│   ├── 🏗️ vm-3001-proj-k8s01.md       # RKE2 cluster node 1
│   ├── 🏗️ vm-3002-proj-k8s02.md       # RKE2 cluster node 2
│   └── 🚀 vm-3003-proj-k8s03.md       # RKE2 cluster node 3 + GPU
└── 📋 README.md                    # This file
```

### **Navigation Guide:**

- **📚 Management VMs** - Control plane infrastructure and enterprise services
- **🔬 Project VMs** - Research computing and application workloads  
- **☸️ Kubernetes Cluster** - Container orchestration platform with GPU acceleration
- **🗄️ Database Platforms** - Comprehensive multi-modal database ecosystem
- **📁 File Services** - Distributed storage and data management

---

## **🏗️ Infrastructure Architecture**

### **VM Portfolio Overview**

| **Category** | **Count** | **Total Resources** | **Purpose** |
|--------------|-----------|-------------------|-------------|
| **Management VMs** | 6 VMs | ~60GB RAM, ~24 vCPU | Control plane and enterprise services |
| **Project VMs** | 12 VMs | ~200GB RAM, ~80 vCPU | Research computing and applications |
| **Kubernetes Cluster** | 3 VMs | 96GB RAM, 48 vCPU, 3TB storage | Container orchestration platform |
| **Total Platform** | **21 VMs** | **~356GB RAM, ~152 vCPU** | **Enterprise research computing** |

### **Database Ecosystem**

Our comprehensive database platform supports diverse data models and research requirements:

| **Database Platform** | **Type** | **Purpose** | **VM Asset** |
|----------------------|----------|-------------|--------------|
| **PostgreSQL** | Relational | DESI research data, applications | proj-pg01, proj-pgsql02 |
| **MongoDB** | Document | Flexible schema, JSON storage | proj-mongo01 |
| **Milvus** | Vector | Semantic search, RAG operations | proj-milvus01 |
| **Neo4j** | Graph | Relationship modeling, analytics | proj-node4j01 |

### **Hybrid Architecture Benefits**

- **Strategic VMs** for persistent services (databases, file storage, RDP gateways)
- **RKE2 Kubernetes** for dynamic workloads (AI/ML, microservices, distributed computing)
- **GPU acceleration** available to Kubernetes cluster for AI/ML workloads
- **Enterprise security** with CIS Controls v8 Level 2 across all platforms

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the knowledge graph, connecting virtual machines to related infrastructure domains.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Hardware](../hardware/README.md)** | VMs deployed on 7-node Proxmox cluster | [../hardware/README.md](../hardware/README.md) |
| **[Infrastructure](../infrastructure/README.md)** | VMs provide core infrastructure services | [../infrastructure/README.md](../infrastructure/README.md) |
| **[Security](../security/README.md)** | CIS Controls v8 L2 baseline across all VMs | [../security/README.md](../security/README.md) |
| **[Monitoring](../monitoring/README.md)** | VM performance and health monitoring | [../monitoring/README.md](../monitoring/README.md) |
| **[Projects](../projects/README.md)** | VMs support active research projects | [../projects/README.md](../projects/README.md) |

---

## **🚀 Getting Started**

For new users approaching virtual machine management:

1. **Start Here:** [Enterprise Infrastructure Overview](../infrastructure/README.md)
2. **Database Platforms:** [Database Infrastructure](../infrastructure/databases/README.md)  
3. **Kubernetes Cluster:** [RKE2 Orchestration](../infrastructure/k8s-rke2/README.md)
4. **Security Framework:** [CIS Controls Implementation](../security/README.md)
5. **Operational Procedures:** [VM Lifecycle Management](lifecycle-management/README.md)

### **Quick Reference:**

- **🔬 DESI Research VMs:** proj-pg01 (database), proj-dp01 (analysis)
- **☸️ Kubernetes Cluster:** proj-k8s01/02/03 (3-node RKE2 with GPU)
- **🗄️ Database Ecosystem:** PostgreSQL, MongoDB, Milvus, Neo4j
- **🐳 Container Platforms:** Docker (mgmt-docker01, proj-docker01) + Kubernetes
- **📁 File Services:** proj-fs01/02/03/04 (distributed storage)

---

## **📊 Platform Statistics**

### **Resource Allocation**

| **Resource Type** | **Management VMs** | **Project VMs** | **Kubernetes Cluster** | **Total** |
|------------------|-------------------|-----------------|------------------------|-----------|
| **Memory (RAM)** | ~60GB | ~200GB | 96GB | **~356GB** |
| **vCPU Cores** | ~24 | ~80 | 48 | **~152 vCPU** |
| **Storage** | ~500GB | ~8TB | 3TB | **~11.5TB** |

### **Security Compliance**

- **✅ CIS Controls v8 Level 2** baseline across all VMs
- **✅ Enterprise authentication** integration
- **✅ Comprehensive monitoring** and audit logging
- **✅ Professional backup** and disaster recovery

### **Operational Capabilities**

- **🔬 Production research workloads** (DESI DR1 analysis)
- **🧠 AI/ML acceleration** with GPU passthrough
- **🗄️ Multi-modal databases** supporting diverse data types
- **☸️ Container orchestration** with enterprise reliability
- **📊 Enterprise monitoring** and observability

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: virtual-machines, vm-assets, infrastructure-documentation, enterprise-architecture, hybrid-kubernetes-vm
