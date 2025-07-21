# 🐳 **Docker**

This wiki section provides practical how-to guides for Docker container management across the Proxmox Astronomy Lab infrastructure. The documentation covers essential Docker administration procedures including volume management, service configuration, and user access control for containerized workloads supporting astronomical research and infrastructure services.

## **Overview**

Docker container management represents a critical component of the hybrid infrastructure, providing lightweight containerization for development environments, monitoring services, and specialized applications. The Proxmox Astronomy Lab implements Docker alongside Kubernetes to provide flexible container deployment options including standalone services, development environments, and infrastructure tools. These procedures cover practical Docker administration tasks including volume management for persistent storage, service migration to dedicated volumes, and user permission configuration for secure container access.

This wiki provides hands-on procedures for system administrators, infrastructure engineers, and developers working with Docker containers in the lab environment. Each guide covers tested procedures specific to Ubuntu 24.04 deployments with considerations for enterprise security and operational efficiency.

---

## **📂 Directory Contents**

This section provides navigation to all Docker administration how-to guides and procedures.

### **📋 Core Docker Administration**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[add-a-docker-volume-to-linux-ubuntu2404.md](add-a-docker-volume-to-linux-ubuntu2404.md)** | How to add and configure Docker volumes on Ubuntu 24.04 | Persistent storage for containers |
| **[move-docker-service-to-dedicated-volume-linux-ubuntu2404.md](move-docker-service-to-dedicated-volume-linux-ubuntu2404.md)** | Moving Docker service data to dedicated storage volumes | Storage optimization and management |
| **[adding-user-to-docker-group.md](adding-user-to-docker-group.md)** | How to add your user to the docker group for passwordless access | User permission configuration |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[docker-troubleshooting-checklist.md](docker-troubleshooting-checklist.md)** | Common Docker issues and resolution steps | System administrators |
| **[container-security-basics.md](container-security-basics.md)** | Basic container security practices and validation | Security administrators |

---

## **🏗️ Repository Structure**

```markdown
wiki/docker/
├── README.md                                    # This overview document
├── add-a-docker-volume-to-linux-ubuntu2404.md  # Docker volume configuration
├── move-docker-service-to-dedicated-volume-linux-ubuntu2404.md  # Docker service migration
├── adding-user-to-docker-group.md              # Docker group user management
├── docker-troubleshooting-checklist.md         # Common Docker issues
└── container-security-basics.md                # Container security practices
```

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **Docker Integration** |
|--------------|------------------|----------------------|
| **[k8s/](../k8s/README.md)** | Container orchestration | Kubernetes and Docker hybrid deployment |
| **[portainer/](../portainer/README.md)** | Container management UI | Portainer Docker management interface |
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Container automation | Ansible Docker configuration management |

### **Platform Integration**

| **Category** | **Relationship** | **Docker Integration** |
|--------------|------------------|----------------------|
| **[observability/](../observability/README.md)** | Container monitoring | Docker container monitoring and logging |
| **[storage/](../storage/README.md)** | Volume management | Docker volume storage optimization |
| **[security/](../../security/README.md)** | Container security | Docker security hardening and access controls |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within Docker administration.

### **For System Administrators**

**Start Here:** [adding-user-to-docker-group.md](adding-user-to-docker-group.md)  
**Volume Management:** [add-a-docker-volume-to-linux-ubuntu2404.md](add-a-docker-volume-to-linux-ubuntu2404.md)  
**Service Migration:** [move-docker-service-to-dedicated-volume-linux-ubuntu2404.md](move-docker-service-to-dedicated-volume-linux-ubuntu2404.md)  
**Troubleshooting:** [docker-troubleshooting-checklist.md](docker-troubleshooting-checklist.md)

### **For Infrastructure Engineers**

**Start Here:** [move-docker-service-to-dedicated-volume-linux-ubuntu2404.md](move-docker-service-to-dedicated-volume-linux-ubuntu2404.md)  
**Storage Setup:** [add-a-docker-volume-to-linux-ubuntu2404.md](add-a-docker-volume-to-linux-ubuntu2404.md)  
**User Management:** [adding-user-to-docker-group.md](adding-user-to-docker-group.md)  
**Security Practices:** [container-security-basics.md](container-security-basics.md)

### **For Developers**

**Start Here:** [adding-user-to-docker-group.md](adding-user-to-docker-group.md)  
**Volume Configuration:** [add-a-docker-volume-to-linux-ubuntu2404.md](add-a-docker-volume-to-linux-ubuntu2404.md)  
**Issue Resolution:** [docker-troubleshooting-checklist.md](docker-troubleshooting-checklist.md)  
**Security Guidelines:** [container-security-basics.md](container-security-basics.md)

### **For Security Administrators**

**Start Here:** [container-security-basics.md](container-security-basics.md)  
**User Access Control:** [adding-user-to-docker-group.md](adding-user-to-docker-group.md)  
**Storage Security:** [add-a-docker-volume-to-linux-ubuntu2404.md](add-a-docker-volume-to-linux-ubuntu2404.md)  
**Security Validation:** [docker-troubleshooting-checklist.md](docker-troubleshooting-checklist.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: docker, container-management, ubuntu-2404, volume-management, user-permissions
