<---
title: "radio-dc02 - Enterprise Read-Only Domain Controller VM"
type: "enterprise-vm-asset"
domain: "windows-infrastructure-rodc"
tech: "windows-server-2025-rodc-vlan20"
scale: "enterprise-domain-services"
enterprise_context:
  architecture: "CIS v8 Level 1 Baseline VM"
  vm_classification: "Read-Only Domain Controller"
  compliance_framework: "CIS Controls v8 Level 1"
  os_platform: "Windows Server 2025 Standard"
  domain_role: "RODC for VLAN 20 project workloads"
--->

# 🖥️ **radio-dc02 - Enterprise Read-Only Domain Controller VM**

**Asset Classification:** Read-Only Domain Controller Platform | **Service Tier:** Production | **Location:** node03 - Infrastructure Host

This knowledge base article provides comprehensive virtual machine specifications, domain controller configuration, and operational procedures for radio-dc02, a Windows Server 2025 Standard enterprise Read-Only Domain Controller (RODC) virtual machine baselined to CIS Controls v8 Level 1 standards, serving as the dedicated domain services platform for VLAN 20 project workloads supporting distributed authentication and domain services across the 7-node Proxmox astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

radio-dc02 serves as the enterprise Read-Only Domain Controller providing distributed Active Directory domain services, authentication infrastructure, and read-only directory services specifically for VLAN 20 project workloads, supporting secure domain authentication, group policy distribution, and Windows infrastructure coordination for research computing environments while maintaining security through read-only operations.

### **1.2 Service Classification**

**Production Tier:** Mission-critical distributed domain controller platform optimized for read-only Active Directory services, project workload authentication, VLAN 20 domain coordination, and secure Windows infrastructure support with CIS Controls v8 Level 1 baseline security implementation and RODC security architecture.

### **1.3 Cluster Integration**

Distributed domain services hub enabling secure authentication for VLAN 20 project workloads, read-only directory services, and Windows infrastructure coordination supporting research computing authentication while maintaining security through limited write capabilities and seamless integration with primary domain controller radio-dc01.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node03 (Intel i5-12600H) | Physical infrastructure foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Project domain services connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | RODC storage infrastructure |
| **Security Framework** | CIS Controls v8 Level 1 | Windows security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Primary Domain Controller** | radio-dc01 (VLAN 10) | Active Directory replication |
| **Network Connectivity** | labswitch02 management layer | Project VLAN access |
| **DNS Infrastructure** | Domain DNS services | RODC DNS integration |
| **Time Synchronization** | Windows Time Service | Domain time coordination |

### **2.3 RODC Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **RODC Configuration** | Read-Only Domain Controller setup | Distributed authentication |
| **Domain Replication** | radio-dc01 synchronization | Active Directory coordination |
| **Security Baseline** | CIS L1 implementation | Windows security compliance |
| **Project VLAN Access** | VLAN 20 connectivity | Project workload authentication |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2003 | Read-Only Domain Controller identifier |
| **Memory** | 2.00 GiB allocated / 6.00 GiB maximum | Optimized for RODC workloads |
| **Processors** | 2 vCPU (2 sockets, 1 core each) | [host] CPU type with NUMA |
| **Machine Type** | pc-i440fx-9.0 | Windows-compatible virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **Primary Disk** | scsi0: nvmethin01:vm-2003-disk-4, 125GB | VirtIO SCSI with discard, raw format, iothread |
| **EFI System** | nvmethin01:vm-2003-disk-3, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2003-disk-5, 4MB | TPM v2.0 hardware security module |
| **Controller** | VirtIO SCSI single | High-performance storage interface |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:4F:DE:D1 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.2 (static) | RODC address for project VLAN |
| **Security Hardening** | Windows Firewall active | Domain traffic filtering |

### **3.4 RODC Implementation**

| **RODC Component** | **Implementation** | **Security** |
|-------------------|-------------------|--------------|
| **Read-Only Operations** | Limited write capabilities | Enhanced security posture |
| **Domain Replication** | radio-dc01 synchronization | Active Directory coordination |
| **Authentication Caching** | Project user credential caching | Performance optimization |
| **VLAN 20 Services** | Project workload domain services | Dedicated project authentication |

---

## **🔧 4. Management & Operations**

### **4.1 Read-Only Domain Controller Services**

| **Service** | **Function** | **Scope** |
|-------------|--------------|-----------|
| **RODC Authentication** | Read-only domain authentication | VLAN 20 project workloads |
| **DNS Services** | Project VLAN name resolution | Domain name coordination |
| **Group Policy Distribution** | Read-only policy enforcement | Project security policies |
| **Domain Replication** | Active Directory synchronization | Primary DC coordination |

### **4.2 Project VLAN Services**

