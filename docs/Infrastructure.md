<!-- 
---
title: "Proxmox Astronomy Lab - Infrastructure Overview"
description: "Comprehensive overview of the lab's infrastructure components, architecture, and organization"
author: "VintageDon"
tags: ["infrastructure", "proxmox", "kubernetes", "networking", "storage"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🏗️ **Proxmox Astronomy Lab - Infrastructure Overview**

Our infrastructure combines enterprise-grade architecture with specialized research capabilities to create a structured environment that supports radio astronomy research, AI-driven signal processing, and modern IT operations.

## 📚 **1. Infrastructure Components**

The lab's infrastructure is organized into functional areas that work together to support our research and operational goals.

| **Component** | **Purpose** | **Key Elements** |
|--------------|------------|-----------------|
| [**Control Plane**](control-plane/README.md) | Core management services | Identity, security, monitoring, automation |
| [**Kubernetes**](kubernetes/README.md) | Research orchestration | RKE2 cluster, containers, research workloads |
| [**Networking**](networking/README.md) | Connectivity and security | VLAN segmentation, edge security, routing |
| [**Observatory Hardware**](observatory-hardware/README.md) | Research equipment | Hydrogen Line receivers, SDR, feed chains |
| [**Proxmox**](proxmox/README.md) | Virtualization platform | Hypervisor nodes, VM management, resource allocation |
| [**Storage**](storage/README.md) | Data management | Multi-tiered storage, research data, backups |
| [**Projects**](projects/README.md) | Research infrastructure | Application services, databases, desktops |
| [**AI/ML**](ai-ml/README.md) | Machine learning | GPU resources, inference services, model hosting |

## 🖥️ **2. Compute Architecture**

Our compute infrastructure is built on a five-node Proxmox cluster that balances performance, capacity, and specialized capabilities.

### **2.1 Cluster Overview**

The Proxmox cluster provides the foundation for all lab services and research workloads.

| **Node** | **CPU** | **RAM** | **Network** | **Primary Role** |
|---------|--------|--------|------------|----------------|
| **Node01** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Management |
| **Node02** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Management |
| **Node03** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Management |
| **Node04** | Ryzen 5950X | 128GB | 10G | AI/ML, GPU Workloads |
| **Node05** | Ryzen 3700X | 128GB | 10G | Storage, Backup |

This architecture strategically balances small form-factor nodes with higher-capacity systems for specialized workloads. For detailed specifications and configurations, see the [Proxmox section](proxmox/README.md).

## 🌐 **3. Network Design**

Our networking infrastructure implements a structured approach to connectivity, security, and performance.

### **3.1 Network Segmentation**

The lab uses VLAN segmentation to create secure boundaries between different functional areas.

| **VLAN** | **Purpose** | **Key Services** |
|---------|------------|----------------|
| **VLAN10** | Control Plane | AD, DNS, Monitoring, Security |
| **VLAN20** | Research & Workloads | K8s, Databases, Applications |

This segmentation enhances both security and performance by isolating management traffic from research data flows. For detailed network architecture information, see the [Networking section](networking/README.md).

## 📡 **4. Research Infrastructure**

Specialized infrastructure supports our radio astronomy research objectives, including custom hardware and data processing capabilities.

### **4.1 Hydrogen Line Research**

Our primary research focus is hydrogen line radio astronomy, supported by specialized equipment and data pipelines. The research chain includes:

- **Custom Hydrogen Line antenna and feed system**
- **Low-noise amplification with precision filtering**
- **SDR signal processing and data capture**
- **Automated processing pipelines and storage**

For complete details on our research hardware, see the [Observatory Hardware section](observatory-hardware/README.md).

## 📊 **5. Services Architecture**

The lab implements a structured service architecture that supports both research and operational needs.

### **5.1 Core Services**

These essential services form the foundation of our operational capabilities:

- **Identity Management** - Windows Server 2025 AD with Entra ID integration
- **Security Operations** - Wazuh SIEM, vulnerability scanning, compliance monitoring
- **Automation** - Ansible-based configuration management and deployment
- **Monitoring** - Prometheus, Loki, and Grafana for comprehensive observability

### **5.2 Research Services**

Specialized services support scientific workflows and data analysis:

- **Database Cluster** - PostgreSQL, TimescaleDB, and PostGIS for research data
- **AI/ML Platform** - GPU-accelerated inference and model serving
- **Data Processing** - Kubernetes-based analysis pipelines and workflows

For detailed service documentation, see the [Control Plane](control-plane/README.md) and [Projects](projects/README.md) sections.

## 🔒 **6. Security Approach**

Security is integrated throughout our infrastructure with a defense-in-depth strategy:

- **CIS-hardened systems** - CISv8 Level 2 (Linux) and CISv9 Level 1 (Windows)
- **Zero-Trust Architecture** - Strict access controls and network segmentation
- **Continuous Monitoring** - Comprehensive logging and security analytics
- **Automated Compliance** - Regular scanning and automated remediation

This approach ensures protection of both research data and infrastructure components.

## 📝 **7. Documentation Structure**

Each infrastructure section follows a consistent documentation approach:

- **README files** provide section overviews
- **Service documentation** details specific components
- **Configuration guides** cover setup and maintenance
- **Troubleshooting resources** address common issues

This structured approach ensures comprehensive coverage of all infrastructure elements.

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial infrastructure README | VintageDon |
