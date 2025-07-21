<---
title: "proj-fs02 - Enterprise Scale-Out File Server VM"
type: "enterprise-vm-asset"
domain: "windows-file-services"
tech: "windows-server-2025-scale-out-file-server"
scale: "enterprise-file-services"
enterprise_context:
  architecture: "CIS v8 Level 1 Baseline VM"
  vm_classification: "Scale-out file server"
  compliance_framework: "CIS Controls v8 Level 1"
  os_platform: "Windows Server 2025 Standard"
  file_services: "SMB and NFS shares with clustering support"
--->

# 📁 **proj-fs02 - Enterprise Scale-Out File Server VM**

**Asset Classification:** Scale-Out File Server Platform | **Service Tier:** Production | **Location:** node05 - Infrastructure Host

This knowledge base article provides comprehensive virtual machine specifications, file services configuration, and operational procedures for proj-fs02, a Windows Server 2025 Standard enterprise scale-out file server virtual machine baselined to CIS Controls v8 Level 1 standards, serving as the primary distributed file services platform providing SMB and NFS shares for drive mounts, home folders, and distributed file access with clustering coordination alongside proj-fs04 across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-fs02 serves as the enterprise scale-out file server providing distributed file services through SMB and NFS protocols, supporting network drive mounts, user home directories, shared file storage, and distributed file access with clustering coordination alongside proj-fs04 for enhanced reliability and performance in file service delivery.

### **1.2 Service Classification**

**Production Tier:** Mission-critical file services platform optimized for distributed file sharing, network storage access, home directory services, and scale-out file clustering supporting enterprise file workflows with CIS Controls v8 Level 1 baseline security implementation and Windows Server 2025 file services architecture.

### **1.3 Cluster Integration**

Primary file services hub enabling distributed file sharing, network drive access, and home directory services while maintaining enterprise-grade security standards and seamless integration with proj-fs04 for clustered file services, authentication systems, and distributed storage coordination.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node05 (Intel i5-12600H) | Physical infrastructure foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | File services network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | File server storage |
| **Security Framework** | CIS Controls v8 Level 1 | Windows security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Domain Services** | radio-dc02 RODC authentication | File services authentication |
| **Clustering Partner** | proj-fs04 scale-out coordination | Distributed file services |
| **Network Connectivity** | labswitch02 management layer | Project VLAN access |
| **Backup Services** | veeam01 Windows backup | File services data protection |

### **2.3 File Services Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **File Services Role** | Windows Server file and storage services | SMB and NFS protocols |
| **Scale-Out Clustering** | Distributed file services coordination | Enhanced reliability |
| **Security Baseline** | CIS L1 implementation | Windows security compliance |
| **Storage Allocation** | 275GB total file storage | Network shares and home directories |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2011 | Scale-out file server identifier |
| **Memory** | 2.00 GiB allocated / 6.00 GiB maximum | Optimized for file services workloads |
| **Processors** | 4 vCPU (2 sockets, 2 cores each) | [host] CPU type with NUMA |
| **Machine Type** | pc-i440fx-9.0 | Windows-compatible virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2011-disk-1, 125GB | VirtIO SCSI with discard, raw format, iothread |
| **File Storage** | scsi1: nvmethin01:vm-2011-disk-3, 150GB | Dedicated file services storage |
| **EFI System** | nvmethin01:vm-2011-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2011-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:09:71:9D | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.20 (static) | File server address |
| **Security Hardening** | Windows Firewall configured | File services traffic filtering |

### **3.4 File Services Implementation**

| **File Services Component** | **Implementation** | **Protocols** |
|----------------------------|-------------------|---------------|
| **SMB Shares** | Windows file sharing | Network drive mounts |
| **NFS Services** | Network File System | Cross-platform file access |
| **Home Directories** | User home folder services | Personal file storage |
| **Scale-Out Clustering** | Distributed file services | Enhanced reliability with proj-fs04 |

---

## **🔧 4. Management & Operations**

### **4.1 File Services Platform**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **SMB File Shares** | Windows network file sharing | Drive mounts and shared folders |
| **NFS Services** | Cross-platform file access | Linux/Unix file system integration |
| **Home Directories** | User personal storage | Individual file spaces |
| **Distributed Access** | Scale-out file clustering | Enhanced performance and reliability |

