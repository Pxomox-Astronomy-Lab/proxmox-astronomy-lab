<---
title: "proj-dev01 - Enterprise Development Workstation VM"
type: "enterprise-vm-asset"
domain: "development-workstation-platform"
tech: "ubuntu-2404-lts-vscode-server-docker-python"
scale: "enterprise-development-workstation"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Personal development workstation"
  compliance_framework: "CIS Controls v8 Level 2"
  development_platform: "Fully Meshed VS Code Server environment"
--->

# 👨‍💻 **proj-dev01 - Enterprise Development Workstation VM**

**Asset Classification:** Personal Development Workstation Platform | **Service Tier:** Production | **Location:** node05 - Infrastructure Host

This knowledge base article provides comprehensive virtual machine specifications, development environment configuration, and operational procedures for proj-dev01, an Ubuntu Server 24.04 LTS enterprise development workstation virtual machine baselined to CIS Controls v8 Level 2 standards, serving as a personal development environment with Fully Meshed VS Code Server, Python development stack, Docker containerization, and integrated development toolchain supporting advanced software development workflows.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-dev01 serves as the enterprise personal development workstation providing comprehensive software development capabilities through Fully Meshed VS Code Server environment, Python development stack, Docker containerization, and integrated development toolchain supporting advanced coding workflows, infrastructure as code development, and research computing software engineering with browser-based remote development access.

### **1.2 Service Classification**

**Production Tier:** Mission-critical personal development platform optimized for software engineering workflows, remote development access, containerized development environments, and integrated toolchain coordination supporting enterprise development practices with CIS Controls v8 Level 2 baseline security implementation and advanced VS Code Server architecture.

### **1.3 Cluster Integration**

Personal development hub enabling comprehensive software development workflows, infrastructure as code development, and research computing software engineering while maintaining enterprise-grade security standards and seamless integration with cluster services, databases, container orchestration, and development infrastructure coordination.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node05 (Intel i5-12600H) | Physical infrastructure foundation |
| **Network Infrastructure** | VLAN 20 (Project workloads) | Development environment connectivity |
| **Storage Backend** | nvmethin01 + nvmethin02 pools | Multi-tier development storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Container Services** | Docker engine + proj-port01 | Development containerization |
| **Database Access** | proj-pg01 PostgreSQL platform | Development database connectivity |
| **Source Control** | Gitea integration | Code repository management |
| **Network Connectivity** | labswitch02 management layer | Project VLAN access |

