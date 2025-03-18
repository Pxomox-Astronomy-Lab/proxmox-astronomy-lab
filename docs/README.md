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

[[_TOC_]]

## 🔍 **Overview**

The **Proxmox Astronomy Lab** is a purpose-built hybrid environment that supports **radio astronomy research, AI-driven signal processing, and structured IT operations**. This documentation hub serves as the central knowledge base for all aspects of the lab, from **infrastructure and security** to **research methodologies and data analysis pipelines**.

Our comprehensive knowledge base brings together infrastructure, research, and operations documentation in a structured, searchable format designed for both human readability and AI-assisted retrieval.

### **Key Features:**

✅ **Comprehensive coverage** of all lab components and processes  
✅ **CISv8-compliant security documentation**  
✅ **ITIL-aligned operational processes**  
✅ **Scientific research methodologies and results**  
✅ **Structured for both human readers and AI-assisted retrieval**

---

## 🏢 **About the Lab**

<details>
<summary><b>Click to expand lab details</b></summary>

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
</details>

---

## 🗂️ **Documentation Structure**

Our knowledge base is organized into functional areas that reflect the core components of the lab, making information easily discoverable for different user groups.

| **Section** | **Content** | **Primary Audience** |
|------------|-----------|-------------------|
| [**Applications**](/Applications/index) | Running services, databases, applications | Operators, Engineers |
| [**Compliance-Security**](/Compliance-Security/index) | Security controls, CIS benchmarks, policies | Security Personnel, Auditors |
| [**Control-Plane**](/Control-Plane/index) | Core services, identity, monitoring | Engineers, Administrators |
| [**Documentation-Standards**](/Documentation-Standards/index) | Documentation guidelines, templates, RAG optimization | Contributors, Maintainers |
| [**Entra-Hybrid-Cloud**](/Entra-Hybrid-Cloud/index) | Azure integration, identity management | Security Personnel, Administrators |
| [**Infrastructure**](/Infrastructure/index) | Hardware, virtualization, networking | Engineers, Administrators |
| [**ITIL-Processes**](/ITIL-Processes/index) | Operational procedures, ITIL processes | Operators, Service Desk |
| [**Research-Projects**](/Research-Projects/index) | Research methodologies, findings, datasets | Scientists, Researchers |

---

## 🖥️ **Infrastructure Overview**

<details>
<summary><b>Click to expand infrastructure details</b></summary>

The lab is built on a structured infrastructure foundation designed for performance, security, and research capabilities, balancing computational needs with physical constraints.

### **Compute Resources**

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
</details>

---

## 🔭 **Research Focus**

<details>
<summary><b>Click to expand research details</b></summary>

The lab focuses on several core research initiatives that leverage our infrastructure and specialized equipment to contribute to radio astronomy knowledge.

The following table outlines our primary research areas:

| **Research Area** | **Description** | **Documentation** |
|----------------|---------------|-------------------|
| **Hydrogen Line Studies** | Detection and analysis of neutral hydrogen emissions | [Hydrogen Line Research](/Research-Projects/Hydrogen-Line-Studies/index) |
| **Data Pipelines** | Signal processing and analysis frameworks | [Data Pipeline Architecture](/Research-Projects/Data-Pipelines/index) |
| **RF Monitoring** | RFI detection and mitigation strategies | [RF Monitoring](/Research-Projects/RF-Monitoring/index) |
| **Low Surface Brightness Galaxies** | Detection of diffuse galactic structures | [LSB Galaxy Research](/Research-Projects/Low-Surface-Brightness-Galaxies/index) |
| **Supernova Remnants** | Radio signatures of supernova remnants | [SNR Studies](/Research-Projects/Supernova-Remnants/index) |

Each of these research areas combines hardware instrumentation, signal processing techniques, and data analysis methodologies to extract meaningful astronomical insights.
</details>

---

## 🛡️ **Security & Compliance**

<details>
<summary><b>Click to expand security details</b></summary>

Security forms a foundational element of the lab's architecture and operations, implemented through multiple complementary strategies.

Our security approach includes:

- **CISv8 Level 2 hardening** for all Linux systems
- **CISv9 Level 1 compliance** for Windows servers
- **Zero-Trust Network Architecture** with strict VLAN segmentation
- **Entra Private Access** for secure remote authentication
- **Daily security scanning** with comprehensive logging

This defense-in-depth strategy ensures protection of both IT infrastructure and research data. For complete details, see the [Compliance & Security](/Compliance-Security/index) section.
</details>

---

## 🤖 **Cloud Integration**

<details>
<summary><b>Click to expand cloud details</b></summary>

The lab leverages hybrid cloud capabilities through Microsoft Entra ID and Azure services to enhance both security and operational efficiency.

Our hybrid cloud integration includes:

- **Entra ID** for centralized identity management
- **Azure Arc** for unified governance across on-premises resources
- **Conditional Access** for zero-trust security implementation
- **Private Access** for secure remote connectivity
- **Azure Container Registry** for Kubernetes image management

These integrations extend cloud capabilities to our on-premises environment while maintaining security and control. For details, see the [Entra Hybrid Cloud](/Entra-Hybrid-Cloud/index) section.
</details>

---

## 🧭 **Quick Navigation Guide**

### **For New Users**

We recommend the following navigation path for those new to the lab environment:

1. Start with this README for a high-level overview
2. Explore the [Infrastructure](/Infrastructure/index) section to understand the physical environment
3. Review the [Applications](/Applications/index) documentation for specific components
4. Check the [Research Projects](/Research-Projects/index) section to understand scientific endeavors

### **For Contributors**

Contributors to this documentation should follow these guidelines:

1. Follow the templates in the [Documentation Standards](/Documentation-Standards/index) section
2. Adhere to the established style guide and metadata standards
3. Submit updates through the standard pull request process

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