### **4.2 File Server Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **File and Storage Services** | Windows Server role | File sharing infrastructure |
| **SMB Protocol** | Network file sharing | Windows-based file access |
| **NFS Protocol** | Cross-platform sharing | Multi-platform file services |
| **Clustering Services** | Scale-out coordination | Distributed file services with proj-fs04 |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **File Services Health Monitoring** | Continuous | SMB and NFS service validation |
| **Storage Capacity Management** | Weekly | File share utilization tracking |
| **Clustering Coordination** | Daily | Scale-out cluster health validation |
| **User Access Management** | As needed | Home directory and share permissions |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **File Services Performance** | Windows Performance Monitor | SMB and NFS performance |
| **Storage Utilization** | File share monitoring | Capacity and usage tracking |
| **Clustering Health** | Scale-out cluster monitoring | Distributed services coordination |
| **User Access** | File access auditing | Share and directory usage |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 1 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **File Services Security** | SMB and NFS security hardening | ✅ CIS L1 file services implementation |
| **Access Controls** | Domain-based file permissions | ✅ CIS L1 Compliant |
| **Network Security** | Windows Firewall + file protocol filtering | ✅ Layered security controls |
| **Audit & Logging** | File access auditing | ✅ Complete file access tracking |
| **Update Management** | Windows Update coordination | ✅ Systematic patch management |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 1, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | File services access controls | **2025-07-20** |
| **CIS.4.1** | **Compliant** | Windows Update management | **2025-07-20** |
| **CIS.6.1** | **Compliant** | File access auditing | **2025-07-20** |
| **CIS.13.1** | **Compliant** | File data protection | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 File Services Platform Protection**

This virtual machine is protected through integration with **veeam01** (Windows-based backup infrastructure) providing enterprise-grade backup and recovery capabilities specifically designed for Windows file services environments with file-aware backup procedures ensuring file share consistency, home directory preservation, and rapid recovery supporting critical file services continuity.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **System State Backup** | Daily at 04:00 | 30 days | veeam01 Windows backup |
| **File Shares** | Real-time file replication | Continuous | Scale-out clustering |
| **Home Directories** | Daily backup | 60 days | User data protection |
| **File Services Configuration** | Weekly backup | 90 days | Service configuration preservation |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | veeam01 full restoration |
| **File Services Recovery** | <45 minutes | <8 hours | File and storage services restoration |
| **Share Recovery** | <30 minutes | <24 hours | File share restoration |
| **Cluster Rejoin** | <60 minutes | <4 hours | Scale-out cluster coordination |

---

## **📚 7. References & Documentation**

### **7.1 File Services Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Microsoft File Services Documentation** | Windows file and storage services | [Microsoft File Services Guide](https://docs.microsoft.com/windows-server/storage) |
| **Scale-Out File Server Documentation** | Clustered file services | [Microsoft Clustering Documentation](https://docs.microsoft.com/windows-server/failover-clustering) |
| **CIS Controls v8 Level 1** | Windows baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node05](../hardware/node05-12600h-infrastructure-node.md)** | Physical host platform | Infrastructure foundation |
| **[proj-fs04](proj-fs04.md)** | Clustering partner | Scale-out file services coordination |
| **[veeam01](../infrastructure/backup/veeam01.md)** | Windows backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 File Services Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **SMB Functionality** | Network file share testing | Successful file access |
| **NFS Services** | Cross-platform file access testing | Multi-protocol file sharing |
| **Home Directories** | User folder access validation | Personal storage functionality |
| **Clustering Coordination** | Scale-out cluster testing | Distributed file services |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L1 Compliance** | Security policy auditing | Baseline compliance verification |
| **File Services Security** | SMB and NFS security validation | Secure file sharing |
| **Access Control** | File permission testing | Restricted file access |
| **Network Security** | File protocol security testing | Proper traffic filtering |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-fs02 represents a comprehensive enterprise scale-out file server implementing Windows Server 2025 file and storage services with CIS Controls v8 Level 1 security standards, providing SMB and NFS file sharing, home directory services, and distributed file access coordination with proj-fs04 for enhanced reliability and performance supporting enterprise file workflows with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Multi-Protocol File Sharing** | SMB and NFS services | Comprehensive file access |
| **Home Directory Services** | User personal storage | Individual file management |
| **Scale-Out Clustering** | Distributed file services | Enhanced reliability and performance |
| **Cross-Platform Access** | Windows and Linux/Unix support | Universal file sharing |

### **9.3 Operational Impact**

This virtual machine serves as the critical file services foundation enabling distributed file sharing, network drive access, and home directory services across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential file services capabilities for user data management and collaborative file access.

### **9.4 Future Considerations**

Planned enhancements include expanded file services optimization, enhanced clustering capabilities, and advanced file management features supporting the evolution toward comprehensive distributed file services and enterprise-grade file sharing supporting the growing file storage requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all file services configurations, clustering procedures, and Windows Server implementations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