### **2.3 Development Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **VS Code Server** | Fully Meshed development environment | Browser-based remote development |
| **Python Stack** | Complete Python development toolkit | Programming language support |
| **Docker Environment** | Container development platform | Containerized workflow support |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2004 | Personal development workstation identifier |
| **Memory** | 4.00 GiB allocated / 16.00 GiB maximum | Optimized for development workloads |
| **Processors** | 4 vCPU (2 sockets, 2 cores each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2004-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Development Storage** | scsi1: nvmethin02:vm-2004-disk-0, 100GB | Dedicated development workspace |
| **EFI System** | nvmethin01:vm-2004-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2004-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:19:D9:95 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=20 | Project workloads VLAN |
| **IP Configuration** | 10.25.20.7 (static) | Development workstation address |
| **Security Hardening** | Host-based firewall active | Development traffic filtering |

### **3.4 Development Platform Implementation**

| **Development Component** | **Implementation** | **Capabilities** |
|--------------------------|-------------------|------------------|
| **VS Code Server** | Fully Meshed development environment | Browser-based remote development |
| **Python Development** | Complete Python toolkit | Programming language support |
| **Docker Platform** | Container development environment | Containerized workflows |
| **Database Integration** | PostgreSQL development connectivity | Database-driven development |

---

## **🔧 4. Management & Operations**

### **4.1 Development Environment Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **VS Code Server** | Browser-based development environment | Remote development access |
| **Python Development** | Programming language development | Complete Python toolkit |
| **Docker Development** | Container-based development workflows | Containerized applications |
| **Database Development** | PostgreSQL development integration | Database-driven applications |

### **4.2 Development Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **VS Code Server** | Fully Meshed environment | Browser-based development interface |
| **Python Environment** | Complete development stack | Programming language support |
| **Docker Engine** | Container development platform | Containerized workflow management |
| **Development Tools** | Integrated development toolchain | Code editor, debugger, extensions |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Development Environment Updates** | Weekly | VS Code Server and extension updates |
| **Python Package Management** | As needed | Development dependency management |
| **Container Image Management** | Daily | Docker image and container lifecycle |
| **Code Repository Synchronization** | Continuous | Git and Gitea integration |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Development Performance** | System monitoring + development metrics | Development workflow efficiency |
| **Container Health** | Docker monitoring | Container development environment |
| **Storage Utilization** | Multi-tier storage monitoring | Development workspace optimization |
| **Network Connectivity** | Development service connectivity | Service integration validation |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Development Security** | VS Code Server access controls | ✅ CIS L2 development platform security |
| **Container Security** | Docker security hardening | ✅ CIS L2 container baseline |
| **Access Controls** | SSH hardening + development authentication | ✅ CIS L2 Compliant |
| **Network Security** | Host firewall + VLAN segmentation | ✅ Layered security controls |
| **Code Security** | Development environment isolation | ✅ Secure development practices |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | Development environment access controls | **2025-07-20** |
| **CIS.4.1** | **Compliant** | Development platform updates | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network security controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | Development data protection | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Development Workstation Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with development-aware backup procedures ensuring development environment preservation, code repository integration, and rapid recovery supporting critical development workflows and personal workspace continuity.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 04:30 | 30 days | pbs01 comprehensive backup |
| **Development Environment** | Real-time persistence | Continuous | VS Code Server configuration |
| **Code Repositories** | Git-based versioning | Continuous | Source control integration |
| **Development Workspace** | Weekly backup | 14 days | Development data protection |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <45 minutes | <24 hours | pbs01 full restoration + development restart |
| **Development Environment** | <30 minutes | <8 hours | VS Code Server restoration |
| **Code Repository Recovery** | <15 minutes | <1 hour | Git repository synchronization |
| **Development Configuration** | <20 minutes | <24 hours | Development toolchain restoration |

---

## **📚 7. References & Documentation**

### **7.1 Development Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Fully Meshed VS Code Server** | Advanced development environment | [Internal Implementation Guide](Fully%20Meshed%20VS%20Code%20Server.pdf) |
| **VS Code Server Documentation** | Remote development platform | [VS Code Server Guides](https://code.visualstudio.com/docs/remote/remote-overview) |
| **Python Development Best Practices** | Programming standards | [Python.org Documentation](https://docs.python.org/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node05](../hardware/node05-12600h-infrastructure-node.md)** | Physical host platform | Infrastructure foundation |
| **[proj-pg01](proj-pg01.md)** | Database development services | Development database connectivity |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Development Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **VS Code Server Functionality** | Browser-based development testing | Full remote development access |
| **Python Development** | Programming environment validation | Complete Python toolkit functionality |
| **Docker Integration** | Container development testing | Containerized workflow support |
| **Database Connectivity** | PostgreSQL development access | Development database integration |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Development Security** | VS Code Server security audit | Secure development environment |
| **Container Security** | Docker security validation | Secure containerized development |
| **Access Control** | Authentication testing | Restricted development access |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-dev01 represents a comprehensive enterprise personal development workstation implementing Fully Meshed VS Code Server environment with CIS Controls v8 Level 2 security standards, providing browser-based remote development, Python programming toolkit, Docker containerization, and integrated development workflows supporting advanced software engineering, infrastructure as code development, and research computing applications with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Remote Development** | VS Code Server browser-based access | Location-independent development |
| **Python Development** | Complete programming toolkit | Advanced software engineering |
| **Container Development** | Docker-based development workflows | Modern containerized applications |
| **Database Integration** | PostgreSQL development connectivity | Database-driven development |

### **9.3 Operational Impact**

This virtual machine serves as the critical personal development foundation enabling comprehensive software engineering workflows, remote development access, and integrated development toolchain coordination across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential development capabilities for infrastructure as code, research computing applications, and advanced software development projects.

### **9.4 Future Considerations**

Planned enhancements include expanded development toolchain integration, enhanced VS Code Server optimization, and advanced container development workflows supporting the evolution toward comprehensive development automation and enterprise-grade software engineering supporting the growing development requirements of the astronomy platform and research computing infrastructure.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all VS Code Server configurations, development environment procedures, and programming toolchain integration  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
