# 📋 **Service Catalog**

# 🔍 **1. Overview**

The Service Catalog for the Proxmox Astronomy Lab provides a structured inventory of all IT and research services offered within our environment. This catalog serves as the definitive source of information about available services, their capabilities, ownership, support arrangements, and dependencies. By maintaining a comprehensive service catalog, we ensure clarity about service offerings, establish clear expectations through documented service levels, and provide a framework for consistent service delivery and improvement.

This section documents our service portfolio structure, service definitions, support arrangements, and the relationships between technical components and the business/research services they enable.

---

# 🧩 **2. Service Portfolio Structure**

## **2.1 Service Categories**

Our services are organized into logical categories based on function and purpose:

| **Category** | **Description** | **Documentation** |
|--------------|----------------|-------------------|
| **Core Services** | Foundational infrastructure and platforms | [Core Services Overview](Core-Services/README.md) |
| **Research Services** | Scientific and data analysis capabilities | [Research Services Overview](Research-Services/README.md) |
| **Support Services** | Operational and administrative functions | [Support Services Overview](Support-Services/README.md) |

## **2.2 Service Lifecycle Status**

Services in the catalog are classified by their lifecycle status:

| **Status** | **Definition** | **Management Approach** | **Documentation** |
|------------|--------------|------------------------|-------------------|
| **Operational** | Live, fully supported services | Standard support and maintenance | [Operational Services](Service-Lifecycle/operational-services.md) |
| **In Development** | Services being implemented | Project management governance | [Development Services](Service-Lifecycle/development-services.md) |
| **Retired** | Decommissioned services | Historical reference only | [Retired Services](Service-Lifecycle/retired-services.md) |
| **Planned** | Future service roadmap | Strategic planning | [Planned Services](Service-Lifecycle/planned-services.md) |

---

# 📑 **3. Core Services**

## **3.1 Infrastructure Services**

Foundational services that support all other capabilities:

| **Service** | **Description** | **Owner** | **Documentation** |
|------------|----------------|----------|-------------------|
| **Compute Platform** | Virtualization infrastructure | Infrastructure Team | [Compute Service](Core-Services/compute-platform-service.md) |
| **Storage Services** | Data storage and management | Infrastructure Team | [Storage Service](Core-Services/storage-services.md) |
| **Network Services** | Connectivity and security | Infrastructure Team | [Network Service](Core-Services/network-services.md) |
| **Identity Services** | Authentication and authorization | Security Team | [Identity Service](Core-Services/identity-services.md) |

## **3.2 Platform Services**

Middle-tier services enabling application deployment:

| **Service** | **Description** | **Owner** | **Documentation** |
|------------|----------------|----------|-------------------|
| **Kubernetes Platform** | Container orchestration | Platform Team | [Kubernetes Service](Core-Services/kubernetes-platform.md) |
| **Database Platform** | Database hosting and management | Platform Team | [Database Service](Core-Services/database-platform.md) |
| **Monitoring & Observability** | System and service monitoring | Operations Team | [Monitoring Service](Core-Services/monitoring-observability.md) |
| **Backup & Recovery** | Data protection services | Infrastructure Team | [Backup Service](Core-Services/backup-recovery.md) |

---

# 🔭 **4. Research Services**

## **4.1 Data Analysis Services**

Services supporting scientific data processing:

| **Service** | **Description** | **Owner** | **Documentation** |
|------------|----------------|----------|-------------------|
| **Hydrogen Line Analysis** | Radio astronomy data processing | Research Team | [H-Line Service](Research-Services/hydrogen-line-analysis.md) |
| **AI/ML Platform** | Machine learning infrastructure | Research Team | [AI Platform](Research-Services/ai-ml-platform.md) |
| **Data Pipeline** | Data ingestion and processing | Research Team | [Data Pipeline](Research-Services/data-pipeline.md) |
| **Visualization Services** | Scientific data visualization | Research Team | [Visualization](Research-Services/visualization-services.md) |

## **4.2 Collaborative Research Tools**

Services supporting research collaboration:

