<---
title: "proj-rds01 - Enterprise Remote Desktop Services VM"
type: "enterprise-vm-asset"
domain: "windows-remote-desktop-services"
tech: "windows-server-2025-rds-l3-engineering"
scale: "enterprise-remote-desktop-services"
enterprise_context:
  architecture: "CIS v8 Level 1 Baseline VM"
  vm_classification: "Remote Desktop Services platform"
  compliance_framework: "CIS Controls v8 Level 1"
  os_platform: "Windows Server 2025 Standard"
  user_scope: "L3 engineers and power staff"
--->

# 🖥️ **proj-rds01 - Enterprise Remote Desktop Services VM**

**Asset Classification:** Remote Desktop Services Platform | **Service Tier:** Production | **Location:** node04 - Database Flagship Host

This knowledge base article provides comprehensive virtual machine specifications, RDS configuration, and operational procedures for proj-rds01, a Windows Server 2025 Standard enterprise Remote Desktop Services virtual machine baselined to CIS Controls v8 Level 1 standards, serving as the specialized remote desktop platform for L3 engineers and power staff requiring maximum flexibility with enterprise utility applications including HeidiSQL and advanced engineering tools.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-rds01 serves as the enterprise Remote Desktop Services platform providing high-privilege remote desktop access for L3 engineers and power staff requiring maximum operational flexibility, advanced engineering tools including HeidiSQL database management, specialized utility applications, and elevated access capabilities supporting critical infrastructure engineering and advanced technical operations.

### **1.2 Service Classification**

**Production Tier:** Mission-critical remote desktop platform optimized for L3 engineering workflows, power user operations, advanced utility applications, and high-privilege technical access supporting enterprise infrastructure engineering with CIS Controls v8 Level 1 baseline security implementation and RDS architecture for elevated access requirements.

### **1.3 Cluster Integration**

Specialized engineering access hub enabling high-privilege remote desktop services, advanced engineering tool access, and power user operations while maintaining enterprise-grade security standards and providing controlled elevated access for L3 engineers and infrastructure specialists requiring maximum operational flexibility.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node04 (Intel i9-12900H) | Database flagship foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | RDS network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance RDS storage |
| **Security Framework** | CIS Controls v8 Level 1 | Windows security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Domain Services** | radio-dc02 RODC authentication | Secure L3 user authentication |
| **Database Access** | proj-pg01 PostgreSQL platform | Engineering database connectivity |
| **Network Security** | Firewall and VLAN isolation | Secure RDS access |
| **Backup Services** | veeam01 Windows backup | RDS data protection |

### **2.3 RDS Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Remote Desktop Services** | Windows RDS configuration | L3 engineer remote access |
| **Engineering Tools** | HeidiSQL and utility applications | Advanced tool availability |
| **Security Baseline** | CIS L1 implementation | Windows security compliance |
| **Elevated Access** | Power user capabilities | L3 operational flexibility |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2006 | RDS platform identifier |
| **Memory** | 4.00 GiB allocated / 16.00 GiB maximum | Optimized for RDS workloads |
| **Processors** | 6 vCPU (2 sockets, 3 cores each) | [host] CPU type with NUMA |
| **Machine Type** | pc-i440fx-9.0 | Windows-compatible virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **Primary Disk** | scsi0: nvmethin01:vm-2006-disk-1, 125GB | VirtIO SCSI with discard, iothread |
| **EFI System** | nvmethin01:vm-2006-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2006-disk-2, 4MB | TPM v2.0 hardware security module |
| **Controller** | VirtIO SCSI single | High-performance storage interface |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:EC:A8:99 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.6 (static) | RDS platform address |
| **Security Hardening** | Windows Firewall configured | RDS traffic filtering |

### **3.4 RDS Implementation**

| **RDS Component** | **Implementation** | **Access Control** |
|------------------|-------------------|-------------------|
| **Remote Desktop Services** | Windows RDS role | L3 engineer access |
| **Engineering Applications** | HeidiSQL, utility tools | Advanced tool availability |
| **Session Management** | RDS session control | Power user session management |
| **Authentication** | Domain-based access | Controlled L3 access |

---

## **🔧 4. Management & Operations**

### **4.1 RDS Platform Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **Remote Desktop Access** | L3 engineer remote sessions | High-privilege access |
| **Engineering Tools** | HeidiSQL and advanced utilities | Database and system management |
| **Session Management** | RDS session coordination | Power user operations |
| **Application Delivery** | Utility application access | Specialized tool availability |

