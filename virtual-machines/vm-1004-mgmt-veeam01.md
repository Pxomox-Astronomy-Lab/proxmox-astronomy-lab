<---
title: "mgmt-veeam01 - Enterprise Windows Backup Management VM"
type: "enterprise-vm-asset"
domain: "windows-backup-infrastructure"
tech: "veeam-community-edition-windows-backup"
scale: "enterprise-backup-management"
enterprise_context:
  architecture: "CIS v8 Level 1 Baseline VM"
  vm_classification: "Windows backup management platform"
  compliance_framework: "CIS Controls v8 Level 1"
  os_platform: "Windows Server 2025 Standard"
  backup_capacity: "10 endpoint limit (Community Edition)"
--->

# 💾 **mgmt-veeam01 - Enterprise Windows Backup Management VM**

**Asset Classification:** Windows Backup Infrastructure Platform | **Service Tier:** Production | **Location:** node05 - Infrastructure Host

This knowledge base article provides comprehensive virtual machine specifications, backup configuration, and operational procedures for mgmt-veeam01, a Windows Server 2025 Standard enterprise backup management virtual machine baselined to CIS Controls v8 Level 1 standards, serving as the primary Veeam Community Edition backup platform for Windows VM data protection across the 7-node Proxmox astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

mgmt-veeam01 serves as the enterprise Windows backup management platform providing centralized backup orchestration, data protection services, and recovery capabilities through Veeam Backup & Replication Community Edition, supporting comprehensive Windows VM backup operations with 10 endpoint capacity for the astronomy research platform's Windows infrastructure components.

### **1.2 Service Classification**

**Production Tier:** Mission-critical backup infrastructure management platform optimized for enterprise Windows backup workflows, data protection orchestration, and recovery operations supporting Windows VM infrastructure with CIS Controls v8 Level 1 baseline security implementation and centralized backup management capabilities.

### **1.3 Cluster Integration**

Central backup coordination hub enabling comprehensive Windows VM data protection, backup scheduling, and recovery operations across all Windows-based infrastructure components while maintaining enterprise-grade backup standards and integration with hybrid Linux/Windows cluster infrastructure management.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node05 (Intel i5-12600H) | Physical infrastructure foundation |
| **Network Infrastructure** | VLAN 10 (Infrastructure services) | Backup network connectivity |
| **Storage Backend** | nvmethin01 + nvmethin04 pools | Dual-tier backup storage |
| **Security Framework** | CIS Controls v8 Level 1 | Windows security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Network Connectivity** | labswitch02 management layer | Infrastructure VLAN access |
| **DNS Resolution** | Domain DNS infrastructure | Backup target discovery |
| **Time Synchronization** | Windows Time Service | Backup schedule coordination |
| **Storage Infrastructure** | Dual NVMe storage pools | Backup data repository |

### **2.3 Backup Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Veeam Licensing** | Community Edition (10 endpoints) | License compliance |
| **Storage Capacity** | 1TB dedicated backup storage | Backup data repository |
| **Network Access** | Windows VM connectivity | Backup target reachability |
| **Security Baseline** | CIS L1 implementation | Windows security compliance |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 1004 | Windows backup management identifier |
| **Memory** | 8.00 GiB allocated / 16.00 GiB maximum | Optimized for backup workloads |
| **Processors** | 4 vCPU (2 sockets, 2 cores each) | [host] CPU type with NUMA |
| **Machine Type** | pc-q35-9.0 | Enterprise Windows virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-1004-disk-0, 125GB | VirtIO SCSI with discard, iothread, backup=0 |
| **Backup Repository** | scsi1: nvmethin04:vm-1004-disk-0, 1000GB | Dedicated 1TB backup storage |
| **EFI System** | nvmethin01:vm-1004-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-1004-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:EB:E6:90 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=10 | Infrastructure services VLAN |
| **IP Configuration** | 10.25.10.11 (static) | Backup management address |
| **Security Hardening** | Windows Firewall configured | Backup traffic filtering |

### **3.4 Backup Platform Implementation**

| **Backup Component** | **Implementation** | **Capacity** |
|---------------------|-------------------|--------------|
| **Veeam Edition** | Community Edition | 10 endpoint limit |
| **Backup Repository** | 1TB dedicated storage (nvmethin04) | Windows VM backup capacity |
| **Target Scope** | Windows VMs only | Specialized Windows protection |
| **Management Interface** | Veeam Backup & Replication Console | Centralized backup management |

---

## **🔧 4. Management & Operations**

### **4.1 Backup Management Services**

| **Service** | **Function** | **Scope** |
|-------------|--------------|-----------|
| **Veeam Backup & Replication** | Windows VM backup orchestration | Up to 10 Windows endpoints |
| **Backup Repository Management** | 1TB storage allocation | Centralized backup data storage |
| **Recovery Services** | Windows VM restoration | Rapid recovery capabilities |
| **Backup Scheduling** | Automated backup coordination | Enterprise backup workflows |

### **4.2 Windows Backup Infrastructure**

