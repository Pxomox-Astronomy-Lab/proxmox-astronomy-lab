<---
title: "radio-dc01 - Enterprise Windows Domain Controller VM"
type: "enterprise-vm-asset"
domain: "windows-infrastructure-management"
tech: "windows-server-2025-domain-controller"
scale: "enterprise-infrastructure-management"
enterprise_context:
  architecture: "CIS v8 Level 1 Baseline VM"
  vm_classification: "Windows domain controller"
  compliance_framework: "CIS Controls v8 Level 1"
  os_platform: "Windows Server 2025 Standard"
--->

# 🖥️ **radio-dc01 - Enterprise Windows Domain Controller VM**

**Asset Classification:** Windows Infrastructure Management Platform | **Service Tier:** Production | **Location:** node01 - Compute Host

This knowledge base article provides comprehensive virtual machine specifications, security configuration, and operational procedures for radio-dc01, a Windows Server 2025 Standard enterprise domain controller virtual machine baselined to CIS Controls v8 Level 1 standards, serving as the primary Active Directory domain services platform for the 7-node Proxmox astronomy research cluster infrastructure management.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

radio-dc01 serves as the enterprise Windows domain controller providing centralized Active Directory domain services, authentication infrastructure, group policy management, and Windows-based infrastructure coordination supporting hybrid infrastructure management, user authentication, and enterprise Windows services integration for the astronomy research platform.

### **1.2 Service Classification**

**Production Tier:** Mission-critical Windows infrastructure management platform optimized for enterprise Active Directory services, centralized authentication, group policy enforcement, and Windows infrastructure coordination supporting hybrid Linux/Windows cluster management with CIS Controls v8 Level 1 baseline security implementation.

### **1.3 Cluster Integration**

Primary Windows infrastructure hub enabling centralized user authentication, Windows service coordination, and enterprise directory services supporting hybrid infrastructure management across Linux and Windows systems while maintaining integration with existing enterprise identity and access management frameworks.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node01 (Intel i5-12600H) | Physical compute foundation |
| **Network Infrastructure** | VLAN 10 (Infrastructure services) | Management network connectivity |
| **Storage Backend** | local-lvm storage pool | VM storage infrastructure |
| **Security Framework** | CIS Controls v8 Level 1 | Windows security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Network Connectivity** | labswitch02 management layer | Infrastructure VLAN access |
| **DNS Infrastructure** | Domain DNS services | Active Directory DNS integration |
| **Time Synchronization** | Windows Time Service | Domain time coordination |
| **Security Monitoring** | Windows security framework | Enterprise monitoring integration |

### **2.3 Management Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Remote Access** | RDP secured access | Windows remote management |
| **Domain Services** | Active Directory configured | Enterprise directory services |
| **Security Baseline** | CIS L1 implementation | Windows security compliance |
| **Backup Integration** | veeam01 Windows backup | Enterprise data protection |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 1003 | Windows domain controller identifier |
| **Memory** | 2.00 GiB allocated / 6.00 GiB maximum | Optimized for domain controller workloads |
| **Processors** | 2 vCPU (2 sockets, 1 core each) | [host] CPU type with NUMA |
| **Machine Type** | pc-i440fx-9.0 | Windows-compatible virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **Primary Disk** | scsi0: local-lvm:vm-1003-disk-1, 125GB | VirtIO SCSI with discard, iothread |
| **EFI System** | local-lvm:vm-1003-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | local-lvm:vm-1003-disk-2, 4MB | TPM v2.0 hardware security module |
| **Controller** | VirtIO SCSI single | High-performance storage interface |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:8C:74:21 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=10 | Infrastructure services VLAN |
| **IP Configuration** | 10.25.10.2 (static) | Domain controller address |
| **Security Hardening** | Windows Firewall active | Network traffic filtering |

### **3.4 Security Implementation**

| **Security Layer** | **Implementation** | **Compliance** |
|-------------------|-------------------|----------------|
| **BIOS Security** | OVMF (UEFI) with Secure Boot | Hardware security foundation |
| **OS Baseline** | Windows Server 2025 CIS L1 | Enterprise security standards |
| **Domain Security** | Active Directory security policies | Centralized security management |
| **Access Control** | Domain-based authentication | Enterprise identity management |

---

## **🔧 4. Management & Operations**

### **4.1 Domain Controller Services**

| **Service** | **Function** | **Scope** |
|-------------|--------------|-----------|
| **Active Directory** | Centralized directory services | Enterprise user and computer management |
| **DNS Services** | Domain name resolution | Infrastructure DNS coordination |
| **Group Policy** | Centralized policy management | Windows security and configuration |
| **Authentication** | Domain authentication services | Enterprise identity validation |

### **4.2 Windows Infrastructure Services**

