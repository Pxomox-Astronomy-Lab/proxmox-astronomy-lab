<!-- 
---
title: "Control Plane - Proxmox Astronomy Lab"
description: "Documentation of the foundational control plane services that enable secure, automated, and structured IT operations in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["control-plane", "infrastructure", "identity", "automation", "monitoring", "security"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔧 **Control Plane**

## 🔍 **1. Overview**

The **Control Plane** is the foundational layer that enables **secure, automated, and structured IT operations** in the **Proxmox Astronomy Lab**. It provides the **identity, automation, monitoring, and security infrastructure** required to support both **research workloads and IT services**.

This section documents the **core services, architecture, and compliance considerations** that govern control plane operations.

---

## 🎯 **2. Scope**

The Control Plane includes **all core infrastructure services** related to **identity management, automation, observability, and security**. It ensures that **all compute, storage, and network functions** are centrally managed and enforced.

| **Function Area** | **Key Components** | **Primary Services** |
|-------------------|-------------------|----------------------|
| **Identity & Authentication** | Active Directory, Entra ID | lab-dc01, lab-dc02 |
| **Automation & Configuration** | Ansible, GitOps workflows | lab-ansible01 |
| **Monitoring & Logging** | Prometheus, Loki, Grafana | lab-mon01 |
| **Security Operations** | Wazuh SIEM, vulnerability scanning | lab-soc01 |
| **Service Orchestration** | Portainer, Docker | lab-port01, lab-apps01 |

This section **does not cover** Kubernetes workloads or research-specific applications—those are addressed in their respective sections.

---

## 🏗️ **3. Service Architecture**

### **3.1 Service Overview**

The control plane consists of **mission-critical services** that ensure the lab remains operational, secure, and automated.

| **Service** | **Function** | **Documentation** |
|-------------|-------------|-------------------|
| [**lab-ansible01**](lab-ansible01-automation-master.md) | Configuration management and automation via Ansible playbooks | [Ansible Documentation](lab-ansible01-automation-master.md) |
| [**lab-apps01**](lab-apps01-docker-application-node.md) | Hosts containerized microservices for lab operations | [Apps Node Documentation](lab-apps01-docker-application-node.md) |
| [**lab-db01**](lab-db01-docker-database-node.md) | PostgreSQL and TimescaleDB instance for structured data | [Database Node Documentation](lab-db01-docker-database-node.md) |
| [**lab-dc01**](lab-dc01-primary-domain-controller.md) | Manages Active Directory authentication and Entra ID synchronization | [Primary DC Documentation](lab-dc01-primary-domain-controller.md) |
| [**lab-dc02**](lab-dc02-ro-domain-controller.md) | Provides redundancy and high availability for domain services | [RODC Documentation](lab-dc02-ro-domain-controller.md) |
| [**lab-dns01**](lab-dns01-dns-filtering.md) | Technitium-based DNS filtering and security enforcement (VLAN10) | [DNS01 Documentation](lab-dns01-dns-filtering.md) |
| [**lab-dns02**](lab-dns02-dns-filtering.md) | Technitium-based DNS filtering and security enforcement (VLAN20) | [DNS02 Documentation](lab-dns02-dns-filtering.md) |
| [**lab-fs01**](lab-fs01-active-directory-file-shares.md) | Centralized SMB shares for controlled data access | [File Share Documentation](lab-fs01-active-directory-file-shares.md) |
| [**lab-mon01**](lab-mon01-prometheus-monitoring-logging-stack.md) | Prometheus, Loki, and Grafana for system observability | [Monitoring Documentation](lab-mon01-prometheus-monitoring-logging-stack.md) |
| [**lab-port01**](lab-port01-portainer-control-node.md) | Manages Docker-based microservices and containerized workloads | [Portainer Documentation](lab-port01-portainer-control-node.md) |
| [**lab-soc01**](lab-soc01-wazuh-seim-xdr.md) | Security event correlation, log monitoring, and intrusion detection | [Wazuh Documentation](lab-soc01-wazuh-seim-xdr.md) |

### **3.2 Service Dependencies**

The control plane services have interdependencies that ensure proper function:

| **Service** | **Dependencies** | **Dependent Services** |
|-------------|-----------------|------------------------|
| **lab-dc01** | Network infrastructure | All other services (authentication) |
| **lab-dns01/02** | lab-dc01 | All network services (name resolution) |
| **lab-ansible01** | lab-dc01, lab-dns01 | None (configuration source) |
| **lab-mon01** | lab-dc01, lab-dns01 | All services (monitoring targets) |
| **lab-soc01** | lab-dc01, lab-dns01, lab-mon01 | All services (security monitoring) |

---

## 📊 **4. IT Service Management**

### **4.1 ITIL Alignment**

The Control Plane follows a structured **ITIL-lite** approach for **incident, change, and service management**.

| **ITIL Process** | **Implementation in the Lab** | **Documentation** |
|------------------|-------------------------------|-------------------|
| **Change Management** | Changes tracked via **GLPI**, automated playbooks where possible | [Change Management Process](../itil-processes/change-management-process.md) |
| **Incident Management** | Alerts via **Prometheus & Wazuh**, centralized logging with Loki | [Incident Management Process](../itil-processes/incident-management-process.md) |
| **Configuration Management** | Automated configuration drift enforcement via **Ansible playbooks** | [Configuration Management](../itil-processes/configuration-management.md) |
| **Access & Identity Management** | Managed via **Entra ID, Conditional Access, and AD Group Policies** | [Access Management Process](../itil-processes/access-management-process.md) |