| **Infrastructure Component** | **Status** | **Coverage** |
|-----------------------------|------------|--------------|
| **Veeam Community Edition** | Licensed and operational | 10 endpoint capacity |
| **Backup Repository** | 1TB storage configured | Windows VM data protection |
| **Network Connectivity** | Infrastructure VLAN access | Backup target reachability |
| **Management Console** | Veeam interface active | Centralized backup control |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Backup Execution** | Daily (automated) | Scheduled Windows VM backups |
| **Repository Management** | Weekly | Storage utilization monitoring |
| **Recovery Testing** | Monthly | Backup integrity validation |
| **License Compliance** | Quarterly | Community Edition limits verification |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Backup Status** | Veeam Backup Console | Job execution monitoring |
| **Storage Utilization** | Windows Performance Monitor | Repository capacity tracking |
| **System Performance** | Windows Event Logs | Backup system health |
| **Network Connectivity** | Network monitoring | Backup target accessibility |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 1 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Access Controls** | Windows authentication | ✅ CIS L1 Compliant |
| **Backup Security** | Encrypted backup storage | ✅ Data protection implementation |
| **Network Security** | Windows Firewall configured | ✅ Backup traffic control |
| **Audit & Logging** | Veeam and Windows logging | ✅ Backup operation tracking |
| **Update Management** | Windows Update coordination | ✅ Systematic patch management |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 1, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.1** | **Compliant** | Windows authentication controls | **2025-07-20** |
| **CIS.11.1** | **Compliant** | Veeam backup implementation | **2025-07-20** |
| **CIS.11.3** | **Compliant** | Backup testing procedures | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network security controls | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Backup Platform Protection**

This virtual machine serves as the **primary Windows backup infrastructure** using **Veeam Backup & Replication Community Edition** providing enterprise-grade backup capabilities for Windows VMs with 10 endpoint licensing, centralized backup repository management, and comprehensive Windows VM protection supporting critical infrastructure data protection requirements.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **Windows VM Backups** | Daily at 01:00 | 30 days | Veeam backup jobs |
| **Backup Repository** | 1TB dedicated storage | Rolling retention | nvmethin04 storage pool |
| **System State** | Weekly | 14 days | Windows system backup |
| **Veeam Configuration** | On change | 90 days | Configuration backup |

### **6.3 Backup Coverage**

| **Target Type** | **Endpoint Count** | **Capacity Usage** | **Protection Level** |
|----------------|-------------------|-------------------|---------------------|
| **Windows VMs** | Up to 10 endpoints | Community Edition limit | Full VM backup |
| **Domain Controllers** | Active Directory protection | Critical infrastructure | System state + VM backup |
| **Windows Services** | Application-aware backup | Service-specific protection | Consistent backup |

---

## **📚 7. References & Documentation**

### **7.1 Backup Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Veeam Best Practices** | Community Edition deployment | [Veeam Documentation](https://www.veeam.com/documentation-guides-datasheets.html) |
| **CIS Controls v8 Level 1** | Windows backup security | [CIS Benchmarks](https://www.cisecurity.org/) |
| **Windows Backup Security** | Enterprise backup hardening | [Microsoft Backup Security](https://docs.microsoft.com/backup) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node05](../hardware/node05-12600h-infrastructure-node.md)** | Physical host platform | Infrastructure foundation |
| **[radio-dc01](radio-dc01.md)** | Primary backup target | Windows domain controller |
| **[Windows Infrastructure](../infrastructure/windows/)** | Service coordination | Enterprise Windows stack |

---

## **✅ 8. Validation & Testing**

### **8.1 Backup Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Veeam Functionality** | Backup job execution testing | Successful Windows VM backups |
| **Repository Access** | Storage connectivity validation | 1TB backup storage accessible |
| **Recovery Testing** | VM restoration procedures | Complete Windows VM recovery |
| **License Compliance** | Endpoint count verification | Within 10 endpoint limit |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L1 Compliance** | Windows security auditing | Baseline compliance verification |
| **Backup Security** | Encrypted storage validation | Protected backup data |
| **Access Control** | Authentication testing | Restricted backup management access |
| **Network Security** | Firewall rule validation | Proper backup traffic filtering |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

mgmt-veeam01 represents a comprehensive enterprise Windows backup management platform implementing Veeam Backup & Replication Community Edition with CIS Controls v8 Level 1 security standards on Windows Server 2025 Standard, providing centralized Windows VM backup capabilities with 10 endpoint capacity supporting critical infrastructure data protection for the hybrid astronomy research cluster.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Windows VM Backup** | Veeam Community Edition | Centralized Windows data protection |
| **Backup Repository** | 1TB dedicated storage | Comprehensive backup capacity |
| **Security Compliance** | CIS L1 baseline implementation | Enterprise-grade backup security |
| **Recovery Operations** | Rapid VM restoration | Business continuity assurance |

### **9.3 Operational Impact**

This virtual machine serves as the critical Windows backup infrastructure foundation enabling comprehensive Windows VM data protection, centralized backup management, and rapid recovery capabilities across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential data protection services for Windows-based infrastructure components.

### **9.4 Future Considerations**

Planned enhancements include backup optimization procedures, enhanced monitoring integration, and potential backup capacity expansion supporting the evolution toward comprehensive Windows infrastructure protection and enterprise-grade backup operations supporting the growing Windows backup requirements of the astronomy platform within Community Edition licensing constraints.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all Veeam configurations, backup procedures, and licensing compliance  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
