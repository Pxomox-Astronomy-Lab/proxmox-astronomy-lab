# **Proxmox Astronomy Lab - Phase 3: Application Deployment & Research Infrastructure**

## **1. Overview**

Phase 3 represents the **transition from structured IT services to full-scale research infrastructure**. This phase introduces the **RKE2 Kubernetes cluster, AI/ML pipelines, structured SDR ingestion**, and establishes the **first-generation research workflows** that will evolve in Phase 4.

### **Key Goals:**

- **Deploy Kubernetes-based workloads** → Supporting AI/ML, structured data processing, and observability.
- **Secure research operations & external collaboration** → Implement **Entra Private Access (EPA) for controlled remote access**.
- **Finalize SDR data ingestion** → Structuring **raw SDR signals into PostgreSQL (pg01) as immutable datasets**.
- **Initial structured knowledge base ingestion** → Metadata and structured documentation indexed in **Milvus for retrieval.**

[📄 **Previous Phase: [Phase 2 Documentation](PHASE-2.md)**]

---

## **2. Kubernetes & Application Deployment**

### **2.1 RKE2 Kubernetes Cluster Expansion**

The Kubernetes cluster was expanded to support **structured AI/ML workloads and scientific research applications.**

| **Component** | **Purpose** |
|--------------|-------------|
| **Helm & ArgoCD** | Kubernetes package management & GitOps deployment |
| **Cert-Manager** | Automated certificate provisioning |
| **MinIO Operator** | Object storage for research datasets |
| **Milvus** | Vector database for structured knowledge retrieval |
| **TensorFlow Serving** | AI/ML inference & model hosting |
| **Airflow** | Workflow orchestration for research pipelines |
| **Loki & Prometheus** | Observability for research applications |

These components establish the foundation for **automated, scalable research workflows.**

---

## **3. Secure Access & Collaboration**

### **3.1 Entra Private Access (EPA) for Research & External Collaboration**

EPA was implemented to provide **secure remote access** for researchers and technical volunteers:

- **Gates all remote access via Entra tenancy authentication.**
- **Controls Kasm Workspaces & RDP access** for internal & external research staff.
- **Ensures security while enabling external contributions**.

This marks the first phase where **external researchers have begun structured remote work** within the lab.

---

## **4. Structured SDR Data Flow & Research Integration**

### **4.1 SDR Data Pipeline Implementation**

- **Raw SDR signals captured** and structured into **PostgreSQL (pg01) as immutable data**.
- **Data integrity ensured** → Baseline signal ingestion & light QA applied.
- **Hydrogen Line Signal Processing Pipelines Established** → Enabling future AI-driven signal enhancement.

| **Pipeline Component** | **Purpose** |
|-----------------|-------------|
| **GNU Radio & SigMF** | SDR signal processing & metadata structuring |
| **PostgreSQL (pg01)** | Immutable SDR data storage |
| **Grafana Dashboards** | Visualization of collected signals |

---

## **5. Knowledge Base Structuring & Milvus Ingestion**

### **5.1 Initial Knowledge Base Population**

Phase 3 also marks the **beginning of structured knowledge ingestion**:

- **Metadata, documentation, and structured research assets are indexed in Milvus.**
- **Data tagging & AI-driven retrieval capabilities introduced.**
- **Foundational knowledge for Phase 4’s full AI integration established.**

---

## **6. Transition to Phase 4**

With the Kubernetes infrastructure, secure remote access, and research ingestion pipelines in place, the lab now moves toward **Phase 4: Live Data Processing & Research Workflows**.

### **Key Phase 4 Objectives:**

- **Real-time SDR Data Processing** → AI-driven signal enhancement.
- **Structured Research Pipelines** → Automating research workflows.
- **Public Data Availability** → Preparing datasets for broader use.

[📄 **Next: [Phase 4 Documentation](PHASE-4.md)**]
