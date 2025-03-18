<!-- 
---
title: "Applications - Proxmox Astronomy Lab"
description: "Documentation hub for all applications and services running within the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["applications", "services", "documentation", "overview"]
category: "Applications"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🖥️ **Applications & Services**

## 🔍 **1. Overview**

The **Applications & Services** section documents all **deployed software systems** within the **Proxmox Astronomy Lab** environment. This includes **containerized applications, databases, supporting services, and research tools** that collectively enable the lab's IT operations and scientific research capabilities.

Each application is documented with a consistent approach covering **technical architecture, configuration details, access management, and operational procedures** to ensure proper maintenance and support throughout its lifecycle.

---

## 📊 **2. Application Categories**

The lab's applications are organized into functional categories that reflect their purpose and technical characteristics. Each category has its own dedicated documentation section.

| **Category** | **Purpose** | **Key Components** |
|--------------|------------|-------------------|
| [**AI-ML-Platforms**](AI-ML-Platforms/index.md) | Machine learning and AI capabilities | TensorFlow, Milvus, Jupyter, MLflow |
| [**Containerized-Services**](Containerized-Services/index.md) | Container orchestration and management | Docker, Kubernetes, Portainer |
| [**Databases**](Databases/index.md) | Structured and time-series data storage | PostgreSQL, TimescaleDB, Redis, MariaDB, MongoDB |
| [**Data-Analysis**](Data-Analysis/index.md) | Data processing and visualization | Apache Superset, Apache Airflow |
| [**File-Storage**](File-Storage/index.md) | File management and sharing | MinIO, Nextcloud, Restic |
| [**Identity**](Identity/index.md) | Authentication and authorization | Zitadel |
| [**Observability**](Observability/index.md) | Monitoring, logging, and alerting | Prometheus, Grafana, Loki |
| [**Radio-Astronomy**](Radio-Astronomy/index.md) | Scientific research applications | GNU Radio, SDR tools, CASA, Presto |
| [**Security**](Security/index.md) | Security monitoring and protection | Wazuh, Vaultwarden |
| [**Version-Control**](Version-Control/index.md) | Code and configuration management | Gitea |

---

## 🔧 **3. Deployment Architecture**

### **3.1 Deployment Strategy**

The lab employs a structured deployment approach that ensures all applications are properly containerized, monitored, and secured:

- **Containerized by default** - Applications are deployed using Docker and Kubernetes
- **Configuration as code** - All application configurations are version-controlled
- **Standardized monitoring** - Prometheus and Loki integration is mandatory
- **Consistent security baselines** - Security controls are applied to all applications

### **3.2 Primary Application Hosts**

| **Host** | **Purpose** | **Primary Applications** |
|----------|------------|-------------------------|
| **lab-apps01** | Lab-wide applications | Gitea, Nextcloud, Vaultwarden |
| **lab-db01** | Database systems | PostgreSQL, TimescaleDB, MariaDB, Redis |
| **lab-port01** | Container management | Portainer |
| **proj-apps01** | Project-specific applications | Apache Superset, MLflow, Airflow |
| **Kubernetes cluster** | Scalable workloads | Milvus, TensorFlow, processing pipelines |
| **proj-rds02** | Radio astronomy workstation | GNU Radio, SigDigger, SDR++ |

---

## 🔄 **4. Application Lifecycle Management**

### **4.1 Deployment Process**

All applications in the lab follow a structured deployment process:

1. **Containerization** - Applications are packaged in Docker containers
2. **Review & Testing** - Security and functionality testing in isolated environments
3. **Deployment** - Managed via Portainer, Kubernetes, or dedicated Ansible playbooks
4. **Monitoring Integration** - Exporters and agents are deployed with the application
5. **Documentation** - Service documentation is created or updated in this wiki

### **4.2 Maintenance & Updates**

| **Activity** | **Frequency** | **Responsibility** | **Documentation** |
|--------------|--------------|-------------------|-------------------|
| **Security Patching** | Monthly or as required | Engineer | [Patch Management](../ITIL-Processes/Change-Management/Patch-Management.md) |
| **Version Upgrades** | As needed | Engineer | [Application Upgrades](../ITIL-Processes/Change-Management/Application-Upgrades.md) |
| **Configuration Reviews** | Quarterly | Operations | [Configuration Reviews](../ITIL-Processes/Problem-Management/Configuration-Reviews.md) |
| **Backup Verification** | Monthly | Operations | [Backup Verification](../ITIL-Processes/Service-Catalog/Backup-Verification.md) |

