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

 ![proxmox-astronomy-lab-logo](/assets/images/proxmox-astronomy-lab-logo.jpg)

<p align="center">
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

# A Scalable, AI-Enhanced Research Infrastructure for Radio Astronomy and Scientific Computing

The **Proxmox Astronomy Lab** is a **high-performance research environment** designed for **Hydrogen Line Radio Astronomy, AI-driven SDR signal processing, and secure, remote collaboration**. The lab combines **Proxmox, Kubernetes, AI/ML, and modern IT automation** to create a **reproducible, scalable** research platform built on enterprise-grade practices and open-source technologies.

At its core, the lab is **a fusion of IT engineering and citizen science**—designed not just for **scientific discovery**, but also as a **structured and documented template** for others to replicate. Everything here is designed with **reproducibility, automation, and high-performance computing** in mind.

---

## **📡 The Three Pillars of the Proxmox Astronomy Lab**  

| **Component** | **Description** |
|--------------|----------------|
| **📡 Hydrogen Line Radio Astronomy** | AI-enhanced SDR processing for HVCs, LSBJs, and SNR discovery. A research-grade **SDR observation station** built for **precision Doppler shift analysis** and **long-term hydrogen line tracking**. |
| **🔐 Secure Remote Research & IT Lab** | External researchers & IT professionals can securely access the lab for **radio astronomy data analysis, AI workloads, and IT infrastructure testing**, with **policy-driven access controls**. |
| **📖 Reproducible Documentation & AI Integration** | **Comprehensive GitHub-based documentation** and **public-facing research notes** to help others replicate a high-performance, AI-driven research environment. AI-powered **Retrieval-Augmented Generation (RAG)** allows for **contextual querying** of documentation, policies, and workflows. |

 ![proxmox-astronomy-lab-sff-hardware](/assets/images/lab-hardware/proxmox-astronomy-lab-sff-hardware.jpg)

---

## **🧭 Quick Navigation**