| **Infrastructure Component** | **Status** | **Coverage** |
|-----------------------------|------------|--------------|
| **Read-Only Domain Controller** | RODC operational | VLAN 20 authentication services |
| **DNS Server** | Integrated AD DNS | Project workload name resolution |
| **Group Policy** | Read-only policy distribution | Project security coordination |
| **Credential Caching** | User authentication optimization | Performance enhancement |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Domain Replication Monitoring** | Continuous | radio-dc01 synchronization validation |
| **RODC Health Validation** | Daily | Domain controller status verification |
| **Security Updates** | Monthly | Windows Update coordination |
| **Performance Monitoring** | Continuous | VLAN 20 authentication performance |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Domain Services** | Windows Event Logs | RODC health and replication |
| **Authentication Performance** | Windows Performance Monitor | Project workload authentication |
| **Replication Status** | Active Directory monitoring | Domain synchronization |
| **VLAN 20 Services** | Network and domain monitoring | Project infrastructure health |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 1 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **RODC Security** | Read-only domain controller hardening | ✅ CIS L1 RODC implementation |
| **Access Controls** | Domain-based authentication with RODC limitations | ✅ CIS L1 Compliant |
| **Network Security** | Windows Firewall + VLAN segmentation | ✅ Layered security controls |
| **Audit & Logging** | Windows security auditing + RODC monitoring | ✅ Complete event tracking |
| **Update Management** | Windows Update coordination | ✅ Systematic patch management |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 1, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | RODC authentication policies | **2025-07-20** |
| **CIS.4.1** | **Compliant** | Windows Update management | **2025-07-20** |
| **CIS.6.1** | **Compliant** | RODC security auditing | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network security controls | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 RODC Platform Protection**

This virtual machine is protected through integration with **veeam01** (Windows-based backup infrastructure) providing enterprise-grade backup and recovery capabilities specifically designed for Read-Only Domain Controller environments with Active Directory-aware backup procedures ensuring RODC consistency, domain replication integrity, and rapid recovery supporting critical project authentication services.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **System State Backup** | Daily at 02:30 | 30 days | veeam01 Windows backup |
| **RODC Database** | Real-time replication | Continuous | Domain controller replication |
| **DNS Zone Data** | Weekly | 90 days | DNS backup procedures |
| **System Configuration** | Weekly | 30 days | Windows system backup |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <45 minutes | <24 hours | veeam01 full restoration |
| **RODC Recovery** | <30 minutes | <8 hours | System state restoration + replication |
| **DNS Recovery** | <15 minutes | <7 days | DNS zone restoration |
| **Domain Resynchronization** | <60 minutes | <24 hours | Active Directory replication reset |

---

## **📚 7. References & Documentation**

### **7.1 RODC Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Microsoft RODC Documentation** | Read-Only Domain Controller deployment | [Microsoft RODC Guide](https://docs.microsoft.com/windows-server/identity/ad-ds/deploy/rodc) |
| **CIS Controls v8 Level 1** | Windows baseline | [CIS Benchmarks](https://www.cisecurity.org/) |
| **Active Directory Security** | Domain hardening | [AD Security Documentation](https://docs.microsoft.com/windows-server/identity) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node03](../hardware/node03-12600h-service-node.md)** | Physical host platform | Infrastructure foundation |
| **[radio-dc01](radio-dc01.md)** | Primary domain controller | Active Directory coordination |
| **[veeam01](../infrastructure/backup/veeam01.md)** | Windows backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 RODC Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **RODC Functionality** | Domain controller testing | Proper read-only operations |
| **Domain Replication** | radio-dc01 synchronization validation | Successful Active Directory replication |
| **VLAN 20 Authentication** | Project workload logon testing | Successful user authentication |
| **DNS Resolution** | Project VLAN name resolution testing | Proper domain name services |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L1 Compliance** | Security policy auditing | Baseline compliance verification |
| **RODC Security** | Read-only validation | Limited write capabilities confirmed |
| **Network Security** | Windows Firewall testing | Proper traffic filtering |
| **Access Control** | Authentication testing | Restricted administrative access |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

radio-dc02 represents a comprehensive enterprise Read-Only Domain Controller implementing CIS Controls v8 Level 1 security standards on Windows Server 2025 Standard, providing distributed Active Directory services, project workload authentication, and secure domain coordination for VLAN 20 research computing environments with enhanced security through read-only operations and seamless integration with primary domain infrastructure.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **RODC Services** | Read-Only Domain Controller | Enhanced security distributed authentication |
| **Project VLAN Authentication** | VLAN 20 domain services | Dedicated project workload support |
| **Security Enhancement** | Read-only operations | Reduced attack surface |
| **Domain Integration** | radio-dc01 coordination | Seamless Active Directory services |

### **9.3 Operational Impact**

This virtual machine serves as the critical distributed domain services foundation enabling secure authentication for VLAN 20 project workloads, read-only directory services, and Windows infrastructure coordination across the enterprise astronomy research platform while maintaining enhanced security standards through RODC architecture and providing essential distributed authentication capabilities for research computing environments.

### **9.4 Future Considerations**

Planned enhancements include expanded RODC optimization, enhanced replication monitoring, and advanced project workload authentication supporting the evolution toward comprehensive distributed domain services and enterprise-grade Windows authentication supporting the growing project authentication requirements of the astronomy platform with enhanced security posture.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all RODC configurations, domain controller procedures, and Active Directory integration  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
