<!-- 
---
title: "Proxmox VE Infrastructure Documentation"
description: "Comprehensive documentation for the Proxmox Virtual Environment cluster in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["proxmox", "virtualization", "infrastructure", "cluster", "hypervisor"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["Proxmox Backup Server", "RKE2 Kubernetes", "Azure Arc", "Wazuh", "Prometheus"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-1"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 🖥️ **Proxmox VE Infrastructure**

This document provides comprehensive information about the Proxmox Virtual Environment (VE) infrastructure deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the Proxmox VE infrastructure, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for the virtualization platform that forms the foundation of the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Proxmox cluster architecture and configuration | Guest VM internal configurations |
| Node hardware and network implementation | Application-specific workflows |
| VM provisioning and management | End-user application support |
| High availability and redundancy | Business logic implementation |
| Storage architecture and implementation | Data migration processes |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Engineers
- System Administrators
- Operations Personnel
- Security Administrators
- IT Management

## 🔍 **2. Service Overview**

### **2.1 Service Description**

Proxmox VE provides the core virtualization platform for the Proxmox Astronomy Lab, enabling the deployment and management of virtual machines and containers that support all lab functions. Based on a KVM hypervisor with integrated container support, it delivers a high-performance, highly available infrastructure foundation for research, computation, and service deployment.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | INFRA-PROX-001 |
| **Service Type** | Core |
| **Service Category** | Infrastructure |
| **Business Criticality** | Critical |
| **Service Owner** | Infrastructure Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 (Always available) |
| **Support Hours** | Monday-Friday, 08:00-17:00 EST |
| **Maintenance Windows** | Fridays, 10:00-11:00 EST |

## 📊 **3. Technical Architecture**

### **3.1 Cluster Overview**

The Proxmox VE cluster consists of five nodes with specialized roles and capabilities:

| **Node** | **Hardware** | **Purpose** | **Resources** |
|----------|--------------|------------|---------------|
| **node01** | AMD Ryzen 5700U, 64GB RAM, 2TB NVMe | General compute, K8s management | 1Gbps + 2.5Gbps networking |
| **node02** | AMD Ryzen 5700U, 64GB RAM, 2TB NVMe | General compute, K8s management | 1Gbps + 2.5Gbps networking |
| **node03** | AMD Ryzen 5700U, 64GB RAM, 2TB NVMe | General compute, K8s management | 1Gbps + 2.5Gbps networking |
| **node04** | AMD Ryzen 5950X, 128GB RAM, 4TB NVMe, RTX A4000 | GPU-accelerated workloads, high-performance compute | 1Gbps + 2×10G SFP (LACP) |
| **node05** | AMD Ryzen 3700X, 128GB RAM, 2×4TB NVMe, 8×8TB HDD | Storage and backup services | 1Gbps + 2×10G SFP (LACP) |

The cluster leverages a mix of small form factor nodes (node01-03) and performance-oriented nodes (node04-05) to balance space efficiency, power consumption, and computational capabilities.

### **3.2 Network Architecture**

The Proxmox cluster implements a structured VLAN segmentation approach to isolate different types of traffic:

| **VLAN** | **Subnet** | **Purpose** |
|----------|------------|------------|
| **VLAN10** | 10.25.10.0/24 | Control Plane |
| **VLAN20** | 10.25.20.0/24 | Primary Workload Traffic |
| **VLAN30** | 10.25.30.0/24 | Future Expansion |
| **VLAN40** | 10.25.40.0/24 | Provisioning / Onboarding |
| **VLAN50** | 10.25.50.0/24 | Migration Traffic |
| **VLAN60** | 10.25.60.0/24 | Backup Traffic |

Network connectivity is provided through:

- **labswitch01** - Mokerlink 2G16210GSM (16×2.5G RJ45, 2×10G SFP)
- **labswitch02** - Sodola SL-SWTG3C12F (12×10G SFP, 1×RJ45 Console)

The switches are interconnected via 2×10G SFP in an LAG group, with access layer security implemented through the Fortigate 40F firewall.

