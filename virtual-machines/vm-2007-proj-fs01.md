<---
title: "proj-fs01 - Enterprise Object Storage Platform VM"
type: "enterprise-vm-asset"
domain: "object-storage-infrastructure"
tech: "ubuntu-2404-lts-minio-s3-storage"
scale: "enterprise-object-storage"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Object storage platform"
  compliance_framework: "CIS Controls v8 Level 2"
  storage_platform: "MinIO S3-compatible object storage (minio01)"
--->

# 🗄️ **proj-fs01 - Enterprise Object Storage Platform VM**

**Asset Classification:** Object Storage Platform | **Service Tier:** Production | **Location:** node05 - Infrastructure Host

This knowledge base article provides comprehensive virtual machine specifications, object storage configuration, and operational procedures for proj-fs01, an Ubuntu Server 24.04 LTS enterprise object storage virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary MinIO S3-compatible object storage platform (minio01) with 1.5TB NVMe storage capacity supporting distributed file services and S3 API access across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-fs01 serves as the enterprise object storage platform providing S3-compatible storage services through MinIO deployment (minio01), supporting distributed file storage, object-based data access, backup storage repositories, and S3 API integration with 1.5TB high-performance NVMe storage capacity for research data management and distributed storage workflows.

### **1.2 Service Classification**

**Production Tier:** Mission-critical object storage platform optimized for S3-compatible storage services, distributed file management, research data repositories, and high-performance object storage supporting enterprise data workflows with CIS Controls v8 Level 2 baseline security implementation and MinIO enterprise architecture.

### **1.3 Cluster Integration**

Central object storage hub enabling S3-compatible storage services, distributed file management, and object-based data access while maintaining enterprise-grade security standards and seamless integration with backup systems, data processing workflows, and research data management infrastructure.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node05 (Intel i5-12600H) | Physical infrastructure foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Object storage network connectivity |
| **Storage Backend** | nvmethin01 + nvmethin02 pools | Multi-tier object storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Network Connectivity** | labswitch02 management layer | Project VLAN access |
| **DNS Resolution** | Cluster DNS infrastructure | S3 service discovery |
| **Time Synchronization** | chronyd NTP service | Object storage coordination |
| **Backup Integration** | pbs01 enterprise backup | Storage data protection |

