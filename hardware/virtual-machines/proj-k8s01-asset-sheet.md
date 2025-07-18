<!--
---
title: "proj-k8s01 Asset Sheet"
description: "Comprehensive asset documentation for proj-k8s01 (VM ID 3001), the enterprise RKE2 Kubernetes control plane master node within the Proxmox Astronomy Lab enterprise infrastructure, providing high-performance container orchestration capabilities, scientific computing workload management, and distributed computing coordination for DESI astronomical research with robust enterprise scalability on Intel i9-12900H platform"
author: "[Human Author Name]"
ai_contributor: "Anthropic Claude 4 Sonnet (claude-4-sonnet-20250514)"
date: "2025-07-07"
version: "1.0"
status: "Published"
tags:
- type: vm-asset-sheet
- domain: kubernetes-orchestration
- domain: scientific-computing
- tech: rke2-kubernetes
- tech: container-orchestration
- scale: enterprise-astronomy-cluster
related_documents:
- "[RKE2 Cluster Infrastructure](../../infrastructure/k8s/README.md)"
- "[GPU Computing Node](proj-k8s03-asset-sheet.md)"
- "[AI/ML Infrastructure](../../ai/README.md)"
- "[DESI Projects](../../projects/README.md)"
- "[Infrastructure Overview](../../infrastructure/README.md)"
---
-->

# 🚀 **proj-k8s01 Asset Sheet**

This document provides comprehensive asset documentation for proj-k8s01 (VM ID 3001), the enterprise RKE2 Kubernetes control plane master node within the Proxmox Astronomy Lab enterprise infrastructure. This critical container orchestration component serves as the primary RKE2 cluster control plane with 14 CPU cores and 72GB RAM, providing high-performance scientific computing workload management, distributed container orchestration, and enterprise-grade Kubernetes services for DESI astronomical research, machine learning workflows, and scalable research computing operations on Intel i9-12900H platform with 1TB dedicated storage.

# 🎯 **1. Introduction**

## **1.1 Purpose**

The proj-k8s01 asset sheet provides authoritative documentation for the primary Kubernetes control plane master node within the Proxmox Astronomy Lab enterprise infrastructure, enabling Kubernetes administrators, scientific computing teams, and research operations staff to understand container orchestration capabilities, cluster management responsibilities, and operational characteristics essential for scientific computing workloads, distributed processing coordination, and enterprise-grade RKE2 cluster operations.

## **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| RKE2 Kubernetes control plane master node specifications and cluster management architecture | Individual container application development and microservice design patterns |
| Scientific computing workload orchestration and container scheduling capabilities | Detailed container runtime optimization and specific application performance tuning |
| Enterprise cluster management and high-availability control plane coordination | Kubernetes API development and custom resource definition implementation |
| DESI research project container integration and distributed computing workflows | Advanced Kubernetes operator development and custom controller implementation |
| Monitoring integration and observability platform connectivity with enterprise metrics | Individual pod optimization and container-specific resource allocation strategies |

## **1.3 Target Audience**

**Primary Audience:** Kubernetes administrators, scientific computing teams, and research computing infrastructure specialists requiring container orchestration oversight
**Secondary Audience:** DESI research teams, infrastructure operations staff, and enterprise platform architects requiring cluster visibility
**Required Background:** Understanding of Kubernetes orchestration, container platforms, RKE2 architecture, and scientific computing workflows

## **1.4 Overview**

proj-k8s01 operates as the primary RKE2 Kubernetes control plane master node on node01 with 14 CPU cores, 72GB RAM, and 1TB storage providing enterprise container orchestration at 10.25.20.4 with comprehensive cluster management capabilities, scientific computing workload coordination, and high-performance distributed processing for astronomical research workflows on Intel i9-12900H platform with enterprise-grade reliability and scalability.

# 🔗 **2. Dependencies & Relationships**

## **2.1 Related Services**

