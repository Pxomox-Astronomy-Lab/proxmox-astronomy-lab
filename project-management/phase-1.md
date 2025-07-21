I'll rewrite the phase-1.md file to align with your documentation structure and style guidelines.

<!-- 
---
title: "Proxmox Astronomy Lab - Phase 1: Core Infrastructure Foundation"
description: "Documentation of Phase 1 implementation for the Proxmox Astronomy Lab, detailing the core infrastructure foundation and security baseline"
author: "VintageDon"
tags: ["phase-1", "infrastructure", "proxmox", "kubernetes", "security", "networking"]
category: "Implementation"
kb_type: "Reference"
version: "1.0"
status: "Completed"
last_updated: "2025-01-15"
---
-->

# 🏗️ **Proxmox Astronomy Lab - Phase 1: Core Infrastructure Foundation**

# 🔍 **1. Overview**

Phase 1 established the **fundamental infrastructure** for the Proxmox Astronomy Lab. This phase was designed to ensure a **secure, high-performance, and modular environment**, balancing the **small-form-factor constraints of the hardware** while still supporting **scalability and structured research workflows**.

The core infrastructure layer developed during this phase provides the essential foundation upon which all research and operational capabilities are built, with emphasis on security, reliability, and proper segmentation between infrastructure and research functions.

## **1.1 Key Phase 1 Goals**

| **Goal** | **Implementation Focus** |
|----------|------------------------|
| **Enterprise-grade foundation** | Production-ready environment compatible with small-form-factor hardware |
| **Security baseline** | Strong security and compliance implementation from the beginning |
| **Modular architecture** | Scalable and adaptable compute, network, and storage layers |
| **Core services** | Observability, automation, and identity management implementation |

[📄 **Full Architectural Design: [Infrastructure Architecture](docs/infrastructure/architecture.md)**]

---

# 🖥️ **2. Compute & Network Architecture**

## **2.1 Proxmox Cluster Deployment**

The lab was designed around a **five-node Proxmox cluster**, ensuring high availability, performance, and flexibility.

| **Node** | **CPU** | **RAM** | **Networking** | **Primary Role** |
|---------|--------|--------|--------------|----------------|
| **Node01** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Mgmt |
| **Node02** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Mgmt |
| **Node03** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Mgmt |
| **Node04** | Ryzen 5950X | 128GB | 10G | Proxmox, AI/ML workloads, GPU |
| **Node05** | Ryzen 3700X | 128GB | 10G | Storage & Backup |

This cluster configuration provides:

- **High modularity** with structured VLAN segmentation
- **Performance tuning** optimized for research workloads
- **Heterogeneous capabilities** with specialized nodes for different functions

## **2.2 Network Segmentation & Security**

Network architecture was implemented with clear boundaries between different functional areas.

| **Network Segment** | **VLAN ID** | **Purpose** | **Security Controls** |
|--------------------|------------|------------|---------------------|
| **Management Network** | VLAN10 | Infrastructure management | Strict ACLs, restricted routing |
| **Research Network** | VLAN20 | Research workloads | Controlled access to data storage |
| **Edge Network** | VLAN30 | External data collection | Isolated with specific routes |
| **Out-of-Band** | VLAN99 | Emergency management | Physical access controls |

Additional security measures included:

- **Firewall & ACLs** configured for controlled access between segments
- **Azure Arc onboarded** all VMs for remote monitoring and assessment
- **Network monitoring** with full packet visibility for security analysis

---

# 🔐 **3. Identity & Access Management**

## **3.1 Windows Server 2025 Active Directory**

Identity management was established with an on-premises Active Directory infrastructure.

| **Component** | **Implementation** | **Purpose** |
|--------------|-------------------|------------|
| **Primary DC (DC01)** | Windows Server 2025 | Domain authentication, VLAN10 |
| **Secondary DC (DC02)** | Windows Server 2025 | Redundant authentication, VLAN20 |
| **Entra ID Connect** | Hybrid identity | Cloud integration with local AD |
| **SSO Configuration** | SAML & OpenID Connect | Unified authentication across services |

Key identity capabilities implemented:

- **Hybrid Entra ID Join** enabled with Seamless SSO, SSPR, Password Hash Sync
- **Role-based group structure** for granular access control
- **Attribute-based conditional access** for environmental security

## **3.2 Secure Authentication & Compliance**

Authentication mechanisms were implemented across all systems to ensure consistent security.

| **System Type** | **Authentication Method** | **Security Standard** |
|----------------|---------------------------|----------------------|
| **Linux VMs** | Active Directory integration | CISv8 Level 2 |
| **Windows VMs** | Active Directory | CISv9 Level 1 |
| **Containers** | Service accounts with least privilege | Security baseline |
| **Applications** | OAuth2/OIDC with MFA | NIST guidelines |

Additional security measures:

- **SSH access via AD groups**, enforcing role-based access control
- **Just-In-Time privileged access** for administrative functions
- **MFA enforcement** for all user access paths

---

# 🔒 **4. Security, Compliance & Observability**

