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

---

## **🚀 Overview**

The **Proxmox Astronomy Lab** is a **high-performance research environment** designed for **Hydrogen Line Radio Astronomy, AI-driven SDR signal processing, and secure, remote collaboration**. The lab combines **Proxmox, Kubernetes, AI/ML, and modern IT automation** to create a **reproducible, scalable** research platform built on enterprise-grade practices and open-source technologies.

At its core, the lab is **a fusion of IT engineering and citizen science**—designed not just for **scientific discovery**, but also as a **structured and documented template** for others to replicate. Everything here is designed with **reproducibility, automation, and high-performance computing** in mind.

---

## **📡 The Three Pillars of the Proxmox Astronomy Lab**  

| **Component** | **Description** |
|--------------|----------------|
| **📡 Hydrogen Line Radio Astronomy** | AI-enhanced SDR processing for HVCs, LSBJs, and SNR discovery. A research-grade **SDR observation station** built for **precision Doppler shift analysis** and **long-term hydrogen line tracking**. |
| **🔐 Secure Remote Research & IT Lab** | External researchers & IT professionals can securely access the lab for **radio astronomy data analysis, AI workloads, and IT infrastructure testing**, with **policy-driven access controls**. |
| **📖 Reproducible Documentation & AI Integration** | **Comprehensive GitHub-based documentation** and **public-facing research notes** to help others replicate a high-performance, AI-driven research environment. AI-powered **Retrieval-Augmented Generation (RAG)** allows for **contextual querying** of documentation, policies, and workflows. |

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

The primary scientific focus is on **three key research areas**:

### **🔹 High-Velocity Clouds (HVCs)**

Massive interstellar clouds moving at speeds different from normal galactic rotation, tracked using **AI-enhanced Doppler shift analysis**.

### **🔹 Low Surface Brightness Galaxies (LSBJs)**

Difficult-to-detect galaxies with faint Hydrogen Line emissions, mapped through spectral analysis.

### **🔹 Signal-to-Noise Ratio (SNR) Optimization**

Advanced AI-driven noise reduction to enhance weak Hydrogen Line signals.

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

---

## **🔐 Secure Research Lab – Remote Access for External Collaboration**  

One of the **unique aspects** of this lab is that it's not just for personal research—it also functions as a **secure research platform** that allows external users to **collaborate, test, and run workloads remotely**.

🔹 **Security Features**  

| **Security Feature** | **Implementation** |
|----------------------|-------------------|
| **Entra Private Access** | Secure, policy-driven remote access. |
| **Role-Based Access Control (RBAC)** | Limits access to different lab functions. |
| **Virtualized Research Workspaces** | Kasm Workspaces for browser-based, secure research. |
| **CISv8 Compliance** | Ubuntu Server 24.04 LTS @ CISv8 L2, Windows Server 2025 Standard @ CISv9 L1 compliance. |
| **Wazuh SEIM/XDR** | Daily CIS scans via CIS-CAT Lite w/controls mapped to NIST/ISO27001. |

---

## **📖 Reproducible Documentation & AI-Powered Knowledge Base**  

- **GitHub Repository**: All **infrastructure, scripts, and workflows** are public and version-controlled.
- **Structured Documentation**: Step-by-step guides from **infrastructure deployment to SDR processing**.
- **AI-Powered Search**: Uses **RAG + Milvus + OpenWebUI** for contextual queries on research papers, infrastructure configurations, and SDR processing workflows.

---

## **🚀 Getting Started**

To clone and explore the lab's documentation and infrastructure:

```bash
git clone https://github.com/VintageDon/proxmox-astronomy-lab.git
cd proxmox-astronomy-lab
```

📚 **Key Starting Points:**  

- [**Infrastructure Overview**](docs/infrastructure/README.md)
- [**Observatory Projects**](docs/observatory-projects/README.md)
- [**CISv8 Compliance Framework**](docs/compliance-security/cisv8-controls/README.md)
