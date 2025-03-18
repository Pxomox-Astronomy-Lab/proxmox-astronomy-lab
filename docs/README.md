<!-- 
---
title: "Proxmox Astronomy Lab - Main Documentation Hub"
description: "The central documentation hub for the Proxmox Astronomy Lab, covering infrastructure, research operations, security, and scientific projects"
author: "VintageDon"
tags: ["documentation", "overview", "kb", "wiki", "proxmox", "astronomy"]
category: "Meta"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🚀 **Proxmox Astronomy Lab**

## 🔍 **1. Overview**

The **Proxmox Astronomy Lab** is a purpose-built hybrid environment that supports **radio astronomy research, AI-driven signal processing, and structured IT operations**. This documentation hub serves as the central knowledge base for all aspects of the lab, from **infrastructure and security** to **research methodologies and data analysis pipelines**.

Our comprehensive knowledge base brings together infrastructure, research, and operations documentation in a structured, searchable format designed for both human readability and AI-assisted retrieval.

### **Key Features:**

✅ **Comprehensive coverage** of all lab components and processes  
✅ **CISv8-compliant security documentation**  
✅ **ITIL-aligned operational processes**  
✅ **Scientific research methodologies and results**  
✅ **Structured for both human readers and AI-assisted retrieval**

---

## 🏢 **2. About the Lab**

The Proxmox Astronomy Lab represents a unique blend of **enterprise-grade IT practices and scientific research infrastructure**. It is designed as a **citizen science environment** that implements professional IT methodologies while conducting valuable radio astronomy research.

The following table outlines our core characteristics and implementation approaches:

| **Characteristic** | **Implementation** |
|---------------|-----------------|
| **Infrastructure** | 5-node Proxmox cluster, Kubernetes, Zero-Trust Security |
| **Research Focus** | Hydrogen Line studies, AI-assisted signal processing |
| **Operations** | ITIL-aligned processes, structured change management |
| **Security** | CISv8 Level 2 (Linux), CISv9 Level 1 (Windows) |
| **Documentation** | Markdown with frontmatter, structured for RAG systems |

These foundational elements work together to create a robust environment for both technical operations and scientific discovery.

---

## 🗂️ **3. Documentation Structure**

Our knowledge base is organized into functional areas that reflect the core components of the lab, making information easily discoverable for different user groups.

The following table shows the primary sections and their intended audiences:

| **Section** | **Content** | **Primary Audience** |
|------------|-----------|-------------------|
| [**Applications**](applications/README.md) | Running services, databases, applications | Operators, Engineers |
| [**Compliance-Security**](compliance-security/README.md) | Security controls, CIS benchmarks, policies | Security Personnel, Auditors |
| [**Control-Plane**](control-plane/README.md) | Core services, identity, monitoring | Engineers, Administrators |
| [**Documentation-Standards**](documentation-standards/README.md) | Documentation guidelines, templates, RAG optimization | Contributors, Maintainers |
| [**Entra-Hybrid-Cloud**](entra-hybrid-cloud/README.md) | Azure integration, identity management | Security Personnel, Administrators |
| [**Infrastructure**](infrastructure/README.md) | Hardware, virtualization, networking | Engineers, Administrators |
| [**ITIL-Processes**](itil-processes/README.md) | Operational procedures, ITIL processes | Operators, Service Desk |
| [**Research-Projects**](research-projects/README.md) | Research methodologies, findings, datasets | Scientists, Researchers |

Each section contains detailed documentation relevant to its focus area, with consistent formatting and metadata.

---

## 🖥️ **4. Infrastructure Overview**

The lab is built on a structured infrastructure foundation designed for performance, security, and research capabilities, balancing computational needs with physical constraints.

### **4.1 Compute Resources**

The lab operates on a **five-node Proxmox cluster** with specialized hardware to support diverse workloads from VM hosting to GPU-accelerated AI processing.

The following table details our node specifications and primary roles:

| **Node** | **CPU** | **RAM** | **Network** | **Primary Role** |
|---------|--------|--------|------------|----------------|
| **Node01** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Management |
| **Node02** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Management |
| **Node03** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Management |
| **Node04** | Ryzen 5950X | 128GB | 10G | AI/ML, GPU Workloads |
| **Node05** | Ryzen 3700X | 128GB | 10G | Storage, Backup |

This distributed architecture provides both redundancy for critical services and specialized capabilities for performance-intensive workloads.

---

## 🔭 **5. Research Focus**

The lab focuses on several core research initiatives that leverage our infrastructure and specialized equipment to contribute to radio astronomy knowledge.

The following table outlines our primary research areas:

| **Research Area** | **Description** | **Documentation** |
|----------------|---------------|-------------------|
| **Hydrogen Line Studies** | Detection and analysis of neutral hydrogen emissions | [Hydrogen Line Research](research-projects/hydrogen-line-studies/README.md) |
| **Data Pipelines** | Signal processing and analysis frameworks | [Data Pipeline Architecture](research-projects/data-pipelines/README.md) |
| **RF Monitoring** | RFI detection and mitigation strategies | [RF Monitoring](research-projects/rf-monitoring/README.md) |
| **Low Surface Brightness Galaxies** | Detection of diffuse galactic structures | [LSB Galaxy Research](research-projects/low-surface-brightness-galaxies/README.md) |
| **Supernova Remnants** | Radio signatures of supernova remnants | [SNR Studies](research-projects/supernova-remnants/README.md) |

Each of these research areas combines hardware instrumentation, signal processing techniques, and data analysis methodologies to extract meaningful astronomical insights.

---

## 📝 **6. Documentation Approach**

Our documentation follows a consistent, structured approach that supports both human readability and machine processing for advanced retrieval.

### **6.1 Markdown with Frontmatter**

All documentation uses **Markdown with YAML frontmatter** to provide rich metadata and consistent formatting across the knowledge base.

This approach offers several key benefits:

- **Structured metadata** - Consistent tagging and categorization
- **Version control** - Tracking changes and maintaining history
- **RAG optimization** - Enhanced retrieval capabilities

The combination of human-readable content and machine-processable metadata creates a powerful knowledge management system. For details on our documentation standards, see the [Documentation Standards](documentation-standards/README.md) section.

---

## 🧭 **7. Navigation Guide**

Our wiki is designed to serve multiple audiences with different information needs, from new users to experienced contributors.

### **7.1 For New Users**

We recommend the following navigation path for those new to the lab environment:

1. Start with this README for a high-level overview
2. Explore the [Infrastructure](infrastructure/README.md) section to understand the physical environment
3. Review the [Applications](applications/README.md) documentation for specific components
4. Check the [Research Projects](research-projects/README.md) section to understand scientific endeavors

This progressive approach builds understanding from fundamentals to specifics.

### **7.2 For Contributors**

Contributors to this documentation should follow these guidelines to maintain consistency:

1. Follow the templates in the [Documentation Standards](documentation-standards/README.md) section
2. Adhere to the established style guide and metadata standards
3. Submit updates through the standard pull request process

Consistent formatting and metadata ensure that the documentation remains valuable and retrievable.

---

## 🎭 **8. Simulation Approach**

The lab implements a unique **role-based simulation approach** that creates a realistic enterprise IT experience within a small-scale environment.

This methodology allows:

- **Experience across multiple IT roles** through structured rotation
- **Implementation of enterprise processes** in a controlled setting
- **Realistic documentation from multiple perspectives**
- **Development of comprehensive technical skills**

Read more about this innovative approach in the [ITIL Processes](itil-processes/README.md) and [Simulation Approach](itil-processes/simulation-approach/README.md) sections.

---

## 🔐 **9. Security & Compliance**

Security forms a foundational element of the lab's architecture and operations, implemented through multiple complementary strategies.

Our security approach includes:

- **CISv8 Level 2 hardening** for all Linux systems
- **CISv9 Level 1 compliance** for Windows servers
- **Zero-Trust Network Architecture** with strict VLAN segmentation
- **Entra Private Access** for secure remote authentication
- **Daily security scanning** with comprehensive logging

This defense-in-depth strategy ensures protection of both IT infrastructure and research data. For complete details, see the [Compliance & Security](compliance-security/README.md) section.

---

## 🤖 **10. Cloud Integration**

The lab leverages hybrid cloud capabilities through Microsoft Entra ID and Azure services to enhance both security and operational efficiency.

Our hybrid cloud integration includes:

- **Entra ID** for centralized identity management
- **Azure Arc** for unified governance across on-premises resources
- **Conditional Access** for zero-trust security implementation
- **Private Access** for secure remote connectivity
- **Azure Container Registry** for Kubernetes image management

These integrations extend cloud capabilities to our on-premises environment while maintaining security and control. For details, see the [Entra Hybrid Cloud](entra-hybrid-cloud/README.md) section.

---

## ⚠️ **Disclaimer**

This project is a transparent, living process where we document our successes and our mistakes. We follow real-world ITIL project management principles, but this is also a learning experience. We show our work warts and all for transparency. Mistakes and course corrections are part of the process, and that's intentional.

Security policies and best practices should not be blindly lifted from this repo. Every lab has unique needs, and configurations here are tailored to our environment. Always review and adapt security measures accordingly.

---

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial wiki README | VintageDon |