## **4.1 Hardened VM Baselines**

Security was implemented from the foundation with hardened baseline VM templates.

| **Template** | **Security Standard** | **Verification Method** |
|--------------|----------------------|------------------------|
| **Ubuntu 24.04** | CISv8 Level 2 | Lynis score 87 |
| **Windows Server 2025** | CISv9 Level 1 | CIS-CAT Pro |

These hardened templates included:

- **Security Baselines** mapped to ISO27001/NIST controls
- **Automated scanning** with RKHunter, CHKRoot, Lynis, AuditD for Linux
- **Windows hardening** with appropriately configured audit policies
- **Daily Security Scanning** across all systems to verify compliance

## **4.2 Monitoring & Security Stack**

A comprehensive monitoring infrastructure was established to ensure visibility across all systems.

| **Component** | **Implementation** | **Purpose** |
|--------------|-------------------|------------|
| **Prometheus** | Time-series metrics | Performance monitoring |
| **AlertManager** | Alert routing | Notification management |
| **Loki** | Log aggregation | Centralized logging |
| **Grafana** | Visualization | Dashboards and reporting |
| **InfluxDB** | Time-series database | Long-term metrics storage |
| **Wazuh SIEM** | Security monitoring | Threat detection |

This monitoring stack enables:

- **Comprehensive visibility** across all infrastructure components
- **Proactive alerting** for performance and security issues
- **Historical trend analysis** for capacity planning
- **Security event correlation** for threat detection

---

# 💾 **5. Storage & Backup Architecture**

## **5.1 Storage Implementation**

A multi-tiered storage architecture was implemented to support different workload requirements.

| **Storage Type** | **Implementation** | **Purpose** |
|-----------------|-------------------|------------|
| **NVMe-backed S3** | MinIO on local NVMe | High-performance object storage |
| **NFS Storage** | ZFS on Node05 | VM and container persistent storage |
| **Local VM Storage** | Proxmox local-lvm | OS and application storage |
| **Object Storage** | S3 protocol | Research data and backup target |

This architecture provides:

- **Performance tiers** based on workload requirements
- **Data redundancy** through appropriate RAID levels
- **Scalable capacity** for research data growth

## **5.2 Backup Strategy**

A comprehensive backup system was implemented to ensure data protection and recovery capabilities.

| **Component** | **Backup Method** | **Retention Policy** |
|--------------|-------------------|---------------------|
| **Virtual Machines** | Proxmox Backup Server | 7 daily, 1 weekly, 1 monthly |
| **Container Data** | Volume snapshots to S3 | Daily for 7 days |
| **Research Data** | Immutable S3 object versioning | 30-day versioning |
| **Configuration** | Git-based configuration tracking | Full history |

This backup approach ensures:

- **Multiple recovery points** for different time horizons
- **Fast recovery options** for common failure scenarios
- **Compliance with retention requirements** for research data

---

# 🚢 **6. Kubernetes & Research Compute**

## **6.1 RKE2 Kubernetes Cluster**

A production-grade Kubernetes cluster was established as the foundation for containerized workloads.

| **Component** | **Implementation** | **Scale** |
|--------------|-------------------|----------|
| **Management Plane** | RKE2 on CIS-hardened Ubuntu | 3 nodes |
| **Worker Nodes** | RKE2 workers | 5 nodes |
| **Storage Integration** | Longhorn | Replicated persistent storage |
| **Networking** | Calico CNI | Network policy enforcement |

The Kubernetes environment includes:

- **Helm, Traefik, CertManager** for deployment management and ingress
- **GPU passthrough** for AI/ML workloads on Node04
- **Azure Container Registry integration** for private image hosting
- **Horizontal autoscaling** for compute-intensive research workloads

## **6.2 Initial Research & Scientific Infrastructure**

Early research infrastructure was established to validate the platform's capabilities.

| **Component** | **Implementation** | **Purpose** |
|--------------|-------------------|------------|
| **Hydrogen Line Feed** | Initial calibration | Signal detection validation |
| **SDR Processing** | Airspy SDR setup | Radio astronomy data capture |
| **Data Processing Pipeline** | Preliminary workflow | Signal analysis and storage |

These initial research components:

- **Validated platform capabilities** for astronomy research
- **Established baseline performance** for signal processing
- **Created groundwork** for Phase 2 research activities

---

# 🔄 **7. Transition to Phase 2**

With the foundational infrastructure completed, the lab began transition to Phase 2, focusing on expanding from basic infrastructure to operational services.

| **Phase 2 Focus Area** | **Building on Phase 1** |
|------------------------|------------------------|
| **Structured ITSM & Change Management** | GLPI implementation leveraging identity foundation |
| **Research Infrastructure Validation** | Hydrogen line detection using compute infrastructure |
| **Observability Workflow Formalization** | Expanding monitoring capabilities |
| **Service Catalog Development** | Documenting and standardizing available services |

[📄 **Next: [Phase 2 Documentation](PHASE-2.md)**]

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-01-15 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-01-15 | Initial documentation | VintageDon |