### **4.2 Service Level Objectives**

| **Service** | **Availability Target** | **Performance Metrics** | **Recovery Time Objective** |
|-------------|-------------------------|-------------------------|----------------------------|
| **Domain Services** | 99.9% | Authentication < 1s | 15 minutes |
| **DNS Services** | 99.95% | Query response < 100ms | 10 minutes |
| **Monitoring Stack** | 99.5% | Alert latency < 2 minutes | 30 minutes |
| **Security Services** | 99.5% | Alert processing < 5 minutes | 30 minutes |

---

## 🔐 **5. Compliance & Security**

### **5.1 Security Controls**

The control plane aligns with **CIS Benchmarks and security best practices**.

| **Compliance Standard** | **Implementation** | **Verification Method** |
|-------------------------|-------------------|-------------------------|
| **CIS v8 Level 2 (Linux)** | All Linux-based nodes hardened via Ansible playbooks | Lynis, Wazuh agent scans |
| **CIS v9 Level 1 (Windows)** | Windows Server 2025 domain controllers hardened to CIS L1 | CIS-CAT scans, GPO enforcement |
| **Entra ID Conditional Access** | MFA, risk-based sign-in enforcement, and strict access control | Azure Security Center |
| **Security Logging** | Full log aggregation in **Loki and Wazuh**, retained per policy | Log retention verification |
| **Automated Security Scanning** | Daily scans via **RKHunter, CHKRoot, Lynis, and OSQuery** | Scan results review |

### **5.2 Vulnerability Management**

| **Activity** | **Frequency** | **Tooling** | **Response Time** |
|--------------|--------------|------------|-------------------|
| **Vulnerability Scanning** | Daily | Wazuh, OpenSCAP | Critical: 24h, High: 72h |
| **Patch Management** | Monthly (or as needed) | Ansible automation | Based on severity |
| **Configuration Verification** | Daily | Ansible check mode | 24h for drift correction |

---

## 🛠️ **6. Automation & Management**

### **6.1 Ansible Configuration Management**

Ansible manages **infrastructure automation, security compliance, and configuration drift prevention**.

| **Automation Area** | **Implementation** | **Documentation** |
|--------------------|-------------------|-------------------|
| **Baseline Configuration** | All nodes provisioned with predefined security and service settings | [Baseline Playbooks](lab-ansible01-automation-master.md) |
| **Patch & Compliance Enforcement** | Security updates applied per compliance schedule | [Patch Management](lab-ansible01-automation-master.md) |
| **Role-Based Playbooks** | Ensures modular, scalable automation of services | [Ansible Roles](lab-ansible01-automation-master.md) |

### **6.2 Portainer for Docker Management**

Portainer provides **centralized control of Docker-based workloads**, ensuring **efficient service orchestration and monitoring**.

| **Portainer Feature** | **Use Case** | **Documentation** |
|-----------------------|-------------|-------------------|
| **Container Management** | Lifecycle management for all Docker containers | [Container Management](lab-port01-portainer-control-node.md) |
| **Stack Deployment** | Docker Compose deployment for multi-container applications | [Stack Management](lab-port01-portainer-control-node.md) |
| **Resource Monitoring** | Real-time container resource usage tracking | [Container Monitoring](lab-port01-portainer-control-node.md) |

---

## 📈 **7. Monitoring & Observability**

### **7.1 Monitoring Architecture**

| **Component** | **Function** | **Scope** |
|---------------|-------------|-----------|
| **Prometheus** | Metrics collection and alerting | All infrastructure and services |
| **Loki** | Log aggregation and search | Centralized logging repository |
| **Grafana** | Visualization and dashboards | User interface for monitoring data |
| **Wazuh** | Security monitoring and compliance | Security-focused event monitoring |

### **7.2 Key Dashboards**

| **Dashboard** | **Purpose** | **Primary Users** |
|---------------|------------|-------------------|
| **Infrastructure Overview** | High-level status of all systems | Lab Owner, Engineers |
| **Security Monitoring** | Security events and compliance status | Security Administrator |
| **Service Performance** | Detailed service metrics and SLO tracking | Operations |
| **Alert Management** | Active and historical alerts | All roles |

---

## 🔄 **8. Ongoing Development**

The Control Plane is the **foundational framework** for the lab, ensuring **secure, automated, and well-managed IT operations**.

| **Enhancement Area** | **Planned Improvements** | **Timeline** |
|----------------------|--------------------------|-------------|
| **Service Recovery** | Expanded self-healing automation for service recovery | Q2 2025 |
| **Security Analytics** | Improved AI-driven security event correlation | Q3 2025 |
| **Process Refinement** | Refinement of ITIL-based change and incident management | Ongoing |

---

## 🔗 **9. Related Documentation**

| **Document Area** | **Description** | **Link** |
|-------------------|----------------|---------|
| **ITIL Processes** | Detailed service management procedures | [ITIL Documentation](../itil-processes/README.md) |
| **Security Framework** | Lab-wide security policies and controls | [Security Documentation](../compliance-security/README.md) |
| **Infrastructure Overview** | Broader infrastructure context | [Infrastructure Documentation](../README.md) |
| **Kubernetes Control Plane** | Research workload orchestration | [Kubernetes Documentation](../kubernetes/README.md) |

---

## ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Standardized Control Plane README | VintageDon |
