I'll rewrite the ROADMAP.md file to follow your documentation structure and style guidelines.

<!-- 
---
title: "Proxmox Astronomy Lab - Development Roadmap"
description: "Strategic development roadmap outlining the evolutionary phases and implementation timeline for the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["roadmap", "phases", "planning", "infrastructure", "research", "astronomy"]
category: "Project Planning"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---
-->

# 🚀 **Proxmox Astronomy Lab - Development Roadmap**

# 🔍 **1. Overview**

The **Proxmox Astronomy Lab** is designed as a **structured research environment** for **radio astronomy, AI-driven signal processing, and advanced IT automation**. This roadmap documents the lab's evolution through distinct implementation phases, each representing a major step forward in both infrastructure capabilities and research potential.

This lab is **neither a traditional enterprise deployment nor a standard home lab**, but rather a **purpose-built hybrid environment** that combines the structured methodologies of production research infrastructure with the adaptability needed for citizen science initiatives. Each phase builds upon the previous one to create an increasingly sophisticated platform for astronomical research.

---

# 📊 **2. Development Approach**

## **2.1 Core Principles**

The lab's development follows several guiding principles that shape its evolution.

| **Principle** | **Implementation** |
|--------------|-------------------|
| **Modular Architecture** | Each component can evolve independently while maintaining integration |
| **Security-First Design** | CIS frameworks implemented from the beginning with appropriate controls |
| **Research Continuity** | Ensuring research activities can continue during infrastructure changes |
| **Documentation Driven** | Comprehensive documentation maintained throughout development |
| **Enterprise Practices** | ITIL-aligned operations with appropriate scaling for lab environment |

## **2.2 Phase-Based Implementation**

The lab is being developed through structured phases, each with specific goals and milestones.

| **Phase** | **Focus** | **Status** |
|-----------|----------|------------|
| **Phase 1** | Core Infrastructure Foundation | ✅ Completed |
| **Phase 2** | Structured Services & Research Validation | ✅ Completed |
| **Phase 3** | Application Deployment & Research Infrastructure | 🚧 In Progress |
| **Phase 4** | Research Workflows & Public Data Integration | ⏳ Planned |

---

# 📋 **3. Phase Details**

## **3.1 Phase 1: Core Infrastructure Foundation**

Phase 1 established the **fundamental infrastructure** on which all subsequent phases would build, focusing on security, networking, and core systems.

| **Component** | **Implementation** |
|--------------|-------------------|
| **Proxmox Cluster** | 5-node cluster with performance-optimized configuration |
| **Network Segmentation** | VLAN-based isolation for research and infrastructure |
| **Identity Management** | Windows Server 2025 AD with Entra Hybrid Join |
| **Security Baseline** | CISv8 Level 2 (Linux), CISv9 Level 1 (Windows) |
| **Storage Architecture** | NVMe-backed S3, NFS shares, structured backup retention |
| **Initial Kubernetes** | RKE2 cluster with 3 management and 5 worker nodes |

[📄 **Full Details: [Phase 1 Documentation](phase-1.md)**]

## **3.2 Phase 2: Structured Services & Research Validation**

Phase 2 **transformed the infrastructure into a managed environment** while validating initial research capabilities.

| **Component** | **Implementation** |
|--------------|-------------------|
| **ITSM Framework** | GLPI deployment with structured ITIL processes |
| **Monitoring Stack** | Prometheus, AlertManager, Loki, Grafana |
| **Security Operations** | Wazuh SIEM with automated scanning and alerting |
| **Database Services** | PostgreSQL, TimescaleDB, GIS-enabled databases |
| **Initial SDR Pipeline** | First hydrogen line signal detection and validation |

[📄 **Full Details: [Phase 2 Documentation](phase-2.md)**]

## **3.3 Phase 3: Application Deployment & Research Infrastructure**

Phase 3 marks the **transition from IT infrastructure to research platform**, with a focus on research-specific applications and workflows.

| **Component** | **Implementation** | **Status** |
|--------------|-------------------|------------|
| **Kubernetes Finalization** | Stable RKE2 environment with storage integration | 🚧 In Progress |
| **AI/ML Pipeline** | Milvus, Ollama, TensorFlow Serving, Airflow | 🚧 In Progress |
| **Remote Access** | TailScale zero-trust networking with Entra integration | ✅ Completed |
| **Structured SDR Data Flow** | Automated SDR data → PostgreSQL pipeline | 🚧 In Progress |
| **Knowledge Base** | Structured documentation in Milvus for RAG retrieval | 🚧 In Progress |

[📄 **Full Details: [Phase 3 Documentation](phase-3.md)**]

## **3.4 Phase 4: Research Workflows & Public Data Integration**

Phase 4 will focus on **real-time data processing, enhanced analytics, and public data sharing**.

| **Component** | **Planned Implementation** | **Timeline** |
|--------------|---------------------------|------------|
| **Live SDR Processing** | Real-time hydrogen line collection and analysis | Q3 2025 |
| **AI-Driven Enhancement** | Machine learning for signal improvement | Q3 2025 |
| **Public Dataset Publication** | Open data repository for research findings | Q4 2025 |
| **Collaborative Platform** | External researcher integration | Q4 2025 |
| **Advanced Visualization** | Web-based research dashboards | Q1 2026 |

[📄 **Full Details: [Phase 4 Documentation](phase-4.md)**]

---

# 🔬 **4. Research Capability Evolution**

## **4.1 Radio Astronomy Milestones**

The lab's research capabilities are evolving alongside the infrastructure development.

| **Research Milestone** | **Associated Phase** | **Status** |
|------------------------|---------------------|------------|
| **Initial Hydrogen Line Detection** | Phase 2 | ✅ Completed |
| **Calibrated Signal Processing** | Phase 3 | 🚧 In Progress |
| **Automated Data Collection** | Phase 3 | 🚧 In Progress |
| **AI-Enhanced Signal Analysis** | Phase 4 | ⏳ Planned |
| **Long-Term Survey Projects** | Phase 4 | ⏳ Planned |

## **4.2 Data Processing Capabilities**

Data processing capabilities are growing with each phase to support increasingly sophisticated research.

| **Capability** | **Associated Phase** | **Status** |
|----------------|---------------------|------------|
| **Basic Signal Processing** | Phase 2 | ✅ Completed |
| **Database-Driven Storage** | Phase 3 | 🚧 In Progress |
| **Time-Series Analysis** | Phase 3 | 🚧 In Progress |
| **ML-Based RFI Mitigation** | Phase 4 | ⏳ Planned |
| **Public Dataset API** | Phase 4 | ⏳ Planned |

---

# 🛠️ **5. Infrastructure Scaling**

## **5.1 Compute Resources**

The lab's compute resources are strategically deployed to support both infrastructure and research needs.

| **Resource** | **Current State** | **Future Plans** |
|--------------|------------------|-----------------|
| **CPU Cores** | 40 vCPUs allocated | Expand to 60 vCPUs |
| **Memory** | 160GB RAM allocated | Expand to 240GB RAM |
| **GPU** | RTX A4000 for ML workloads | Add specialized ML accelerators |
| **Storage** | 12TB usable across tiers | Expand to 20TB with tiered performance |

## **5.2 Network Evolution**

Network capabilities are evolving to support increased data processing and external collaboration.

| **Component** | **Current State** | **Future Plans** |
|--------------|------------------|-----------------|
| **Internal Network** | 10GbE on core nodes | Expand 10GbE to all nodes |
| **External Connectivity** | Secure TailScale access | Add private research VLAN |
| **SDR Data Transport** | Direct file transfer | Streaming data pipeline |
| **Edge Collection** | Limited remote collection | Expanded edge node deployment |

---

# 📅 **6. Implementation Timeline**

## **6.1 Major Milestones**

| **Milestone** | **Target Date** | **Status** |
|--------------|----------------|------------|
| **Phase 1 Completion** | Q4 2024 | ✅ Completed |
| **Phase 2 Completion** | Q1 2025 | ✅ Completed |
| **Phase 3 Completion** | Q2 2025 | 🚧 In Progress (60%) |
| **Initial Research Publication** | Q3 2025 | 🚧 In Planning |
| **Phase 4 Completion** | Q1 2026 | ⏳ Planned |
| **Public Dataset Release** | Q2 2026 | ⏳ Planned |

## **6.2 Current Focus Areas**

The project is currently focused on completing these key components:

1. **Kubernetes-based ML workloads** for signal processing
2. **Automated data collection pipeline** for continuous observation
3. **Knowledge management system** with RAG capabilities
4. **Collaborative research environment** for external access

---

# 🔗 **7. Related Resources**

| **Resource** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Infrastructure Overview** | Hardware specifications | [Infrastructure Architecture](/docs/infrastructure/architecture.md) |
| **Research Projects** | Scientific focus areas | [Research Projects](/docs/research-projects/README.md) |
| **Implementation Phases** | Detailed phase documentation | [Phase 1](/phase-1.md), [Phase 2](/phase-2.md), [Phase 3](/phase-3.md), [Phase 4](/phase-4.md) |
| **Security Architecture** | Security framework | [Security Documentation](/docs/compliance-security/README.md) |
| **Hydrogen Line Studies** | Research methodologies | [Hydrogen Line Research](/docs/research-projects/hydrogen-line-studies/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial roadmap documentation | VintageDon |
