# 🔄 **Data Pipelines**

# 🔍 **1. Overview**

The Data Pipelines section documents the automated workflows and processing systems that transform raw radio astronomy data into structured scientific datasets within the Proxmox Astronomy Lab. These pipelines handle the complete lifecycle of observed data - from initial SDR ingestion through signal processing, filtering, enrichment, storage, and analysis. Our pipeline architecture emphasizes reproducibility, automation, scalability, and integrity to ensure consistent scientific results and effective data management.

Each pipeline component is designed with modularity in mind, allowing for individual processing steps to be enhanced or replaced as methodologies evolve, while maintaining end-to-end data provenance throughout the research workflow.

---

# 🌊 **2. Ingestion Workflows**

## **2.1 SDR Data Acquisition**

Automated capture and initial processing of radio astronomy signals:

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Airspy Capture** | Raw RF signal digitization | [Airspy Workflow](Ingest-Workflows/airspy-ingest.md) |
| **GNU Radio Processing** | Initial signal processing and filtering | [GNU Radio Pipeline](Ingest-Workflows/gnu-radio-pipeline.md) |
| **SigMF Metadata** | Signal metadata generation and attachment | [SigMF Integration](Ingest-Workflows/sigmf-metadata.md) |

## **2.2 Data Validation**

Quality assurance processes for incoming data:

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Signal Validation** | Automated quality checks | [Signal QA](Ingest-Workflows/signal-validation.md) |
| **RFI Detection** | Interference identification | [RFI Filtering](Ingest-Workflows/rfi-detection.md) |
| **Metadata Verification** | Completeness and accuracy checks | [Metadata QA](Ingest-Workflows/metadata-verification.md) |

---

# 🔬 **3. Processing Algorithms**

## **3.1 Signal Enhancement**

Algorithms for improving signal quality and extracting features:

| **Algorithm** | **Purpose** | **Documentation** |
|--------------|-----------|-------------------|
| **AI Noise Reduction** | ML-based noise filtering | [AI Filtering](Processing-Algorithms/ai-noise-reduction.md) |
| **Doppler Analysis** | Velocity measurement from frequency shifts | [Doppler Processing](Processing-Algorithms/doppler-analysis.md) |
| **Spectral Integration** | Signal averaging for weak source detection | [Signal Integration](Processing-Algorithms/spectral-integration.md) |

## **3.2 Specific Research Pipelines**

Specialized processing for different research areas:

| **Pipeline** | **Scientific Focus** | **Documentation** |
|--------------|---------------------|-------------------|
| **HVC Pipeline** | High-Velocity Cloud detection | [HVC Processing](Processing-Algorithms/hvc-pipeline.md) |
| **Galaxy Mapping** | Low Surface Brightness Galaxy mapping | [LSBG Pipeline](Processing-Algorithms/galaxy-mapping.md) |
| **SNR Detection** | Supernova Remnant identification | [SNR Pipeline](Processing-Algorithms/snr-detection.md) |

---

# 📦 **4. Storage Architecture**

## **4.1 Storage Tiers**

Multi-tiered storage strategy for different data types:

| **Tier** | **Purpose** | **Implementation** | **Documentation** |
|----------|-----------|-------------------|-------------------|
| **Raw Data** | Immutable original observations | TimescaleDB | [Raw Storage](Storage-Architecture/raw-data-storage.md) |
| **Processed Data** | Cleaned and enhanced data | PostgreSQL | [Processed Storage](Storage-Architecture/processed-data.md) |
| **Analysis Results** | Research outputs and findings | PostgreSQL with PostGIS | [Results Storage](Storage-Architecture/analysis-results.md) |
| **Long-term Archive** | Historical data preservation | S3-compatible Object Storage | [Archive Storage](Storage-Architecture/long-term-archive.md) |

## **4.2 Data Access Patterns**

Methods for retrieving and interacting with stored data:

| **Pattern** | **Use Case** | **Documentation** |
|------------|------------|-------------------|
| **API Access** | Programmatic data retrieval | [API Documentation](Storage-Architecture/api-access.md) |
| **Query Interface** | Interactive data exploration | [Query Tools](Storage-Architecture/query-interface.md) |
| **Batch Export** | Dataset extraction for external analysis | [Export Workflows](Storage-Architecture/batch-export.md) |

---

# 🔍 **5. Data Governance**

## **5.1 Data Lifecycle Management**

Policies governing data throughout its lifecycle:

| **Policy Area** | **Coverage** | **Documentation** |
|----------------|-----------|-------------------|
| **Retention Policy** | Data preservation timeframes | [Retention Guidelines](Data-Governance/retention-policy.md) |
| **Versioning Strategy** | Dataset version management | [Versioning Approach](Data-Governance/versioning-strategy.md) |
| **Provenance Tracking** | Data lineage documentation | [Provenance Framework](Data-Governance/provenance-tracking.md) |

## **5.2 Quality Management**

Processes ensuring data quality and integrity:

| **Process** | **Implementation** | **Documentation** |
|------------|-------------------|-------------------|
| **Quality Metrics** | Measurement of data quality | [Quality Framework](Data-Governance/quality-metrics.md) |
| **Validation Rules** | Automated quality checks | [Validation Framework](Data-Governance/validation-rules.md) |
| **Error Handling** | Management of data anomalies | [Error Procedures](Data-Governance/error-handling.md) |

---

# 🤖 **6. Automation Framework**

## **6.1 Orchestration Tools**

Systems managing pipeline execution:

| **Tool** | **Purpose** | **Documentation** |
|----------|-----------|-------------------|
| **Apache Airflow** | Workflow scheduling and orchestration | [Airflow Implementation](Automation/airflow-configuration.md) |
| **Kubernetes Jobs** | Containerized processing tasks | [K8s Processing](Automation/kubernetes-jobs.md) |
| **Event-Driven Processing** | Real-time data handling | [Event Architecture](Automation/event-driven-architecture.md) |

## **6.2 Monitoring & Alerting**

Systems for pipeline health monitoring:

| **Component** | **Coverage** | **Documentation** |
|--------------|-----------|-------------------|
| **Pipeline Metrics** | Performance and throughput monitoring | [Pipeline Metrics](Automation/pipeline-metrics.md) |
| **Data Quality Alerts** | Notification of quality issues | [Quality Alerting](Automation/quality-alerting.md) |
| **Failure Recovery** | Automated error handling | [Recovery Procedures](Automation/failure-recovery.md) |

---

# 🔗 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Ingest-Workflows** | Data acquisition and initial processing | [Ingest Workflows README](Ingest-Workflows/README.md) |
| **Processing-Algorithms** | Signal analysis and feature extraction | [Processing Algorithms README](Processing-Algorithms/README.md) |
| **Storage-Architecture** | Data persistence and management | [Storage Architecture README](Storage-Architecture/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Pipeline Architecture** | Overall system design | [Architecture Overview](pipeline-architecture.md) |
| **Data Dictionary** | Standardized field definitions | [Data Dictionary](data-dictionary.md) |
| **Research Data Policy** | Governance framework | [Data Policy](research-data-policy.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Research-Projects** | Parent directory for data pipelines | [Research Projects README](../README.md) |
| **Hydrogen-Line-Studies** | Scientific research using these pipelines | [Hydrogen Line Studies README](../Hydrogen-Line-Studies/README.md) |
| **RF-Monitoring** | Signal source and RFI detection | [RF Monitoring README](../RF-Monitoring/README.md) |
| **Infrastructure/Storage** | Storage infrastructure for pipelines | [Storage Infrastructure README](../../Infrastructure/Storage/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Initial data pipelines README | VintageDon |
