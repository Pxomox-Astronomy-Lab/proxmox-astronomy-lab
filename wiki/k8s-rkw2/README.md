# ☸️ **Kubernetes RKE2**

This wiki section provides practical how-to guides for managing RKE2 Kubernetes clusters across the Proxmox Astronomy Lab infrastructure. The documentation covers essential cluster management procedures including GUI client setup, Rancher UI configuration, and essential kubectl command line operations for day-to-day cluster administration.

## **Overview**

RKE2 (Rancher Kubernetes Engine 2) represents the enterprise-grade Kubernetes distribution powering containerized workloads across the 7-node Proxmox Astronomy Lab cluster. RKE2 provides government-grade security compliance, simplified cluster management, and seamless integration with the hybrid VM architecture. The cluster management approach combines GUI tools like Lens and Headlamp for visual cluster exploration, Rancher UI for comprehensive cluster management, and kubectl command-line operations for automation and scripting workflows.

This wiki provides hands-on procedures for cluster administrators, DevOps engineers, and infrastructure teams managing RKE2 deployments. Each guide covers tested procedures specific to the lab's RKE2 configuration with considerations for enterprise security, multi-node operations, and integration with astronomical research workloads.

---

## **📂 Directory Contents**

This section provides navigation to all RKE2 management how-to guides and procedures.

### **📋 Core RKE2 Management**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[managing-rke2-lens-headlamp.md](managing-rke2-lens-headlamp.md)** | How to manage RKE2 clusters using Lens or Headlamp GUI clients | Visual cluster management and exploration |
| **[enabling-rancher-ui.md](enabling-rancher-ui.md)** | How to enable and configure Rancher management UI for RKE2 | Web-based cluster administration |
| **[kubectl-commands-and-flags.md](kubectl-commands-and-flags.md)** | Essential kubectl commands and flags for RKE2 cluster management | Command-line cluster operations |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[rke2-troubleshooting-guide.md](rke2-troubleshooting-guide.md)** | Common RKE2 cluster issues and resolution steps | Cluster administrators |

---

## **🏗️ Repository Structure**

```markdown
wiki/k8s-rke2/
├── README.md                                    # This overview document
├── managing-rke2-lens-headlamp.md             # GUI client management (Lens/Headlamp)
├── enabling-rancher-ui.md                      # Rancher UI setup and configuration
├── kubectl-commands-and-flags.md               # Essential kubectl operations
├── rke2-troubleshooting-guide.md              # RKE2 cluster troubleshooting
```

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **RKE2 Integration** |
|--------------|------------------|---------------------|
| **[k8s/](../k8s/README.md)** | General Kubernetes operations | RKE2-specific cluster management procedures |
| **[portainer/](../portainer/README.md)** | Container orchestration UI | Portainer RKE2 cluster management |
| **[gitops-portainer/](../gitops-portainer/README.md)** | GitOps workflows | RKE2 automated deployment via GitOps |

### **Platform Integration**

| **Category** | **Relationship** | **RKE2 Integration** |
|--------------|------------------|---------------------|
| **[observability/](../observability/README.md)** | Cluster monitoring | RKE2 metrics collection and visualization |
| **[security/](../../security/README.md)** | Cluster security | RKE2 security hardening and compliance |
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Cluster automation | Ansible RKE2 configuration management |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within RKE2 management.

### **For Cluster Administrators**

**Start Here:** [kubectl-commands-and-flags.md](kubectl-commands-and-flags.md)  
**GUI Management:** [managing-rke2-lens-headlamp.md](managing-rke2-lens-headlamp.md)  
**Web UI Setup:** [enabling-rancher-ui.md](enabling-rancher-ui.md)  
**Troubleshooting:** [rke2-troubleshooting-guide.md](rke2-troubleshooting-guide.md)

### **For Infrastructure Engineers**

**Start Here:** [enabling-rancher-ui.md](enabling-rancher-ui.md)  
**Security Hardening:** [cluster-security-hardening.md](cluster-security-hardening.md)  
**Command Line:** [kubectl-commands-and-flags.md](kubectl-commands-and-flags.md)  
**Issue Resolution:** [rke2-troubleshooting-guide.md](rke2-troubleshooting-guide.md)

### **For DevOps Engineers**

**Start Here:** [kubectl-commands-and-flags.md](kubectl-commands-and-flags.md)  
**Visual Tools:** [managing-rke2-lens-headlamp.md](managing-rke2-lens-headlamp.md)  
**Management UI:** [enabling-rancher-ui.md](enabling-rancher-ui.md)  
**Troubleshooting:** [rke2-troubleshooting-guide.md](rke2-troubleshooting-guide.md)

### **For Security Administrators**

**Start Here:** [cluster-security-hardening.md](cluster-security-hardening.md)  
**Management Access:** [enabling-rancher-ui.md](enabling-rancher-ui.md)  
**Command Line Security:** [kubectl-commands-and-flags.md](kubectl-commands-and-flags.md)  
**Security Issues:** [rke2-troubleshooting-guide.md](rke2-troubleshooting-guide.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: rke2, kubernetes, lens, headlamp, rancher-ui, kubectl, cluster-management
