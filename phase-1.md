# **Proxmox Astronomy Lab - Phase 1: Core Infrastructure Foundation**

## **1. Overview**

Phase 1 established the **fundamental infrastructure** for the Proxmox Astronomy Lab. This phase was designed to ensure a **secure, high-performance, and modular environment**, balancing the **small-form-factor constraints of the hardware** while still supporting **scalability and structured research workflows**.

### **Key Goals:**

- Architect a **highly structured, production-ready lab environment** while accommodating the **limitations of small-form-factor hardware**.
- Implement **a strong security and compliance baseline** for all systems.
- Ensure **modular and scalable networking and compute resources**.
- Provide **observability, automation, and identity management** as core infrastructure services.

[📄 **Full Architectural Design: [Infrastructure Architecture](docs/infrastructure/architecture.md)**]

---

## **2. Compute & Network Architecture**

### **2.1 Proxmox Cluster Deployment**

The lab was designed around a **five-node Proxmox cluster**, ensuring:

- **High modularity** with structured VLAN segmentation.
- **Performance tuning** optimized for research workloads.
- **10G connectivity on Node04 & Node05**, with other nodes at 2.5G due to form factor constraints.

| **Node** | **CPU** | **RAM** | **Networking** | **Primary Role** |
|---------|--------|--------|--------------|----------------|
| **Node01** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Mgmt |
| **Node02** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Mgmt |
| **Node03** | Ryzen 5700U | 64GB | 2.5G | Proxmox, K8S Mgmt |
| **Node04** | Ryzen 5950X | 128GB | 10G | Proxmox, AI/ML workloads, GPU |
| **Node05** | Ryzen 3700X | 128GB | 10G | Storage & Backup |

### **2.2 Network Segmentation & Security**

- **VLAN-based segmentation** between research, infrastructure, and management networks.
- **Firewall & ACLs configured** for controlled access.
- **Azure Arc onboarded** all VMs for remote monitoring and assessment.

---

## **3. Identity & Access Management**

### **3.1 Windows Server 2025 Active Directory**

- **On-premises domain controllers (DC01/DC02)** deployed.
- **Hybrid Entra ID Join** enabled with:
  - Seamless SSO, Self-Service Password Reset (SSPR), Password Hash Sync.
- **Baseline Group Policy configurations**:
  - Security auditing, password policies, access control enforcement.

### **3.2 Secure Authentication & Compliance**

- **Linux AD integration** → All Linux VMs joined to on-prem AD.
- **SSH access via AD groups**, enforcing role-based access control.
- **CISv8 Level 2 compliance (Ubuntu), CISv9 Level 1 compliance (Windows)**.

---

## **4. Security, Compliance & Observability**

### **4.1 Hardened VM Baselines**

- **CIS-Hardened Templates Created:**
  - **Ubuntu 24.04 (CISv8 Level 2)** → Golden template.
  - **Windows Server 2025 (CISv9 Level 1)** → Golden template.
- **Security Baselines Applied to All VMs:**
  - **Linux: Lynis score 87**, mapped to **ISO27001/NIST controls**.
  - **Windows: CIS Benchmark applied, AD audit policies enforced**.
- **Daily Security Scanning & Monitoring:**
  - RKHunter, CHKRoot, Lynis, AuditD for Linux.
  - OSQuery & CIS-CAT scans for all VMs.

### **4.2 Monitoring & Security Stack**

- **Prometheus, AlertManager, Loki, InfluxDB (cluster metrics), and Grafana deployed.**
- **Wazuh SIEM onboarded, agents deployed across all VMs.**
- **SNMP monitoring for core networking hardware.**

---

## **5. Storage & Backup Architecture**

- **NVMe-backed S3 storage for Kubernetes & research data.**
- **NFS storage for archival workloads.**
- **Proxmox Backup Server implemented with structured retention:**
  - **7 daily, 1 weekly, 1 monthly backups per VM.**

---

## **6. Kubernetes & Research Compute**

### **6.1 RKE2 Kubernetes Cluster**

- **3 management nodes, 5 worker nodes.**
- **Helm, Traefik, CertManager deployed.**
- **GPU passthrough for AI/ML workloads enabled on Node04/05.**
- **Azure Container Registry integrated for private image hosting.**

### **6.2 Initial Research & Scientific Infrastructure**

- **Hydrogen Line feed calibration initiated.**
- **Preliminary SDR validation tests conducted.**

---

## **7. Next Steps: Transition to Phase 2**

With the foundational infrastructure completed, the lab progressed to **Phase 2**, focusing on:

- **Structured ITSM & Change Management (GLPI).**
- **Research infrastructure validation (Hydrogen Line detection).**
- **Formalized observability & automation workflows.**

[📄 **Next: [Phase 2 Documentation](PHASE-2.md)**]
