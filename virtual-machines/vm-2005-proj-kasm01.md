<---
title: "proj-kasm01 - Enterprise Virtual Desktop Infrastructure VM"
type: "enterprise-vm-asset"
domain: "virtual-desktop-infrastructure"
tech: "ubuntu-2404-lts-kasm-workspaces-vdi"
scale: "enterprise-vdi-platform"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Virtual desktop infrastructure platform"
  compliance_framework: "CIS Controls v8 Level 2"
  vdi_platform: "Kasm Workspaces secure ephemeral desktops"
--->

# 🖥️ **proj-kasm01 - Enterprise Virtual Desktop Infrastructure VM**

**Asset Classification:** Virtual Desktop Infrastructure Platform | **Service Tier:** Production | **Location:** node06 - Next-Gen Performance Host

This knowledge base article provides comprehensive virtual machine specifications, VDI configuration, and operational procedures for proj-kasm01, an Ubuntu Server 24.04 LTS enterprise virtual desktop infrastructure virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary Kasm Workspaces platform providing secure ephemeral desktop environments for research collaboration and secure remote access across the astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-kasm01 serves as the enterprise virtual desktop infrastructure platform providing secure ephemeral desktop environments through Kasm Workspaces, supporting browser-based secure remote access, temporary desktop sessions, and isolated workspace environments for research collaboration, external user access, and secure computing workflows requiring controlled desktop environments.

### **1.2 Service Classification**

**Production Tier:** Mission-critical VDI platform optimized for secure desktop delivery, ephemeral workspace management, browser-based remote access, and controlled computing environments supporting research collaboration with CIS Controls v8 Level 2 baseline security implementation and Kasm Workspaces enterprise architecture.

### **1.3 Cluster Integration**

Secure desktop access hub enabling controlled remote access, ephemeral workspace delivery, and secure collaboration environments while maintaining enterprise-grade security standards and seamless integration with authentication systems, network security, and research computing resources.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node06 (Intel i9-13900H) | Next-generation performance foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | VDI network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance VDI storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Authentication** | Domain controller integration | Secure user authentication |
| **Network Security** | Firewall and VLAN isolation | Secure VDI access |
| **Storage Infrastructure** | High-performance storage | VDI workspace performance |
| **Monitoring** | Security and performance monitoring | VDI health validation |

### **2.3 VDI Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Kasm Workspaces** | Ephemeral desktop platform | Secure VDI delivery |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 132GB total VDI storage | Desktop workspace capacity |
| **Performance Optimization** | Next-gen host platform | Optimal VDI performance |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2005 | VDI platform identifier |
| **Memory** | 8.00 GiB allocated / 24.00 GiB maximum | Optimized for VDI workloads |
| **Processors** | 6 vCPU (2 sockets, 3 cores each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2005-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **VDI Storage** | scsi1: nvmethin01:vm-2005-disk-3, 100GB | Dedicated desktop workspace storage |
| **EFI System** | nvmethin01:vm-2005-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2005-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:D8:47:E6 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.10 (static) | VDI platform address |
| **Security Hardening** | Host-based firewall active | VDI traffic filtering |

### **3.4 Kasm Workspaces Implementation**

| **VDI Component** | **Implementation** | **Security** |
|------------------|-------------------|--------------|
| **Ephemeral Desktops** | Temporary workspace environments | Secure session isolation |
| **Browser-Based Access** | Web-based VDI delivery | No client installation required |
| **Workspace Isolation** | Containerized desktop environments | User session security |
| **Authentication Integration** | Enterprise SSO integration | Secure user access |

---

## **🔧 4. Management & Operations**

### **4.1 VDI Platform Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **Ephemeral Desktops** | Temporary secure workspace delivery | Browser-based access |
| **Session Management** | Desktop lifecycle management | Secure session control |
| **User Access Control** | Authentication and authorization | Enterprise identity integration |
| **Workspace Customization** | Desktop environment configuration | Research workflow optimization |

### **4.2 Kasm Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **Kasm Server** | VDI orchestration platform | Desktop delivery management |
| **Desktop Containers** | Ephemeral workspace containers | Isolated desktop environments |
| **Web Gateway** | Browser-based access | Secure VDI delivery |
| **Authentication** | Enterprise identity integration | Secure user access |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **VDI Performance Monitoring** | Continuous | Desktop delivery optimization |
| **Session Management** | Daily | Ephemeral workspace lifecycle |
| **Security Validation** | Weekly | VDI access control verification |
| **Platform Updates** | Monthly | Kasm Workspaces maintenance |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **VDI Performance** | Kasm monitoring + system metrics | Desktop delivery efficiency |
| **Session Health** | Desktop container monitoring | Workspace availability |
| **Security Events** | Access control monitoring | VDI security validation |
| **Resource Utilization** | Host performance monitoring | VDI platform optimization |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **VDI Security** | Ephemeral desktop isolation | ✅ CIS L2 VDI security |
| **Access Controls** | Enterprise authentication integration | ✅ CIS L2 Compliant |
| **Session Security** | Container-based workspace isolation | ✅ Secure desktop environments |
| **Network Security** | Host firewall + VLAN segmentation | ✅ Layered security controls |
| **Data Protection** | Ephemeral session data management | ✅ Secure workspace lifecycle |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | VDI access controls | **2025-07-20** |
| **CIS.4.1** | **Compliant** | VDI platform updates | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network security controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | VDI data protection | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 VDI Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with VDI-aware backup procedures ensuring platform configuration preservation, workspace template protection, and rapid recovery supporting critical virtual desktop infrastructure continuity and secure remote access capabilities.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 05:00 | 30 days | pbs01 comprehensive backup |
| **Kasm Configuration** | Real-time persistence | Continuous | Platform configuration management |
| **Workspace Templates** | Weekly backup | 90 days | Desktop environment preservation |
| **User Session Data** | Ephemeral (not backed up) | Session lifecycle | Secure temporary workspaces |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + VDI restart |
| **Kasm Platform Recovery** | <45 minutes | <8 hours | VDI platform restoration |
| **Workspace Template Recovery** | <30 minutes | <7 days | Desktop environment restoration |
| **Configuration Recovery** | <20 minutes | <24 hours | Platform configuration restoration |

---

## **📚 7. References & Documentation**

### **7.1 VDI Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Kasm Workspaces Documentation** | VDI platform deployment | [Kasm Documentation](https://kasmweb.com/docs) |
| **VDI Security Best Practices** | Secure desktop delivery | [VDI Security Guidelines](https://www.nist.gov/cybersecurity) |
| **CIS Controls v8 Level 2** | VDI security baseline | [CIS Benchmarks](https://www.cisecurity.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node06](../hardware/node06-13900h-performance-node.md)** | Physical host platform | Next-generation performance foundation |
| **[VDI Infrastructure](../infrastructure/vdi-kasm-workspaces/)** | VDI service coordination | Enterprise VDI stack |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 VDI Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Desktop Delivery** | Ephemeral workspace testing | Successful VDI access |
| **Session Isolation** | Multi-user workspace validation | Secure session separation |
| **Performance Testing** | VDI responsiveness validation | Optimal desktop performance |
| **Authentication Integration** | Enterprise SSO testing | Secure user access |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **VDI Security** | Workspace isolation testing | Secure ephemeral environments |
| **Access Control** | Authentication testing | Restricted VDI access |
| **Session Security** | Container security validation | Isolated desktop workspaces |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-kasm01 represents a comprehensive enterprise virtual desktop infrastructure implementing Kasm Workspaces with CIS Controls v8 Level 2 security standards, providing secure ephemeral desktop environments, browser-based remote access, and controlled workspace delivery supporting research collaboration and secure computing with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Ephemeral Desktops** | Kasm Workspaces platform | Secure temporary workspace delivery |
| **Browser-Based Access** | Web VDI delivery | No client installation required |
| **Session Isolation** | Container-based workspaces | Secure user environment separation |
| **Enterprise Integration** | SSO and authentication | Seamless secure access |

### **9.3 Operational Impact**

This virtual machine serves as the critical VDI foundation enabling secure ephemeral desktop delivery, controlled remote access, and research collaboration environments across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential virtual desktop infrastructure for secure computing workflows.

### **9.4 Future Considerations**

Planned enhancements include expanded desktop environment customization, enhanced security monitoring integration, and advanced workspace management supporting the evolution toward comprehensive VDI services and enterprise-grade secure remote access supporting the growing virtual desktop requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all Kasm Workspaces configurations, VDI procedures, and security implementations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
