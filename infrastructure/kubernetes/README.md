# **Kubernetes - Proxmox Astronomy Lab**

## **1. Purpose**

The **Kubernetes environment** within the Proxmox Astronomy Lab provides a **scalable, automated, and resilient platform** for **research workloads, AI/ML pipelines, and containerized applications**. It enables **dynamic workload management, resource efficiency, and security enforcement** while integrating with existing infrastructure services.

This document outlines the **architecture, service components, and compliance measures** that govern Kubernetes operations.

---

## **2. Scope**

The **Kubernetes control plane and worker nodes** handle containerized workloads across **scientific computing, AI/ML, and observability pipelines**.

**Key Functions Covered:**

- **Cluster Management & Scaling** → RKE2-based Kubernetes deployment
- **Workload Orchestration** → Automated research pipelines & microservices
- **Storage & Networking** → Integrated NVMe-backed storage, CNI overlays
- **Security & Compliance** → CIS Kubernetes benchmarks, Entra ID integration

This section **does not cover** non-containerized services, such as **Proxmox-hosted VMs or direct observatory hardware integration**.

---

## **3. Service Overview**

The Kubernetes cluster consists of **management nodes (control plane) and worker nodes** optimized for high-performance workloads.

| **Node** | **Role** | **Resources** |
|---------|---------|-------------|
| **proj-k8sm01** | Control Plane | 8 vCPUs / 32GB RAM / 1TB NVMe |
| **proj-k8sm02** | Control Plane | 8 vCPUs / 32GB RAM / 1TB NVMe |
| **proj-k8sm03** | Control Plane | 8 vCPUs / 32GB RAM / 1TB NVMe |
| **proj-k8sw01** | Worker | 8 vCPUs / 32GB RAM / 1TB NVMe |
| **proj-k8sw02** | Worker | 8 vCPUs / 32GB RAM / 1TB NVMe |
| **proj-k8sw03** | Worker | 8 vCPUs / 32GB RAM / 1TB NVMe |
| **proj-k8sw04** | Worker (GPU) | 16 vCPUs / 64GB RAM / 1TB NVMe + A4000 GPU |
| **proj-k8sw05** | Worker (GPU) | 16 vCPUs / 64GB RAM / 1TB NVMe + 1660 Ti GPU |

Each node is **hardened, optimized for research computing**, and **configured for AI/ML workloads**.

---

## **4. IT Service Management (ITIL Alignment)**

The Kubernetes infrastructure follows **ITIL-lite principles** to maintain structured change management and reliability.

| **ITIL Process** | **Implementation in the Lab** |
|----------------|---------------------------|
| **Change Management** | Managed through **GLPI tickets** and structured Ansible playbooks. |
| **Incident Management** | **Prometheus, Grafana Alerts, and Loki** provide real-time monitoring. |
| **Configuration Management** | Automated through **Ansible and GitOps workflows**. |
| **Access & Identity Management** | Integrated with **Entra ID, RBAC, and Kubernetes Service Accounts**. |

This ensures a **repeatable, scalable, and secure** operational framework for Kubernetes workloads.

---

## **5. Compliance & Security**

The Kubernetes cluster aligns with **CIS Benchmarks and Kubernetes best practices**.

| **Compliance Standard** | **Implementation** |
|-----------------|-----------------|
| **CIS Kubernetes Benchmark v1.6** | RKE2 hardened deployment with security policies enforced. |
| **Entra ID Authentication** | Integrated RBAC for fine-grained access control. |
| **Pod Security Policies** | Enforced through **Kyverno policies** to prevent privilege escalation. |
| **Logging & Monitoring** | Full-stack observability with **Prometheus, Loki, and Fluent Bit**. |
| **Automated Image Scanning** | Security scanning via **Trivy and Clair** before deployment. |

Security controls are **continuously updated** to reflect best practices for containerized workloads.

---

## **6. Automation & Workload Management**

### **6.1 GitOps & CI/CD Integration**

- **Git-backed configuration management** → ArgoCD-based deployment model.
- **Ansible-driven cluster updates** → Ensures configuration drift prevention.
- **Automated application scaling** → Horizontal and vertical scaling enabled.

### **6.2 AI & Research Workloads**

- **GPU Workload Nodes** → Dedicated **A4000 & 1660 Ti GPU nodes** for ML training.
- **High-speed storage integration** → NVMe-backed persistent volumes.
- **AI & Data Pipelines** → Automated ingestion and processing for radio astronomy data.

---

## **7. Summary & Next Steps**

The Kubernetes environment is the **core compute platform for research workloads**, enabling **automated processing, AI-driven analysis, and scalable infrastructure management**.

Future enhancements will include:

- **Refined AI/ML pipeline optimization for Hydrogen Line analysis.**
- **Expanded security policies using Kyverno and Open Policy Agent (OPA).**
- **Integration of additional research datasets into structured workflows.**

📌 **Refer to individual node and workload documentation for deeper implementation details.**