### **4.2 Engineering Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **RDS Role** | Windows Remote Desktop Services | L3 remote access delivery |
| **Engineering Applications** | Specialized utility tools | Advanced engineering capabilities |
| **Database Tools** | HeidiSQL and management utilities | Database administration |
| **Session Control** | RDS session management | Power user coordination |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **RDS Performance Monitoring** | Continuous | Session performance optimization |
| **Application Management** | Weekly | Engineering tool updates |
| **User Access Review** | Monthly | L3 access validation |
| **Security Updates** | Monthly | Windows RDS updates |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **RDS Performance** | Windows Performance Monitor | Session delivery efficiency |
| **Application Health** | Engineering tool monitoring | Utility application availability |
| **Security Events** | Windows Event Logs | RDS access monitoring |
| **Resource Utilization** | System performance monitoring | RDS platform optimization |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 1 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **RDS Security** | Remote Desktop Services hardening | ✅ CIS L1 RDS implementation |
| **Access Controls** | L3 engineer authentication | ✅ CIS L1 Compliant |
| **Session Security** | RDS session management | ✅ Secure remote access |
| **Network Security** | Windows Firewall + VLAN segmentation | ✅ Layered security controls |
| **Application Security** | Engineering tool access control | ✅ Controlled utility access |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 1, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | RDS access controls | **2025-07-20** |
| **CIS.4.1** | **Compliant** | Windows Update management | **2025-07-20** |
| **CIS.6.1** | **Compliant** | RDS security auditing | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network security controls | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 RDS Platform Protection**

This virtual machine is protected through integration with **veeam01** (Windows-based backup infrastructure) providing enterprise-grade backup and recovery capabilities specifically designed for Remote Desktop Services environments with RDS-aware backup procedures ensuring session state preservation, application configuration retention, and rapid recovery supporting critical L3 engineering access continuity.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **System State Backup** | Daily at 03:30 | 30 days | veeam01 Windows backup |
| **RDS Configuration** | Real-time persistence | Continuous | RDS role configuration |
| **Engineering Applications** | Weekly backup | 90 days | Application configuration preservation |
| **User Profile Data** | Weekly backup | 30 days | L3 user data protection |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | veeam01 full restoration |
| **RDS Service Recovery** | <45 minutes | <8 hours | RDS role restoration |
| **Application Recovery** | <30 minutes | <7 days | Engineering tool restoration |
| **Configuration Recovery** | <20 minutes | <24 hours | RDS configuration restoration |

---

## **📚 7. References & Documentation**

### **7.1 RDS Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Microsoft RDS Documentation** | Remote Desktop Services deployment | [Microsoft RDS Guide](https://docs.microsoft.com/windows-server/remote/remote-desktop-services) |
| **CIS Controls v8 Level 1** | Windows baseline | [CIS Benchmarks](https://www.cisecurity.org/) |
| **Windows Security Guide** | RDS hardening | [Microsoft Security Documentation](https://docs.microsoft.com/security) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node04](../hardware/node04-minisforum-ms-a1-12900h.md)** | Physical host platform | Database flagship foundation |
| **[radio-dc02](radio-dc02.md)** | Domain authentication | RODC services |
| **[veeam01](../infrastructure/backup/veeam01.md)** | Windows backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 RDS Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **RDS Functionality** | Remote desktop access testing | Successful L3 engineer access |
| **Engineering Tools** | HeidiSQL and utility testing | Complete tool functionality |
| **Session Management** | Multi-user session validation | Proper RDS session control |
| **Database Connectivity** | PostgreSQL access testing | Engineering database access |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L1 Compliance** | Security policy auditing | Baseline compliance verification |
| **RDS Security** | Remote access validation | Secure session establishment |
| **Access Control** | L3 authentication testing | Restricted engineer access |
| **Network Security** | RDS traffic validation | Proper security controls |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-rds01 represents a comprehensive enterprise Remote Desktop Services platform implementing CIS Controls v8 Level 1 security standards on Windows Server 2025 Standard, providing specialized remote desktop access for L3 engineers and power staff with maximum operational flexibility, advanced engineering tools including HeidiSQL, and elevated access capabilities supporting critical infrastructure engineering and technical operations.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **L3 Remote Access** | RDS platform for engineers | High-privilege remote operations |
| **Engineering Tools** | HeidiSQL and advanced utilities | Specialized tool availability |
| **Maximum Flexibility** | Power user capabilities | L3 operational requirements |
| **Database Management** | HeidiSQL integration | Advanced database administration |

### **9.3 Operational Impact**

This virtual machine serves as the critical L3 engineering access foundation enabling specialized remote desktop services, advanced engineering tool access, and high-privilege operations across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential elevated access capabilities for infrastructure specialists and power users.

### **9.4 Future Considerations**

Planned enhancements include expanded engineering tool integration, enhanced RDS performance optimization, and advanced session management supporting the evolution toward comprehensive L3 engineering access and enterprise-grade remote desktop services supporting the growing advanced technical requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all RDS configurations, engineering tool procedures, and L3 access implementations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
