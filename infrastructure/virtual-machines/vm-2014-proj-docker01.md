<---
title: "proj-docker01 - Enterprise Portainer Worker Node Platform VM"
type: "enterprise-vm-asset"
domain: "docker-container-orchestration-platform"
tech: "ubuntu-2404-lts-docker-portainer-worker-node"
scale: "enterprise-container-platform"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Docker container orchestration worker"
  compliance_framework: "CIS Controls v8 Level 2"
  orchestration_type: "Portainer worker node for VLAN 20 project workloads"
--->

# 🐳 **proj-docker01 - Enterprise Portainer Worker Node Platform VM**

**Asset Classification:** Docker Container Orchestration Worker | **Service Tier:** Production | **Location:** node06 - Container Orchestration Host

This knowledge base article provides comprehensive virtual machine specifications, Docker configuration, and operational procedures for proj-docker01, an Ubuntu Server 24.04 LTS enterprise Docker container orchestration virtual machine baselined to CIS Controls v8 Level 2 standards, serving as a dedicated Portainer worker node for VLAN 20 project workloads supporting distributed container management and enterprise application deployment across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-docker01 serves as the enterprise Portainer worker node providing Docker container orchestration services for VLAN 20 project workloads including distributed application deployment, container management, and enterprise application hosting supporting scalable containerized workloads and coordinated with mgmt-docker01 for comprehensive container platform services.

### **1.2 Service Classification**

**Production Tier:** Mission-critical Docker container orchestration platform optimized for Portainer worker node operations, enterprise application container management, project workload deployment, and distributed container services with CIS Controls v8 Level 2 baseline security implementation and Docker optimization for enterprise container workloads.

### **1.3 Cluster Integration**

Container orchestration foundation enabling comprehensive project workload containerization, distributed application deployment, and enterprise container management while maintaining enterprise-grade security standards and providing scalable container services for project applications and infrastructure service coordination across VLAN 20 networks.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node06 (Intel i9-13900H) | Container orchestration foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Container service connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | Container storage infrastructure |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Portainer Management** | mgmt-docker01 (VLAN 10) | Centralized container orchestration |
| **Network Connectivity** | labswitch02/labswitch03 dual-link | High-performance container networking |
| **Storage Infrastructure** | High-performance NVMe storage | Container image and volume storage |
| **Backup Services** | pbs01 enterprise backup | Container platform protection |

### **2.3 Container Platform Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Docker Engine** | Latest enterprise Docker version | Container runtime optimization |
| **Portainer Agent** | Worker node agent deployment | Centralized management integration |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 100GB container storage | Project workload capacity |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2014 | Docker worker node identifier |
| **Memory** | 8.00 GiB allocated / 32.00 GiB maximum | Optimized for container workloads |
| **Processors** | 6 vCPU (2 sockets, 3 cores each) | [host] CPU type with NUMA optimization |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2014-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Container Storage** | scsi1: nvmethin01:vm-2014-disk-3, 100GB | Dedicated Docker container storage |
| **EFI System** | nvmethin01:vm-2014-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2014-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:4D:6C:8B | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.14 (static) | Container worker node address |
| **Security Hardening** | Host-based firewall active | Container traffic filtering |

### **3.4 Docker Container Platform Implementation**

| **Container Component** | **Implementation** | **Optimization** |
|-----------------------|-------------------|------------------|
| **Docker Engine** | Latest enterprise container runtime | Project workload optimization |
| **Portainer Agent** | Worker node management agent | Centralized orchestration integration |
| **Container Networking** | Docker bridge and overlay networks | Project application connectivity |
| **Storage Management** | Docker volume and bind mount optimization | Container data persistence |

---

## **🔧 4. Management & Operations**

### **4.1 Container Orchestration Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **Portainer Worker** | Container deployment and management | Project workload orchestration |
| **Docker Engine** | Container runtime services | Application container execution |
| **Container Networking** | Project application connectivity | Distributed container communication |
| **Volume Management** | Persistent container data storage | Application data persistence |