| **Infrastructure Component** | **Status** | **Coverage** |
|-----------------------------|------------|--------------|
| **Domain Controller** | Primary DC operational | Complete domain services |
| **DNS Server** | Integrated AD DNS | Domain name resolution |
| **Group Policy Management** | Policy enforcement active | Windows infrastructure coordination |
| **Certificate Services** | Domain PKI infrastructure | Enterprise certificate management |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Security Updates** | Monthly | Windows Update coordination |
| **Active Directory Health** | Daily | Domain controller monitoring |
| **Group Policy Updates** | As needed | Policy deployment and validation |
| **Backup Validation** | Weekly | veeam01 backup verification |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Domain Services** | Windows Event Logs | Active Directory health |
| **System Performance** | Windows Performance Monitor | Resource utilization |
| **Security Events** | Windows Security Auditing | Domain security monitoring |
| **Service Health** | Windows Service Management | Critical service validation |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 1 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Access Controls** | Domain-based authentication | ✅ CIS L1 Compliant |
| **Windows Security** | Security policy enforcement | ✅ Domain policy implementation |
| **Update Management** | Windows Update coordination | ✅ Systematic patch management |
| **Audit & Logging** | Windows security auditing | ✅ Event log monitoring |
| **Network Security** | Windows Firewall configured | ✅ Network traffic control |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 1, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Domain authentication policies | **2025-07-20** |
| **CIS.4.1** | **Compliant** | Windows Update management | **2025-07-20** |
| **CIS.6.1** | **Compliant** | Windows security auditing | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network security controls | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Windows VM Protection**

This virtual machine is protected through integration with **veeam01** (Windows-based backup infrastructure) providing enterprise-grade backup and recovery capabilities specifically designed for Windows Server environments with Active Directory-aware backup procedures ensuring domain controller consistency and rapid recovery supporting critical infrastructure services.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **System State Backup** | Daily at 02:00 | 30 days | veeam01 Windows backup |
| **Active Directory** | Real-time replication | Continuous | Domain controller replication |
| **Group Policy Objects** | Weekly | 90 days | GPO backup procedures |
| **System Configuration** | Weekly | 30 days | Windows system backup |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <45 minutes | <24 hours | veeam01 full restoration |
| **Active Directory Recovery** | <30 minutes | <8 hours | System state restoration |
| **Group Policy Recovery** | <15 minutes | <7 days | GPO backup restoration |
| **System Configuration** | <60 minutes | <24 hours | Windows system restore |

---

## **📚 7. References & Documentation**

### **7.1 Windows Security Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **CIS Controls v8 Level 1** | Windows baseline | [CIS Benchmarks](https://www.cisecurity.org/) |
| **Microsoft Security Baseline** | Windows Server 2025 | [Microsoft Security](https://docs.microsoft.com/security) |
| **Active Directory Security** | Domain hardening | [AD Security Documentation](https://docs.microsoft.com/windows-server/identity) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node01](../hardware/node01-12600h-compute-node.md)** | Physical host platform | Compute foundation |
| **[veeam01](../infrastructure/backup/veeam01.md)** | Windows backup services | Data protection |
| **[Windows Infrastructure](../infrastructure/windows/)** | Service coordination | Enterprise Windows stack |

---

## **✅ 8. Validation & Testing**

### **8.1 Domain Controller Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Active Directory Health** | dcdiag comprehensive testing | All tests passing |
| **DNS Resolution** | nslookup domain queries | Proper name resolution |
| **Authentication** | Domain logon testing | Successful user authentication |
| **Group Policy** | gpresult policy verification | Policy application validation |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L1 Compliance** | Security policy auditing | Baseline compliance verification |
| **Network Security** | Windows Firewall testing | Proper traffic filtering |
| **Access Control** | Permission validation | Restricted administrative access |
| **Backup Integration** | veeam01 backup testing | Successful data protection |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

radio-dc01 represents a comprehensive enterprise Windows domain controller implementing CIS Controls v8 Level 1 security standards on Windows Server 2025 Standard, providing centralized Active Directory services, authentication infrastructure, and Windows-based management capabilities supporting the hybrid Linux/Windows astronomy research cluster with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Domain Services** | Active Directory infrastructure | Centralized identity management |
| **Security Compliance** | CIS L1 baseline implementation | Enterprise-grade Windows protection |
| **Infrastructure Integration** | Hybrid Linux/Windows coordination | Complete enterprise management |
| **Data Protection** | veeam01 backup integration | Comprehensive Windows recovery capabilities |

### **9.3 Operational Impact**

This virtual machine serves as the critical Windows infrastructure foundation enabling centralized user authentication, group policy management, and Windows service coordination across the enterprise astronomy research platform while maintaining enterprise security standards and providing seamless integration with Linux-based infrastructure components.

### **9.4 Future Considerations**

Planned enhancements include expanded Active Directory integration, enhanced Windows security monitoring, and advanced group policy management supporting the evolution toward comprehensive hybrid infrastructure management and enterprise-grade identity services supporting the growing Windows infrastructure requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all technical specifications, security implementations, and operational procedures  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
