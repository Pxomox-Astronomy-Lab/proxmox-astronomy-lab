<---
title: "mgmt-agents01 - Enterprise AI Agents Development Platform VM"
type: "enterprise-vm-asset"
domain: "ai-agents-development-platform"
tech: "ubuntu-2404-lts-claude-code-gemini-mcp"
scale: "enterprise-ai-development"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "AI agents development platform"
  compliance_framework: "CIS Controls v8 Level 2"
  ai_platform: "Claude Code, Gemini CLI, MCP Server ecosystem"
--->

# 🤖 **mgmt-agents01 - Enterprise AI Agents Development Platform VM**

**Asset Classification:** AI Agents Development Platform | **Service Tier:** Production | **Location:** node02 - Storage Host

This knowledge base article provides comprehensive virtual machine specifications, AI platform configuration, and operational procedures for mgmt-agents01, an Ubuntu Server 24.04 LTS enterprise AI agents development virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary agentic AI platform hosting Claude Code, Gemini CLI, and comprehensive MCP (Model Context Protocol) server ecosystem for advanced AI-driven development and automation workflows.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

mgmt-agents01 serves as the enterprise AI agents development platform providing advanced agentic AI capabilities through Claude Code command-line integration, Gemini CLI services, and comprehensive Model Context Protocol (MCP) server infrastructure, supporting AI-driven development workflows, automated code generation, and intelligent infrastructure management for the astronomy research platform.

### **1.2 Service Classification**

**Production Tier:** Mission-critical AI development platform optimized for agentic AI workflows, automated development processes, and intelligent system integration supporting advanced AI-driven operations with CIS Controls v8 Level 2 baseline security implementation and comprehensive AI agent orchestration capabilities.

### **1.3 Cluster Integration**

Central AI intelligence hub enabling automated development workflows, intelligent infrastructure management, and AI-driven operational coordination across the cluster while maintaining enterprise-grade security standards and providing advanced AI capabilities for research computing automation and development acceleration.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node02 (Intel i5-12600H) | Physical storage/compute foundation |
| **Network Infrastructure** | VLAN 10 (Infrastructure services) | AI services network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance AI workload storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Network Connectivity** | labswitch02 management layer | Infrastructure VLAN access |
| **DNS Resolution** | Cluster DNS infrastructure | AI service discovery |
| **Time Synchronization** | chronyd NTP service | AI workflow coordination |
| **External AI Services** | Claude API, Gemini API | AI model access |

### **2.3 AI Platform Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Claude Code** | Command-line AI development tool | Automated code generation |
| **Gemini CLI** | Google AI platform integration | Multi-model AI capabilities |
| **MCP Servers** | Model Context Protocol ecosystem | AI agent coordination |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 1007 | AI agents development identifier |
| **Memory** | 4.00 GiB allocated / 16.00 GiB maximum | Optimized for AI workloads |
| **Processors** | 4 vCPU (2 sockets, 2 cores each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-1007-disk-3, 32GB | VirtIO SCSI with discard, iothread |
| **AI Development Storage** | scsi1: nvmethin01:vm-1007-disk-0, 100GB | Dedicated AI models and workspace |
| **EFI System** | nvmethin01:vm-1007-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-1007-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:4D:35:5E | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=10 | Infrastructure services VLAN |
| **IP Configuration** | 10.25.10.10 (static) | AI development platform address |
| **Security Hardening** | Host-based firewall active | AI traffic filtering |

### **3.4 AI Platform Implementation**

| **AI Component** | **Implementation** | **Capabilities** |
|------------------|-------------------|------------------|
| **Claude Code** | Command-line AI development | Automated code generation and analysis |
| **Gemini CLI** | Google AI platform integration | Multi-modal AI capabilities |
| **MCP Servers** | Model Context Protocol ecosystem | AI agent coordination and integration |
| **Development Environment** | AI-enhanced development tools | Intelligent automation workflows |

---

## **🔧 4. Management & Operations**

### **4.1 AI Development Services**

| **Service** | **Function** | **Capabilities** |
|-------------|--------------|------------------|
| **Claude Code** | AI-driven code development | Automated programming and analysis |
| **Gemini CLI** | Multi-modal AI operations | Text, code, and data processing |
| **MCP Server Ecosystem** | AI agent coordination | Protocol-based AI integration |
| **Development Automation** | Intelligent workflow management | AI-enhanced development processes |

### **4.2 AI Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **Claude Code Integration** | Active development tool | Command-line AI assistance |
| **Gemini CLI Services** | Multi-model AI access | Google AI platform integration |
| **MCP Server Network** | Protocol-based coordination | AI agent communication |
| **Development Environment** | AI-enhanced toolchain | Intelligent development workflows |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **AI Model Updates** | Weekly | Claude and Gemini platform updates |
| **MCP Server Management** | Daily | Protocol server health monitoring |
| **Development Workflow Optimization** | Continuous | AI-driven process improvement |
| **Security Validation** | Weekly | AI platform security assessment |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **AI Platform Health** | System monitoring + AI metrics | Service availability |
| **Development Performance** | AI workflow analytics | Process efficiency |
| **Resource Utilization** | Host performance monitoring | AI workload optimization |
| **Security Events** | Host security auditing | AI platform security |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **AI Platform Security** | Secure AI service integration | ✅ CIS L2 application security |
| **Access Controls** | SSH hardening + AI service authentication | ✅ CIS L2 Compliant |
| **Data Protection** | AI model and data encryption | ✅ Comprehensive data security |
| **Network Security** | Host firewall + AI traffic filtering | ✅ Layered security controls |
| **Audit & Logging** | AI activity monitoring | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.3.3** | **Compliant** | AI platform access controls | **2025-07-20** |
| **CIS.13.1** | **Compliant** | AI data protection | **2025-07-20** |
| **CIS.14.1** | **Compliant** | AI platform security monitoring | **2025-07-20** |
| **CIS.16.1** | **Compliant** | AI incident response procedures | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 AI Development Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with AI-aware backup procedures ensuring development environment preservation, AI model configuration retention, and rapid recovery supporting critical AI development workflows and intelligent automation capabilities.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 03:30 | 30 days | pbs01 comprehensive backup |
| **AI Development Environment** | Real-time persistence | Continuous | Development workspace management |
| **MCP Server Configurations** | Weekly backup | 90 days | Protocol server state preservation |
| **AI Model Cache** | Weekly backup | 30 days | Model and configuration data |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <45 minutes | <24 hours | pbs01 full restoration + AI service restart |
| **AI Platform Recovery** | <30 minutes | <8 hours | Development environment restoration |
| **MCP Server Recovery** | <15 minutes | <24 hours | Protocol server reconfiguration |
| **Development Environment** | <20 minutes | <1 hour | Workspace and toolchain restoration |

---

## **📚 7. References & Documentation**

### **7.1 AI Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Claude Code Documentation** | AI development integration | [Anthropic Documentation](https://docs.anthropic.com/) |
| **Gemini CLI Reference** | Google AI platform | [Google AI Documentation](https://ai.google.dev/) |
| **MCP Protocol Specification** | Model Context Protocol | [MCP Standards](https://modelcontextprotocol.io/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node02](../hardware/node02-12600h-storage-node.md)** | Physical host platform | Storage foundation |
| **[AI Infrastructure](../ai/)** | AI/ML platform integration | Enterprise AI stack |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 AI Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Claude Code Functionality** | AI development task execution | Successful code generation and analysis |
| **Gemini CLI Integration** | Multi-modal AI testing | Complete platform functionality |
| **MCP Server Communication** | Protocol server validation | Proper AI agent coordination |
| **Development Workflow** | AI-enhanced process testing | Optimized development automation |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **AI Platform Security** | AI service security audit | Secure AI integration |
| **Access Control** | Authentication testing | Restricted AI platform access |
| **Data Protection** | AI data security validation | Protected development environments |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

mgmt-agents01 represents a comprehensive enterprise AI agents development platform implementing advanced agentic AI capabilities with Claude Code, Gemini CLI, and MCP server ecosystem on CIS Controls v8 Level 2 security baseline, providing intelligent development automation, AI-driven workflows, and advanced artificial intelligence integration supporting the astronomy research platform with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Agentic AI Development** | Claude Code + Gemini CLI | Automated intelligent development |
| **MCP Server Ecosystem** | Protocol-based AI coordination | Advanced AI agent integration |
| **Development Automation** | AI-enhanced workflows | Accelerated development processes |
| **Multi-Model AI Access** | Claude and Gemini integration | Comprehensive AI capabilities |

### **9.3 Operational Impact**

This virtual machine serves as the critical AI development foundation enabling advanced agentic AI capabilities, intelligent automation workflows, and AI-driven development processes across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential artificial intelligence coordination for next-generation research computing operations.

### **9.4 Future Considerations**

Planned enhancements include expanded AI model integration, enhanced MCP server ecosystem development, and advanced agentic AI workflow automation supporting the evolution toward comprehensive AI-driven infrastructure management and enterprise-grade artificial intelligence operations supporting the growing AI development requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all AI platform configurations, agentic AI workflows, and MCP server integrations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
