<---
title: "proj-fs03 - Enterprise Object Storage Platform VM (Secondary)"
type: "enterprise-vm-asset"
domain: "object-storage-infrastructure"
tech: "ubuntu-2404-lts-minio-s3-storage"
scale: "enterprise-object-storage"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Object storage platform (secondary)"
  compliance_framework: "CIS Controls v8 Level 2"
  storage_platform: "MinIO S3-compatible object storage (minio02)"
--->

# 🗄️ **proj-fs03 - Enterprise Object Storage Platform VM (Secondary)**

**Asset Classification:** Secondary Object Storage Platform | **Service Tier:** Production | **Location:** node02 - Storage Host

This knowledge base article provides comprehensive virtual machine specifications, object storage configuration, and operational procedures for proj-fs03, an Ubuntu Server 24.04 LTS enterprise object storage virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the secondary MinIO S3-compatible object storage platform (minio02) with 1.5TB NVMe storage capacity providing distributed object storage redundancy and S3 API access as counterpart to proj-fs01 across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-fs03 serves as the secondary enterprise object storage platform providing distributed S3-compatible storage services through MinIO deployment (minio02), supporting object storage redundancy, load distribution, backup storage repositories, and S3 API access with 1.5TB high-performance NVMe storage capacity complementing proj-fs01 for enhanced reliability and distributed storage architecture.

### **1.2 Service Classification**

**Production Tier:** Mission-critical secondary object storage platform optimized for distributed S3-compatible storage services, storage redundancy, load balancing, and high-availability object storage supporting enterprise data workflows with CIS Controls v8 Level 2 baseline security implementation and MinIO distributed architecture.

### **1.3 Cluster Integration**

Secondary object storage hub enabling distributed S3-compatible storage services, storage redundancy coordination, and object-based data access while maintaining enterprise-grade security standards and seamless integration with primary storage (proj-fs01), backup systems, and distributed storage infrastructure for enhanced reliability.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node02 (Intel i5-12600H) | Physical storage/compute foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Object storage network connectivity |
| **Storage Backend** | nvmethin01 + nvmethin02 pools | Multi-tier object storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Primary Storage** | proj-fs01 (minio01) | Distributed storage coordination |
| **Network Connectivity** | labswitch02 management layer | Project VLAN access |
| **DNS Resolution** | Cluster DNS infrastructure | S3 service discovery |
| **Backup Integration** | pbs01 enterprise backup | Storage data protection |

### **2.3 Object Storage Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **MinIO Server** | S3-compatible object storage | Distributed storage platform |
| **Storage Allocation** | 1.5TB dedicated object storage | High-capacity data repository |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Distributed Coordination** | minio02 cluster member | Secondary storage node |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2010 | Secondary object storage identifier |
| **Memory** | 2.00 GiB allocated / 6.00 GiB maximum | Optimized for object storage workloads |
| **Processors** | 2 vCPU (2 sockets, 1 core each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2010-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Object Storage** | scsi1: nvmethin02:vm-2010-disk-0, 1500GB | Dedicated 1.5TB MinIO storage |
| **EFI System** | nvmethin01:vm-2010-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2010-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:B0:FC:FF | VirtIO network adapter |
| **Bridge Assignment** | vmbr0, tag=20 | Management bridge with project VLAN |
| **IP Configuration** | 10.25.20.17 (static) | Secondary object storage address |
| **Security Hardening** | Host-based firewall active | S3 traffic filtering |

### **3.4 MinIO Object Storage Implementation**

| **Storage Component** | **Implementation** | **Capabilities** |
|----------------------|-------------------|------------------|
| **MinIO Server** | S3-compatible object storage (minio02) | Distributed storage coordination |
| **Storage Pool** | 1.5TB NVMe storage | High-performance object repository |
| **API Endpoint** | S3-compatible interface | Standard object storage access |
| **Distributed Architecture** | Secondary cluster member | Storage redundancy and load balancing |

---

## **🔧 4. Management & Operations**

### **4.1 Secondary Storage Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **MinIO S3 Storage** | Secondary object storage platform | Distributed S3-compatible repository |
| **Storage Redundancy** | Backup and failover coordination | Enhanced reliability |
| **Load Distribution** | Storage load balancing | Performance optimization |
| **API Gateway** | Secondary S3 interface | Distributed object storage access |

### **4.2 Distributed Storage Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **MinIO Server** | Secondary storage engine | Distributed object storage delivery |
| **Storage Pool** | 1.5TB NVMe repository | High-capacity secondary storage |
| **Web Interface** | MinIO console | Secondary storage management |
| **Cluster Coordination** | minio02 member | Distributed storage architecture |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Distributed Health Monitoring** | Continuous | MinIO cluster coordination validation |
| **Storage Synchronization** | Continuous | Primary/secondary coordination |
| **Performance Optimization** | Monthly | Secondary storage tuning |
| **Failover Testing** | Quarterly | Redundancy validation |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Secondary Performance** | MinIO metrics + system monitoring | Secondary storage efficiency |
| **Cluster Coordination** | Distributed storage monitoring | Primary/secondary synchronization |
| **API Health** | Secondary S3 endpoint monitoring | Backup storage accessibility |
| **Redundancy Status** | Storage failover monitoring | Distributed storage health |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Distributed Storage Security** | MinIO cluster security coordination | ✅ CIS L2 distributed storage security |
| **Data Protection** | Object encryption and redundancy | ✅ CIS L2 data protection |
| **Access Controls** | SSH hardening + S3 authentication | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + VLAN segmentation | ✅ Layered security controls |
| **Audit & Logging** | Secondary storage access monitoring | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Secondary storage access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Distributed data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Secondary storage monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Distributed storage incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Secondary Storage Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with distributed storage-aware backup procedures ensuring MinIO secondary configuration preservation, object data protection, and rapid recovery supporting critical distributed storage services and S3 API continuity.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 06:30 | 30 days | pbs01 comprehensive backup |
| **MinIO Configuration** | Real-time persistence | Continuous | Secondary storage configuration |
| **Object Data** | Distributed replication | Continuous | MinIO cluster coordination |
| **Storage Metadata** | Weekly backup | 90 days | Secondary storage state |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + MinIO restart |
| **Secondary Service Recovery** | <30 minutes | <8 hours | Secondary storage service restoration |
| **Cluster Rejoin** | <45 minutes | <4 hours | Distributed storage cluster coordination |
| **Configuration Recovery** | <20 minutes | <24 hours | Secondary MinIO configuration restoration |

---

## **📚 7. References & Documentation**

### **7.1 Distributed Storage Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **MinIO Distributed Documentation** | Secondary storage deployment | [MinIO Distributed Guides](https://docs.min.io/) |
| **S3 API Specification** | Object storage interface | [AWS S3 Documentation](https://docs.aws.amazon.com/s3/) |
| **CIS Controls v8 Level 2** | Distributed storage security | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node02](../hardware/node02-12600h-storage-node.md)** | Physical host platform | Storage foundation |
| **[proj-fs01](proj-fs01.md)** | Primary storage counterpart | Distributed storage coordination |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Secondary Storage Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **MinIO Functionality** | Secondary S3 API testing | Successful distributed storage operations |
| **Cluster Coordination** | Primary/secondary sync validation | Proper distributed storage |
| **Failover Testing** | Primary storage failover validation | Successful secondary takeover |
| **Data Integrity** | Distributed object validation | Accurate data replication |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Distributed Security** | MinIO cluster security audit | Secure distributed storage |
| **Access Control** | Secondary S3 authentication testing | Restricted storage access |
| **Data Protection** | Distributed encryption validation | Protected research data |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-fs03 represents a comprehensive secondary enterprise object storage platform implementing MinIO S3-compatible distributed storage with CIS Controls v8 Level 2 security standards, providing 1.5TB high-performance secondary object storage, distributed storage redundancy, and S3 API access supporting enhanced reliability and distributed storage architecture as counterpart to proj-fs01 with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Secondary S3 Storage** | MinIO distributed object storage | Enhanced storage reliability |
| **Storage Redundancy** | Primary/secondary coordination | Improved data availability |
| **Load Distribution** | Distributed storage architecture | Performance optimization |
| **Distributed API** | Secondary S3 interface | Redundant storage access |

### **9.3 Operational Impact**

This virtual machine serves as the critical secondary object storage foundation enabling distributed S3-compatible storage services, enhanced storage reliability, and redundant object storage access across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential distributed storage capabilities for enhanced data availability and performance optimization.

### **9.4 Future Considerations**

Planned enhancements include expanded distributed storage features, enhanced MinIO clustering optimization, and advanced redundancy management supporting the evolution toward comprehensive distributed storage services and enterprise-grade object storage supporting the growing distributed storage requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all MinIO configurations, distributed storage procedures, and secondary storage implementations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
