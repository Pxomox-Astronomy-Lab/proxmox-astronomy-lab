<---
title: "proj-pg01 - Enterprise PostgreSQL Database Platform VM"
type: "enterprise-vm-asset"
domain: "astronomical-database-platform"
tech: "ubuntu-2404-lts-postgresql-16-astronomical"
scale: "enterprise-database-platform"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "High-performance database platform"
  compliance_framework: "CIS Controls v8 Level 2"
  database_type: "PostgreSQL 16 optimized for astronomical workloads"
--->

# 🗄️ **proj-pg01 - Enterprise PostgreSQL Database Platform VM**

**Asset Classification:** High-Performance Database Platform | **Service Tier:** Production | **Location:** node06 - Next-Gen Performance Host

This knowledge base article provides comprehensive virtual machine specifications, database configuration, and operational procedures for proj-pg01, an Ubuntu Server 24.04 LTS enterprise PostgreSQL database virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary high-performance database platform optimized for demanding astronomical workloads including 30GB+ DESI cosmic void datasets and large-scale research data operations across the 7-node Proxmox astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-pg01 serves as the enterprise PostgreSQL database platform providing high-performance data storage, query processing, and transaction management optimized for demanding astronomical workloads including DESI cosmic void analysis (30GB+ datasets), AGN outflow studies, quasar anomaly detection, and large-scale research data operations requiring enterprise-grade database performance and reliability.

### **1.2 Service Classification**

**Production Tier:** Mission-critical database platform optimized for high-performance astronomical data storage, complex query processing, large dataset operations, and enterprise-grade database services supporting demanding research workloads with CIS Controls v8 Level 2 baseline security implementation and PostgreSQL 16 optimization for scientific computing.

### **1.3 Cluster Integration**

Primary database foundation enabling comprehensive astronomical data storage, research data management, and high-performance query processing supporting all DESI research projects while maintaining enterprise-grade security standards and providing scalable database services for data processing, analysis, and scientific discovery workflows.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node06 (Intel i9-13900H) | Next-generation performance foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | High-performance database connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | Enterprise-grade database storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Data Processing** | proj-dp01 ETL platform | Data ingestion and transformation |
| **Network Connectivity** | labswitch02/labswitch03 dual-link | High-bandwidth database access |
| **Storage Infrastructure** | High-performance NVMe storage | Database performance optimization |
| **Backup Services** | pbs01 enterprise backup | Database protection and recovery |

### **2.3 Database Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **PostgreSQL 16** | Latest enterprise database version | Astronomical workload optimization |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 282GB total database storage | Large dataset capacity |
| **Performance Configuration** | Astronomical workload optimization | DESI dataset processing |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2002 | Enterprise database platform identifier |
| **Memory** | 16.00 GiB allocated / 32.00 GiB maximum | Optimized for high-performance database workloads |
| **Processors** | 8 vCPU (2 sockets, 4 cores each) | [host] CPU type with NUMA optimization |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2002-disk-2, 32GB | VirtIO SCSI with discard, iothread |
| **Database Storage** | scsi1: nvmethin01:vm-2002-disk-4, 250GB | Dedicated high-performance database storage |
| **EFI System** | nvmethin01:vm-2002-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2002-disk-3, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:B0:1F:69 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.8 (static) | Primary database server address |
| **Security Hardening** | Host-based firewall active | Database traffic filtering |

### **3.4 PostgreSQL Database Implementation**

| **Database Component** | **Implementation** | **Optimization** |
|-----------------------|-------------------|------------------|
| **PostgreSQL 16** | Latest enterprise database version | Astronomical workload optimization |
| **Database Configuration** | High-performance tuning | DESI dataset processing optimization |
| **Storage Optimization** | NVMe performance tuning | Large dataset query optimization |
| **Security Hardening** | Database access controls | Enterprise security implementation |

---

## **🔧 4. Management & Operations**

### **4.1 Database Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **DESI Cosmic Void Database** | 30GB+ galaxy evolution dataset | Primary research data storage |
| **AGN Outflow Database** | Quasar outflow analysis data | Spectral analysis data management |
| **Quasar Anomaly Database** | ML anomaly detection datasets | Large-scale machine learning data |
| **Research Data Management** | General astronomical data storage | Comprehensive research support |

