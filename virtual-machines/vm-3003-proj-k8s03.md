<---
title: "proj-k8s03 - Enterprise RKE2 Kubernetes Cluster Node 3 with GPU VM"
type: "enterprise-vm-asset"
domain: "kubernetes-gpu-orchestration-platform"
tech: "ubuntu-2404-lts-rke2-kubernetes-nvidia-gpu"
scale: "enterprise-kubernetes-gpu-orchestration-platform"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM with GPU Passthrough"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "RKE2 Kubernetes cluster node 3 of 3 with NVIDIA A4000 GPU"
  compliance_framework: "CIS Controls v8 Level 2"
  orchestration_type: "RKE2 Kubernetes cluster with GPU acceleration for AI/ML workloads"
--->

# ☸️🚀 **proj-k8s03 - Enterprise RKE2 Kubernetes Cluster Node 3 with GPU VM**

**Asset Classification:** Kubernetes GPU Orchestration Platform - Cluster Node 3 | **Service Tier:** Production | **Location:** node07 - GPU-Accelerated Cluster Foundation Host

This knowledge base article provides comprehensive virtual machine specifications, RKE2 configuration, and operational procedures for proj-k8s03, an Ubuntu Server 24.04 LTS enterprise RKE2 Kubernetes virtual machine with NVIDIA RTX A4000 GPU passthrough baselined to CIS Controls v8 Level 2 standards, serving as the third and final node in a three-node RKE2 Kubernetes cluster for VLAN 20 project workloads supporting GPU-accelerated containerized applications, AI/ML computing, and enterprise orchestration across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-k8s03 serves as the third enterprise RKE2 Kubernetes cluster node with GPU acceleration providing container orchestration, AI/ML workload acceleration, and cloud-native GPU computing for VLAN 20 project workloads including distributed ML training, inference pipelines, and GPU-accelerated research applications supporting scalable computing environments and coordinated with proj-k8s01 and proj-k8s02 for high-availability Kubernetes cluster operations with specialized GPU capabilities.

### **1.2 Service Classification**

**Production Tier:** Mission-critical GPU-accelerated Kubernetes orchestration platform optimized for RKE2 cluster operations, AI/ML workload acceleration, distributed GPU computing support, and enterprise application orchestration with CIS Controls v8 Level 2 baseline security implementation and Kubernetes optimization for GPU-accelerated research and AI/ML workloads.

### **1.3 Cluster Integration**

GPU-accelerated Kubernetes orchestration foundation enabling comprehensive container platform services, AI/ML workload acceleration, and enterprise cloud-native GPU computing while maintaining enterprise-grade security standards and providing specialized GPU orchestration services for research workloads and infrastructure coordination across VLAN 20 networks.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node07 (Intel i9-13900H) | GPU-accelerated Kubernetes cluster foundation |
| **GPU Hardware** | NVIDIA RTX A4000 16GB (PCI passthrough) | AI/ML workload acceleration |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Kubernetes cluster connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance container storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Kubernetes Cluster** | proj-k8s01, proj-k8s02 (nodes 1 & 2) | Multi-node RKE2 cluster formation |
| **GPU Drivers** | NVIDIA Container Toolkit | GPU container runtime support |
| **Container Registry** | Portainer and enterprise registries | Container image management |
| **Network Connectivity** | labswitch02/labswitch03 dual-link | High-performance cluster networking |

### **2.3 RKE2 Kubernetes with GPU Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **RKE2 Distribution** | Latest enterprise Kubernetes distribution | Production workload optimization |
| **NVIDIA Container Runtime** | GPU-accelerated container support | AI/ML workload acceleration |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 1TB container and cluster storage | Research workload capacity |
| **GPU Integration** | NVIDIA A4000 16GB passthrough | Enterprise GPU computing |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 3003 | Kubernetes GPU cluster node 3 identifier |
| **Memory** | 32.00 GiB allocated / 82.00 GiB maximum | Optimized for GPU-accelerated workloads |
| **Processors** | 16 vCPU (2 sockets, 8 cores each) | [host] CPU type with NUMA optimization |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |
| **GPU Passthrough** | NVIDIA RTX A4000 16GB (0000:08:00.0) | Direct GPU access for containers |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-3003-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Container Storage** | scsi1: nvmethin01:vm-3003-disk-3, 1000GB | Dedicated Kubernetes cluster storage |
| **EFI System** | nvmethin01:vm-3003-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-3003-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:96:E3:3B | VirtIO network adapter |
| **Bridge Assignment** | vmbr0, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.6 (static) | Kubernetes cluster node 3 address |
| **Security Hardening** | Host-based firewall active | Cluster traffic filtering |

### **3.4 RKE2 Kubernetes with GPU Implementation**

| **Kubernetes Component** | **Implementation** | **Optimization** |
|--------------------------|-------------------|------------------|
| **RKE2 Distribution** | Latest enterprise Kubernetes | GPU workload optimization |
| **Cluster Role** | GPU-accelerated cluster node (node 3 of 3) | High-availability orchestration with GPU |
| **Container Runtime** | containerd with NVIDIA Container Toolkit | GPU-accelerated container execution |
| **GPU Operator** | NVIDIA GPU Operator for Kubernetes | Automated GPU resource management |
| **Network Plugin** | Calico or Flannel for cluster networking | High-performance pod networking |

---

## **🔧 4. Management & Operations**

### **4.1 GPU-Accelerated Kubernetes Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **GPU Container Orchestration** | GPU-accelerated workload scheduling | AI/ML research application deployment |
| **Cluster Coordination** | Multi-node cluster coordination with k8s01/k8s02 | High-availability operations with GPU |
| **GPU Resource Management** | NVIDIA GPU allocation and scheduling | AI/ML workload resource optimization |
| **Storage Management** | Persistent volume and container storage | Application data persistence |

