<!-- 
---
title: "Control Plane - Proxmox Astronomy Lab"
description: "Documentation of core infrastructure services for identity management, security, automation, and observability"
author: "VintageDon"
tags: ["infrastructure", "control-plane", "identity", "monitoring", "automation", "security"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["Active Directory", "Wazuh", "Ansible", "Portainer", "Prometheus"]
implements_policies: ["Identity Management Policy", "Security Monitoring Policy"]
phase: "phase-1"
---
-->

# 🛂 **Control Plane - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

The Control Plane serves as the foundational layer for all operations within the Proxmox Astronomy Lab, providing critical infrastructure services for identity management, security, automation, and observability. This section documents the core services that enable secure, automated, and structured IT operations supporting both research workloads and IT management.

The Control Plane implements enterprise-grade practices through a carefully designed architecture that balances security, performance, and operational efficiency while maintaining compliance with security frameworks and best practices.

---

# 🔐 **2. Identity & Security Services**

## **2.1 Domain Controllers & Identity Management**

This component group provides authentication, authorization, and identity services for the entire lab environment.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Primary Domain Controller (lab-dc01)** | Windows Server 2025 PDC with Entra ID hybrid join, FSMO roles, and group policy management | [Primary DC Documentation](./lab-dc01-primary-domain-controller.md) |
| **Read-Only Domain Controller (lab-dc02)** | Windows Server 2025 RODC providing authentication redundancy in VLAN20 | [Secondary DC Documentation](./lab-dc02-ro-domain-controller.md) |
| **DNS Filtering (lab-dns01, lab-dns02)** | Technitium-based DNS filtering for security enforcement and name resolution | [DNS01 Documentation](./lab-dns01-dns-filtering.md), [DNS02 Documentation](./lab-dns02-dns-filtering.md) |

## **2.2 Security Operations**

This component group handles security monitoring, event management, and compliance enforcement.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Wazuh SIEM/XDR (lab-soc01)** | Security event correlation, log monitoring, and intrusion detection | [Wazuh SIEM Documentation](./lab-soc01-wazuh-seim-xdr.md) |
| **Active Directory File Shares (lab-fs01)** | Centralized SMB shares with security-based access controls | [File Shares Documentation](./lab-fs01-active-directory-file-shares.md) |

---

# 📊 **3. Automation & Operational Services**

## **3.1 Configuration Management**

This component group provides infrastructure automation, security compliance, and configuration management.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Ansible Master (lab-ansible01)** | Centralized configuration management and automation via Ansible playbooks | [Ansible Documentation](./lab-ansible01-automation-master.md) |

## **3.2 Containerized Services Management**

This component group manages Docker-based workloads throughout the environment.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Portainer Control Node (lab-port01)** | Management of Docker-based microservices and containerized workloads | [Portainer Documentation](./lab-port01-portainer-control-node.md) |
| **Docker Application Node (lab-apps01)** | Portainer agent node hosting containerized microservices for lab operations | [Docker Apps Documentation](./lab-apps01-docker-application-node.md) |
| **Database Node (lab-db01)** | Portainer agent node for databases (PostgreSQL, TimescaleDB, etc.) | [Database Node Documentation](./lab-db01-docker-database-node.md) |

## **3.3 Monitoring & Observability**

This component group provides comprehensive monitoring, logging, and alerting services.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Monitoring Stack (lab-mon01)** | Prometheus, Loki, AlertManager, and Grafana for system observability | [Monitoring Documentation](./lab-mon01-prometheus-monitoring-logging-stack.md) |

---

# 🔗 **4. Directory Contents**

This section provides direct navigation to all key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Primary Domain Controller** | Documentation for lab-dc01 | [lab-dc01-primary-domain-controller.md](./lab-dc01-primary-domain-controller.md) |
| **Read-Only Domain Controller** | Documentation for lab-dc02 | [lab-dc02-ro-domain-controller.md](./lab-dc02-ro-domain-controller.md) |
| **DNS Filtering Primary** | Documentation for lab-dns01 | [lab-dns01-dns-filtering.md](./lab-dns01-dns-filtering.md) |
| **DNS Filtering Secondary** | Documentation for lab-dns02 | [lab-dns02-dns-filtering.md](./lab-dns02-dns-filtering.md) |
| **Ansible Automation** | Documentation for lab-ansible01 | [lab-ansible01-automation-master.md](./lab-ansible01-automation-master.md) |
| **Docker Applications** | Documentation for lab-apps01 | [lab-apps01-docker-application-node.md](./lab-apps01-docker-application-node.md) |
| **Database Node** | Documentation for lab-db01 | [lab-db01-docker-database-node.md](./lab-db01-docker-database-node.md) |
| **File Shares** | Documentation for lab-fs01 | [lab-fs01-active-directory-file-shares.md](./lab-fs01-active-directory-file-shares.md) |
| **Monitoring Stack** | Documentation for lab-mon01 | [lab-mon01-prometheus-monitoring-logging-stack.md](./lab-mon01-prometheus-monitoring-logging-stack.md) |
| **Portainer Control** | Documentation for lab-port01 | [lab-port01-portainer-control-node.md](./lab-port01-portainer-control-node.md) |
| **Security Operations** | Documentation for lab-soc01 | [lab-soc01-wazuh-seim-xdr.md](./lab-soc01-wazuh-seim-xdr.md) |

---

# 🔄 **5. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Physical host nodes running these VMs | [Infrastructure Documentation](/infrastructure/README.md) |
| **Kubernetes** | Research applications supported by control plane | [Kubernetes Documentation](/infrastructure/kubernetes/README.md) |
| **Entra Hybrid Cloud** | Cloud identity integration with on-premises AD | [Entra Documentation](/entra-hybrid-cloud/README.md) |
| **Monitoring** | Extended monitoring configuration | [Monitoring Documentation](/monitoring/README.md) |
| **Security & Compliance** | Security policies implemented by control plane | [Security Documentation](/docs/Compliance-Security/README.md) |

---

# ✅ **6. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **7. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for control plane directory | VintageDon |