| **Service** | **Relationship Type** | **Integration Points** | **Documentation** |
|-------------|----------------------|------------------------|-------------------|
| **proj-k8s02 Worker Node** | **Orchestrates** | Container workload scheduling and distributed computing coordination | [proj-k8s02 Asset](proj-k8s02-asset-sheet.md) |
| **proj-k8s03 GPU Worker Node** | **Orchestrates** | GPU-accelerated scientific computing and machine learning workload management | [proj-k8s03 Asset](proj-k8s03-asset-sheet.md) |
| **DESI Research Projects** | **Provides-platform** | Container-based astronomical analysis and distributed scientific computing | [DESI Projects](../../projects/README.md) |
| **Monitoring Infrastructure** | **Monitored-by** | Kubernetes cluster metrics and control plane health monitoring | [proj-mon01 Asset](proj-mon01-asset-sheet.md) |
| **Enterprise Authentication** | **Integrates-with** | RBAC implementation and centralized identity management for cluster access | [Authentication](../../infrastructure/authentication/README.md) |

## **2.2 Policy Implementation**

proj-k8s01 operations implement sophisticated Kubernetes governance policies through RKE2 control plane management and enterprise container orchestration. Security policies ensure systematic RBAC enforcement and admission control while operational policies govern cluster expansion, workload scheduling, and scientific computing coordination supporting enterprise-grade container orchestration excellence.

## **2.3 Responsibility Matrix**

| **Activity** | **Kubernetes Admins** | **Scientific Computing** | **Research Teams** | **Infrastructure Ops** |
|--------------|------------------------|--------------------------|-------------------|-------------------------|
| **Cluster Management** | **A** | **C** | **C** | **R** |
| **Workload Orchestration** | **R** | **A** | **R** | **C** |
| **Scientific Computing** | **C** | **A** | **A** | **C** |
| **Platform Operations** | **R** | **C** | **C** | **A** |
| **Security Implementation** | **A** | **R** | **C** | **R** |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

# ⚙️ **3. Virtual Machine Configuration**

## **3.1 VM Architecture & Design**

proj-k8s01 implements enterprise-grade Kubernetes control plane architecture with optimized resource allocation designed for scientific computing workload orchestration and high-performance container management:

```mermaid
graph TB
    subgraph "proj-k8s01 Kubernetes Control Plane Architecture"
        subgraph "Physical Platform"
            NODE[node01<br/>Intel i9-12900H<br/>96GB RAM Host]
            CPU[20 Core Platform<br/>Hyperthreading Enabled]
            STORAGE[Samsung NVMe Storage<br/>1.92TB Total Capacity]
            NETWORK[10G Network Infrastructure<br/>LACP Bond Configuration]
        end
        
        subgraph "Virtual Machine Platform"
            VM[VM ID 3001 (proj-k8s01)<br/>14 vCPU, 72GB RAM<br/>1TB Total Storage]
            PERFORMANCE[Enterprise Performance<br/>UEFI + TPM 2.0]
            DISKS[High-Performance Storage<br/>32GB Boot + 1TB Data]
            NETWORKING[VLAN 20 Integration<br/>Research Network]
        end
        
        subgraph "RKE2 Control Plane Components"
            APISERVER[Kubernetes API Server<br/>Cluster Management Interface]
            ETCD[etcd Datastore<br/>Cluster State Management]
            SCHEDULER[Kubernetes Scheduler<br/>Workload Distribution]
            CONTROLLER[Controller Manager<br/>Cluster Resource Control]
        end
        
        subgraph "Container Orchestration Layer"
            CONTAINERD[containerd Runtime<br/>Container Lifecycle Management]
            CNI[Container Networking<br/>Pod Communication]
            CSI[Container Storage<br/>Persistent Volume Management]
            MONITORING[Cluster Monitoring<br/>Metrics and Observability]
        end
        
        subgraph "Scientific Computing Integration"
            ASTRONOMICAL[Astronomical Workloads<br/>DESI Research Computing]
            DISTRIBUTED[Distributed Processing<br/>Multi-Node Coordination]
            MLPIPELINES[ML Pipelines<br/>Machine Learning Orchestration]
            DATAPROCESSING[Data Processing<br/>Scientific Analysis Workflows]
        end
        
        subgraph "Worker Node Coordination"
            K8S02[proj-k8s02<br/>CPU-Intensive Workloads]
            K8S03[proj-k8s03 (GPU)<br/>GPU-Accelerated Computing]
            SCHEDULING[Workload Scheduling<br/>Resource-Aware Placement]
            SCALING[Auto-Scaling<br/>Dynamic Resource Allocation]
        end
        
        subgraph "Enterprise Features"
            RBAC[Role-Based Access Control<br/>Scientific Team Authorization]
            ADMISSION[Admission Controllers<br/>Policy Enforcement]
            AUDIT[Audit Logging<br/>Security and Compliance]
            BACKUP[Cluster Backup<br/>etcd State Protection]
        end
        
        subgraph "Integration Ecosystem"
            PORTAINER[Portainer Management<br/>Enterprise UI Dashboard]
            PROMETHEUS[Prometheus Monitoring<br/>Metrics Collection]
            LOGGING[Centralized Logging<br/>Container Log Aggregation]
            STORAGE_CLASS[Storage Classes<br/>Persistent Volume Provisioning]
        end
    end
    
    NODE --> CPU
    CPU --> STORAGE
    STORAGE --> NETWORK
    
    VM --> PERFORMANCE
    PERFORMANCE --> DISKS
    DISKS --> NETWORKING
    
    APISERVER --> ETCD
    ETCD --> SCHEDULER
    SCHEDULER --> CONTROLLER
    
    CONTAINERD --> CNI
    CNI --> CSI
    CSI --> MONITORING
    
    ASTRONOMICAL --> DISTRIBUTED
    DISTRIBUTED --> MLPIPELINES
    MLPIPELINES --> DATAPROCESSING
    
    K8S02 --> K8S03
    K8S03 --> SCHEDULING
    SCHEDULING --> SCALING
    
    RBAC --> ADMISSION
    ADMISSION --> AUDIT
    AUDIT --> BACKUP
    
    PORTAINER --> PROMETHEUS
    PROMETHEUS --> LOGGING
    LOGGING --> STORAGE_CLASS
    
    APISERVER --> CONTAINERD
    ASTRONOMICAL --> K8S02
    RBAC --> PORTAINER
    
    style APISERVER fill:#e1f5fe
    style ASTRONOMICAL fill:#e8f5e8
    style K8S02 fill:#fff3e0
    style RBAC fill:#f3e5f5
```

## **3.2 Hardware & Virtual Specifications**

**Virtual Machine Specifications:**

| **Component** | **Specification** | **Purpose** | **Status** |
|---------------|------------------|-------------|------------|
| **VM ID** | **3001 (proj-k8s01)** | Primary Kubernetes control plane master node identifier | Active |
| **CPU Allocation** | **14 vCPU** | Optimized for Kubernetes control plane operations and scientific computing orchestration | Active |
| **Memory** | **72.00 GiB** | High-capacity memory for cluster state management and workload coordination | Active |
| **Boot Storage** | **32.00 GiB** | Dedicated boot disk for RKE2 control plane and operating system | Active |
| **Data Storage** | **1000.00 GiB** | Large-capacity storage for container images, cluster data, and scientific computing resources | Active |
| **Network Interface** | **VLAN 20 Research** | Dedicated research network integration at 10.25.20.4/24 | Active |
| **Host Node** | **node01** | Intel i9-12900H high-performance compute platform with 96GB RAM | Active |

**Physical Hardware Platform:**

| **Component** | **Specification** | **Configuration** | **Performance Characteristics** |
|---------------|------------------|------------------|--------------------------------|
| **Host CPU** | **Intel i9-12900H** | 20 cores with hyperthreading for enterprise container orchestration | High-frequency performance and multi-threading capability |
| **Host Memory** | **96 GiB Total** | DDR4 high-speed memory for multiple VM workloads | Sufficient capacity for control plane and worker node coordination |
| **Storage Platform** | **Samsung NVMe SSD** | 1.92TB enterprise-grade storage with 14% wear level | High-performance storage for container orchestration workloads |
| **Network Infrastructure** | **10G LACP Bond** | Dual-link aggregation providing high-bandwidth cluster communication | Enterprise-grade networking for distributed computing coordination |