| **Area** | **What You'll Find** |
|----------|---------------------|
| [**📡 Research Focus**](#-hydrogen-line-radio-astronomy--ai-powered-sdr-research) | Scientific objectives, hardware setup, and research methodology |
| [**🔐 Lab Infrastructure**](#-lab-infrastructure--proxmox-kubernetes-and-high-performance-storage) | Compute, storage, and network architecture details |
| [**🛡️ Security Framework**](#-secure-research-lab--remote-access-for-external-collaboration) | Access controls, compliance, and collaboration mechanisms |
| [**📚 Documentation**](#-reproducible-documentation--ai-powered-knowledge-base) | Knowledge base structure and AI-enhanced documentation |
| [**🗺️ Project Roadmap**](ROADMAP.md) | Implementation phases and current status |

---

## **🚀 Hydrogen Line Radio Astronomy – AI-Powered SDR Research**  

Radio astronomy has traditionally required **large, expensive facilities**—but modern **Software-Defined Radio (SDR) technology, AI, and advanced computing** are changing that. This lab is designed to **push the limits of what's possible in a home-based, research-grade Hydrogen Line observation setup**.

 ![nooelec-h1-parabolic-dish-antenna](/assets/images/nooelec-h1-parabolic-dish-antenna.jpg)

The primary scientific focus is on **three key research areas**:  

### **🔹 High-Velocity Clouds (HVCs)**

HVCs are **massive interstellar clouds moving at speeds different from normal galactic rotation**. Studying them can reveal insights into the **formation of galaxies and the cosmic web**. This lab aims to **track the movement of these clouds** over time using **AI-enhanced Doppler shift analysis**.

### **🔹 Low Surface Brightness Galaxies (LSBJs)**

LSBJs are some of the **most elusive objects in the universe**—they have very little visible light but contain **significant hydrogen gas**. This project seeks to **detect their presence using Hydrogen Line emissions**, helping to **map faint galactic structures**.

### **🔹 Signal-to-Noise Ratio (SNR) Optimization**

A major challenge in **amateur radio astronomy** is **weak signals buried in noise**. This lab uses **AI-enhanced noise reduction** techniques to improve the **clarity and reliability of Hydrogen Line observations**.

| **Component** | **Hardware** | **Purpose** |
|--------------|-------------|------------|
| **📡 Antenna** | Nooelec Hydrogen Line Parabolic (20 dBi) | Captures Hydrogen Line emissions at 1.42 GHz. |
| **📡 Pre-LNA Filter** | BP-2 Band-Pass Filter | Filters out unwanted RF interference before amplification. |
| **📡 LNA (Amplifier)** | 1420 MHz Cavity LNA (34 dB Gain) | Boosts weak Hydrogen Line signals. |
| **📡 SDR (Receiver)** | Airspy R2 | High dynamic range SDR for precise Hydrogen Line analysis. |
| **📡 Clock Source** | GPS-Disciplined Oscillator (GPSDO) | Provides precise timing for Doppler shift calculations. |
| **📡 Edge Processing** | N100 Mini PC | First-stage SDR signal processing before lab transfer. |

 ![hydrogen-line-graph-gnu-radio](/assets/images/hydrogen-line-graph-gnu-radio.jpg)

🛰 **Data Processing**:  

- SDR captures **real-time 1420 MHz Hydrogen Line data**  
- Data is processed using **AI noise filtering and spectral enhancement**  
- Results are stored in **PostgreSQL & TimescaleDB** for time-series tracking  

🚀 **Future Plans**:  

- **Motorized tracking mount** for **targeted observations**  
- **Upgraded 1.2m dish** for **higher gain and better resolution**  
- **Integration with OpenSpace & AI-enhanced spectral classification**  

---

## **🔐 Secure Research Lab – Remote Access for External Collaboration**  

One of the **unique aspects** of this lab is that it's not just for personal research—it also functions as a **secure research platform** that allows external users to **collaborate, test, and run workloads remotely**.

🔹 **External users** can:  

- Run **SDR processing workloads** remotely  
- Test **AI-driven workflows in Kubernetes**  
- Work with **structured datasets & time-series astronomy data**  

### **🔑 Secure Access Architecture**  

| **Security Feature** | **Implementation** |
|----------------------|-------------------|
| **Entra Private Access** | Secure, policy-driven remote access. |
| **Role-Based Access Control (RBAC)** | Limits access to different lab functions. |
| **Virtualized Research Workspaces** | Kasm Workspaces for browser-based, secure research. |
| **CISv8 Compliance** | Ubuntu Server 24.04 LTS @ CISv8 L2, Windows Server 2025 Standard @ CISv9 L1 compliance |
| **Wazuh SEIM/XDR** | Daily CIS scans via CIS-CAT Lite w/controls mapped to NIST/ISO27001 |

---

## **📖 Reproducible Documentation & AI-Powered Knowledge Base**  

The **Proxmox Astronomy Lab** is not just about research—it's about **documenting everything in a way that others can follow and replicate**. Our documentation covers everything from infrastructure and security to research methodologies and data processing workflows.

### **📚 Structured Documentation & Public Knowledge Base**

- **GitHub Repository**: All **infrastructure, scripts, and workflows** are public and version-controlled.
- **Step-by-step guides**: From **infrastructure deployment to SDR processing**.
- **Security & Compliance**: Complete **CISv8 implementation** with mappings to **NIST and ISO 27001**.
- **ITIL Processes**: Structured **change management, incident response, and service catalogs**.
- **Research Methodologies**: Detailed procedures for **Hydrogen Line observation and analysis**.

### **🧠 AI-Powered Documentation Search (RAG + Milvus + OpenWebUI)**

One of the biggest challenges in complex projects is **finding relevant documentation quickly**. This lab uses **AI-powered document retrieval** to allow **natural language queries** on:  

- **Research papers & Hydrogen Line methodology**  
- **Infrastructure configurations & compliance policies**  
- **Custom workflows for AI-powered SDR processing**  

### HPC Proxmox GPU Node w/RTXA4000 GPU, 5950X and 128GB of RAM

 ![proxmox-astronomy-lab-node04](/assets/images/lab-hardware/proxmox-astronomy-lab-node04.jpg)

🚀 **The result?** A **context-aware, AI-enhanced research assistant** that helps users navigate and understand the lab's resources **efficiently**.

---

## **🏗 Lab Infrastructure – Proxmox, Kubernetes, and High-Performance Storage**  

### **🔹 Compute & Storage Architecture**  

| **Component** | **Specifications** |
|--------------|-------------------|
| **Compute Nodes** | 3 × Ryzen 5700U (64GB RAM, 2TB NVMe) |
| **High-Performance Node** | Ryzen 5950X (128GB RAM, 4TB NVMe, RTX A4000) |
| **Storage** | UnRAID NAS (8×8TB HDD RAID6 + NVMe Cache) |
| **Network** | Dual 10G SFP for high-speed data transfer |

💾 **Storage Architecture**:  
✅ **All AI/ML & K8s workloads run on local NVMe storage** for maximum performance.  
✅ **Network storage (NFS & S3) provides fast, scalable research data access**.  

### **🔹 Implementation Status**  

The lab is being implemented in structured phases, with clear milestones and documentation for each:

| **Phase** | **Focus** | **Status** | **Key Deliverables** |
|-----------|----------|--------------|---------------------|
| [**Phase 1**](phase-1.md) | Core Infrastructure Foundation | ✅ Complete | Proxmox cluster, network segmentation, security baseline |
| [**Phase 2**](phase-2.md) | Structured Services & Research Validation | ✅ Complete | ITSM framework, monitoring stack, initial SDR validation |
| [**Phase 3**](phase-3.md) | Application Deployment & Research Infrastructure | 🚧 In Progress | Kubernetes workloads, AI pipelines, SDR data flow |
| [**Phase 4**](phase-4.md) | Research Workflows & Public Data Integration | ⏳ Upcoming | Real-time processing, public datasets, research dashboards |

📌 See the [ROADMAP.md](ROADMAP.md) for detailed information on each phase and implementation timeline.

---

## **🤖 AI Ethics & Responsible Research**

The Proxmox Astronomy Lab integrates AI/ML-enhanced signal processing, automation, and research workflows, but with a strong commitment to ethical AI practices. AI is a tool to enhance scientific discovery, not to replace rigorous analysis or responsible decision-making.

### **🔹 Key Ethical Principles**

1. **Transparency** - AI/ML models used for SDR processing, RAG knowledge retrieval, and automation are documented, explainable, and auditable.
2. **Data Integrity** – Hydrogen Line radio astronomy data is processed with AI for enhancement, not manipulation. Scientific accuracy remains paramount.
3. **Privacy & Security** – No user data, queries, or access logs are shared or monetized. All AI processing is local, not cloud-based.
4. **Open Science & Reproducibility** – AI-powered signal enrichment and automation pipelines are open-source, so others can verify and improve them.

🛰️ **Why It Matters**: AI in scientific computing should be aiding research, not obscuring truth. The Proxmox Astronomy Lab adheres to ethical AI guidelines that prioritize transparency, accuracy, and reproducibility over automation for automation's sake.

---

## **🚀 Getting Started**

To clone and explore the lab's documentation and infrastructure:

```bash
git clone https://github.com/yourusername/proxmox-astronomy-lab.git
cd proxmox-astronomy-lab
```

📚 **Key Starting Points:**

- [**Infrastructure Overview**](docs/infrastructure/README.md) - Lab hardware and architecture
- [**ITIL Simulation Approach**](docs/simulation-approach/README.md) - How enterprise IT practices are implemented
- [**Observatory Projects**](docs/observatory-projects/README.md) - Scientific research focus areas
- [**CISv8 Compliance Framework**](docs/compliance-security/cisv8-controls/README.md) - Security implementation

💡 Check out the complete [**Documentation Structure**](docs/README.md) for a comprehensive guide to all resources.

---

## **📡 Join the Community & Contribute**

This is an **open-source research project**. If you're interested in **AI-powered radio astronomy, high-performance research infrastructure, or IT automation**, feel free to **contribute, test, or collaborate**.

🛰 **Follow the project on GitHub**  
📖 **Read the full documentation in the `/docs` folder**  

## **🤝 Acknowledgments**

This lab builds on the work of many open-source projects and communities, particularly those in radio astronomy, SDR processing, and scientific computing. Special thanks to:

- The **GNU Radio** community
- **RTL-SDR** and **Airspy** developers
- **Proxmox** and **Kubernetes** communities
- **Wazuh**, **Prometheus**, and **Grafana** projects

## **📄 License**

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## 🤖 AI Transparency and Ethical Use  

We track **which AI models contributed**, how they were used, and ensure all content undergoes **final human verification** before publication.  

| **Step** | **AI Model(s) Used** | **Purpose** | **Human Reviewer** | **Final Approval** |
|----------|----------------------|-------------|--------------------|----------------|
| Initial Draft | ChatGPT-4 (Pro) | Structured KB generation, metadata tagging | VintageDon | ✅ Approved |
| Model Crosscheck | Claude 3.7 Sonnet | Refinements, clarity, formatting | VintageDon | ✅ Approved |
| Compliance Cross-Check | None | Manual review | VintageDon | ✅ Approved |

🔹 **AI is a tool, not an autonomous author.** Every article undergoes **strict human review and fact-checking** before publishing.
