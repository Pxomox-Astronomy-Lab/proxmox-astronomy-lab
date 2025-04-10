<!-- 
---
title: "Proxmox Astronomy Lab"
description: "A scalable, AI-enhanced research infrastructure for radio astronomy and scientific computing, combining Proxmox, Kubernetes, AI/ML, and modern IT automation."
author: "VintageDon"
tags: ["proxmox", "radio-astronomy", "hydrogen-line", "kubernetes", "infrastructure", "documentation", "ai-ml", "sdr"]
category: "Project Overview"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---
-->

<p align="center">
  <img src="/assets/images/proxmox-astronomy-lab-logo.jpg" alt="proxmox-astronomy-lab-logo">
  <h1 align="center">Proxmox Astronomy Lab</h1>
  <p align="center">
    A structured research environment for radio astronomy, AI-driven signal processing, and advanced IT automation.
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/github/stars/VintageDon/proxmox-astronomy-lab?style=social" alt="Stars">
  <img src="https://img.shields.io/github/forks/VintageDon/proxmox-astronomy-lab?style=social" alt="Forks">
  <img src="https://img.shields.io/github/issues/VintageDon/proxmox-astronomy-lab" alt="Issues">
  <img src="https://img.shields.io/github/issues-pr/VintageDon/proxmox-astronomy-lab" alt="Pull Requests">
  <img src="https://img.shields.io/github/contributors/VintageDon/proxmox-astronomy-lab" alt="Contributors">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
</p>

<details>
<summary>Table of Contents</summary>