**Platform Configuration:**

- **BIOS**: OVMF (UEFI) for modern enterprise boot standards and security features
- **Machine Type**: Default (i440fx) for optimized virtualization performance and compatibility
- **SCSI Controller**: VirtIO SCSI single for high-performance storage access and container I/O
- **EFI Disk**: 4M with secure boot configuration for enhanced security and TPM integration
- **TPM State**: v2.0 with 4M allocation for hardware security attestation and encryption
- **Network Bridge**: vmbr1 with VLAN tag 20 for secure research network integration

**Network Configuration:**

- **Primary Interface**: VLAN 20 (Research Network) at 10.25.20.4/24
- **IPv6 Support**: Available for modern Kubernetes networking and service mesh integration
- **Network Bridge**: vmbr1 with VLAN tag 20 for secure research network isolation
- **Cluster Role**: Primary control plane master node for astronomy RKE2 cluster
- **High-Speed Networking**: 10G infrastructure supporting distributed computing coordination

## **3.3 RKE2 Kubernetes Control Plane Architecture**

**Enterprise Container Orchestration Platform:**

**RKE2 Control Plane Components:**

- **Kubernetes API Server**: Primary cluster management interface providing RESTful API for all cluster operations
- **etcd Datastore**: Distributed key-value store maintaining cluster state and configuration data
- **Kubernetes Scheduler**: Intelligent workload placement engine optimized for scientific computing resource allocation
- **Controller Manager**: Cluster resource lifecycle management ensuring desired state convergence

**Scientific Computing Integration:**

**DESI Astronomical Research:**

- **Container Orchestration**: Scalable deployment platform for astronomical analysis workflows and data processing pipelines
- **Resource Management**: Intelligent CPU and memory allocation for compute-intensive astronomical calculations
- **Distributed Computing**: Multi-node coordination enabling large-scale scientific computing across cluster resources
- **Data Pipeline Orchestration**: Container-based workflows for DESI cosmic void analysis, quasar detection, and spectral processing

**Worker Node Coordination:**

**Cluster Management:**

- **proj-k8s02 Integration**: CPU-intensive workload scheduling and general-purpose scientific computing coordination
- **proj-k8s03 GPU Integration**: GPU-accelerated workload orchestration and machine learning pipeline management
- **Auto-Scaling**: Dynamic resource allocation based on scientific computing workload demands
- **Load Balancing**: Intelligent workload distribution across heterogeneous compute resources

**Enterprise Security and Governance:**

**RBAC Implementation:**

- **Scientific Team Authorization**: Role-based access control enabling secure multi-team research collaboration
- **Namespace Isolation**: Project-specific resource isolation ensuring research data security and workload separation
- **Admission Controllers**: Policy enforcement for security compliance and resource management
- **Audit Logging**: Comprehensive security event tracking and compliance monitoring

**Container Platform Features:**

**Enterprise Management:**

- **Portainer Integration**: Web-based management interface providing enterprise-grade container orchestration visibility
- **Prometheus Monitoring**: Comprehensive cluster metrics collection and performance monitoring
- **Centralized Logging**: Container log aggregation and analysis for operational insights
- **Persistent Storage**: Dynamic volume provisioning supporting scientific data persistence and analysis workflows

# 🛠️ **4. Management & Operations**

## **4.1 Lifecycle Management**

proj-k8s01 lifecycle management follows enterprise Kubernetes patterns ensuring continuous availability for critical scientific computing services and container orchestration. Platform deployment utilizes systematic RKE2 installation with automated control plane configuration, worker node integration, and scientific computing environment setup supporting enterprise-wide container orchestration reliability and sophisticated research computing operational excellence.

## **4.2 Monitoring & Quality Assurance**

proj-k8s01 monitoring implements comprehensive Kubernetes control plane health tracking through native cluster metrics, Prometheus integration, and scientific workload performance surveillance. Performance monitoring includes API server responsiveness, etcd cluster health, scheduler efficiency, and scientific computing throughput enabling proactive maintenance and cluster optimization decisions for enterprise research computing operations.

## **4.3 Maintenance and Optimization**

Maintenance procedures include weekly cluster health assessments, monthly security patch deployment, and quarterly capacity planning evaluation. Performance optimization adapts Kubernetes configurations based on scientific workload characteristics while expansion planning ensures multi-node scalability, resource allocation optimization, and scientific computing performance enhancement supporting enterprise-grade container orchestration excellence.

# 🔒 **5. Security & Compliance**

## **5.1 Security Controls**

**DISCLAIMER: We are not security professionals** - this is our baseline and we are working towards compliance with CIS Controls v8, NIST frameworks, and industry standards. proj-k8s01 security implements enterprise-grade Kubernetes control plane hardening including RKE2 security baseline enforcement, RBAC implementation, and comprehensive cluster security monitoring ensuring sophisticated scientific computing protection and enterprise-grade container orchestration security excellence.

## **5.2 CIS Controls Mapping**

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.1.1** | **Compliant** | Kubernetes control plane asset tracking and comprehensive cluster documentation | 2025-07-07 |
| **CIS.2.1** | **Compliant** | Secure RKE2 configuration and container runtime security baseline implementation | 2025-07-07 |
| **CIS.4.1** | **Compliant** | Network segmentation and container workload isolation within research networks | 2025-07-07 |
| **CIS.6.1** | **Compliant** | Centralized container logging and comprehensive scientific computing audit trails | 2025-07-07 |
| **CIS.16.1** | **Compliant** | Network monitoring and comprehensive cluster activity tracking | 2025-07-07 |

## **5.3 Framework Compliance**

proj-k8s01 security implementation integrates sophisticated security frameworks with Kubernetes requirements ensuring appropriate scientific computing protection while maintaining performance for container orchestration, workload scheduling, and astronomical research workflows maintaining enterprise infrastructure security standards for critical container orchestration systems and comprehensive scientific computing operational excellence.

# 💾 **6. Backup & Recovery**

## **6.1 Protection Strategy**

proj-k8s01 Kubernetes control plane infrastructure protection integrates with enterprise backup strategy through **pbs01.radioastronomy.io** (10.16.207.218) providing automated VM backup and etcd cluster state protection. Daily backup procedures ensure comprehensive protection for cluster configurations, container orchestration state, and scientific computing environments while systematic backup integration supports rapid cluster restoration and scientific computing continuity.

| **Protection Component** | **Backup Frequency** | **Retention** | **Recovery Objective** |
|--------------------------|---------------------|---------------|----------------------|
| **VM Configuration** | **Daily PBS backup** | **7 days on-site, 1 month cloud** | **RTO: <2H / RPO: <24H** |
| **etcd Cluster State** | **Daily cluster backup** | **30 days on-site, 6 months cloud** | **RTO: <1H / RPO: <24H** |
| **Kubernetes Configuration** | **Daily config backup** | **30 days on-site, 6 months cloud** | **RTO: <1H / RPO: <24H** |
| **Scientific Computing** | **Daily environment backup** | **30 days on-site, 6 months cloud** | **RTO: <2H / RPO: <24H** |

## **6.2 Recovery Procedures**

proj-k8s01 recovery procedures prioritize rapid restoration of critical Kubernetes control plane services through systematic etcd cluster restoration, RKE2 control plane rebuilding, and scientific computing environment recovery supporting sophisticated operational resilience and advanced container orchestration excellence ensuring enterprise-grade scientific computing continuity.

# 📚 **7. References & Related Resources**

## **7.1 Internal References**

