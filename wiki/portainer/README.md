# 🐳 **Portainer**

This wiki section provides practical how-to guides for Portainer container management platform across the Proxmox Astronomy Lab infrastructure. The documentation covers essential Portainer administration procedures including Docker environment setup, Microsoft Entra ID OAuth integration, and role-based access control using Entra security groups for enterprise-grade container orchestration.

## **Overview**

Portainer represents the primary container management interface for the hybrid Kubernetes and Docker infrastructure, providing web-based administration for both standalone Docker hosts and RKE2 Kubernetes clusters. The Proxmox Astronomy Lab implements Portainer with enterprise authentication using Microsoft Entra ID (formerly Azure AD) for single sign-on and role-based access control through security groups. This configuration enables secure, scalable container management with proper separation of duties and enterprise compliance for astronomical research workloads and infrastructure services.

This wiki provides hands-on procedures for container administrators, infrastructure teams, and security administrators implementing Portainer management interfaces. Each guide covers tested procedures specific to the lab's hybrid architecture with considerations for enterprise security, OAuth integration, and RBAC implementation supporting both Docker and Kubernetes workloads.

---

## **📂 Directory Contents**

This section provides navigation to all Portainer administration guides and procedures.

### **📋 Core Portainer Administration**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[setup-docker-environment-gui.md](setup-docker-environment-gui.md)** | How to setup a Docker node/environment via the Portainer GUI | Docker host management and container deployment |
| **[entra-id-oauth-integration.md](entra-id-oauth-integration.md)** | How to setup Microsoft Entra ID OAuth authentication | Enterprise SSO and identity integration |
| **[entra-security-groups-rbac.md](entra-security-groups-rbac.md)** | How to use Entra security groups for role-based access control | Enterprise RBAC and access management |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[portainer-troubleshooting-guide.md](portainer-troubleshooting-guide.md)** | Common Portainer issues and resolution procedures | Container administrators |
| **[backup-restore-procedures.md](backup-restore-procedures.md)** | Portainer configuration backup and restore procedures | Infrastructure engineers |

---

## **🏗️ Repository Structure**

```
wiki/portainer/
├── README.md                                    # This overview document
├── setup-docker-environment-gui.md             # Docker environment setup via GUI
├── entra-id-oauth-integration.md               # Microsoft Entra ID OAuth setup
├── entra-security-groups-rbac.md               # Entra security groups RBAC configuration
├── portainer-troubleshooting-guide.md          # Portainer troubleshooting procedures
└── backup-restore-procedures.md                # Configuration backup and restore
```

---

## **🔧 Lab Portainer Configuration**

The Portainer deployment supports enterprise-grade container management across the hybrid infrastructure:

### **Environment Management**

| **Environment Type** | **Purpose** | **Integration** |
|---------------------|-------------|-----------------|
| **Docker Standalone** | Single-host container management | Direct Docker API integration |
| **RKE2 Kubernetes** | Kubernetes cluster management | RKE2 cluster integration with kubectl proxy |
| **Docker Swarm** | Orchestrated container services | Swarm mode cluster management |

### **Authentication and Authorization**

| **Component** | **Implementation** | **Purpose** |
|---------------|-------------------|-------------|
| **Entra ID OAuth** | Microsoft identity provider integration | Enterprise SSO authentication |
| **Security Groups** | Entra ID group-based RBAC | Role-based access control |
| **Team Management** | Portainer native teams with Entra mapping | Resource access separation |
| **User Permissions** | Granular resource-level permissions | Fine-grained access control |

### **Security Integration**

| **Feature** | **Configuration** | **Benefit** |
|-------------|------------------|-------------|
| **SSL/TLS** | Certificate-based encryption | Secure communication |
| **Audit Logging** | Comprehensive action logging | Security monitoring and compliance |
| **Session Management** | Token-based authentication | Secure session handling |
| **MFA Support** | Entra ID conditional access | Multi-factor authentication |

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **Portainer Integration** |
|--------------|------------------|-------------------------|
| **[docker/](../docker/README.md)** | Docker host management | Portainer Docker environment administration |
| **[k8s/](../k8s/README.md)** | Kubernetes cluster management | RKE2 cluster integration via Portainer |
| **[gitops-portainer/](../gitops-portainer/README.md)** | GitOps deployment workflows | Automated deployment via Portainer Stacks |

### **Platform Integration**

| **Category** | **Relationship** | **Portainer Integration** |
|--------------|------------------|-------------------------|
| **[security/](../../security/README.md)** | Enterprise authentication | Entra ID integration and RBAC implementation |
| **[observability/](../observability/README.md)** | Container monitoring | Portainer metrics and logging integration |
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Container automation | Automated container deployment and management |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within Portainer administration.

### **For Container Administrators**

**Start Here:** [setup-docker-environment-gui.md](setup-docker-environment-gui.md)  
**Enterprise Auth:** [entra-id-oauth-integration.md](entra-id-oauth-integration.md)  
**Access Control:** [entra-security-groups-rbac.md](entra-security-groups-rbac.md)  
**Troubleshooting:** [portainer-troubleshooting-guide.md](portainer-troubleshooting-guide.md)

### **For Infrastructure Engineers**

**Start Here:** [entra-id-oauth-integration.md](entra-id-oauth-integration.md)  
**Environment Setup:** [setup-docker-environment-gui.md](setup-docker-environment-gui.md)  
**RBAC Configuration:** [entra-security-groups-rbac.md](entra-security-groups-rbac.md)  
**Backup Procedures:** [backup-restore-procedures.md](backup-restore-procedures.md)

### **For Security Administrators**

**Start Here:** [entra-security-groups-rbac.md](entra-security-groups-rbac.md)  
**OAuth Setup:** [entra-id-oauth-integration.md](entra-id-oauth-integration.md)  
**Security Validation:** [portainer-troubleshooting-guide.md](portainer-troubleshooting-guide.md)  
**Configuration Security:** [backup-restore-procedures.md](backup-restore-procedures.md)

### **For Platform Administrators**

**Start Here:** [setup-docker-environment-gui.md](setup-docker-environment-gui.md)  
**Identity Integration:** [entra-id-oauth-integration.md](entra-id-oauth-integration.md)  
**Role Management:** [entra-security-groups-rbac.md](entra-security-groups-rbac.md)  
**Issue Resolution:** [portainer-troubleshooting-guide.md](portainer-troubleshooting-guide.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: portainer, docker-management, kubernetes-management, entra-id, oauth, rbac, container-orchestration