### **2.3 Object Storage Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **MinIO Server** | S3-compatible object storage | Distributed storage platform |
| **Storage Allocation** | 1.5TB dedicated object storage | High-capacity data repository |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **S3 API Access** | MinIO S3 compatibility | Standard object storage interface |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2007 | Object storage platform identifier |
| **Memory** | 2.00 GiB allocated / 6.00 GiB maximum | Optimized for object storage workloads |
| **Processors** | 2 vCPU (2 sockets, 1 core each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2007-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Object Storage** | scsi1: nvmethin02:vm-2007-disk-0, 1500GB | Dedicated 1.5TB MinIO storage |
| **EFI System** | nvmethin01:vm-2007-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2007-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:F7:9E:13 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.11 (static) | Object storage platform address |
| **Security Hardening** | Host-based firewall active | S3 traffic filtering |

### **3.4 MinIO Object Storage Implementation**

| **Storage Component** | **Implementation** | **Capabilities** |
|----------------------|-------------------|------------------|
| **MinIO Server** | S3-compatible object storage | Standard S3 API access |
| **Storage Pool** | 1.5TB NVMe storage | High-performance object repository |
| **API Endpoint** | S3-compatible interface | Standard object storage access |
| **Data Management** | Object-based storage | Distributed file services |

---

## **🔧 4. Management & Operations**

### **4.1 Object Storage Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **MinIO S3 Storage** | Object storage platform | S3-compatible data repository |
| **Distributed File Services** | Object-based file management | Research data storage |
| **Backup Repository** | Storage backup destination | Data protection services |
| **API Gateway** | S3 interface access | Standard object storage API |

### **4.2 Storage Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **MinIO Server** | Object storage engine | S3-compatible storage delivery |
| **Storage Pool** | 1.5TB NVMe repository | High-capacity object storage |
| **Web Interface** | MinIO console | Storage management interface |
| **API Service** | S3 endpoint | Object storage access |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Storage Health Monitoring** | Continuous | MinIO cluster status validation |
| **Capacity Management** | Weekly | Storage utilization tracking |
| **Performance Optimization** | Monthly | Object storage tuning |
| **Security Validation** | Weekly | S3 access control verification |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Storage Performance** | MinIO metrics + system monitoring | Object storage efficiency |
| **Capacity Utilization** | Storage monitoring | 1.5TB capacity tracking |
| **API Health** | S3 endpoint monitoring | Object storage accessibility |
| **Security Events** | Access control monitoring | S3 security validation |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Object Storage Security** | MinIO access controls and encryption | ✅ CIS L2 storage security |
| **Data Protection** | Object encryption and access management | ✅ CIS L2 data protection |
| **Access Controls** | SSH hardening + S3 authentication | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + VLAN segmentation | ✅ Layered security controls |
| **Audit & Logging** | Storage access monitoring | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Object storage access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Research data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Storage security monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Storage incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Object Storage Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with object storage-aware backup procedures ensuring MinIO configuration preservation, object data protection, and rapid recovery supporting critical distributed storage services and S3 API continuity.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 05:30 | 30 days | pbs01 comprehensive backup |
| **MinIO Configuration** | Real-time persistence | Continuous | Object storage configuration |
| **Object Data** | Storage-level protection | Object versioning | MinIO data management |
| **Storage Metadata** | Weekly backup | 90 days | Object storage state |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + MinIO restart |
| **MinIO Service Recovery** | <30 minutes | <8 hours | Object storage service restoration |
| **Object Data Recovery** | <45 minutes | Variable | Object-level restoration |
| **Configuration Recovery** | <20 minutes | <24 hours | MinIO configuration restoration |

---

## **📚 7. References & Documentation**

### **7.1 Object Storage Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **MinIO Documentation** | Object storage deployment | [MinIO Guides](https://docs.min.io/) |
| **S3 API Specification** | Object storage interface | [AWS S3 Documentation](https://docs.aws.amazon.com/s3/) |
| **CIS Controls v8 Level 2** | Storage security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node05](../hardware/node05-12600h-infrastructure-node.md)** | Physical host platform | Infrastructure foundation |
| **[Storage Infrastructure](../infrastructure/storage/)** | Storage coordination | Enterprise storage stack |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Object Storage Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **MinIO Functionality** | S3 API testing | Successful object storage operations |
| **Storage Performance** | 1.5TB capacity validation | Optimal storage performance |
| **S3 Compatibility** | API compliance testing | Standard S3 interface functionality |
| **Data Integrity** | Object validation procedures | Accurate data storage and retrieval |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Storage Security** | MinIO security audit | Secure object storage configuration |
| **Access Control** | S3 authentication testing | Restricted storage access |
| **Data Protection** | Object encryption validation | Protected research data |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-fs01 represents a comprehensive enterprise object storage platform implementing MinIO S3-compatible storage with CIS Controls v8 Level 2 security standards, providing 1.5TB high-performance object storage, distributed file services, and S3 API access supporting research data management and distributed storage workflows with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **S3-Compatible Storage** | MinIO object storage platform | Standard object storage interface |
| **High-Capacity Storage** | 1.5TB NVMe repository | Large-scale data storage |
| **Distributed File Services** | Object-based storage | Scalable research data management |
| **API Integration** | S3 interface | Standard storage integration |

### **9.3 Operational Impact**

This virtual machine serves as the critical object storage foundation enabling S3-compatible storage services, distributed file management, and research data repositories across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential object storage capabilities for data workflows and distributed storage requirements.

### **9.4 Future Considerations**

Planned enhancements include expanded object storage capacity, enhanced MinIO clustering, and advanced S3 feature implementation supporting the evolution toward comprehensive distributed storage services and enterprise-grade object storage supporting the growing data storage requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all MinIO configurations, object storage procedures, and S3 implementations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