- [🔭 **Project Overview**](#-project-overview)
  - [🔍 **1. Introduction**](#-1-introduction)
  - [🔎 **2. Core Components**](#-2-core-components)
    - [**2.1 Three Pillars of the Proxmox Astronomy Lab**](#21-three-pillars-of-the-proxmox-astronomy-lab)
    - [**2.2 Repository Organization**](#22-repository-organization)
      - [**Key Documentation Areas**](#key-documentation-areas)
  - [🛰️ **3. Hydrogen Line Radio Astronomy**](#️-3-hydrogen-line-radio-astronomy)
    - [**3.1 Research Areas**](#31-research-areas)
      - [**3.1.1 High-Velocity Clouds (HVCs)**](#311-high-velocity-clouds-hvcs)
      - [**3.1.2 Low Surface Brightness Galaxies (LSBJs)**](#312-low-surface-brightness-galaxies-lsbjs)
      - [**3.1.3 Signal-to-Noise Ratio (SNR) Optimization**](#313-signal-to-noise-ratio-snr-optimization)
    - [**3.2 Hardware Components**](#32-hardware-components)
    - [**3.3 Data Processing**](#33-data-processing)
    - [**3.4 Future Plans**](#34-future-plans)
  - [🔒 **4. Secure Research Lab**](#-4-secure-research-lab)
    - [**4.1 External Collaboration Capabilities**](#41-external-collaboration-capabilities)
    - [**4.2 Security Architecture**](#42-security-architecture)
  - [📚 **5. Reproducible Documentation**](#-5-reproducible-documentation)
    - [**5.1 Documentation Structure**](#51-documentation-structure)
    - [**5.2 AI-Powered Knowledge Retrieval**](#52-ai-powered-knowledge-retrieval)
  - [🏗️ **6. Lab Infrastructure**](#️-6-lab-infrastructure)
    - [**6.1 Compute \& Storage Architecture**](#61-compute--storage-architecture)
    - [**6.2 Storage Design**](#62-storage-design)
    - [**6.3 Implementation Status**](#63-implementation-status)
  - [⚠️ **7. Disclaimer \& Ethics**](#️-7-disclaimer--ethics)
    - [**7.1 Project Transparency**](#71-project-transparency)
    - [**7.2 AI Ethics \& Responsible Research**](#72-ai-ethics--responsible-research)
      - [**7.2.1 Key Ethical Principles**](#721-key-ethical-principles)
  - [🚀 **8. Getting Started**](#-8-getting-started)
    - [**8.1 Key Starting Points**](#81-key-starting-points)
  - [📡 **9. Community \& Contributions**](#-9-community--contributions)
  - [🤝 **10. Acknowledgments**](#-10-acknowledgments)
  - [📄 **11. License**](#-11-license)
</details>

# 🔭 **Project Overview**

## 🔍 **1. Introduction**

The **Proxmox Astronomy Lab** is a **high-performance research environment** designed for **Hydrogen Line Radio Astronomy, AI-driven SDR signal processing, and secure, remote collaboration**. The lab combines **Proxmox, Kubernetes, AI/ML, and modern IT automation** to create a **reproducible, scalable** research platform built on enterprise-grade practices and open-source technologies.

At its core, the lab is **a fusion of IT engineering and citizen science**—designed not just for **scientific discovery**, but also as a **structured and documented template** for others to replicate. Everything here is designed with **reproducibility, automation, and high-performance computing** in mind.

## 🔎 **2. Core Components**

### **2.1 Three Pillars of the Proxmox Astronomy Lab**

The lab is built around three interconnected areas that form its foundation.

| **Component** | **Description** |
|--------------|----------------|
| **📡 Hydrogen Line Radio Astronomy** | AI-enhanced SDR processing for HVCs, LSBJs, and SNR discovery. A research-grade **SDR observation station** built for **precision Doppler shift analysis** and **long-term hydrogen line tracking**. |
| **🔐 Secure Remote Research & IT Lab** | External researchers & IT professionals can securely access the lab for **radio astronomy data analysis, AI workloads, and IT infrastructure testing**, with **policy-driven access controls**. |
| **📖 Reproducible Documentation & AI Integration** | **Comprehensive GitHub-based documentation** and **public-facing research notes** to help others replicate a high-performance, AI-driven research environment. AI-powered **Retrieval-Augmented Generation (RAG)** allows for **contextual querying** of documentation, policies, and workflows. |

<p align="center">
  <img src="/assets/images/lab-hardware/proxmox-astronomy-lab-sff-hardware.jpg" alt="proxmox-astronomy-lab-sff-hardware">
</p>

### **2.2 Repository Organization**

This repository is organized into the following main directories and files:

| **Directory/File** | **Purpose** |
|-----------------|------------|
| [**📁 assets**](/assets) | Images, diagrams, and visual resources for documentation |
| [**📁 docker**](/docker) | Docker configurations, Portainer stacks, and container definitions |
| [**📁 docs**](/docs) | Primary documentation organized by category |
| [**📁 entra-hybrid-cloud**](/entra-hybrid-cloud) | Entra ID integration and hybrid identity management |
| [**📁 infrastructure**](/infrastructure) | Core infrastructure components and configuration |
| [**📁 itil**](/itil) | IT service management documentation and processes |
| [**📁 k8s-rancher-rke2**](/k8s-rancher-rke2) | Kubernetes configuration and workloads |
| [**📁 lab-services**](/lab-services) | Documentation for lab services and applications |
| [**📁 monitoring**](/monitoring) | Monitoring stack configuration and dashboards |
| [**📁 observatory-and-projects**](/observatory-and-projects) | Radio astronomy projects and research |
| [**📁 wiki**](/wiki) | Knowledge base articles and guides |
| [**📄 phase-1.md**](/phase-1.md) | Core Infrastructure Foundation documentation |
| [**📄 phase-2.md**](/phase-2.md) | Structured Services & Research Validation |
| [**📄 phase-3.md**](/phase-3.md) | Application Deployment & Research Infrastructure |
| [**📄 phase-4.md**](/phase-4.md) | Research Workflows & Public Data Integration |
| [**📄 ROADMAP.md**](/ROADMAP.md) | Project roadmap and phase planning |

#### **Key Documentation Areas**

The docs directory contains detailed documentation organized by function:

| **Docs Subdirectory** | **Content** |
|--------------------|----------|
| [**📁 Applications**](/docs/Applications) | Documentation for all applications and services |
| [**📁 Compliance-Security**](/docs/Compliance-Security) | Security frameworks, policies, and CIS controls |
| [**📁 Control-Plane**](/docs/Control-Plane) | Core infrastructure management services |
| [**📁 Documentation-Standards**](/docs/Documentation-Standards) | Templates and style guides for documentation |
| [**📁 Entra-Hybrid-Cloud**](/docs/Entra-Hybrid-Cloud) | Microsoft Entra ID and Azure integration |
| [**📁 Infrastructure**](/docs/Infrastructure) | Hardware, networking, and virtualization details |
| [**📁 ITIL-Processes**](/docs/ITIL-Processes) | IT service management procedures |
| [**📁 Research-Projects**](/docs/Research-Projects) | Scientific research methodologies and datasets |

## 🛰️ **3. Hydrogen Line Radio Astronomy**

Radio astronomy has traditionally required **large, expensive facilities**—but modern **Software-Defined Radio (SDR) technology, AI, and advanced computing** are changing that. This lab is designed to **push the limits of what's possible in a home-based, research-grade Hydrogen Line observation setup**.

<p align="center">
  <img src="/assets/images/nooelec-h1-parabolic-dish-antenna.jpg" alt="nooelec-h1-parabolic-dish-antenna">
</p>

### **3.1 Research Areas**

The primary scientific focus is on three key research domains that leverage hydrogen line observations.

#### **3.1.1 High-Velocity Clouds (HVCs)**

HVCs are **massive interstellar clouds moving at speeds different from normal galactic rotation**. Studying them can reveal insights into the **formation of galaxies and the cosmic web**. This lab aims to **track the movement of these clouds** over time using **AI-enhanced Doppler shift analysis**.

#### **3.1.2 Low Surface Brightness Galaxies (LSBJs)**

LSBJs are some of the **most elusive objects in the universe**—they have very little visible light but contain **significant hydrogen gas**. This project seeks to **detect their presence using Hydrogen Line emissions**, helping to **map faint galactic structures**.

#### **3.1.3 Signal-to-Noise Ratio (SNR) Optimization**

A major challenge in **amateur radio astronomy** is **weak signals buried in noise**. This lab uses **AI-enhanced noise reduction** techniques to improve the **clarity and reliability of Hydrogen Line observations**.

### **3.2 Hardware Components**

The radio astronomy equipment chain is designed for optimal hydrogen line detection and analysis.

| **Component** | **Hardware** | **Purpose** |
|--------------|-------------|------------|
| **📡 Antenna** | Nooelec Hydrogen Line Parabolic (20 dBi) | Captures Hydrogen Line emissions at 1.42 GHz. |
| **📡 Pre-LNA Filter** | BP-2 Band-Pass Filter | Filters out unwanted RF interference before amplification. |
| **📡 LNA (Amplifier)** | 1420 MHz Cavity LNA (34 dB Gain) | Boosts weak Hydrogen Line signals. |
| **📡 SDR (Receiver)** | Airspy R2 | High dynamic range SDR for precise Hydrogen Line analysis. |
| **📡 Clock Source** | GPS-Disciplined Oscillator (GPSDO) | Provides precise timing for Doppler shift calculations. |
| **📡 Edge Processing** | N100 Mini PC | First-stage SDR signal processing before lab transfer. |

The table above details each component in the signal chain from antenna to initial processing.

<p align="center">
  <img src="/assets/images/hydrogen-line-graph-gnu-radio.jpg" alt="hydrogen-line-graph-gnu-radio">
</p>

### **3.3 Data Processing**

Data from the SDR hardware is processed through multiple stages for analysis and storage.

- SDR captures **real-time 1420 MHz Hydrogen Line data**  
- Data is processed using **AI noise filtering and spectral enhancement**  
- Results are stored in **PostgreSQL & TimescaleDB** for time-series tracking  

### **3.4 Future Plans**

The observatory has several planned enhancements to improve capability and precision.

- **Motorized tracking mount** for **targeted observations**  
- **Upgraded 1.2m dish** for **higher gain and better resolution**  
- **Integration with OpenSpace & AI-enhanced spectral classification**  

## 🔒 **4. Secure Research Lab**

One of the **unique aspects** of this lab is that it's not just for personal research—it also functions as a **secure research platform** that allows external users to **collaborate, test, and run workloads remotely**.

### **4.1 External Collaboration Capabilities**

The lab supports multiple external user workflows for research collaboration.

- Run **SDR processing workloads** remotely  
- Test **AI-driven workflows in Kubernetes**  
- Work with **structured datasets & time-series astronomy data**  

### **4.2 Security Architecture**

The lab implements several security measures to protect research data while enabling collaboration.

| **Security Feature** | **Implementation** |
|----------------------|-------------------|
| **Tailscale with Entra SCIM** | Secure remote access controlled by Entra ID policies and ACLs by group |
| **Role-Based Access Control (RBAC)** | Limits access to different lab functions |
| **Virtualized Research Workspaces** | Kasm Workspaces for browser-based, secure research |
| **CISv8 Compliance** | Ubuntu Server 24.04 LTS @ CISv8 L2, Windows Server 2025 Standard @ CISv9 L1 compliance |
| **Wazuh SEIM/XDR** | Daily CIS scans via CIS-CAT Lite w/controls mapped to NIST/ISO27001 |

The security features above ensure that external collaborators can access resources safely while maintaining data integrity.

## 📚 **5. Reproducible Documentation**

The **Proxmox Astronomy Lab** is not just about research—it's about **documenting everything in a way that others can follow and replicate**. Our documentation covers everything from infrastructure and security to research methodologies and data processing workflows.

### **5.1 Documentation Structure**

The knowledge base is organized to support both human navigation and AI-powered retrieval.

- **GitHub Repository**: All **infrastructure, scripts, and workflows** are public and version-controlled.
- **Step-by-step guides**: From **infrastructure deployment to SDR processing**.
- **Security & Compliance**: Complete **CISv8 implementation** with mappings to **NIST and ISO 27001**.
- **ITIL Processes**: Structured **change management, incident response, and service catalogs**.
- **Research Methodologies**: Detailed procedures for **Hydrogen Line observation and analysis**.

### **5.2 AI-Powered Knowledge Retrieval**

One of the biggest challenges in complex projects is **finding relevant documentation quickly**. This lab uses **AI-powered document retrieval** to allow **natural language queries** on:  

- **Research papers & Hydrogen Line methodology**  
- **Infrastructure configurations & compliance policies**  
- **Custom workflows for AI-powered SDR processing**  

<p align="center">
  <img src="/assets/images/lab-hardware/proxmox-astronomy-lab-node04.jpg" alt="proxmox-astronomy-lab-node04">
  <br>
  <em>HPC Proxmox GPU Node w/RTXA4000 GPU, 5950X and 128GB of RAM</em>
</p>

The result is a **context-aware, AI-enhanced research assistant** that helps users navigate and understand the lab's resources **efficiently**.

## 🏗️ **6. Lab Infrastructure**

### **6.1 Compute & Storage Architecture**

The lab is built on a high-performance infrastructure stack optimized for research workloads.

| **Component** | **Specifications** |
|--------------|-------------------|
| **Compute Nodes** | 3 × Ryzen 5700U (64GB RAM, 2TB NVMe) |
| **High-Performance Node** | Ryzen 5950X (128GB RAM, 4TB NVMe, RTX A4000) |
| **Storage** | Proxmox Node05, ZFS 8×8TB HDD RAID10 + NVMe partition as a SLOG |
| **Network** | Dual 10G SFP for high-speed data transfer |

The table above outlines the key hardware components that make up the lab's infrastructure backbone.

### **6.2 Storage Design**

The storage architecture is optimized for performance and scalability for research workloads.

✅ **All AI/ML & K8s workloads run on local NVMe storage** for maximum performance.  
✅ **Network storage (NFS & S3) provides fast, scalable research data access**.  

### **6.3 Implementation Status**

The lab is being implemented in structured phases, with clear milestones and documentation for each.

| **Phase** | **Focus** | **Status** | **Key Deliverables** |
|-----------|----------|--------------|---------------------|
| [**Phase 1**](phase-1.md) | Core Infrastructure Foundation | ✅ Complete | Proxmox cluster, network segmentation, security baseline |
| [**Phase 2**](phase-2.md) | Structured Services & Research Validation | ✅ Complete | ITSM framework, monitoring stack, initial SDR validation |
| [**Phase 3**](phase-3.md) | Application Deployment & Research Infrastructure | 🚧 In Progress | Kubernetes workloads, AI pipelines, SDR data flow |
| [**Phase 4**](phase-4.md) | Research Workflows & Public Data Integration | ⏳ Upcoming | Real-time processing, public datasets, research dashboards |

See the [ROADMAP.md](ROADMAP.md) for detailed information on each phase and implementation timeline.

## ⚠️ **7. Disclaimer & Ethics**

### **7.1 Project Transparency**

This project is a transparent, living process where we document our successes and our mistakes. We follow real-world ITIL project management principles, but this is also a learning experience. We show our work warts and all for transparency. Mistakes and course corrections are part of the process, and that's intentional.

🔹 Security policies and best practices should not be blindly lifted from this repo. Every lab has unique needs, and configurations here are tailored to our environment. Always review and adapt security measures accordingly.

### **7.2 AI Ethics & Responsible Research**

The Proxmox Astronomy Lab integrates AI/ML-enhanced signal processing, automation, and research workflows, but with a strong commitment to ethical AI practices. AI is a tool to enhance scientific discovery, not to replace rigorous analysis or responsible decision-making.

#### **7.2.1 Key Ethical Principles**

1. **Transparency** - AI/ML models used for SDR processing, RAG knowledge retrieval, and automation are documented, explainable, and auditable.
2. **Data Integrity** – Hydrogen Line radio astronomy data is processed with AI for enhancement, not manipulation. Scientific accuracy remains paramount.
3. **Privacy & Security** – No user data, queries, or access logs are shared or monetized. All AI processing is local, not cloud-based.
4. **Open Science & Reproducibility** – AI-powered signal enrichment and automation pipelines are open-source, so others can verify and improve them.

AI in scientific computing should be aiding research, not obscuring truth. The Proxmox Astronomy Lab adheres to ethical AI guidelines that prioritize transparency, accuracy, and reproducibility over automation for automation's sake.

## 🚀 **8. Getting Started**

To clone and explore the lab's documentation and infrastructure:

```bash
git clone https://github.com/yourusername/proxmox-astronomy-lab.git
cd proxmox-astronomy-lab
```

### **8.1 Key Starting Points**

The following documentation areas provide essential entry points to understanding the project:

- [**Infrastructure Overview**](docs/infrastructure/README.md) - Lab hardware and architecture
- [**ITIL Simulation Approach**](docs/simulation-approach/README.md) - How enterprise IT practices are implemented
- [**Observatory Projects**](docs/observatory-projects/README.md) - Scientific research focus areas
- [**CISv8 Compliance Framework**](docs/compliance-security/cisv8-controls/README.md) - Security implementation

Check out the complete [**Documentation Structure**](docs/README.md) for a comprehensive guide to all resources.

## 📡 **9. Community & Contributions**

This is an **open-source research project**. If you're interested in **AI-powered radio astronomy, high-performance research infrastructure, or IT automation**, feel free to **contribute, test, or collaborate**.

🛰 **Follow the project on GitHub**  
📖 **Read the full documentation in the `/docs` folder**  

## 🤝 **10. Acknowledgments**

This lab builds on the work of many open-source projects and communities, particularly those in radio astronomy, SDR processing, and scientific computing. Special thanks to:

- The **GNU Radio** community
- **RTL-SDR** and **Airspy** developers
- **Proxmox** and **Kubernetes** communities
- **Wazuh**, **Prometheus**, and **Grafana** projects

## 📄 **11. License**

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.
