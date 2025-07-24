<---
title: "mgmt-sec01 - Enterprise Security Operations Center VM"
type: "enterprise-vm-asset"
domain: "security-operations-management"
tech: "ubuntu-2404-lts-wazuh-siem-xdr"
scale: "enterprise-security-operations"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Security operations center platform"
  compliance_framework: "CIS Controls v8 Level 2"
  security_platform: "Wazuh SIEM/XDR containerized deployment"
--->

# 🛡️ **mgmt-sec01 - Enterprise Security Operations Center VM**

**Asset Classification:** Security Operations Center Platform | **Service Tier:** Production | **Location:** node02 - Storage Host

This knowledge base article provides comprehensive virtual machine specifications, security platform configuration, and operational procedures for mgmt-sec01, an Ubuntu Server 24.04 LTS enterprise security operations center virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary Wazuh SIEM/XDR platform deployed in containerized architecture for comprehensive security monitoring across the 7-node Proxmox astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

mgmt-sec01 serves as the enterprise security operations center providing comprehensive Security Information and Event Management (SIEM) and Extended Detection and Response (XDR) capabilities through containerized Wazuh deployment, supporting centralized security monitoring, threat detection, compliance reporting, and incident response coordination for the entire astronomy research platform infrastructure.

### **1.2 Service Classification**

**Production Tier:** Mission-critical security operations platform optimized for enterprise SIEM/XDR workflows, threat intelligence processing, compliance monitoring, and security incident management supporting comprehensive cluster security with CIS Controls v8 Level 2 baseline security implementation and containerized Wazuh architecture.

### **1.3 Cluster Integration**

Central security coordination hub enabling comprehensive threat detection, security event correlation, compliance monitoring, and incident response coordination across all cluster nodes, virtual machines, containers, and network infrastructure while maintaining enterprise-grade security standards and providing centralized security operations capabilities.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node02 (Intel i5-12600H) | Physical storage/compute foundation |
| **Network Infrastructure** | VLAN 10 (Infrastructure services) | Security monitoring network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance security data storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Network Connectivity** | labswitch02 management layer | Infrastructure VLAN access |
| **DNS Resolution** | Cluster DNS infrastructure | Security service discovery |
| **Time Synchronization** | chronyd NTP service | Accurate security event timestamping |
| **Agent Connectivity** | All monitored systems | Security data collection |

### **2.3 Security Platform Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Docker Engine** | Container runtime for Wazuh | Containerized SIEM deployment |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Storage Allocation** | 132GB total security data storage | Event and log retention |
| **Network Access** | All cluster nodes reachable | Comprehensive monitoring coverage |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 1006 | Security operations center identifier |
| **Memory** | 4.00 GiB allocated / 12.00 GiB maximum | Optimized for SIEM/XDR workloads |
| **Processors** | 4 vCPU (2 sockets, 2 cores each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-1006-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Security Data Storage** | scsi1: nvmethin01:vm-1006-disk-3, 100GB | Dedicated SIEM data and log storage |
| **EFI System** | nvmethin01:vm-1006-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-1006-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:FF:B2:94 | VirtIO network adapter |
| **Bridge Assignment** | vmbr0, tag=10 | Management bridge with VLAN |
| **IP Configuration** | 10.25.10.8 (static) | Security operations center address |
| **Security Hardening** | Host-based firewall active | Security traffic filtering |

### **3.4 Wazuh SIEM/XDR Implementation**

| **Security Component** | **Implementation** | **Architecture** |
|-----------------------|-------------------|------------------|
| **Wazuh Manager** | Containerized deployment | Central SIEM coordination |
| **Wazuh Indexer** | Elasticsearch-based indexing | Security event storage and search |
| **Wazuh Dashboard** | Kibana-based visualization | Security operations interface |
| **Agent Management** | Cluster-wide agent deployment | Comprehensive monitoring coverage |

---

## **🔧 4. Management & Operations**

### **4.1 Security Operations Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **SIEM Operations** | Security event correlation and analysis | Complete 7-node cluster |
| **XDR Capabilities** | Extended detection and response | Endpoints, network, containers |
| **Threat Intelligence** | Security threat analysis and reporting | Enterprise threat landscape |
| **Compliance Monitoring** | CIS Controls and framework validation | Continuous compliance assessment |

### **4.2 Wazuh Platform Services**

| **Platform Component** | **Status** | **Function** |
|------------------------|------------|--------------|
| **Wazuh Manager** | Containerized deployment | Central security management |
| **Security Indexer** | Elasticsearch container | Event storage and search |
| **Security Dashboard** | Kibana interface | Security visualization and reporting |
| **Agent Network** | Cluster-wide deployment | Comprehensive data collection |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Security Event Analysis** | Continuous | Real-time SIEM monitoring |
| **Threat Hunting** | Daily | Proactive security investigation |
| **Compliance Reporting** | Weekly | CIS Controls assessment |
| **Incident Response** | As needed | Security incident coordination |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Security Events** | Wazuh SIEM dashboard | Cluster-wide security monitoring |
| **System Performance** | Container monitoring | SIEM platform health |
| **Agent Connectivity** | Wazuh agent status | Monitoring coverage validation |
| **Compliance Status** | Automated CIS scanning | Continuous compliance assessment |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Security Monitoring** | Wazuh SIEM comprehensive coverage | ✅ CIS L2 monitoring implementation |
| **Incident Response** | Automated detection and alerting | ✅ CIS L2 incident management |
| **Access Controls** | SSH hardening + container isolation | ✅ CIS L2 Compliant |
| **File Integrity** | AIDE + Wazuh FIM monitoring | ✅ Comprehensive integrity monitoring |
| **Audit & Logging** | Centralized security event collection | ✅ Enterprise audit framework |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.6.1** | **Compliant** | Wazuh centralized logging | **2025-07-20** |
| **CIS.6.2** | **Compliant** | Security event correlation | **2025-07-20** |
| **CIS.8.1** | **Compliant** | Wazuh audit capabilities | **2025-07-20** |
| **CIS.16.1** | **Compliant** | Incident response procedures | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Security Operations Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with security-aware backup procedures ensuring SIEM data preservation, security configuration retention, and rapid recovery supporting critical security operations continuity and threat detection capabilities.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 03:00 | 30 days | pbs01 comprehensive backup |
| **Wazuh Configuration** | Real-time persistence | Continuous | Container volume management |
| **Security Event Data** | Automated retention | 90 days | Elasticsearch index management |
| **Threat Intelligence** | Weekly backup | 180 days | Security intelligence preservation |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + container restart |
| **Wazuh Service Recovery** | <30 minutes | <8 hours | Container service restoration |
| **Security Data Recovery** | <45 minutes | <24 hours | Elasticsearch index restoration |
| **Configuration Recovery** | <15 minutes | <1 hour | Wazuh configuration restoration |

---

## **📚 7. References & Documentation**

### **7.1 Security Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Wazuh Documentation** | SIEM/XDR deployment | [Wazuh Guides](https://documentation.wazuh.com/) |
| **CIS Controls v8 Level 2** | Security monitoring baseline | [CIS Benchmarks](https://www.cisecurity.org/) |
| **NIST Cybersecurity Framework** | Security operations alignment | [NIST CSF](https://www.nist.gov/cyberframework) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node02](../hardware/node02-12600h-storage-node.md)** | Physical host platform | Storage foundation |
| **[All Cluster Nodes](../hardware/)** | Monitoring targets | Security agent deployment |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Security Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Wazuh SIEM Functionality** | Security event processing | All agents reporting successfully |
| **Dashboard Access** | Security interface testing | Complete visibility and reporting |
| **Alert Generation** | Security rule testing | Proper threat detection and alerting |
| **Agent Connectivity** | Cluster-wide agent validation | Comprehensive monitoring coverage |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Container Security** | Wazuh container audit | Container isolation verification |
| **Network Security** | Security traffic analysis | Proper monitoring data flow |
| **Incident Response** | Security simulation testing | Effective threat detection and response |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

mgmt-sec01 represents a comprehensive enterprise security operations center implementing Wazuh SIEM/XDR platform with CIS Controls v8 Level 2 security standards in containerized architecture, providing centralized security monitoring, threat detection, compliance reporting, and incident response capabilities supporting the complete 7-node astronomy research cluster with robust security operations and comprehensive threat visibility.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **SIEM Operations** | Wazuh centralized platform | Comprehensive security monitoring |
| **XDR Capabilities** | Extended detection and response | Advanced threat detection |
| **Compliance Monitoring** | Automated CIS Controls assessment | Continuous compliance validation |
| **Incident Response** | Coordinated security operations | Rapid threat response capabilities |

### **9.3 Operational Impact**

This virtual machine serves as the critical security operations foundation enabling comprehensive threat detection, security event correlation, compliance monitoring, and incident response coordination across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential security operations capabilities for the complete hybrid infrastructure environment.

### **9.4 Future Considerations**

Planned enhancements include advanced threat intelligence integration, enhanced security automation capabilities, and expanded compliance reporting supporting the evolution toward comprehensive security operations center functionality and enterprise-grade security monitoring supporting the growing security requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all Wazuh configurations, security monitoring procedures, and SIEM operations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