### **4.2 RKE2 GPU Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **RKE2 Engine** | Production Kubernetes cluster with GPU | GPU-accelerated orchestration services |
| **NVIDIA A4000 GPU** | 16GB GPU memory available to cluster | AI/ML workload acceleration |
| **Cluster Storage** | 1TB container storage | Research workload capacity |
| **GPU Operator** | Automated GPU resource management | Enterprise GPU computing |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **GPU Cluster Health Monitoring** | Continuous | GPU and cluster performance optimization |
| **GPU Resource Validation** | Daily | GPU availability and utilization monitoring |
| **Security Updates** | Weekly | RKE2, NVIDIA drivers, and system updates |
| **Backup Verification** | Daily | Cluster configuration backup validation |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **GPU Performance** | NVIDIA monitoring + Kubernetes metrics | GPU utilization and performance optimization |
| **Kubernetes Performance** | RKE2 metrics + system monitoring | Cluster performance optimization |
| **Container GPU Workloads** | Pod and GPU service monitoring | AI/ML application performance validation |
| **Storage Utilization** | Disk space and I/O monitoring | Container storage optimization |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Kubernetes Security** | RKE2 security hardening and RBAC implementation | ✅ CIS L2 orchestration security |
| **GPU Security** | NVIDIA container security and GPU isolation | ✅ CIS L2 GPU protection |
| **Container Security** | Container runtime protection and image scanning | ✅ CIS L2 container protection |
| **Access Controls** | SSH hardening + Kubernetes authentication | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + pod network policies | ✅ Layered security controls |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Kubernetes cluster access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Container and GPU data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Kubernetes security monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Cluster incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 GPU Kubernetes Cluster Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with Kubernetes-aware backup procedures ensuring cluster configuration consistency, container data integrity, and rapid recovery supporting critical GPU-accelerated orchestration platform protection and service continuity requirements.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 01:30 | 30 days | pbs01 comprehensive backup |
| **Kubernetes Configuration** | Continuous etcd backup | 90 days | Cluster state protection |
| **Container Persistent Volumes** | Daily incremental | 60 days | Application data protection |
| **GPU Configuration** | Daily backup | 30 days | NVIDIA driver and configuration backup |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + cluster rejoin |
| **GPU Kubernetes Recovery** | <30 minutes | <15 minutes | RKE2 cluster with GPU restoration |
| **GPU Driver Recovery** | <45 minutes | <8 hours | NVIDIA driver and toolkit restoration |
| **Container Workload Recovery** | <20 minutes | <4 hours | Pod and GPU service restoration |

---

## **📚 7. References & Documentation**

### **7.1 GPU Kubernetes Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **RKE2 Documentation** | Kubernetes cluster administration | [RKE2 Guides](https://docs.rke2.io/) |
| **NVIDIA Container Toolkit** | GPU container runtime | [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/) |
| **Kubernetes GPU Support** | GPU resource management | [Kubernetes GPU Documentation](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/) |
| **CIS Controls v8 Level 2** | Kubernetes security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node07](../hardware/node07-minisforum-ms-a1-13900h.md)** | Physical host platform | GPU-accelerated Kubernetes foundation |
| **[proj-k8s01, proj-k8s02](../infrastructure/k8s-rke2/)** | Cluster nodes 1 & 2 | Multi-node Kubernetes cluster |
| **[NVIDIA RTX A4000](../hardware/gpu/)** | GPU hardware | AI/ML acceleration hardware |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Cluster protection |

---

## **✅ 8. Validation & Testing**

### **8.1 GPU Kubernetes Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **GPU RKE2 Performance** | GPU-accelerated cluster benchmark testing | Optimized AI/ML workload performance |
| **Multi-Node GPU Coordination** | Cluster communication with GPU testing | Successful inter-node coordination |
| **GPU Container Deployment** | GPU pod scheduling and execution validation | Successful AI/ML application deployment |
| **GPU Resource Management** | NVIDIA GPU allocation testing | Efficient GPU resource utilization |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Kubernetes Security** | RKE2 security audit | Secure cluster configuration |
| **GPU Security** | NVIDIA container security validation | Secure GPU resource access |
| **Access Control** | RBAC testing | Restricted cluster and GPU access |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-k8s03 represents a comprehensive enterprise RKE2 Kubernetes cluster node with GPU acceleration implementing high-performance container orchestration and AI/ML workload acceleration with CIS Controls v8 Level 2 security standards, completing the three-node Kubernetes cluster supporting VLAN 20 project workloads with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **GPU Container Orchestration** | RKE2 Kubernetes cluster node 3 with NVIDIA A4000 | Advanced AI/ML container platform services |
| **Multi-Node GPU Clustering** | High-availability cluster with specialized GPU node | Enterprise reliability with AI/ML acceleration |
| **Research AI/ML Support** | GPU-accelerated scientific computing optimization | Specialized AI/ML research application hosting |
| **Enterprise Security** | CIS L2 baseline with Kubernetes and GPU hardening | Secure GPU orchestration platform operation |

### **9.3 Operational Impact**

This virtual machine completes the critical three-node Kubernetes orchestration platform enabling comprehensive GPU-accelerated container services, AI/ML workload acceleration, and enterprise cloud-native GPU computing across the enterprise astronomy research platform while maintaining enterprise security standards and providing specialized GPU orchestration services for research workloads and infrastructure coordination.

### **9.4 Future Considerations**

Planned enhancements include expanded GPU cluster capabilities, enhanced AI/ML performance monitoring, and advanced GPU orchestration features supporting the evolution toward comprehensive GPU container platform services and enterprise-grade AI/ML computing supporting the growing GPU acceleration requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all RKE2 configurations, GPU integration procedures, and container orchestration implementation  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
