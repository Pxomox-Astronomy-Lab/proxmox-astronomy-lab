<---
title: "proj-k8s02 - Enterprise RKE2 Kubernetes Cluster Node 2 VM"
type: "enterprise-vm-asset"
domain: "kubernetes-orchestration-platform"
tech: "ubuntu-2404-lts-rke2-kubernetes-cluster"
scale: "enterprise-kubernetes-orchestration-platform"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "RKE2 Kubernetes cluster node 2 of 3"
  compliance_framework: "CIS Controls v8 Level 2"
  orchestration_>

# ☸️ **proj-k8s02 - Enterprise RKE2 Kubernetes Cluster Node 2 VM**

**Asset Classification:** Kubernetes Orchestration Platform - Cluster Node 2 | **Service Tier:** Production | **Location:** node03 - Secondary Cluster Foundation Host

This knowledge base article provides comprehensive virtual machine specifications, RKE2 configuration, and operational procedures for proj-k8s02, an Ubuntu Server 24.04 LTS enterprise RKE2 Kubernetes virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the second node in a three-node RKE2 Kubernetes cluster for VLAN 20 project workloads supporting containerized applications, distributed computing, and enterprise orchestration across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-k8s02 serves as the second enterprise RKE2 Kubernetes cluster node providing container orchestration, distributed application hosting, and cloud-native workload management for VLAN 20 project workloads including AI/ML pipelines, research applications, and microservices supporting scalable computing environments and coordinated with proj-k8s01 and proj-k8s03 for high-availability Kubernetes cluster operations.

### **1.2 Service Classification**

**Production Tier:** Mission-critical Kubernetes orchestration platform optimized for RKE2 cluster operations, container workload management, distributed computing support, and enterprise application orchestration with CIS Controls v8 Level 2 baseline security implementation and Kubernetes optimization for research and AI/ML workloads.

### **1.3 Cluster Integration**

Kubernetes orchestration foundation enabling comprehensive container platform services, distributed application deployment, and enterprise cloud-native computing while maintaining enterprise-grade security standards and providing scalable orchestration services for research workloads and infrastructure coordination across VLAN 20 networks.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node03 (Intel i9-12900H) | Kubernetes cluster foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Kubernetes cluster connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance container storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Kubernetes Cluster** | proj-k8s01, proj-k8s03 (nodes 1 & 3) | Multi-node RKE2 cluster formation |
| **Container Registry** | Portainer and enterprise registries | Container image management |
| **Network Connectivity** | labswitch02/labswitch03 dual-link | High-performance cluster networking |
| **Storage Infrastructure** | High-performance NVMe storage | Container and persistent volume storage |

### **2.3 RKE2 Kubernetes Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **RKE2 Distribution** | Latest enterprise Kubernetes distribution | Production workload optimization |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 1TB container and cluster storage | Research workload capacity |
| **Cluster Configuration** | Multi-node HA cluster setup | Enterprise reliability standards |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 3002 | Kubernetes cluster node 2 identifier |
| **Memory** | 32.00 GiB allocated / 82.00 GiB maximum | Optimized for container workloads |
| **Processors** | 16 vCPU (2 sockets, 8 cores each) | [host] CPU type with NUMA optimization |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-3002-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Container Storage** | scsi1: nvmethin01:vm-3002-disk-3, 1000GB | Dedicated Kubernetes cluster storage |
| **EFI System** | nvmethin01:vm-3002-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-3002-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:C3:03:AA | VirtIO network adapter |
| **Bridge Assignment** | vmbr0, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.5 (static) | Kubernetes cluster node 2 address |
| **Security Hardening** | Host-based firewall active | Cluster traffic filtering |

### **3.4 RKE2 Kubernetes Implementation**

| **Kubernetes Component** | **Implementation** | **Optimization** |
|--------------------------|-------------------|------------------|
| **RKE2 Distribution** | Latest enterprise Kubernetes | Research workload optimization |
| **Cluster Role** | Secondary cluster node (node 2 of 3) | High-availability orchestration |
| **Container Runtime** | containerd with security optimization | Enterprise container execution |
| **Network Plugin** | Calico or Flannel for cluster networking | High-performance pod networking |

---

## **🔧 4. Management & Operations**

### **4.1 Kubernetes Cluster Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **Container Orchestration** | Kubernetes workload scheduling and management | Research application deployment |
| **Cluster Coordination** | Multi-node cluster coordination with k8s01/k8s03 | High-availability operations |
| **Storage Management** | Persistent volume and container storage | Application data persistence |
| **Network Services** | Pod networking and service discovery | Application connectivity |

