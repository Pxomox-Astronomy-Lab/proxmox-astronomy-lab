<---
title: "proj-pgsql02 - Enterprise General-Purpose Database Platform VM"
type: "enterprise-vm-asset"
domain: "general-purpose-database-platform"
tech: "ubuntu-2404-lts-postgresql-16-general-workloads"
scale: "enterprise-database-platform"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "General-purpose database platform"
  compliance_framework: "CIS Controls v8 Level 2"
  database_type: "PostgreSQL 16 for application workloads"
--->

# 🗄️ **proj-pgsql02 - Enterprise General-Purpose Database Platform VM**

**Asset Classification:** General-Purpose Database Platform | **Service Tier:** Production | **Location:** node04 - Database Flagship Host

This knowledge base article provides comprehensive virtual machine specifications, database configuration, and operational procedures for proj-pgsql02, an Ubuntu Server 24.04 LTS enterprise general-purpose database virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary PostgreSQL database platform for VLAN 20 application workloads including Gitea source control and general infrastructure applications across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-pgsql02 serves as the enterprise general-purpose database platform providing PostgreSQL database services for VLAN 20 application workloads including Gitea source control repositories, infrastructure applications, and general-purpose database requirements supporting distributed application architectures and infrastructure services coordination.

### **1.2 Service Classification**

**Production Tier:** Mission-critical general-purpose database platform optimized for application database services, infrastructure application support, source control database management, and distributed application data storage with CIS Controls v8 Level 2 baseline security implementation and PostgreSQL 16 optimization for application workloads.

### **1.3 Cluster Integration**

Application database foundation enabling comprehensive infrastructure application data storage, source control database services, and general-purpose database support while maintaining enterprise-grade security standards and providing scalable database services for application workloads and infrastructure service coordination.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node04 (Intel i9-12900H) | Database flagship foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Application database connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | Database storage infrastructure |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Application Services** | Gitea and infrastructure applications | Database service provision |
| **Network Connectivity** | labswitch02/labswitch03 dual-link | High-performance database access |
| **Storage Infrastructure** | High-performance NVMe storage | Database performance optimization |
| **Backup Services** | pbs01 enterprise backup | Database protection and recovery |

### **2.3 Database Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **PostgreSQL 16** | Latest enterprise database version | Application workload optimization |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 132GB total database storage | Application database capacity |
| **Application Integration** | Gitea and infrastructure service support | Application database connectivity |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2012 | General-purpose database identifier |
| **Memory** | 12.00 GiB allocated / 24.00 GiB maximum | Optimized for application database workloads |
| **Processors** | 6 vCPU (2 sockets, 3 cores each) | [host] CPU type with NUMA optimization |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2012-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Database Storage** | scsi1: nvmethin01:vm-2012-disk-3, 100GB | Dedicated application database storage |
| **EFI System** | nvmethin01:vm-2012-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2012-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:25:2A:D3 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.16 (static) | Application database server address |
| **Security Hardening** | Host-based firewall active | Database traffic filtering |

### **3.4 PostgreSQL Database Implementation**

| **Database Component** | **Implementation** | **Optimization** |
|-----------------------|-------------------|------------------|
| **PostgreSQL 16** | Latest enterprise database version | Application workload optimization |
| **Database Configuration** | General-purpose tuning | Application performance optimization |
| **Storage Optimization** | NVMe performance tuning | Application database query optimization |
| **Security Hardening** | Database access controls | Enterprise security implementation |

---

## **🔧 4. Management & Operations**

### **4.1 Application Database Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **Gitea Database** | Source control repository data | Code repository management |
| **Infrastructure Application DBs** | General application database services | Infrastructure service data storage |
| **General-Purpose Databases** | Application workload data management | Distributed application support |
| **Application Data Management** | Database coordination for VLAN 20 services | Comprehensive application support |

### **4.2 Database Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **PostgreSQL 16 Engine** | Production database server | Application database processing |
| **Database Optimization** | Application workload tuning | General-purpose query optimization |
| **Storage Management** | 100GB database storage | Application data capacity |
| **Security Implementation** | Enterprise access controls | Database security hardening |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Database Performance Monitoring** | Continuous | Application query optimization |
| **Application Database Health** | Daily | Database service validation |
| **Security Updates** | Weekly | PostgreSQL and system updates |
| **Backup Verification** | Daily | Database backup integrity validation |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Database Performance** | PostgreSQL monitoring + system metrics | Application database performance |
| **Application Connectivity** | Database connection monitoring | Application service validation |
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
| **Application Data Protection** | Database encryption and access management | ✅ CIS L2 data protection |
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
| **CIS.13.1** | **Compliant** | Application data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | Database security monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Database incident response | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Application Database Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with database-aware backup procedures ensuring PostgreSQL data consistency, application data integrity, and rapid recovery supporting critical application database protection and service continuity requirements.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 02:00 | 30 days | pbs01 comprehensive backup |
| **PostgreSQL Database** | Continuous WAL archiving | 90 days | Database-consistent backup |
| **Gitea Database** | Daily incremental | 60 days | Source control data protection |
| **Application Databases** | Daily backup | 30 days | Application data protection |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + database validation |
| **Database Point-in-Time Recovery** | <30 minutes | <15 minutes | PostgreSQL WAL replay |
| **Application Database Recovery** | <20 minutes | <24 hours | Selective database restoration |
| **Gitea Database Recovery** | <15 minutes | <8 hours | Source control database restoration |

---

## **📚 7. References & Documentation**

### **7.1 Database Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **PostgreSQL Documentation** | Database administration | [PostgreSQL Guides](https://www.postgresql.org/docs/) |
| **Gitea Database Integration** | Source control database management | [Gitea Documentation](https://docs.gitea.io/) |
| **CIS Controls v8 Level 2** | Database security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node04](../hardware/node04-minisforum-ms-a1-12900h.md)** | Physical host platform | Database flagship foundation |
| **[Gitea Infrastructure](../infrastructure/gitops-portainer/)** | Source control services | Application integration |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Database protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Database Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **PostgreSQL Performance** | Database benchmark testing | Optimized application query performance |
| **Gitea Database Operations** | Source control database testing | Efficient repository data management |
| **Application Connectivity** | Database connection validation | Successful application database access |
| **Backup Integrity** | Recovery testing procedures | Successful database restoration |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Database Security** | PostgreSQL security audit | Secure database configuration |
| **Access Control** | Authentication testing | Restricted database access |
| **Data Protection** | Encryption validation | Protected application data |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-pgsql02 represents a comprehensive enterprise general-purpose database platform implementing PostgreSQL 16 with CIS Controls v8 Level 2 security standards, providing application database services for Gitea source control, infrastructure applications, and general-purpose database workloads supporting distributed application architectures with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Application Database Services** | PostgreSQL 16 for application workloads | Scalable application data management |
| **Source Control Database** | Gitea database management | Code repository data support |
| **General-Purpose Storage** | Infrastructure application database support | Comprehensive application data services |
| **Enterprise Security** | CIS L2 baseline with database hardening | Secure application data protection |

### **9.3 Operational Impact**

This virtual machine serves as the critical application database foundation enabling comprehensive infrastructure application data storage, source control database services, and general-purpose database support across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential database services for application workloads and infrastructure service coordination.

### **9.4 Future Considerations**

Planned enhancements include expanded application database optimization, enhanced performance monitoring, and advanced database management features supporting the evolution toward comprehensive application database services and enterprise-grade data management supporting the growing application database requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all PostgreSQL configurations, application database procedures, and general-purpose database management  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
