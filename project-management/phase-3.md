<!--
---
title: "Proxmox Astronomy Lab - Phase 3: Application Deployment & Research Infrastructure"
description: "Documentation of Phase 3 implementation, focusing on Kubernetes workloads, AI/ML pipelines, secure research operations, and structured SDR data ingestion"
author: "VintageDon"
tags: ["phase-3", "documentation", "kubernetes", "ai-ml", "research-infrastructure", "sdr", "data-pipelines"]
category: "Implementation"
kb_type: "Reference"
version: "1.0"
status: "In Progress"
last_updated: "2025-04-05"
related_services: ["Kubernetes", "AI/ML Platforms", "Milvus", "SDR Processing", "Tailscale"]
implements_policies: ["Data Protection Policy", "Access Control Management Policy"]
phase: "phase-3"
---
-->

# **Proxmox Astronomy Lab - Phase 3: Application Deployment & Research Infrastructure**

# 🔍 **1. Overview**

Phase 3 represents the **transition from structured IT services to full-scale research infrastructure**. This phase introduces the **RKE2 Kubernetes cluster, AI/ML pipelines, structured SDR ingestion**, and establishes the **first-generation research workflows** that will evolve in Phase 4.

While Phase 1 established fundamental infrastructure and Phase 2 implemented essential services, Phase 3 shifts focus toward **research enablement and scientific data processing**. This marks the first phase where the lab begins to fulfill its primary purpose: **supporting structured radio astronomy research with AI-enhanced processing capabilities**.

# 🏗️ **2. Dependencies & Relationships**

## **2.1 Related Services**

This phase builds upon and integrates with the following services:

| **Service** | **Relationship** | **Documentation** |
|-------------|-----------------|-------------------|
| **RKE2 Kubernetes Cluster** | Core orchestration platform for research workloads | [RKE2 Configuration](/docs/Applications/Containerized-Services/Kubernetes-Workloads/RKE2-Cluster.md) |
| **Milvus Vector Database** | Knowledge retrieval for research data | [Milvus Implementation](/docs/Applications/AI-ML-Platforms/Vector-Databases/Milvus.md) |
| **PostgreSQL & TimescaleDB** | Structured data storage for SDR observations | [PostgreSQL Database](/docs/Applications/Databases/PostgreSQL/PostgreSQL-Server.md) |
| **Tailscale** | Secure remote access for researchers | [Tailscale Configuration](/docs/Entra-Hybrid-Cloud/Private-Access/Tailscale-Configuration/README.md) |

## **2.2 Phase Dependencies**

The successful completion of Phase 3 depends on the following:

- **Phase 1**: Core Infrastructure Foundation ✅ Complete
- **Phase 2**: Structured Services & Research Validation ✅ Complete

This phase serves as the foundation for:

- **Phase 4**: Live Data Processing & Research Workflows ⏳ Upcoming

## **2.3 Responsibility Matrix**

| **Activity** | **Infrastructure** | **Security Admin** | **Engineer** | **Research Lead** |
|--------------|-------------------|-------------------|--------------|-------------------|
| Kubernetes Implementation | R/A | C | I | I |
| AI/ML Pipeline Deployment | I | I | R/A | C |
| SDR Data Ingestion | I | I | R | A |
| Tailscale Remote Access Setup | C | R/A | I | I |
| Vector Database Configuration | I | I | R | A |
| Research Pipeline Architecture | I | C | R | A |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents ownership and communication requirements for each major activity in Phase 3, ensuring clear accountability throughout implementation.

# 🖥️ **3. Kubernetes & Application Deployment**

## **3.1 RKE2 Kubernetes Cluster Expansion**

The Kubernetes cluster has been expanded to support **structured AI/ML workloads and scientific research applications**. This infrastructure provides the foundation for containerized research pipelines and scalable data processing.

| **Component** | **Purpose** | **Implementation Status** |
|--------------|-------------|---------------------------|
| **Helm & ArgoCD** | Kubernetes package management & GitOps deployment | ✅ Implemented |
| **Cert-Manager** | Automated certificate provisioning | ✅ Implemented |
| **MinIO Operator** | Object storage for research datasets | ✅ Implemented |
| **Milvus** | Vector database for structured knowledge retrieval | ✅ Implemented |
| **TensorFlow Serving** | AI/ML inference & model hosting | 🚧 In Progress |
| **Airflow** | Workflow orchestration for research pipelines | 🚧 In Progress |
| **Loki & Prometheus** | Observability for research applications | ✅ Implemented |

The Kubernetes infrastructure is distributed across the following nodes:

| **Node** | **Role** | **Resources** | **Primary Workloads** |
|----------|----------|--------------|----------------------|
| **proj-k8sm01** | Management | 2vCPU, 8GB RAM | Kubernetes control plane, etcd |
| **proj-k8sm02** | Management | 2vCPU, 8GB RAM | Kubernetes control plane, etcd |
| **proj-k8sm03** | Management | 2vCPU, 8GB RAM | Kubernetes control plane, etcd |
| **proj-k8sw01** | Worker | 8vCPU, 32GB RAM | General-purpose pods |
| **proj-k8sw02** | Worker | 8vCPU, 32GB RAM | General-purpose pods |
| **proj-k8sw03** | Worker | 8vCPU, 32GB RAM | General-purpose pods |
| **proj-k8sw04** | Worker | 8vCPU, 32GB RAM, 2TB storage | Storage-intensive workloads |
| **proj-k8sw05** | Worker | 8vCPU, 32GB RAM | General-purpose pods |
| **proj-kasm01** | Worker | 6vCPU, 24GB RAM | Kasm Workspaces (VDI) |

The cluster design balances high availability (3 control plane nodes) with optimized resource allocation for specific workload types. The separation of storage-intensive workloads onto proj-k8sw04 ensures data processing pipelines can access dedicated storage resources.

## **3.2 Deep Infra AI Model Selection**

Phase 3 integrates several AI models from the Deep Infra platform to support research workflows:

| **Model Family** | **Selected Models** | **Purpose** | **Implementation Status** |
|-----------------|---------------------|-------------|---------------------------|
| **Mistral** | Mistral-Small-24B | General text generation, documentation assistance | ✅ Implemented |
| **Gemma** | Gemma-2-9B | Lightweight local model for edge deployments | 🚧 In Progress |
| **BGE** | bge-large-en, bge-m3 | Text embeddings for semantic search | ✅ Implemented |
| **OpenAI** | clip-vit-base-patch32 | Image classification for SDR spectrograph analysis | 🔄 Planned |

These models provide a balance between performance and resource consumption, enabling AI-driven research assistants while maintaining reasonable GPU/compute requirements on the lab's hardware infrastructure.

# 🔒 **4. Secure Access & Collaboration**

## **4.1 Tailscale for Research & External Collaboration**

Tailscale has been implemented to provide **secure remote access** for researchers and technical volunteers:

| **Capability** | **Implementation Details** |
|----------------|----------------------------|
| **Zero-trust network access** | All remote connectivity is authenticated via Tailscale with Tailscale SCIM integration |
| **Role-based access controls** | Access tailored to research roles through Tailscale ACLs |
| **Secure Kasm Workspaces access** | Browser-based VDI environments for remote research |
| **RDP session management** | Remote desktop connectivity for administrative tasks |

This implementation marks the first phase where **external researchers have begun structured remote work** within the lab environment. The zero-trust approach ensures security while enabling flexible collaboration.

## **4.2 Research Collaboration Framework**

The following collaboration framework has been established:

| **Collaboration Type** | **Access Method** | **Authentication Mechanism** |
|------------------------|-------------------|------------------------------|
| **Code contributions** | GitOps via ArgoCD | Tailscale-protected Git access |
| **Data analysis** | Kasm Workspaces | Tailscale with MFA |
| **Infrastructure administration** | RDP to management systems | Tailscale with MFA, privileged access |
| **Documentation contributions** | Web-based wiki access | Tailscale with standard access |

This structured approach ensures that external collaborators can actively participate in research activities while maintaining appropriate security boundaries.

# 🔄 **5. Structured SDR Data Flow & Research Integration**

## **5.1 SDR Data Pipeline Implementation**

A structured data pipeline has been established to capture, process, and store radio astronomy observations:

| **Pipeline Stage** | **Implementation** | **Status** |
|-------------------|-------------------|------------|
| **SDR signal capture** | Airspy SDR hardware with GNU Radio software | ✅ Implemented |
| **Signal formatting** | Signal metadata formatting with SigMF | ✅ Implemented |
| **Primary storage** | PostgreSQL (proj-pg01) as immutable data store | ✅ Implemented |
| **Time-series analysis** | TimescaleDB (proj-pgts01) for temporal analysis | ✅ Implemented |
| **Geospatial referencing** | PostGIS (proj-pggis01) for spatial analysis | 🚧 In Progress |
| **Data visualization** | Grafana dashboards for real-time monitoring | ✅ Implemented |

This pipeline ensures that raw SDR signals are captured with appropriate metadata, structured into a queryable format, and made available for both real-time and historical analysis.

## **5.2 Hydrogen Line Signal Processing Pipeline**

Specialized processing for Hydrogen Line observations has been implemented:

| **Processing Stage** | **Implementation Details** | **Status** |
|---------------------|----------------------------|------------|
| **Signal isolation** | Focused 1420MHz band isolation | ✅ Implemented |
| **Noise reduction** | Statistical noise filtering | ✅ Implemented |
| **Doppler analysis** | Frequency shift calculation | 🚧 In Progress |
| **Spectral visualization** | Waterfall plots and spectrograms | ✅ Implemented |
| **AI-driven enhancement** | Neural network signal improvement | 🔄 Planned for Phase 4 |

These specialized processing steps enable the detection and analysis of Hydrogen Line signals, forming the foundation for the scientific research objectives of the lab.

# 📚 **6. Knowledge Base Structuring & Milvus Ingestion**

## **6.1 RAGGraph Implementation**

The RAGGraph framework has been implemented to enable AI-assisted knowledge retrieval across the lab's documentation ecosystem:

| **Component** | **Implementation** | **Status** |
|---------------|-------------------|------------|
| **Document standardization** | Structured Markdown with consistent sections | ✅ Implemented |
| **Vector embedding** | BGE-large-en model for semantic embeddings | ✅ Implemented |
| **Knowledge graph** | Relationship mapping between documents | 🚧 In Progress |
| **Milvus vector database** | Document chunk storage and retrieval | ✅ Implemented |
| **Retrieval API** | Efficient semantic search | ✅ Implemented |
| **Query interface** | Natural language knowledge interface | 🚧 In Progress |

This implementation enables contextual, AI-driven retrieval of the lab's documentation, research methodologies, and operational procedures.

## **6.2 Documentation Structure Alignment**

All documentation has been structured according to the RAGGraph requirements:

| **Section** | **Implementation** | **Purpose** |
|-------------|-------------------|------------|
| **Numbered headings** | Fixed section numbering | Graph node creation |
| **Section blurbs** | Self-contained explanations | Semantic chunking |
| **Explicit relationships** | Clear cross-references | Graph edge creation |
| **Consistent metadata** | YAML frontmatter | Filtering and classification |

This standardized approach ensures that the documentation supports both human navigation and AI-powered retrieval, facilitating knowledge discovery across the lab's expanding knowledge base.

# 🔄 **7. Transition to Phase 4**

With the Kubernetes infrastructure, secure remote access, and research ingestion pipelines in place, the lab now moves toward **Phase 4: Live Data Processing & Research Workflows**.

## **7.1 Key Phase 4 Objectives**

| **Objective** | **Description** | **Timeline** |
|---------------|----------------|--------------|
| **Real-time SDR Data Processing** | AI-driven signal enhancement and anomaly detection | Q2 2025 |
| **Structured Research Pipelines** | End-to-end automation of research workflows | Q2-Q3 2025 |
| **Public Data Availability** | Preparing datasets for broader scientific community | Q3 2025 |
| **Enhanced AI Signal Processing** | Advanced machine learning for signal classification | Q3-Q4 2025 |

Phase 4 will build upon the infrastructure and pipelines established in Phase 3, focusing on optimizing research productivity and scientific discovery.

## **7.2 Current Limitations & Challenges**

The following challenges have been identified for resolution in Phase 4:

| **Challenge** | **Impact** | **Mitigation Plan** |
|---------------|-----------|---------------------|
| **GPU resource constraints** | Limited AI model capacity | Optimize smaller models, prioritize workloads |
| **Data volume management** | Storage growth from SDR observations | Implement tiered storage, selective archiving |
| **Pipeline automation gaps** | Manual intervention points | Focus on end-to-end workflow automation |
| **External researcher onboarding** | Access provisioning complexity | Standardize researcher profiles and permissions |

Addressing these challenges will be critical to achieving the full research potential of the Proxmox Astronomy Lab.

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-05 | ✅ Approved |

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-05 | Initial Phase 3 documentation | VintageDon |