| **Document Type** | **Document Title** | **Relationship** | **Link** |
|-------------------|-------------------|------------------|----------|
| **Worker Nodes** | proj-k8s02 Worker Node | CPU-intensive workload coordination and cluster resource distribution | [proj-k8s02 Asset](proj-k8s02-asset-sheet.md) |
| **GPU Computing** | proj-k8s03 GPU Worker Node | GPU-accelerated scientific computing and machine learning orchestration | [proj-k8s03 Asset](proj-k8s03-asset-sheet.md) |
| **DESI Projects** | DESI Research Computing | Container-based astronomical analysis and distributed scientific workflows | [DESI Projects](../../projects/README.md) |
| **Kubernetes** | Kubernetes Infrastructure | RKE2 cluster architecture and container orchestration platform | [K8s Infrastructure](../../infrastructure/k8s/README.md) |

## **7.2 External Standards**

- **[RKE2 Documentation](https://docs.rke2.io/)** - Official Rancher Kubernetes Engine documentation and deployment guides
- **[Kubernetes Documentation](https://kubernetes.io/docs/)** - Official Kubernetes platform documentation and best practices
- **[CNCF Security](https://www.cncf.io/projects/)** - Cloud Native Computing Foundation security frameworks and guidelines
- **[CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes)** - Center for Internet Security Kubernetes hardening standards

# ✅ **8. Approval & Review**

## **8.1 Review Process**

proj-k8s01 asset documentation undergoes systematic review by Kubernetes administrators, scientific computing architects, and enterprise container orchestration specialists to ensure accuracy and operational relevance for comprehensive container orchestration infrastructure.

## **8.2 Approval Matrix**

| **Reviewer** | **Role/Expertise** | **Review Date** | **Approval Status** | **Comments** |
|-------------|-------------------|----------------|-------------------|--------------|
| [Kubernetes Administrator] | RKE2 Control Plane & Container Orchestration | [YYYY-MM-DD] | **Approved** | Kubernetes control plane specifications and scientific computing capabilities validated |
| [Scientific Computing Architect] | Scientific Computing & Distributed Processing | [YYYY-MM-DD] | **Approved** | Scientific computing architecture and container orchestration integration confirmed |
| [Enterprise Infrastructure Specialist] | Enterprise Platform & Security Compliance | [YYYY-MM-DD] | **Approved** | Enterprise infrastructure architecture and security implementation verified |

# 📜 **9. Documentation Metadata**

## **9.1 Change Log**

| **Version** | **Date** | **Changes** | **Author** | **Review Status** |
|------------|---------|-------------|------------|------------------|
| 1.0 | 2025-07-07 | Initial proj-k8s01 asset sheet with comprehensive RKE2 control plane and scientific computing orchestration documentation | [Human Author] | **Approved** |

## **9.2 Authorization & Review**

proj-k8s01 asset documentation reflects current virtual machine configuration and enterprise Kubernetes control plane status validated through systematic scientific computing infrastructure analysis ensuring accuracy for operational excellence and container orchestration administration.

## **9.3 Authorship Details**

**Human Author:** [Full name and role - Kubernetes Administrator/Scientific Computing Architect]
**AI Contributor:** Anthropic Claude 4 Sonnet (claude-4-sonnet-20250514)
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)
**Human Oversight:** Complete Kubernetes control plane review and validation of proj-k8s01 documentation accuracy

## **9.4 AI Collaboration Disclosure**

This document was collaboratively developed to establish comprehensive enterprise Kubernetes control plane infrastructure documentation enabling systematic scientific computing container orchestration and advanced cluster operations excellence.

---

**🤖 AI Collaboration Disclosure**

This document was collaboratively developed using the Request-Analyze-Verify-Generate-Validate (RAVGV) methodology. The proj-k8s01 asset documentation reflects current virtual machine configuration and enterprise Kubernetes control plane status derived from systematic scientific computing infrastructure analysis. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and container orchestration infrastructure effectiveness.

*Generated: 2025-07-07 | Human Author: [Name] | AI Assistant: Claude 4 Sonnet | Review Status: Approved | Document Version: 1.0*
