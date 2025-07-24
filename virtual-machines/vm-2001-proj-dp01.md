<---
title: "proj-dp01 - Enterprise Data Processing Platform VM"
type: "enterprise-vm-asset"
domain: "astronomical-data-processing"
tech: "ubuntu-2404-lts-data-processing-etl"
scale: "enterprise-data-processing"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Data processing platform"
  compliance_framework: "CIS Controls v8 Level 2"
  workload_type: "Mixed ETL and astronomical data processing"
--->

# 📊 **proj-dp01 - Enterprise Data Processing Platform VM**

**Asset Classification:** Data Processing Platform | **Service Tier:** Production | **Location:** node04 - Database Flagship Host

This knowledge base article provides comprehensive virtual machine specifications, data processing configuration, and operational procedures for proj-dp01, an Ubuntu Server 24.04 LTS enterprise data processing virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary data processing platform for ETL operations, astronomical data transformation, and mixed analytical workloads supporting DESI research projects across the 7-node Proxmox astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-dp01 serves as the enterprise data processing platform providing comprehensive Extract, Transform, Load (ETL) capabilities, astronomical data processing workflows, and mixed analytical workloads supporting DESI research projects including cosmic void analysis, AGN outflow studies, and quasar anomaly detection with scalable data transformation and processing automation.

### **1.2 Service Classification**

**Production Tier:** Mission-critical data processing platform optimized for astronomical data workflows, ETL operations, data transformation pipelines, and analytical processing supporting enterprise research computing with CIS Controls v8 Level 2 baseline security implementation and comprehensive data processing capabilities.

### **1.3 Cluster Integration**

Central data processing hub enabling comprehensive astronomical data transformation, ETL workflow coordination, and analytical processing supporting research projects while maintaining enterprise-grade security standards and seamless integration with database services, storage infrastructure, and computational resources across the astronomy platform.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node04 (Intel i9-12900H) | Physical database flagship foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Data processing network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance data processing storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Database Services** | proj-pg01 PostgreSQL platform | Data source and destination |
| **Network Connectivity** | labswitch02 management layer | Project VLAN access |
| **Storage Infrastructure** | High-performance NVMe storage | Data processing workspace |
| **Computational Resources** | Distributed processing coordination | Scalable data workflows |