### **3.3 Storage Architecture**

Proxmox leverages multiple storage types across the cluster:

| **Storage Type** | **Location** | **Purpose** | **Capacity** |
|-----------------|------------|------------|--------------|
| **Local NVMe** | All nodes | VM and Container primary storage | 2-4TB per node |
| **ZFS Pool** | node05 | Shared storage for backups and archives | 8×8TB HDDs in mirrored vdev setup |
| **NFS Storage** | node05 (exported) | Template storage, shared media | 2TB allocation |
| **Proxmox Backup Server** | backup01 VM on node05 | VM and container backups | Multiple datastores |

The storage design prioritizes:

- High-performance local NVMe storage for primary workloads
- Reliable, redundant storage for backups and archival data
- Efficient template distribution and shared resources

### **3.4 Virtual Machine Deployment**

The cluster hosts a comprehensive set of virtual machines across different functional areas:

| **Category** | **Count** | **Examples** | **Purpose** |
|--------------|----------|-------------|------------|
| **Control Plane VMs** | 5 | proj-k8sm01/02/03, lab-dns01/02 | Infrastructure management |
| **Worker Nodes** | 6 | proj-k8sw01/02/03/04/05, proj-kasm01 | Containerized workloads |
| **Database Services** | 7 | proj-pg01, proj-pgts01, proj-pggis01, proj-mariadb01 | Data storage and management |
| **Application Servers** | 4 | proj-apps01, lab-apps01, proj-fs01/02/03 | Application hosting |
| **Security Services** | 2 | lab-soc1, DC01/02 | Security monitoring, identity |
| **Development Resources** | 5 | Various -dev suffixed VMs | Testing and development |

