# **Control Plane - Proxmox Astronomy Lab**

## **1. Purpose**

The **Control Plane** is the foundational layer that enables **secure, automated, and structured IT operations** in the **Proxmox Astronomy Lab**. It provides the **identity, automation, monitoring, and security infrastructure** required to support both **research workloads and IT services**.

This document defines the **core services, architecture, and compliance considerations** that govern control plane operations.

---

## **2. Scope**

The Control Plane includes **all core infrastructure services** related to **identity management, automation, observability, and security**. It ensures that **all compute, storage, and network functions** are centrally managed and enforced.

**Key Functions Covered:**

- **Authentication & Identity Management** → Hybrid AD, Entra ID, Conditional Access
- **Automation & Configuration Management** → Ansible-based automation
- **Monitoring & Security Operations** → Prometheus, Loki, Wazuh SIEM
- **Service Orchestration** → Portainer, AD-integrated file shares

This section **does not cover** Kubernetes workloads or research-specific applications—those are addressed in their respective sections.

---

## **3. Service Overview**

The control plane consists of **mission-critical services** that ensure the lab remains operational, secure, and automated.

| **Service** | **Function** |
|-------------|-------------|
| **Ansible Master (lab-ansible01)** | Configuration management and automation via Ansible playbooks. |
| **Docker Application Node (lab-apps01)** | Hosts containerized microservices for lab operations. |
| **Database Node (lab-db01)** | PostgreSQL and TimescaleDB instance for structured data. |
| **Primary Domain Controller (lab-dc01)** | Manages Active Directory authentication and Entra ID synchronization. |
| **Read-Only Domain Controller (lab-dc02)** | Provides redundancy and high availability for domain services. |
| **DNS Filtering (lab-dns01, lab-dns02)** | Technitium-based DNS filtering and security enforcement. |
| **Active Directory File Shares (lab-fs01)** | Centralized SMB shares for controlled data access. |
| **Monitoring & Logging Stack (lab-mon01)** | Prometheus, Loki, and Grafana for system observability. |
| **Portainer Control Node (lab-port01)** | Manages Docker-based microservices and containerized workloads. |
| **Wazuh SIEM & XDR (lab-soc01)** | Security event correlation, log monitoring, and intrusion detection. |

Each service is designed to **ensure high availability, enforce security policies, and streamline operations**.

---

## **4. IT Service Management (ITIL Alignment)**

The Control Plane follows a structured **ITIL-lite** approach for **incident, change, and service management**.

| **ITIL Process** | **Implementation in the Lab** |
|----------------|---------------------------|
| **Change Management** | Changes tracked via **GPLI**, automated playbooks where possible. |
| **Incident Management** | Alerts via **Prometheus & Wazuh**, centralized logging with Loki. |
| **Configuration Management** | Automated configuration drift enforcement via **Ansible playbooks**. |
| **Access & Identity Management** | Managed via **Entra ID, Conditional Access, and AD Group Policies**. |

This ensures that **infrastructure changes, security policies, and service reliability** are continuously maintained.

---

## **5. Compliance & Security**

The control plane aligns with **CIS Benchmarks and security best practices**.

| **Compliance Standard** | **Implementation** |
|-----------------|-----------------|
| **CIS v8 Level 2 (Linux)** | All Linux-based nodes hardened via Ansible playbooks. |
| **CIS v9 Level 1 (Windows)** | Windows Server 2025 domain controllers hardened to CIS L1. |
| **Entra ID Conditional Access** | MFA, risk-based sign-in enforcement, and strict access control. |
| **Security Logging** | Full log aggregation in **Loki and Wazuh**, retained per policy. |
| **Automated Security Scanning** | Daily scans via **RKHunter, Lynis, and OSQuery**. |

Security and compliance policies are **continuously reviewed and updated** to maintain alignment with evolving threats and best practices.

---

## **6. Automation & Infrastructure Management**

### **6.1 Ansible Configuration Management**

Ansible manages **infrastructure automation, security compliance, and configuration drift prevention**.

- **Baseline Configuration** → All nodes provisioned with predefined security and service settings.
- **Patch & Compliance Enforcement** → Security updates applied per compliance schedule.
- **Role-Based Playbooks** → Ensures modular, scalable automation of services.

### **6.2 Portainer for Docker Management**

Portainer provides **centralized control of Docker-based workloads**, ensuring **efficient service orchestration and monitoring**.

---

## **7. Summary & Next Steps**

The Control Plane is the **foundational framework** for the lab, ensuring **secure, automated, and well-managed IT operations**.

Future enhancements will include:

- **Expanded self-healing automation for service recovery.**
- **Improved AI-driven security analytics.**
- **Refinement of ITIL-based change and incident management.**

📌 **Refer to each service’s documentation for in-depth details.**