---

## 🔐 **5. Security & Access Management**

### **5.1 Access Control**

The lab follows a consistent approach to application access control:

- **Centralized authentication** - Zitadel for identity management
- **Role-based access control** - Permissions assigned based on user roles
- **Multi-factor authentication** - Required for all administrative access
- **Access reviews** - Regular review of user accounts and permissions

### **5.2 Security Monitoring**

All applications are subject to security monitoring via:

- **Wazuh SIEM** - Security event monitoring and alerting
- **Log analysis** - Centralized logging in Loki with security alerting
- **Vulnerability scanning** - Regular assessment of application security
- **Configuration compliance** - Automated verification against security baselines

---

## 🚀 **6. Getting Started**

### **6.1 New Application Onboarding**

To add a new application to the lab environment:

1. Review the [Application Onboarding Guide](../ITIL-Processes/Change-Management/Application-Onboarding.md)
2. Submit a change request following the [RFC Template](../ITIL-Processes/Change-Management/RFC-Templates/RFC-Template.md)
3. Ensure the application meets security requirements detailed in [Application Security Standards](../Compliance-Security/Security-Policies/Application-Security-Standards.md)
4. Document the application following templates in [Documentation Standards](../Documentation-Standards/Templates/Service-Documentation/index.md)

### **6.2 Documentation Navigation**

For efficient navigation of application documentation:

1. Start with the category index to identify relevant services
2. Review application-specific pages for detailed technical information
3. Reference related operational procedures in the [ITIL Processes](../ITIL-Processes/index.md) section
4. Check security-related requirements in the [Compliance & Security](../Compliance-Security/index.md) section

---

## 🔗 **7. Related Documentation**

| **Documentation Area** | **Purpose** | **Link** |
|----------------------|------------|---------|
| **Infrastructure** | Physical and virtual infrastructure supporting applications | [Infrastructure](../Infrastructure/index.md) |
| **Control Plane** | Core services that enable applications | [Control Plane](../Control-Plane/index.md) |
| **ITIL Processes** | Operational procedures for application management | [ITIL Processes](../ITIL-Processes/index.md) |
| **Compliance & Security** | Security standards and requirements | [Compliance & Security](../Compliance-Security/index.md) |

---

## 🔄 **8. Application Integration**

### **8.1 Integration Patterns**

Applications in the lab are integrated using several standardized patterns:

- **API-first** - RESTful and GraphQL APIs for service communication
- **Message queuing** - Event-driven communication using RabbitMQ
- **Shared storage** - NFS and MinIO for common file access
- **Data pipelines** - Structured data flows using Apache Airflow

### **8.2 Key Integration Points**

| **Integration** | **Purpose** | **Documentation** |
|----------------|------------|-------------------|
| **Zitadel → All Applications** | Centralized authentication | [Identity Integration](../Entra-Hybrid-Cloud/Identity-Integration/index.md) |
| **Applications → Prometheus/Loki** | Monitoring and logging | [Observability Integration](Observability/index.md) |
| **Applications → Databases** | Data persistence | [Database Access](Databases/index.md) |
| **Research Applications → TimescaleDB** | Research data storage | [Research Data Architecture](Research-Projects/Data-Pipelines/Storage-Architecture/index.md) |

---

## 🛠️ **9. Process Integration**

### **9.1 ITIL Process Relationship**

Applications in the lab are managed according to ITIL processes:

- **Change Management** - Controlled application deployment and updates
- **Incident Management** - Handling application outages and issues
- **Problem Management** - Root cause analysis and permanent fixes
- **Service Level Management** - Defining and measuring application performance

### **9.2 Role Responsibilities**

| **Role** | **Application Management Responsibilities** |
|----------|-------------------------------------------|
| **Lab Owner** | Strategy, portfolio management, approval authority |
| **Engineer** | Design, implementation, upgrades, security hardening |
| **Operations** | Monitoring, incident response, performance management |
| **Service Desk** | User support, service requests, documentation |
| **Security Admin** | Security monitoring, compliance verification, vulnerability management |

---

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Applications index documentation | VintageDon |
