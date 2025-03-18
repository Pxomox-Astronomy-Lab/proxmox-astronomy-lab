<!--
---
title: "Azure Hybrid & DevOps Tagging Strategy"
description: "Comprehensive tagging approach for Azure Arc-managed infrastructure, security compliance, and DevOps workloads."
author: "VintageDon"
tags: ["infrastructure", "azure arc", "security", "devops", "tagging"]
category: "Governance"
kb_type: "Reference"
version: "2.0"
status: "Published"
last_updated: "2025-03-15"
---
-->

# **Azure Hybrid & DevOps Tagging Strategy**

## **1. Overview**

### **1.1 Purpose**

This document defines the **standardized tagging strategy** for **Azure Arc-managed on-premises resources, security posture management, and Azure DevOps work tracking**. The goal is to:

- Ensure **consistent governance** across **hybrid cloud and on-prem workloads**.
- Improve **security tracking** for Windows Defender for Cloud **reference systems (dc01, sec01, pg01)**.
- Streamline **Azure DevOps work item tagging** to **enhance ITIL change management, automation tracking, and monitoring**.
- Support **research workflows** for **Hydrogen Line astronomy and RF monitoring**.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|-------------|------------------|
| **Azure Arc-managed infrastructure** | **Azure-hosted VMs or services** |
| **Windows Defender for Cloud (reference nodes)** | **End-user devices** |
| **DevOps pipelines & observability workloads** | **Personal development environments** |
| **Research & science-specific tagging** | **External data repositories** |

### **1.3 Target Audience**

This document is intended for **Lab Engineers, Security Administrators, DevOps Engineers, and IT Operations** responsible for maintaining **hybrid infrastructure and security policies**.

---

## **2. Tagging Principles**

### **2.1 Core Tagging Philosophy**

The tagging strategy follows these key principles:

- **Hybrid Governance:** Tags align with **Azure Arc and on-prem workloads**.
- **Security & Compliance:** Tags help track **CISv8 enforcement, security policies, and audits**.
- **Automation & DevOps:** Ensures **CI/CD pipelines and observability tracking** are properly categorized.
- **ITIL Process Alignment:** Tracks **change requests, incident management, and approvals**.

### **2.2 Required vs. Optional Tags**

| **Required Tags** | **Purpose** |
|-------------------|------------|
| `security:defender` | **Tracks Defender for Cloud protection status** |
| `security:compliance` | **Indicates CIS, NIST, or ISO27001 compliance level** |
| `infra:arc` | **Identifies resources managed under Azure Arc** |
| `itil:change-mgmt` | **Tracks CAB approvals and governance workflows** |
| `automation:ci-cd` | **Links to DevOps automation & pipeline processes** |

Optional tags **enhance tracking but are not enforced**.

---

## **3. Tag Categories and Definitions**

### **3.1 Security & Compliance (Windows Defender for Cloud & CIS Posture)**

| **Tag Name** | **Description** | **Applied To** |
|-------------|----------------|---------------|
| `security:defender` | Defender for Cloud **(dc01, sec01, pg01 reference set)** | Defender-enabled nodes |
| `security:compliance` | General security **tracking (CISv8, NIST, ISO27001 alignment)** | All security-monitored nodes |
| `security:rbac` | Role-based access control policies | Any identity-managed service |
| `security:firewall` | Firewall & network policy enforcement | Network appliances |
| `security:audit` | Tracks **compliance & security audits** | Compliance-tracked workloads |

### **3.2 Infrastructure & Services (Azure Arc Hybrid)**

| **Tag Name** | **Description** | **Applied To** |
|-------------|----------------|---------------|
| `infra:arc` | Azure Arc-managed on-prem infrastructure | Arc-enabled servers |
| `infra:keyvault` | **Azure Key Vault integration** for secrets management | Secure credential stores |
| `infra:blob` | **Azure Blob Storage** for backups & archival | Azure storage services |
| `infra:dc01` | **Domain Controller (Security Hardened Reference)** | Domain controller |
| `infra:sec01` | **Security monitoring node (Defender for Cloud enabled)** | SIEM nodes |
| `infra:pg01` | **PostgreSQL reference node under security enforcement** | Database nodes |

### **3.3 DevOps & Automation (Azure DevOps Workloads)**

| **Tag Name** | **Description** | **Applied To** |
|-------------|----------------|---------------|
| `devops:github` | **GitHub repository integration with Azure DevOps** | Source control systems |
| `devops:repo` | **Source control & version tracking** | GitHub/Azure DevOps |
| `devops:pipelines` | **CI/CD pipeline automation tracking** | DevOps workloads |
| `automation:ci-cd` | **General DevOps automation & workflows** | All pipeline jobs |
| `automation:ansible` | **Ansible-based infrastructure automation** | Config-managed nodes |
| `automation:terraform` | **Terraform infrastructure provisioning** | IaC-deployed resources |

### **3.4 ITIL & Change Management**

| **Tag Name** | **Description** | **Applied To** |
|-------------|----------------|---------------|
| `itil:change-mgmt` | **Tracks CAB approvals for governance workflows** | Work items needing review |
| `itil:incident` | **Incident response tagging for security issues** | Security reports |
| `itil:problem` | **Problem management & root cause analysis** | ITSM-tracked tickets |
| `itil:request` | **Change requests requiring approval** | Infrastructure change logs |

### **3.5 Observability & Logging**

| **Tag Name** | **Description** | **Applied To** |
|-------------|----------------|---------------|
| `monitoring:prometheus` | **Prometheus metric collection & alerts** | Monitoring stack |
| `monitoring:cadvisor` | **cAdvisor container-level monitoring** | Containerized workloads |
| `monitoring:sensu` | **Sensu Go monitoring implementation** | On-prem alerting stack |
| `logging:loki` | **Loki-based structured logging & ingestion** | Logging pipelines |
| `logging:audit` | **Audit log tracking for compliance enforcement** | Security-monitored services |

### **3.6 Research & Science (Radio Astronomy & RF Monitoring)**

| **Tag Name** | **Description** | **Applied To** |
|-------------|----------------|---------------|
| `research:h1line` | **Hydrogen Line Astronomy project tracking** | Astronomy data pipelines |
| `research:rf-monitoring` | **RF interference monitoring workloads** | RF signal processing |
| `data:processing-stage` | **Data processing workflow stages** | SDR workflows |

---

### **3.7 Application & Service Tagging**

Application tagging ensures that **all deployed services, databases, and microservices** are properly categorized for **observability, security, and governance tracking**.

| **Tag Name** | **Description** | **Applied To** |
|-------------|----------------|---------------|
| `app:gitea` | **Gitea source control management** | lab-apps01, microservices stack |
| `app:wiki-js` | **Wiki.js documentation platform** | lab-apps01 |
| `app:nginxproxymgr` | **NGINX Proxy Manager reverse proxy & web services** | lab-apps01, proj-apps01 |
| `app:vault` | **HashiCorp Vault for secrets management** | lab-apps01 |
| `app:zitadel` | **Zitadel authentication & identity provider** | lab-apps01 |
| `db:postgresql` | **PostgreSQL database service** | proj-db01, lab-db01 |
| `db:timescaledb` | **TimescaleDB for time-series data** | proj-db01, lab-db01 |
| `db:mariadb` | **MariaDB relational database** | proj-db01, lab-db01 |
| `db:redis` | **Redis caching & message queue** | proj-db01, microservices stack |
| `db:mongodb` | **MongoDB NoSQL database** | proj-db01, microservices stack |
| `db:backup` | **Database backup tracking & policy enforcement** | proj-db01, lab-db01 |
| `service:monitoring` | **General observability services** | lab-mon01, microservices stack |
| `service:logging` | **Logging infrastructure (Loki, Promtail)** | lab-mon01, observability stack |
| `service:metrics` | **Metrics collection (Prometheus, cAdvisor, Sensu)** | lab-mon01 |
| `service:api-gateway` | **API Gateway services (Kong, Traefik)** | proj-apps01 |
| `service:containerized` | **Containerized application deployment** | proj-apps01, lab-apps01 |
| `service:reverse-proxy` | **Reverse proxy management (NGINX, Traefik)** | proj-apps01, lab-apps01 |

These tags provide **structured tracking and governance** for all **applications, databases, and supporting services** deployed in **Phase 3**.

---

## **4. Implementation Plan**

### **4.1 Azure Arc & DevOps Tagging**

1. **Apply Arc-related tags to all Azure Arc-enabled servers.**
2. **Enforce Defender for Cloud security tags on `dc01`, `sec01`, `pg01`.**
3. **Standardize DevOps work item tagging across Azure Boards.**
4. **Map all ITIL work items to `itil:change-mgmt`, `itil:incident`, or `itil:request`.**

### **4.2 Automation & Governance**

- **Use Azure Policy & DevOps Rules to enforce tags.**
- **Automate DevOps work item tagging based on workflows.**
- **Generate reports based on tagged security, DevOps, and ITIL work items.**

---

## **5. Review & Compliance**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lab Owner | 2025-03-15 | Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 2.0 | 2025-03-15 | Integrated DevOps tagging strategy | VintageDon |