### **4.2 Project Workload Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **Container Runtime** | Production Docker engine | Project application hosting |
| **Orchestration Agent** | Portainer worker node | Centralized management integration |
| **Storage Services** | 100GB container storage | Project workload capacity |
| **Security Implementation** | Enterprise container security | CIS L2 container hardening |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Container Health Monitoring** | Continuous | Container performance optimization |
| **Portainer Agent Status** | Daily | Management agent validation |
| **Security Updates** | Weekly | Docker and system updates |
| **Backup Verification** | Daily | Container platform backup validation |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Container Performance** | Docker metrics + system monitoring | Container resource utilization |
| **Portainer Connectivity** | Management plane monitoring | Orchestration agent status |
| **Storage Utilization** | Disk space and I/O monitoring | Container storage optimization |
| **Security Events** | Container audit logging | Runtime security monitoring |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Container Security** | Docker security hardening and runtime protection | ✅ CIS L2 container security |
| **Orchestration Security** | Portainer agent security and encrypted communication | ✅ CIS L2 orchestration protection |
| **Access Controls** | SSH hardening + container access management | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + VLAN segmentation | ✅ Layered security controls |
| **Audit & Logging** | Container runtime monitoring | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Container access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Container data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Container security monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Container incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Container Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with container-aware backup procedures ensuring Docker container data consistency, Portainer configuration integrity, and rapid recovery supporting critical container platform protection and service continuity requirements.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 02:30 | 30 days | pbs01 comprehensive backup |
| **Docker Containers** | Container-aware snapshot | 14 days | Application-consistent backup |
| **Portainer Configuration** | Daily incremental | 60 days | Management configuration protection |
| **Container Volumes** | Daily backup | 30 days | Persistent data protection |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + container validation |
| **Container Service Recovery** | <20 minutes | <4 hours | Docker service restoration |
| **Portainer Agent Recovery** | <15 minutes | <8 hours | Management agent reconfiguration |
| **Container Volume Recovery** | <30 minutes | <24 hours | Persistent data restoration |

---

## **📚 7. References & Documentation**

### **7.1 Container Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Docker Documentation** | Container runtime administration | [Docker Guides](https://docs.docker.com/) |
| **Portainer Documentation** | Container orchestration management | [Portainer Docs](https://docs.portainer.io/) |
| **CIS Controls v8 Level 2** | Container security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node06](../hardware/node06-minisforum-ms-a1-13900h.md)** | Physical host platform | Container orchestration foundation |
| **[mgmt-docker01](../infrastructure/docker/mgmt-docker01.md)** | Portainer management node | Centralized orchestration |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Container platform protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Container Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Docker Performance** | Container benchmark testing | Optimized project workload performance |
| **Portainer Integration** | Management agent connectivity testing | Successful centralized orchestration |
| **Container Networking** | Network connectivity validation | Successful project application communication |
| **Backup Integrity** | Recovery testing procedures | Successful container platform restoration |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Container Security** | Docker security audit | Secure container configuration |
| **Access Control** | Authentication testing | Restricted container access |
| **Runtime Protection** | Container security validation | Protected container execution |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-docker01 represents a comprehensive enterprise Docker container orchestration platform implementing Portainer worker node services with CIS Controls v8 Level 2 security standards, providing container deployment and management for VLAN 20 project workloads supporting distributed application architectures with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Container Orchestration** | Portainer worker node for project workloads | Scalable application deployment |
| **Docker Platform** | Enterprise container runtime | Robust application hosting |
| **Project Workload Support** | VLAN 20 container services | Comprehensive project application support |
| **Enterprise Security** | CIS L2 baseline with container hardening | Secure container platform operation |

### **9.3 Operational Impact**

This virtual machine serves as the critical container orchestration foundation enabling comprehensive project workload containerization, distributed application deployment, and enterprise container management across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential container services for project applications and infrastructure service coordination.

### **9.4 Future Considerations**

Planned enhancements include expanded container orchestration capabilities, enhanced performance monitoring, and advanced container management features supporting the evolution toward comprehensive container platform services and enterprise-grade application deployment supporting the growing containerization requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all Docker configurations, container orchestration procedures, and Portainer integration  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