### **2.3 Data Processing Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Data Processing Tools** | ETL and analytical frameworks | Data transformation capabilities |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 132GB total processing storage | Data pipeline workspace |
| **Database Connectivity** | PostgreSQL integration | DESI data access |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2001 | Data processing platform identifier |
| **Memory** | 2.00 GiB allocated / 16.00 GiB maximum | Optimized for data processing workloads |
| **Processors** | 4 vCPU (2 sockets, 2 cores each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2001-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Data Processing Storage** | scsi1: nvmethin01:vm-2001-disk-3, 100GB | Dedicated ETL and processing workspace |
| **EFI System** | nvmethin01:vm-2001-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2001-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:43:78:3A | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.3 (static) | Data processing platform address |
| **Security Hardening** | Host-based firewall active | Data processing traffic filtering |

### **3.4 Data Processing Implementation**

| **Processing Component** | **Implementation** | **Capabilities** |
|-------------------------|-------------------|------------------|
| **ETL Frameworks** | Data extraction, transformation, loading | Comprehensive data pipeline automation |
| **Astronomical Processing** | DESI data analysis tools | Cosmic void, AGN, quasar processing |
| **Mixed Workloads** | General data processing capabilities | Flexible analytical workflows |
| **Database Integration** | PostgreSQL connectivity | DESI research data coordination |

---

## **🔧 4. Management & Operations**

### **4.1 Data Processing Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **ETL Operations** | Data extraction, transformation, loading | Astronomical data pipelines |
| **DESI Data Processing** | Cosmic void, AGN, quasar analysis | Research project workflows |
| **Mixed Analytical Workloads** | General data processing | Flexible processing capabilities |
| **Database Coordination** | PostgreSQL integration | Research data management |

### **4.2 Processing Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **Data Processing Engine** | Active processing environment | ETL and analytical workflows |
| **Astronomical Tools** | DESI analysis frameworks | Research data processing |
| **Database Connectivity** | proj-pg01 integration | Data source and destination |
| **Storage Management** | 100GB processing workspace | Data pipeline storage |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Data Pipeline Execution** | Continuous | Automated ETL workflows |
| **Processing Performance** | Daily | Resource utilization monitoring |
| **Data Quality Validation** | Per workflow | Processing integrity verification |
| **Storage Management** | Weekly | Processing workspace optimization |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Processing Performance** | System monitoring + pipeline metrics | Workflow efficiency |
| **Data Quality** | Processing validation tools | Data integrity assurance |
| **Resource Utilization** | Host performance monitoring | Processing optimization |
| **Database Integration** | PostgreSQL connectivity monitoring | Data access validation |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Data Protection** | Processing data encryption and access control | ✅ CIS L2 data security |
| **Access Controls** | SSH hardening + processing authentication | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + VLAN segmentation | ✅ Layered security controls |
| **File Integrity** | AIDE monitoring with processing awareness | ✅ Comprehensive monitoring |
| **Audit & Logging** | Processing activity tracking | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Data processing access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Research data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Processing pipeline monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Data processing incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Data Processing Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with data-aware backup procedures ensuring processing environment preservation, ETL configuration retention, and rapid recovery supporting critical astronomical data processing workflows and research continuity.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 04:00 | 30 days | pbs01 comprehensive backup |
| **Processing Environment** | Real-time persistence | Continuous | ETL configuration management |
| **Data Pipeline State** | Workflow checkpoints | Processing recovery | Pipeline state preservation |
| **Processing Workspace** | Weekly backup | 14 days | Temporary data protection |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <45 minutes | <24 hours | pbs01 full restoration + processing restart |
| **Processing Environment** | <30 minutes | <8 hours | ETL framework restoration |
| **Data Pipeline Recovery** | <20 minutes | <4 hours | Workflow checkpoint restoration |
| **Database Integration** | <15 minutes | <1 hour | PostgreSQL connectivity restoration |

---

## **📚 7. References & Documentation**

### **7.1 Data Processing Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **DESI Data Processing** | Astronomical analysis workflows | [DESI Collaboration](https://www.desi.lbl.gov/) |
| **ETL Best Practices** | Data pipeline frameworks | [Data Engineering Standards](https://www.dataengineering.org/) |
| **CIS Controls v8 Level 2** | Data security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node04](../hardware/node04-minisforum-ms-a1-12900h.md)** | Physical host platform | Database flagship foundation |
| **[proj-pg01](proj-pg01.md)** | Database services | DESI data storage |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Data Processing Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **ETL Pipeline Functionality** | Data processing workflow testing | Successful data transformation |
| **Database Integration** | PostgreSQL connectivity validation | Proper data access and storage |
| **Processing Performance** | Workflow efficiency testing | Optimized resource utilization |
| **Data Quality** | Processing integrity validation | Accurate data transformation |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Data Security** | Processing data protection audit | Secure data handling |
| **Access Control** | Authentication testing | Restricted processing access |
| **Network Security** | VLAN isolation validation | Proper traffic segmentation |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-dp01 represents a comprehensive enterprise data processing platform implementing CIS Controls v8 Level 2 security standards with specialized astronomical data processing capabilities, ETL workflows, and mixed analytical workloads supporting DESI research projects including cosmic void analysis, AGN outflow studies, and quasar anomaly detection with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **ETL Operations** | Comprehensive data pipeline automation | Scalable data transformation |
| **Astronomical Processing** | DESI-specific analysis workflows | Research data processing |
| **Mixed Workloads** | Flexible analytical capabilities | Adaptable processing platform |
| **Database Integration** | PostgreSQL connectivity | Seamless research data coordination |

### **9.3 Operational Impact**

This virtual machine serves as the critical data processing foundation enabling comprehensive astronomical data transformation, ETL workflow automation, and analytical processing coordination across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential data processing capabilities for DESI research projects and computational workflows.

### **9.4 Future Considerations**

Planned enhancements include expanded data processing frameworks, enhanced astronomical analysis capabilities, and advanced ETL optimization supporting the evolution toward comprehensive data processing automation and enterprise-grade analytical operations supporting the growing data processing requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all data processing configurations, ETL workflows, and astronomical data procedures  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