| **Service** | **Description** | **Owner** | **Documentation** |
|------------|----------------|----------|-------------------|
| **Knowledge Repository** | Research documentation platform | Research Team | [Knowledge Repo](Research-Services/knowledge-repository.md) |
| **Remote Research Access** | Secure research environment access | Security Team | [Remote Access](Research-Services/remote-research-access.md) |
| **Data Publishing** | Public dataset management | Research Team | [Data Publishing](Research-Services/data-publishing.md) |
| **Jupyter Environment** | Interactive computing environment | Research Team | [Jupyter Service](Research-Services/jupyter-environment.md) |

---

# 🔧 **5. Support Services**

## **5.1 Operational Support**

Services for maintaining operational effectiveness:

| **Service** | **Description** | **Owner** | **Documentation** |
|------------|----------------|----------|-------------------|
| **Service Desk** | Single point of contact for support | Operations Team | [Service Desk](Support-Services/service-desk.md) |
| **Change Management** | Controlled implementation of changes | Operations Team | [Change Management](Support-Services/change-management.md) |
| **Asset Management** | Hardware and software asset tracking | Operations Team | [Asset Management](Support-Services/asset-management.md) |
| **Security Operations** | Security monitoring and response | Security Team | [Security Operations](Support-Services/security-operations.md) |

## **5.2 Administrative Services**

Services supporting governance and administration:

| **Service** | **Description** | **Owner** | **Documentation** |
|------------|----------------|----------|-------------------|
| **Documentation Management** | Technical and user documentation | Knowledge Team | [Documentation Service](Support-Services/documentation-management.md) |
| **Compliance Management** | Security and regulatory compliance | Security Team | [Compliance Service](Support-Services/compliance-management.md) |
| **Training Services** | Technical and user training | Knowledge Team | [Training Service](Support-Services/training-services.md) |
| **Capacity Management** | Resource forecasting and planning | Operations Team | [Capacity Service](Support-Services/capacity-management.md) |

---

# 🛠️ **6. Service Level Management**

## **6.1 Service Level Definitions**

Standard service level parameters:

| **Service Level** | **Availability Target** | **Support Hours** | **Documentation** |
|-------------------|----------------------|-----------------|-------------------|
| **Platinum** | 99.9%, 24x7 | 24x7 | [Platinum SLA](SLA-Templates/platinum-sla.md) |
| **Gold** | 99.5%, 24x7 | Business hours + on-call | [Gold SLA](SLA-Templates/gold-sla.md) |
| **Silver** | 99%, business hours | Business hours | [Silver SLA](SLA-Templates/silver-sla.md) |
| **Bronze** | Best effort | Business hours | [Bronze SLA](SLA-Templates/bronze-sla.md) |

## **6.2 Service Level Agreements**

Framework for establishing service commitments:

| **Component** | **Description** | **Documentation** |
|--------------|----------------|-------------------|
| **SLA Template** | Standard agreement structure | [SLA Template](SLA-Templates/sla-template.md) |
| **Performance Metrics** | Service measurement framework | [SLA Metrics](SLA-Templates/performance-metrics.md) |
| **Review Process** | Regular SLA assessment | [SLA Reviews](SLA-Templates/review-process.md) |
| **Reporting** | Service level reporting framework | [SLA Reporting](SLA-Templates/reporting.md) |

---

# 🔄 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Core-Services** | Documentation for infrastructure and platform services | [Core Services README](Core-Services/README.md) |
| **Research-Services** | Documentation for scientific and analysis services | [Research Services README](Research-Services/README.md) |
| **Support-Services** | Documentation for operational and administrative services | [Support Services README](Support-Services/README.md) |
| **SLA-Templates** | Service level agreement templates and guidelines | [SLA Templates README](SLA-Templates/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Service Catalog Policy** | Governance for service catalog management | [Catalog Policy](service-catalog-policy.md) |
| **Service Request Procedures** | Process for requesting services | [Service Requests](service-request-procedures.md) |
| **Service Portfolio Roadmap** | Strategic direction for service development | [Service Roadmap](service-portfolio-roadmap.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **ITIL-Processes** | Parent directory for service catalog | [ITIL Processes README](../README.md) |
| **Incident-Management** | Supports service restoration | [Incident Management README](../Incident-Management/README.md) |
| **Problem-Management** | Addresses underlying service issues | [Problem Management README](../Problem-Management/README.md) |
| **Change-Management** | Controls service modifications | [Change Management README](../Change-Management/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Initial service catalog README | VintageDon |
