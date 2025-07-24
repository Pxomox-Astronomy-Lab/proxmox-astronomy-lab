<---
title: "mgmt-docker01 - Enterprise Infrastructure Microservices VM"
type: "enterprise-vm-asset"
domain: "infrastructure-microservices-management"
tech: "ubuntu-2404-lts-docker-portainer"
scale: "enterprise-microservices-infrastructure"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Infrastructure microservices platform"
  compliance_framework: "CIS Controls v8 Level 2"
  orchestration: "Portainer-managed infrastructure services"
--->

# 🐳 **mgmt-docker01 - Enterprise Infrastructure Microservices VM**

**Asset Classification:** Infrastructure Microservices Platform | **Service Tier:** Production | **Location:** node02 - Storage Host

This knowledge base article provides comprehensive virtual machine specifications, container orchestration configuration, and operational procedures for mgmt-docker01, an Ubuntu Server 24.04 LTS enterprise infrastructure microservices virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary Portainer-managed microservices platform for control plane infrastructure services across the 7-node Proxmox astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

mgmt-docker01 serves as the enterprise infrastructure microservices platform providing containerized control plane services including PostgreSQL database services, Gitea source control management, and specialized VLAN 10 infrastructure microservices, all orchestrated through Portainer management and controlled by proj-port01 for centralized container lifecycle management.

### **1.2 Service Classification**

**Production Tier:** Mission-critical infrastructure microservices platform optimized for containerized control plane services, source control management, database services, and specialized infrastructure microservices supporting enterprise cluster management with CIS Controls v8 Level 2 baseline security implementation and Portainer orchestration.

### **1.3 Cluster Integration**

Central infrastructure microservices hub enabling containerized control plane services, source control coordination, and specialized infrastructure services supporting cluster management operations while maintaining enterprise-grade security standards and seamless integration with proj-port01 Portainer management coordination.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node02 (Intel i5-12600H) | Physical storage/compute foundation |
| **Network Infrastructure** | VLAN 10 (Infrastructure services) | Control plane network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance container storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Container Orchestration** | proj-port01 Portainer management | Centralized container control |
| **Network Connectivity** | labswitch02 management layer | Infrastructure VLAN access |
| **DNS Resolution** | Cluster DNS infrastructure | Service discovery |
| **Time Synchronization** | chronyd NTP service | Container time coordination |

### **2.3 Microservices Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Docker Engine** | Container runtime platform | Containerization foundation |
| **Portainer Agent** | proj-port01 management integration | Centralized orchestration |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 132GB total container storage | Service data persistence |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 1005 | Infrastructure microservices identifier |
| **Memory** | 8.00 GiB allocated / 24.00 GiB maximum | Optimized for containerized workloads |
| **Processors** | 6 vCPU (2 sockets, 3 cores each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-1005-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Container Storage** | scsi1: nvmethin01:vm-1005-disk-3, 100GB | Dedicated container and data storage |
| **EFI System** | nvmethin01:vm-1005-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-1005-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:D5:B3:60 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=10 | Infrastructure services VLAN |
| **IP Configuration** | 10.25.10.9 (static) | Microservices management address |
| **Security Hardening** | Host-based firewall active | Container traffic filtering |

### **3.4 Container Platform Implementation**

| **Container Component** | **Implementation** | **Management** |
|------------------------|-------------------|----------------|
| **Docker Engine** | Container runtime platform | Local container execution |
| **Portainer Agent** | proj-port01 integration | Centralized orchestration |
| **Infrastructure Services** | VLAN 10 microservices | Control plane containerization |
| **Service Discovery** | Container networking | Inter-service communication |

---

## **🔧 4. Management & Operations**

### **4.1 Infrastructure Microservices**

| **Service** | **Function** | **Orchestration** |
|-------------|--------------|------------------|
| **PostgreSQL Database** | Control plane data services | Portainer-managed container |
| **Gitea Source Control** | Infrastructure code management | Version control for cluster config |
| **VLAN 10 Services** | Specialized infrastructure services | Control plane microservices |
| **Service Coordination** | Inter-service communication | Container networking fabric |

### **4.2 Container Management Services**

| **Management Component** | **Status** | **Coverage** |
|--------------------------|------------|--------------|
| **Docker Engine** | Active container runtime | Local containerization |
| **Portainer Agent** | proj-port01 coordination | Centralized management |
| **Container Networking** | VLAN 10 service mesh | Inter-service connectivity |
| **Persistent Storage** | 100GB container data | Service data persistence |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Container Health Monitoring** | Continuous | Docker and Portainer status |
| **Service Updates** | As needed | Portainer-coordinated deployments |
| **Security Scanning** | Weekly | Container image vulnerability assessment |
| **Performance Optimization** | Monthly | Resource utilization analysis |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Container Health** | Docker stats, Portainer dashboard | Service availability |
| **System Performance** | Host metrics collection | Resource utilization |
| **Security Events** | Host security auditing | Container security monitoring |
| **Service Coordination** | proj-port01 centralized monitoring | Cluster-wide visibility |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Container Security** | Docker security hardening | ✅ CIS L2 container baseline |
| **Access Controls** | SSH AllowUsers, container isolation | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + container networking | ✅ Layered security controls |
| **File Integrity** | AIDE monitoring with container awareness | ✅ Comprehensive monitoring |
| **Audit & Logging** | Host + container logging integration | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Container access controls | **2025-07-20** |
| **CIS.4.1** | **Compliant** | Host and container updates | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network security controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Container data protection | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Microservices Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with container-aware backup procedures ensuring microservices data persistence, configuration preservation, and rapid recovery supporting critical infrastructure control plane services and containerized applications.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 02:30 | 30 days | pbs01 comprehensive backup |
| **Container Volumes** | Real-time persistence | Continuous | Docker volume management |
| **PostgreSQL Data** | Database-consistent backup | Automated | Container-aware backup |
| **Gitea Repository** | Source control data protection | Continuous | Git repository persistence |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <45 minutes | <24 hours | pbs01 full restoration + container restart |
| **Container Service Recovery** | <15 minutes | <1 hour | Portainer service restoration |
| **Database Recovery** | <30 minutes | <8 hours | PostgreSQL container restoration |
| **Source Control Recovery** | <20 minutes | <24 hours | Gitea repository restoration |

---

## **📚 7. References & Documentation**

### **7.1 Container Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **CIS Docker Benchmark** | Container security baseline | [CIS Docker Guidelines](https://www.cisecurity.org/) |
| **Docker Security Best Practices** | Container hardening | [Docker Security](https://docs.docker.com/engine/security/) |
| **Portainer Documentation** | Container orchestration | [Portainer Guides](https://documentation.portainer.io/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node02](../hardware/node02-12600h-storage-node.md)** | Physical host platform | Storage foundation |
| **[proj-port01](../infrastructure/orchestration/proj-port01.md)** | Portainer management controller | Container orchestration |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Container Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Docker Engine Health** | Container runtime testing | All containers operational |
| **Portainer Integration** | proj-port01 connectivity | Centralized management active |
| **Service Connectivity** | VLAN 10 service testing | Inter-service communication |
| **PostgreSQL Service** | Database connectivity testing | Control plane data access |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Container Security** | Docker security audit | Container isolation verification |
| **Network Security** | Container network testing | Proper traffic segmentation |
| **Access Control** | Authentication testing | Restricted container access |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

mgmt-docker01 represents a comprehensive enterprise infrastructure microservices platform implementing CIS Controls v8 Level 2 security standards with containerized control plane services orchestrated through Portainer management, providing PostgreSQL database services, Gitea source control, and specialized VLAN 10 infrastructure microservices supporting centralized cluster management with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Infrastructure Microservices** | Containerized control plane services | Scalable infrastructure management |
| **Source Control Management** | Gitea integration | Infrastructure as Code support |
| **Database Services** | PostgreSQL containers | Control plane data persistence |
| **Portainer Integration** | proj-port01 orchestration | Centralized container management |

### **9.3 Operational Impact**

This virtual machine serves as the critical infrastructure microservices foundation enabling containerized control plane services, centralized source control management, and specialized infrastructure applications supporting the enterprise astronomy research platform while maintaining enterprise security standards and providing essential microservices coordination through Portainer management integration.

### **9.4 Future Considerations**

Planned enhancements include expanded microservices deployment, enhanced container security monitoring, and advanced service mesh implementation supporting the evolution toward comprehensive containerized infrastructure management and enterprise-grade microservices operations supporting the growing infrastructure service requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all container configurations, Portainer integration, and microservices architecture  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
