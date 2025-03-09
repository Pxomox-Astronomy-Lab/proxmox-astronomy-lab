# 🚀 **Proxmox Astronomy Lab - Roadmap**

The **Proxmox Astronomy Lab** is a structured research environment designed for **radio astronomy, AI-driven signal processing, and advanced IT automation**. It blends the structured methodologies of **production research infrastructure** with the adaptability of a **high-performance home lab**.

This lab is **not a traditional enterprise deployment, nor a standard home lab**—it is a **purpose-built hybrid environment** that evolves through structured development phases.

Each phase represents a **major step forward**, ensuring the lab remains scalable, modular, and structured for **both research and IT operations**. While production research is the **primary goal**, the structured development of its IT components **enables** new research capabilities.

---

## **🛠️ The Lab’s Evolution: Key Phases**

| **Phase** | **Focus** | **Major Outcomes** |
|-----------|----------|-------------------|
| **Phase 1** | Core Infrastructure | Built the foundation: networking, compute, security, and hybrid identity. |
| **Phase 2** | Structured Services | Deployed critical services, monitoring, and ITSM for structured operations. |
| **Phase 3** | Application Deployment | Kubernetes, AI/ML pipelines, SDR ingestion, and research-specific workloads. |
| **Phase 4** | Research Workflows | Live data processing, public datasets, and applied research. |

---

## ✅ **Phase 1: Core Infrastructure Foundation (Completed)**

### **Overview**

The lab began as **bare nodes with no structured services or identity management**. This phase focused on designing a **secure, high-performance infrastructure** that balances **modularity, security, and small-form-factor constraints**. While the **smaller node footprint enhances efficiency, it introduces a ceiling on network performance**, particularly beyond 2.5G speeds. **Node04 and Node05 provide 10G connectivity**, but the tradeoff is that they are desktop-class nodes.

### **Key Outcomes**

- **Cluster Established** → 5 Proxmox nodes, VLAN-segmented networking.
- **Hybrid Identity Configured** → Windows Server 2025 AD, Entra Hybrid Join, Seamless SSO.
- **Security & Compliance Hardened** → CISv8 Level 2 (Linux), CISv9 Level 1 (Windows), daily security scanning.
- **Monitoring & Automation Deployed** → Prometheus, Wazuh, Azure Arc, Ansible-managed configurations.
- **Proxmox Backup & Storage Finalized** → NVMe-backed S3 gateway for Kubernetes, NFS shares, structured backup retention.
- **RKE2 Kubernetes Cluster Spun Up** → 3 management nodes, 5 worker nodes (40vCPU/160GB RAM total), GPU passthrough configured.
- **Architectural Design Documented** → [Infrastructure Architecture](docs/infrastructure/architecture.md).

With this foundation in place, the lab transitioned to **Phase 2: Structured Service Deployment**.

---

## ✅ **Phase 2: Structured Services & Initial Research Validation (Completed)**

### **Overview**

Phase 2 **transformed the infrastructure into a structured, managed environment**. This was also the first phase where **research validation was introduced**, as the lab moved beyond IT architecture into **real-world scientific data handling**.

### **Key Outcomes**

- **ITSM & Change Management Formalized** → GLPI deployed, structured ITIL-aligned operations introduced.
- **Full Monitoring Stack Online** → Wazuh, Prometheus, structured logging (Loki, Grafana, SNMP monitoring).
- **Storage & Data Handling Finalized** → PostgreSQL, TimescaleDB, GIS-enabled databases.
- **Microservices & GitOps Introduced** → Portainer for managed containerization, GitOps repo established.
- **Hydrogen Line Feed Calibration** → The lab sourced, assembled, and tested its **first 1.42 GHz hydrogen line signal detection**, confirming **early-stage research viability**.

With core services deployed and **hydrogen line detection validated**, the lab advanced to **Phase 3: Application Deployment & Research-Specific Infrastructure**.

---

## 🚧 **Phase 3: Application Deployment & Research Infrastructure (In Progress)**

### **Overview**

Phase 3 marks the transition from structured IT services to **full-scale research infrastructure**, including:

- **Finalizing Kubernetes Infrastructure (RKE2)** → Ensuring stability and scalability for containerized workloads.
- **Deploying AI/ML Pipelines** → Milvus (vector DB), Ollama (LLM hosting), TensorFlow Serving, Airflow orchestration.
- **Integrating Research Workflows** → Hydrogen line SDR pipelines, immutable data storage.
- **Entra Private Access (EPA) for Secure Access** → Gating Kasm Workspaces and RDP access through the Entra tenancy.
- **Structured SDR Data Flow** → Establishing **raw SDR data ingestion → PostgreSQL (pg01)** as the baseline immutable dataset.
- **Initial Knowledge Base Structuring** → Ingesting metadata into Milvus for structured retrieval.

Additionally, **external researchers and technical volunteers** have started **light remote work and early testing**, ensuring the lab can scale for **collaborative research efforts**.

[📄 **Full details in: [Phase 3 Documentation](PHASE-3.md)**]

---

## ⏳ **Phase 4: Research Workflows & Public Data Integration (Upcoming)**

### **Overview**

With structured IT infrastructure and application workloads in place, Phase 4 will focus on **real-time data processing, AI-enhanced signal analysis, and research observability**.

### **Planned Focus Areas**

- 📡 **Live SDR Data Processing** → Hydrogen Line data collection & signal analysis.
- 🤖 **AI-Driven Noise Reduction** → Machine learning models for signal enhancement.
- 📊 **Research Observability & Data Sharing** → Public dataset publication, real-time analytics dashboards.

This phase is where the **true research potential of the lab is fully realized**, transitioning from **foundational infrastructure to active discovery**.

---

## **📌 Roadmap Notes**

- **This roadmap tracks structured evolution, with continuous documentation updates.**
- **Phase 1 & 2 foundations are in place, Phase 3 is actively progressing, and Phase 4 is planned.**
- **External contributors are now actively testing and integrating with the lab’s infrastructure.**
- **The lab remains an evolving system, continuously iterating on its capabilities.**

📌 **This roadmap will be actively updated as the lab continues to evolve.**