### **4.2 RKE2 Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **RKE2 Engine** | Production Kubernetes cluster | Container orchestration services |
| **Cluster Storage** | 1TB container storage | Research workload capacity |
| **Node Management** | Cluster node 2 operations | Multi-node coordination |
| **Security Implementation** | Enterprise Kubernetes security | CIS L2 cluster hardening |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Cluster Health Monitoring** | Continuous | Kubernetes cluster performance optimization |
| **Node Status Validation** | Daily | Cluster node service validation |
| **Security Updates** | Weekly | RKE2 and system updates |
| **Backup Verification** | Daily | Cluster configuration backup validation |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Kubernetes Performance** | RKE2 metrics + system monitoring | Cluster performance optimization |
| **Container Workloads** | Pod and service monitoring | Application performance validation |
| **Storage Utilization** | Disk space and I/O monitoring | Container storage optimization |
| **Security Events** | Kubernetes audit logging | Cluster security monitoring |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Kubernetes Security** | RKE2 security hardening and RBAC implementation | ✅ CIS L2 orchestration security |
| **Container Security** | Container runtime protection and image scanning | ✅ CIS L2 container protection |
| **Access Controls** | SSH hardening + Kubernetes authentication | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + pod network policies | ✅ Layered security controls |
| **Audit & Logging** | Kubernetes audit logging and monitoring | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Kubernetes cluster access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Container data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Kubernetes security monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Cluster incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Kubernetes Cluster Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with Kubernetes-aware backup procedures ensuring cluster configuration consistency, container data integrity, and rapid recovery supporting critical orchestration platform protection and service continuity requirements.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 01:15 | 30 days | pbs01 comprehensive backup |
| **Kubernetes Configuration** | Continuous etcd backup | 90 days | Cluster state protection |
| **Container Persistent Volumes** | Daily incremental | 60 days | Application data protection |
| **Cluster Certificates** | Daily backup | 30 days | Cluster security configuration backup |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + cluster rejoin |
| **Kubernetes Cluster Recovery** | <30 minutes | <15 minutes | RKE2 cluster restoration |
| **Container Workload Recovery** | <20 minutes | <4 hours | Pod and service restoration |
| **Cluster Configuration Recovery** | <15 minutes | <8 hours | RKE2 configuration restoration |

---

## **📚 7. References & Documentation**

### **7.1 Kubernetes Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **RKE2 Documentation** | Kubernetes cluster administration | [RKE2 Guides](https://docs.rke2.io/) |
| **Kubernetes Best Practices** | Container orchestration optimization | [Kubernetes Documentation](https://kubernetes.io/docs/) |
| **CIS Controls v8 Level 2** | Kubernetes security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node03](../hardware/node03-minisforum-ms-a1-12900h.md)** | Physical host platform | Kubernetes cluster foundation |
| **[proj-k8s01, proj-k8s03](../infrastructure/k8s-rke2/)** | Cluster nodes 1 & 3 | Multi-node Kubernetes cluster |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Cluster protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Kubernetes Cluster Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **RKE2 Performance** | Kubernetes cluster benchmark testing | Optimized container workload performance |
| **Multi-Node Coordination** | Cluster communication testing | Successful inter-node coordination |
| **Container Deployment** | Pod scheduling and execution validation | Successful application deployment |
| **Backup Integrity** | Recovery testing procedures | Successful cluster restoration |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Kubernetes Security** | RKE2 security audit | Secure cluster configuration |
| **Access Control** | RBAC testing | Restricted cluster access |
| **Container Protection** | Runtime security validation | Protected container execution |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-k8s02 represents a comprehensive enterprise RKE2 Kubernetes cluster node implementing high-performance container orchestration with CIS Controls v8 Level 2 security standards, providing the second node foundation for a three-node Kubernetes cluster supporting VLAN 20 project workloads with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Container Orchestration** | RKE2 Kubernetes cluster node 2 | Advanced container platform services |
| **Multi-Node Clustering** | High-availability cluster coordination | Enterprise reliability and scalability |
| **Research Workload Support** | AI/ML and scientific computing optimization | Specialized research application hosting |
| **Enterprise Security** | CIS L2 baseline with Kubernetes hardening | Secure orchestration platform operation |

### **9.3 Operational Impact**

This virtual machine serves as the critical secondary Kubernetes orchestration node enabling comprehensive container platform services, distributed application deployment, and enterprise cloud-native computing across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential orchestration services for research workloads and infrastructure coordination.

### **9.4 Future Considerations**

Planned enhancements include expanded Kubernetes cluster capabilities, enhanced performance monitoring, and advanced orchestration features supporting the evolution toward comprehensive container platform services and enterprise-grade cloud-native computing supporting the growing containerization requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all RKE2 configurations, Kubernetes cluster procedures, and container orchestration integration  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