### **4.2 Database Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **PostgreSQL 16 Engine** | Production database server | High-performance data processing |
| **Database Optimization** | Astronomical workload tuning | DESI dataset query optimization |
| **Storage Management** | 250GB database storage | Large dataset capacity |
| **Security Implementation** | Enterprise access controls | Database security hardening |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Database Performance Monitoring** | Continuous | Query optimization and resource tracking |
| **Data Integrity Validation** | Daily | Database consistency verification |
| **Security Updates** | Weekly | PostgreSQL and system updates |
| **Backup Verification** | Daily | Database backup integrity validation |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Database Performance** | PostgreSQL monitoring + system metrics | Query performance and resource utilization |
| **Data Integrity** | Database consistency checks | Data validation and corruption detection |
| **Storage Utilization** | Disk space and I/O monitoring | Database storage optimization |
| **Security Events** | Database audit logging | Access control and security monitoring |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Database Security** | PostgreSQL access controls and encryption | ✅ CIS L2 database security |
| **Data Protection** | Database encryption and access management | ✅ CIS L2 data protection |
| **Access Controls** | SSH hardening + database authentication | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + VLAN segmentation | ✅ Layered security controls |
| **Audit & Logging** | Database activity monitoring | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Database access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Research data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Database security monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Database incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Enterprise Database Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with database-aware backup procedures ensuring PostgreSQL data consistency, transaction integrity, and rapid recovery supporting critical astronomical research data protection and business continuity requirements.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 01:00 | 30 days | pbs01 comprehensive backup |
| **PostgreSQL Database** | Continuous WAL archiving | 90 days | Database-consistent backup |
| **DESI Dataset Backup** | Daily incremental | 60 days | Large dataset protection |
| **Database Configuration** | Weekly backup | 180 days | Database setup preservation |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + database validation |
| **Database Point-in-Time Recovery** | <45 minutes | <15 minutes | PostgreSQL WAL replay |
| **Table/Schema Recovery** | <30 minutes | <24 hours | Selective database restoration |
| **Configuration Recovery** | <20 minutes | <7 days | Database configuration restoration |

---

## **📚 7. References & Documentation**

### **7.1 Database Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **PostgreSQL Documentation** | Database administration | [PostgreSQL Guides](https://www.postgresql.org/docs/) |
| **DESI Data Management** | Astronomical database optimization | [DESI Collaboration](https://www.desi.lbl.gov/) |
| **CIS Controls v8 Level 2** | Database security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node06](../hardware/node06-13900h-performance-node.md)** | Physical host platform | Next-generation performance foundation |
| **[proj-dp01](proj-dp01.md)** | Data processing services | ETL and data transformation |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Database protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Database Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **PostgreSQL Performance** | Database benchmark testing | Optimized query performance |
| **DESI Dataset Operations** | Large dataset query testing | Efficient 30GB+ data processing |
| **Data Integrity** | Database consistency validation | Complete data accuracy |
| **Backup Integrity** | Recovery testing procedures | Successful database restoration |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Database Security** | PostgreSQL security audit | Secure database configuration |
| **Access Control** | Authentication testing | Restricted database access |
| **Data Protection** | Encryption validation | Protected research data |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-pg01 represents a comprehensive enterprise PostgreSQL database platform implementing CIS Controls v8 Level 2 security standards with high-performance optimization for demanding astronomical workloads, supporting 30GB+ DESI cosmic void datasets, AGN outflow studies, and quasar anomaly detection with enterprise-grade database services, robust security controls, and operational excellence on next-generation Intel hardware.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **High-Performance Database** | PostgreSQL 16 with astronomical optimization | Scalable research data management |
| **Large Dataset Support** | 30GB+ DESI dataset processing | Production research workloads |
| **Enterprise Security** | CIS L2 baseline with database hardening | Secure research data protection |
| **Data Integrity** | Comprehensive backup and recovery | Business continuity assurance |

### **9.3 Operational Impact**

This virtual machine serves as the critical database foundation enabling comprehensive astronomical research data storage, high-performance query processing, and large-scale dataset management across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential database services for DESI research projects and scientific discovery workflows.

### **9.4 Future Considerations**

Planned enhancements include expanded database optimization, enhanced performance monitoring, and advanced query optimization supporting the evolution toward comprehensive astronomical database services and enterprise-grade data management supporting the growing database requirements of the astronomy platform and expanding research datasets.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all PostgreSQL configurations, database optimization procedures, and astronomical data management  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