A complete VM inventory is maintained in the [virtual-machine-infrastructure-list.md](../../../../infrastructure/virtual-machine-infrastructure-list.md) document.

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Node Updates | Monthly | Infrastructure Team | [PROX-MAINT-001](../Procedures/PROX-MAINT-001.md) |
| VM Template Updates | Quarterly | Infrastructure Team | [PROX-MAINT-002](../Procedures/PROX-MAINT-002.md) |
| Storage Health Check | Weekly | Infrastructure Team | [PROX-MAINT-003](../Procedures/PROX-MAINT-003.md) |
| Cluster Health Validation | Weekly | Infrastructure Team | [PROX-MAINT-004](../Procedures/PROX-MAINT-004.md) |
| System Updates | Monthly (3rd Friday) | Infrastructure Team | [itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md](../../../../itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

Proxmox VE is monitored through Prometheus using custom exporters:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Node CPU Utilization | >75% sustained | >90% sustained | [PROX-RESP-001](../Procedures/PROX-RESP-001.md) |
| Node Memory Usage | >80% | >90% | [PROX-RESP-002](../Procedures/PROX-RESP-002.md) |
| Storage Utilization | >80% capacity | >90% capacity | [PROX-RESP-003](../Procedures/PROX-RESP-003.md) |
| Cluster Quorum | Warning on node unreachable | Critical on quorum loss | [PROX-RESP-004](../Procedures/PROX-RESP-004.md) |

All metrics are exposed to Prometheus and visualized through dedicated Grafana dashboards on lab-mon01, following procedures defined in [itil-policies-and-procedures/Monitoring/MON-PROC-001.md](../../../../itil-policies-and-procedures/Monitoring/MON-PROC-001.md).

### **4.3 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| VM Migration Failure | Migration error, timeout | Check storage access, network connectivity | KEDB-PROX-001 |
| Node High Load | Performance degradation, VM slowness | Identify resource contention, balance VMs | KEDB-PROX-002 |
| Storage Performance Issues | Slow VM I/O, high latency | Check storage subsystem, optimize VM placement | KEDB-PROX-003 |
| Cluster Communication Issues | Node dropping out of cluster | Verify network connectivity, restart pve-cluster service | KEDB-PROX-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | Role-based with Entra ID MFA | [itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md) |
| API Access | Token-based with minimal privileges | [itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md) |
| Remote Access | SSL/TLS with certificate validation | [itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md](../../../../itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the Proxmox VE infrastructure:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based with Entra integration | Quarterly access review |
| Network Security | VLAN segmentation, firewall rules | Monthly security scans |
| Data Encryption | TLS for management, VM encryption where required | Weekly security audits |
| Auditing | Comprehensive activity logging | Weekly log review, Wazuh alerts |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.2 (Ensure remote access requires MFA) | Entra ID with MFA required for admin access | Entra Sign-in Logs | Compliant |
| CIS.8.3 (Ensure access is revoked upon termination) | AD group-based access with automated provisioning | GLPI Change Records | Compliant |
| CIS.10.1 (Deploy and maintain anti-malware) | Wazuh agent with active scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 (Configure automatic updates) | Scheduled patching process | Patch Management Records | Compliant |

The compliance mapping follows guidelines outlined in [itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md](../../../../itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md).

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

The following backup strategy ensures data protection and recoverability:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|-----------------|-------------|--------------|----------------------|
| VM Backups | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Weekly VM Backups | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly VM Backups | First Sunday of month | 6 months | PBS + AWS Deep Glacier |
| Configuration Backups | Daily | 30 days | PBS (dedicated storage) |

The backup strategy follows the principles defined in [itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md](../../../../itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md).

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Single VM Failure | 15 minutes | 24 hours | [DR-PROX-001](../DR/DR-PROX-001.md) | Infrastructure Team |
| Host Node Failure | 1 hour | 24 hours | [DR-PROX-002](../DR/DR-PROX-002.md) | Infrastructure Team |
| Cluster Quorum Loss | 2 hours | 24 hours | [DR-PROX-003](../DR/DR-PROX-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 48 hours | [DR-PROX-004](../DR/DR-PROX-004.md) | DR Team |

The recovery procedures align with the incident management process defined in [itil-policies-and-procedures/Incident-Management/INC-PROC-001.md](../../../../itil-policies-and-procedures/Incident-Management/INC-PROC-001.md).

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | Proxmox Performance Tuning | [docs/PROX-Tuning-Guide.md](../Guides/PROX-Tuning-Guide.md) | Performance optimization |
| Procedure | VM Provisioning Procedure | [docs/VM-Provisioning.md](../Procedures/VM-Provisioning.md) | Operational procedure |
| Architecture | Infrastructure Architecture Overview | [docs/Infrastructure-Architecture.md](../Architecture/Infrastructure-Architecture.md) | Overall context |
| Hardware | Proxmox Astronomy Lab Hardware Overview | [proxmox-astronomy-lab-hardware-overview.md](../../../../docs/Infrastructure/proxmox-astronomy-lab-hardware-overview.md) | Hardware specifications |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Proxmox VE Administration Guide | <https://pve.proxmox.com/pve-docs/> | [Local Copy](../References/Proxmox-Admin-Guide.pdf) | 2025-04-01 |
| Proxmox Clustering Guide | <https://pve.proxmox.com/wiki/Cluster_Manager> | [Local Copy](../References/Proxmox-Cluster-Guide.pdf) | 2025-04-01 |
| Proxmox Storage Documentation | <https://pve.proxmox.com/wiki/Storage> | [Local Copy](../References/Proxmox-Storage-Guide.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-PROX-2025-001 | Proxmox 8.x Upgrade | 2025-02-15 | [GLPI-CR-PROX-001](https://glpi.lab.local/CR-PROX-2025-001) |
| CR-PROX-2025-002 | Network Enhancement | 2025-03-10 | [GLPI-CR-PROX-002](https://glpi.lab.local/CR-PROX-2025-002) |
| CR-PROX-2025-003 | Storage Expansion | 2025-04-05 | [GLPI-CR-PROX-003](https://glpi.lab.local/CR-PROX-2025-003) |

All changes follow the process defined in [itil-policies-and-procedures/Change-Management/CHG-PROC-001.md](../../../../itil-policies-and-procedures/Change-Management/CHG-PROC-001.md).

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| InfraAdmin | Infrastructure Administrator | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |
