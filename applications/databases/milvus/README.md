<!-- 
---
title: "Milvus Vector Database Service Documentation"
description: "Comprehensive documentation for Milvus vector database service in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["milvus", "vector-database", "embeddings", "semantic-search", "ai-ml", "infrastructure", "service", "rag"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["RAGGraph", "Neo4j", "Ollama", "OpenWebUI", "TensorFlow Serving", "Prometheus", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 🧠 **Milvus Vector Database Service**

This document provides comprehensive information about the Milvus vector database service deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the Milvus vector database service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of Milvus in the Proxmox Astronomy Lab environment, focusing on its role in providing vector similarity search and embedding storage for AI/ML and semantic search applications.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Milvus instances and configuration | Application code interacting with Milvus |
| Vector index management and optimization | Business logic implementation |
| Query performance and tuning | Data migration processes |
| Integration with AI/ML pipelines | End-user application support |
| Semantic search capabilities | Custom plugin development |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- AI/ML Engineers
- Data Scientists
- RAG System Developers

## 🔍 **2. Service Overview**

### **2.1 Service Description**

Milvus provides a highly scalable vector database optimized for similarity searches and AI embedding storage. In the Proxmox Astronomy Lab, it serves as the core vector storage system for the RAGGraph knowledge retrieval system, semantic search capabilities, and embedding-based AI applications. Its millisecond query performance supports real-time AI inference and knowledge retrieval across the lab's documentation and research datasets.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-MILVUS-001 |
| **Service Type** | Core |
| **Service Category** | Database |
| **Business Criticality** | High |
| **Service Owner** | AI/ML Infrastructure Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 (Always available) |
| **Support Hours** | Monday-Friday, 08:00-17:00 EST |
| **Maintenance Windows** | Fridays, 10:00-11:00 EST |

## 📊 **3. Technical Architecture**

### **3.1 Deployment Overview**

Milvus is deployed across two instances to separate production and development workloads:

| **Instance** | **Host** | **Purpose** | **Resources** |
|-------------|----------|------------|---------------|
| **proj-milvus01** | RKE2 Kubernetes on node04 | Primary vector database for production RAG systems | 4 vCPU, 32GB RAM, 500GB storage |
| **proj-milvus02dev** | Container on lab-db01 | Development and testing workloads | 2 vCPU, 8GB RAM, 100GB storage |

The production instance runs as a Kubernetes deployment with high availability while the development instance runs as a containerized deployment for testing and development.

### **3.2 Infrastructure Components**

The following components comprise the Milvus service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| Milvus Standalone (prod) | Kubernetes deployment with etcd, MinIO | CMDB-K8S-MILVUS01 |
| Milvus Standalone (dev) | Development container | CMDB-CNT-MILVUS02 |
| Milvus Exporter | Prometheus metrics collector | CMDB-MON-MILVUSEXP |
| Etcd | Metadata storage for Milvus | CMDB-K8S-ETCD |
| MinIO | Object storage for vectors | CMDB-K8S-MINIO |

### **3.3 Network Configuration**

| **Instance** | **Network Type** | **Network Segment** | **Access Method** |
|--------------|----------------|---------------------|------------------|
| proj-milvus01 | Kubernetes Service | VLAN20 | Internal K8s Service + Ingress |
| proj-milvus02dev | Container Network | VLAN10 | Direct container port |

### **3.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Kubernetes (RKE2) | Complete service outage for proj-milvus01 |
| **Requires** | Portainer | Container management for proj-milvus02dev |
| **Requires** | MinIO | Vector storage unavailable |
| **Requires** | Etcd | Metadata management unavailable |
| **Required By** | RAGGraph | Semantic search unavailable |
| **Required By** | OpenWebUI | Context-aware query results impacted |
| **Required By** | Knowledge Base System | Document embeddings inaccessible |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Index Optimization | Monthly | AI/ML Engineer | [MILVUS-MAINT-001](../Procedures/MILVUS-MAINT-001.md) |
| Vector Collection Tuning | Quarterly | AI/ML Engineer | [MILVUS-MAINT-002](../Procedures/MILVUS-MAINT-002.md) |
| Performance Analysis | Monthly | AI/ML Engineer | [MILVUS-MAINT-003](../Procedures/MILVUS-MAINT-003.md) |
| System Updates | Weekly (Friday 10:00-11:00 EST) | Infrastructure Team | [itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md](../../../../itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

Milvus instances are monitored through Prometheus using the Milvus exporter:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Query Latency | >50ms avg | >200ms avg | [MILVUS-RESP-001](../Procedures/MILVUS-RESP-001.md) |
| Memory Usage | >75% max | >90% max | [MILVUS-RESP-002](../Procedures/MILVUS-RESP-002.md) |
| Index Load Time | >10s | >30s | [MILVUS-RESP-003](../Procedures/MILVUS-RESP-003.md) |
| Storage Utilization | >80% capacity | >90% capacity | [MILVUS-RESP-004](../Procedures/MILVUS-RESP-004.md) |

All metrics are exposed to Prometheus via exporters and visualized through dedicated Grafana dashboards on lab-mon01, following procedures defined in [itil-policies-and-procedures/Monitoring/MON-PROC-001.md](../../../../itil-policies-and-procedures/Monitoring/MON-PROC-001.md).

### **4.3 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Search Latency | High query times, timeouts | Review index type and parameters | KEDB-MILVUS-001 |
| Memory Pressure | High resource utilization | Adjust resource limits, optimize collections | KEDB-MILVUS-002 |
| Connection Issues | API errors, timeouts | Check network, restart components if needed | KEDB-MILVUS-003 |
| Index Loading Problems | Slow queries after restart | Check index cache settings | KEDB-MILVUS-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | JWT token authentication | [itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md) |
| Application Access | Service accounts with minimal privileges | [itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md) |
| API Access | SSL/TLS encrypted connections with API keys | [itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md](../../../../itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the Milvus service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based authentication, JWT tokens | Quarterly access review |
| Network Security | K8s network policies, TLS encryption | Monthly security scans |
| Data Encryption | TLS for connections, encryption at rest | Weekly security audits |
| Activity Logging | Comprehensive query and admin logging | Weekly log review, Wazuh alerts |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.2 (Ensure remote access requires MFA) | K8s authentication with token-based access | Security Scan Reports | Partially Compliant |
| CIS.8.3 (Ensure access is revoked upon termination) | Service account management via CI/CD pipelines | GLPI Change Records | Compliant |
| CIS.10.1 (Deploy and maintain anti-malware) | Host-level and container scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 (Configure automatic updates) | Container image updates via CI/CD pipeline | Pipeline Logs | Compliant |

The compliance mapping follows guidelines outlined in [itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md](../../../../itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md).

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

The following backup strategy ensures data protection and recoverability:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|-----------------|-------------|--------------|----------------------|
| Collection Snapshots | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Full Metadata Export | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Weekly Backup | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly Backup | First Sunday of month | 6 months | PBS + AWS Deep Glacier |

The backup strategy follows the principles defined in [itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md](../../../../itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md).

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Collection Corruption | 2 hours | 24 hours | [DR-MILVUS-001](../DR/DR-MILVUS-001.md) | AI/ML Engineer |
| Pod/Container Failure | 15 minutes | 1 hour | [DR-MILVUS-002](../DR/DR-MILVUS-002.md) | Kubernetes Administrator |
| Node Failure | 1 hour | 24 hours | [DR-MILVUS-003](../DR/DR-MILVUS-003.md) | Infrastructure Team |
| Datacenter Failure | 12 hours | 48 hours | [DR-MILVUS-004](../DR/DR-MILVUS-004.md) | DR Team |

The recovery procedures align with the incident management process defined in [itil-policies-and-procedures/Incident-Management/INC-PROC-001.md](../../../../itil-policies-and-procedures/Incident-Management/INC-PROC-001.md).

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | Milvus Tuning Guide | [docs/MILVUS-Tuning-Guide.md](../Guides/MILVUS-Tuning-Guide.md) | Performance optimization |
| Procedure | Vector Index Optimization | [docs/Vector-Index-Optimization.md](../Procedures/Vector-Index-Optimization.md) | Query performance |
| Architecture | RAG System Architecture | [docs/RAG-Architecture.md](../Architecture/RAG-Architecture.md) | Overall context |
| Security | Milvus Security Baseline | [docs/MILVUS-Security-Baseline.md](../Security/MILVUS-Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Milvus Documentation | <https://milvus.io/docs> | [Local Copy](../References/Milvus-Docs.pdf) | 2025-04-01 |
| Vector Database Best Practices | <https://milvus.io/docs/performance_tuning.md> | [Local Copy](../References/Milvus-Performance.pdf) | 2025-04-01 |
| Milvus Security Guide | <https://milvus.io/docs/security.md> | [Local Copy](../References/Milvus-Security.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-MILVUS-2025-001 | Milvus Kubernetes Deployment | 2025-02-20 | [GLPI-CR-MILVUS-001](https://glpi.lab.local/CR-MILVUS-2025-001) |
| CR-MILVUS-2025-002 | Index Type Change | 2025-03-15 | [GLPI-CR-MILVUS-002](https://glpi.lab.local/CR-MILVUS-2025-002) |
| CR-MILVUS-2025-003 | RAGGraph Integration | 2025-04-05 | [GLPI-CR-MILVUS-003](https://glpi.lab.local/CR-MILVUS-2025-003) |

All changes follow the process defined in [itil-policies-and-procedures/Change-Management/CHG-PROC-001.md](../../../../itil-policies-and-procedures/Change-Management/CHG-PROC-001.md).

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| AIMLEngineer | AI/ML Infrastructure Lead | 2025-04-22 | ✅ Approved |
| RAGArchitect | Knowledge Systems Architect | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |
