<---
title: "mgmt-ansible01 - Enterprise Infrastructure Management VM"
type: "enterprise-vm-asset"
domain: "infrastructure-management"
tech: "ubuntu-2404-lts-ansible-automation"
scale: "enterprise-infrastructure-management"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Infrastructure management platform"
  compliance_framework: "CIS Controls v8 Level 2"
--->

# 🖥️ **mgmt-ansible01 - Enterprise Infrastructure Management VM**

**Asset Classification:** Infrastructure Management Platform | **Service Tier:** Production | **Location:** node05 - Infrastructure Host

This knowledge base article provides comprehensive virtual machine specifications, security configuration, and operational procedures for mgmt-ansible01, an Ubuntu Server 24.04 LTS enterprise infrastructure management virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the primary automation and configuration management platform for the 7-node Proxmox astronomy research cluster.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

mgmt-ansible01 serves as the enterprise infrastructure management platform providing centralized automation, configuration management, and operational orchestration through Ansible automation framework, supporting comprehensive cluster management, security compliance enforcement, and infrastructure as code practices for the hybrid Kubernetes and VM architecture.

### **1.2 Service Classification**

**Production Tier:** Mission-critical infrastructure management platform optimized for enterprise automation workflows, configuration management, security compliance enforcement, and operational excellence supporting the complete 7-node cluster infrastructure with CIS Controls v8 Level 2 baseline security implementation.

### **1.3 Cluster Integration**

Central management hub enabling comprehensive infrastructure automation, security baseline enforcement, and operational coordination across all cluster nodes, virtual machines, and containerized services while maintaining enterprise-grade security standards and compliance frameworks.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node05 (Intel i5-12600H) | Physical infrastructure foundation |
| **Network Infrastructure** | VLAN 10 (Infrastructure services) | Management network connectivity |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance VM storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Network Connectivity** | labswitch02 management layer | Infrastructure VLAN access |
| **DNS Resolution** | Cluster DNS infrastructure | Name resolution services |
| **Time Synchronization** | chronyd NTP service | Accurate time coordination |
| **Security Monitoring** | Integrated security stack | Compliance validation |

### **2.3 Management Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **SSH Access** | AllowUsers configured | Secure remote management |
| **Ansible Framework** | Automation platform ready | Infrastructure orchestration |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |
| **Monitoring Integration** | System observability | Operational awareness |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 1002 | Infrastructure management identifier |
| **Memory** | 2.00 GiB allocated / 4.00 GiB maximum | Optimized for automation workloads |
| **Processors** | 2 vCPU (2 sockets, 1 core each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **Primary Disk** | scsi0: nvmethin01:vm-1002-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **EFI System** | nvmethin01:vm-1002-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-1002-disk-2, 4MB | TPM v2.0 hardware security module |
| **Controller** | VirtIO SCSI single | High-performance storage interface |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:33:EC:29 | VirtIO network adapter |
| **Bridge Assignment** | vmbr1, tag=10 | Infrastructure services VLAN |
| **IP Configuration** | 10.25.10.7 (static) | Management network address |
| **Security Hardening** | Host-based firewall active | Network traffic filtering |

### **3.4 Security Implementation**

| **Security Layer** | **Implementation** | **Compliance** |
|-------------------|-------------------|----------------|
| **BIOS Security** | OVMF (UEFI) with Secure Boot | Hardware security foundation |
| **OS Baseline** | Ubuntu Server 24.04 LTS CIS L2 | 87/100 Lynis hardening index |
| **Access Control** | SSH AllowUsers, sudo configuration | Restricted administrative access |
| **File Integrity** | AIDE with active database | Comprehensive integrity monitoring |

---

## **🔧 4. Management & Operations**

### **4.1 Infrastructure Management Services**

| **Service** | **Function** | **Scope** |
|-------------|--------------|-----------|
| **Ansible Automation** | Configuration management | Complete 7-node cluster |
| **Security Enforcement** | CIS L2 baseline maintenance | All managed systems |
| **Operational Coordination** | Infrastructure orchestration | Hybrid K8s/VM environment |
| **Compliance Monitoring** | Security posture validation | Enterprise standards |

### **4.2 Security & Compliance Services**

| **Security Component** | **Status** | **Coverage** |
|-----------------------|------------|--------------|
| **Fail2ban** | Installed with jail.local | Intrusion prevention |
| **AIDE** | Database configured, active | File integrity monitoring |
| **Anti-malware** | chkrootkit, Rootkit Hunter | Malware detection |
| **Audit Logging** | auditd enabled with log file | Security event tracking |
| **AppArmor** | Enabled (43 unconfined processes) | Mandatory access control |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Security Scanning** | Monthly | Lynis comprehensive audit |
| **Integrity Validation** | Daily (automated) | AIDE file system checks |
| **Configuration Management** | Continuous | Ansible automation framework |
| **Compliance Verification** | Weekly | CIS L2 baseline validation |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **System Health** | systemd (24 running services) | Service management |
| **Security Events** | auditd logging | Security incident tracking |
| **System Logging** | RSyslog, systemd journal | Comprehensive log management |
| **Time Synchronization** | chronyd NTP daemon | Accurate time coordination |

---

## **🔒 5. Security & Compliance**

**Security Implementation Disclaimer:** This virtual machine implements enterprise-grade security controls guided by CIS Controls v8 Level 2 standards achieving 87/100 Lynis hardening index. Security configurations include comprehensive file integrity monitoring, intrusion detection systems, malware protection, and audit logging. While these controls provide robust protection for infrastructure management operations, organizations should conduct regular security assessments and adapt configurations to meet specific regulatory and operational requirements.

### **5.1 Security Framework Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Access Controls** | SSH AllowUsers, sudo hardening | ✅ CIS L2 Compliant |
| **File System Security** | Hardened mount options | ✅ Multiple partitions secured |
| **Kernel Hardening** | sysctl security parameters | ⚠️ 3 values differ from profile |
| **Network Security** | Firewall active, IPv4 hardening | ✅ Comprehensive controls |
| **Audit & Logging** | auditd, RSyslog configured | ✅ Complete event tracking |

### **5.2 Compliance Validation**

| **Compliance Domain** | **Score/Status** | **Validation Method** |
|----------------------|------------------|----------------------|
| **Overall Hardening** | 87/100 Lynis index | Monthly comprehensive scan |
| **File Integrity** | AIDE active with database | Daily automated validation |
| **Malware Protection** | Multiple scanners configured | Continuous monitoring |
| **Access Security** | No passwordless accounts | Regular audit verification |

---

## **💾 6. Backup & Recovery**

### **6.1 Proxmox Backup Server Integration**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with deduplication, encryption, and point-in-time recovery supporting comprehensive data protection for critical infrastructure management services and configuration data.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM Snapshots** | Daily at 02:00 | 30 days | Proxmox Backup Server |
| **Configuration Files** | Real-time | Continuous | Git repository sync |
| **Ansible Playbooks** | On change | Version controlled | Infrastructure as Code |
| **Security Baselines** | Weekly | 90 days | Compliance documentation |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <30 minutes | <24 hours | pbs01 full restoration |
| **Configuration Recovery** | <15 minutes | <1 hour | Ansible playbook deployment |
| **Selective File Recovery** | <10 minutes | <24 hours | pbs01 file-level restore |
| **Security Baseline** | <45 minutes | <7 days | CIS L2 re-implementation |

---

## **📚 7. References & Documentation**

### **7.1 Security Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **CIS Controls v8 Level 2** | Complete baseline | [CIS Benchmarks](https://www.cisecurity.org/) |
| **Ubuntu Security Guide** | OS hardening | [Ubuntu Security](https://ubuntu.com/security) |
| **Lynis Security Framework** | Continuous assessment | [Lynis Documentation](https://cisofy.com/lynis/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node05](../hardware/node05-12600h-infrastructure-node.md)** | Physical host platform | Infrastructure foundation |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |
| **[Infrastructure Services](../infrastructure/)** | Service coordination | Enterprise management stack |

---

## **✅ 8. Validation & Testing**

### **8.1 Security Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Lynis Security Scan** | Monthly comprehensive audit | Maintain >85/100 score |
| **AIDE Integrity** | Daily automated validation | No unauthorized changes |
| **Access Control** | SSH configuration testing | Restricted user access only |
| **Service Security** | Port scanning, service audit | Minimal attack surface |

### **8.2 Operational Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **Ansible Automation** | Playbook execution testing | Successful configuration management |
| **Network Connectivity** | VLAN 10 access validation | Infrastructure service reachability |
| **Security Monitoring** | Alert generation testing | Proper incident detection |
| **Backup Integration** | pbs01 backup validation | Successful data protection |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

mgmt-ansible01 represents a comprehensive enterprise infrastructure management platform implementing CIS Controls v8 Level 2 security standards with 87/100 Lynis hardening index, providing centralized automation and configuration management capabilities supporting the complete 7-node Proxmox astronomy research cluster with robust security controls and operational excellence.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Infrastructure Automation** | Ansible-based orchestration | Complete cluster management |
| **Security Compliance** | CIS L2 baseline with monitoring | Enterprise-grade protection |
| **Operational Excellence** | Centralized configuration management | Consistent infrastructure state |
| **Data Protection** | pbs01 backup integration | Comprehensive recovery capabilities |

### **9.3 Operational Impact**

This virtual machine serves as the critical infrastructure management hub enabling automated deployment, configuration management, security compliance enforcement, and operational coordination across the entire enterprise astronomy research platform while maintaining the highest security standards and operational reliability.

### **9.4 Future Considerations**

Planned enhancements include expanded automation capabilities, enhanced security monitoring integration, and advanced compliance reporting supporting the evolution toward fully automated infrastructure management and security operations supporting the growing research computing requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all technical specifications, security implementations, and operational procedures  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0