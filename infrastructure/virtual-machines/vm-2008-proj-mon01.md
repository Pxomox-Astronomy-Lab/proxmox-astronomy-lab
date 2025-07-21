<---
title: "proj-mon01 - Enterprise Monitoring & Observability Platform VM"
type: "enterprise-vm-asset"
domain: "monitoring-observability-platform"
tech: "ubuntu-2404-lts-prometheus-grafana-loki-alertmanager"
scale: "enterprise-monitoring-observability"
enterprise_context:
  architecture: "CIS v8 Level 2 Baseline VM"
  security_score: "87/100 Lynis hardening index"
  vm_classification: "Monitoring and observability platform"
  compliance_framework: "CIS Controls v8 Level 2"
  monitoring_stack: "Prometheus, Grafana, Loki, AlertManager, Grafana Alloy"
--->

# 📊 **proj-mon01 - Enterprise Monitoring & Observability Platform VM**

**Asset Classification:** Monitoring & Observability Platform | **Service Tier:** Production | **Location:** node05 - Infrastructure Host

This knowledge base article provides comprehensive virtual machine specifications, monitoring platform configuration, and operational procedures for proj-mon01, an Ubuntu Server 24.04 LTS enterprise monitoring and observability virtual machine baselined to CIS Controls v8 Level 2 standards, serving as the comprehensive monitoring stack with Prometheus, Grafana, Loki, AlertManager, and Grafana Alloy collecting metrics, logs, and alerts from across the entire astronomy research cluster infrastructure.

---

## **🎯 1. Purpose & Scope**

### **1.1 Primary Function**

proj-mon01 serves as the enterprise monitoring and observability platform providing comprehensive infrastructure monitoring through Prometheus metrics collection, Grafana visualization dashboards, Loki log aggregation, AlertManager notification management, and Grafana Alloy agent coordination, supporting complete cluster visibility with specialized exporters including NVIDIA GPU monitoring and PostgreSQL performance tracking.

### **1.2 Service Classification**

**Production Tier:** Mission-critical monitoring platform optimized for comprehensive observability workflows, metrics collection, log aggregation, and alerting coordination supporting enterprise infrastructure monitoring with CIS Controls v8 Level 2 baseline security implementation and complete monitoring stack architecture.

### **1.3 Cluster Integration**

Central observability hub enabling comprehensive infrastructure monitoring, performance tracking, and operational alerting across all cluster nodes, services, and applications while maintaining enterprise-grade security standards and providing complete visibility into system performance, resource utilization, and operational health.

---

## **⚙️ 2. Dependencies & Prerequisites**

### **2.1 Infrastructure Dependencies**

| **Dependency** | **Requirement** | **Purpose** |
|---------------|-----------------|-------------|
| **Host Platform** | node05 (Intel i5-12600H) | Physical infrastructure foundation |
| **Network Infrastructure** | VLAN 20 + Management network | Dual-network monitoring access |
| **Storage Backend** | nvmethin01 NVMe pool | High-performance monitoring storage |
| **Security Framework** | CIS Controls v8 Level 2 | Enterprise security baseline |

### **2.2 Service Dependencies**

| **Service** | **Provider** | **Integration** |
|-------------|--------------|-----------------|
| **Target Monitoring** | All cluster nodes and services | Complete infrastructure coverage |
| **Network Connectivity** | Dual-network access | Management and project VLAN monitoring |
| **DNS Resolution** | Cluster DNS infrastructure | Service discovery |
| **Time Synchronization** | chronyd NTP service | Accurate monitoring timestamps |

### **2.3 Monitoring Prerequisites**

| **Requirement** | **Implementation** | **Validation** |
|----------------|-------------------|----------------|
| **Monitoring Stack** | Prometheus, Grafana, Loki, AlertManager | Complete observability platform |
| **Grafana Alloy** | Metrics and logging agent | Comprehensive data collection |
| **Specialized Exporters** | NVIDIA GPU, PostgreSQL exporters | Targeted monitoring capabilities |
| **Security Baseline** | CIS L2 implementation | 87/100 Lynis score |

---

## **🏗️ 3. Technical Implementation**

### **3.1 Virtual Machine Architecture**

| **Component** | **Specification** | **Configuration** |
|---------------|------------------|------------------|
| **VM ID** | 2008 | Monitoring platform identifier |
| **Memory** | 4.00 GiB allocated / 12.00 GiB maximum | Optimized for monitoring workloads |
| **Processors** | 4 vCPU (2 sockets, 2 cores each) | [host] CPU type with NUMA |
| **Machine Type** | q35 with Intel IOMMU | Enterprise virtualization platform |

### **3.2 Storage Implementation**

| **Storage Component** | **Configuration** | **Performance** |
|--------------------- |------------------|-----------------|
| **System Disk** | scsi0: nvmethin01:vm-2008-disk-1, 32GB | VirtIO SCSI with discard, iothread |
| **Monitoring Storage** | scsi1: nvmethin01:vm-2008-disk-3, 500GB | Dedicated metrics/logs storage, backup=0 |
| **EFI System** | nvmethin01:vm-2008-disk-0, 528KB | EFI type 4m, pre-enrolled keys |
| **TPM Security** | nvmethin01:vm-2008-disk-2, 4MB | TPM v2.0 hardware security module |

### **3.3 Network Implementation**

| **Network Component** | **Configuration** | **Security** |
|----------------------|------------------|--------------|
| **Primary Interface** | net0: virtio=BC:24:11:C6:1F:61, vmbr1, tag=20 | Project workloads VLAN |
| **Management Interface** | net1: virtio=BC:24:11:FB:AE:C8, vmbr0 | Management network access |
| **IP Configuration** | 10.25.20.9 (primary) | Dual-network monitoring access |
| **Security Hardening** | Host-based firewall active | Monitoring traffic filtering |

### **3.4 Monitoring Stack Implementation**

| **Monitoring Component** | **Implementation** | **Function** |
|--------------------------|-------------------|--------------|
| **Prometheus** | Metrics collection and storage | Time-series database |
| **Grafana** | Visualization and dashboards | Monitoring interface |
| **Loki** | Log aggregation and analysis | Centralized logging |
| **AlertManager** | Alert routing and notifications | Operational alerting |
| **Grafana Alloy** | Metrics and logging agent | Data collection coordination |

---

## **🔧 4. Management & Operations**

### **4.1 Monitoring Platform Services**

| **Service** | **Function** | **Coverage** |
|-------------|--------------|--------------|
| **Prometheus Metrics** | Time-series data collection | Complete infrastructure monitoring |
| **Grafana Dashboards** | Visualization and analysis | Operational observability |
| **Loki Logs** | Centralized log aggregation | System and application logging |
| **AlertManager** | Notification and alerting | Operational incident management |

### **4.2 Specialized Monitoring Services**

| **Monitoring Component** | **Status** | **Function** |
|--------------------------|------------|--------------|
| **NVIDIA GPU Exporter** | GPU performance monitoring | Graphics card utilization tracking |
| **PostgreSQL Exporter** | Database performance monitoring | Database metrics collection |
| **Grafana Alloy** | Universal collection agent | Metrics and logs coordination |
| **Node Exporters** | System metrics collection | Host performance monitoring |

### **4.3 Operational Procedures**

| **Procedure Type** | **Frequency** | **Implementation** |
|-------------------|---------------|-------------------|
| **Monitoring Health Validation** | Continuous | Stack component status verification |
| **Dashboard Management** | Weekly | Grafana dashboard optimization |
| **Alert Rule Management** | Monthly | AlertManager configuration tuning |
| **Data Retention Management** | Daily | Prometheus and Loki retention policies |

### **4.4 Monitoring & Alerting**

| **Monitoring Domain** | **Tool** | **Scope** |
|----------------------|----------|-----------|
| **Platform Health** | Self-monitoring stack | Monitoring system health |
| **Data Collection** | Grafana Alloy metrics | Collection agent performance |
| **Storage Utilization** | 500GB monitoring data | Retention and capacity management |
| **Alert Delivery** | AlertManager status | Notification system health |

---

## **🔒 5. Security & Compliance**

⚠️ SECURITY DISCLAIMER

*The security implementations described in this document are part of ongoing baseline establishment and should not be considered production-ready specifications. Our team consists of research computing professionals, not dedicated security experts. All security measures are implemented as best-effort implementations based on industry standards. For production deployments requiring formal security validation, engage qualified security professionals for comprehensive review and approval.*

### **5.1 CIS Controls v8 Level 2 Implementation**

| **Security Control** | **Implementation** | **Compliance Status** |
|---------------------|-------------------|---------------------|
| **Monitoring Security** | Secure monitoring stack access | ✅ CIS L2 monitoring platform security |
| **Data Protection** | Monitoring data encryption and access control | ✅ CIS L2 data protection |
| **Access Controls** | SSH hardening + monitoring authentication | ✅ CIS L2 Compliant |
| **Network Security** | Dual-network isolation + firewall | ✅ Layered security controls |
| **Audit & Logging** | Comprehensive monitoring and logging | ✅ Complete event tracking |

### **5.2 Framework Compliance**

**Baseline Standards:** CIS Controls v8 Level 2, NIST AI Risk Management Framework  
**Framework:** NIST Cybersecurity Framework 2.0  
**Mapping to:** NIST SP 800-171

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.6.1** | **Compliant** | Centralized logging implementation | **2025-07-20** |
| **CIS.6.2** | **Compliant** | Security event monitoring | **2025-07-20** |
| **CIS.8.1** | **Compliant** | Comprehensive audit capabilities | **2025-07-20** |
| **CIS.12.1** | **Compliant** | Network monitoring controls | **2025-07-20** |

---

## **💾 6. Backup & Recovery**

### **6.1 Monitoring Platform Protection**

This virtual machine is protected through integration with **pbs01** (Proxmox Backup Server) providing enterprise-grade backup and recovery capabilities with monitoring-aware backup procedures ensuring observability platform preservation, dashboard configuration retention, and rapid recovery supporting critical monitoring infrastructure continuity and operational visibility.

### **6.2 Backup Configuration**

| **Backup Component** | **Schedule** | **Retention** | **Method** |
|---------------------|--------------|---------------|------------|
| **VM System Backup** | Daily at 06:00 | 30 days | pbs01 comprehensive backup |
| **Monitoring Configuration** | Real-time persistence | Continuous | Stack configuration management |
| **Dashboard Definitions** | Weekly backup | 90 days | Grafana dashboard preservation |
| **Historical Data** | Retention policies | 30-90 days | Prometheus/Loki data management |

### **6.3 Recovery Procedures**

| **Recovery Type** | **RTO** | **RPO** | **Procedure** |
|------------------|---------|---------|---------------|
| **Complete VM Restore** | <60 minutes | <24 hours | pbs01 full restoration + monitoring restart |
| **Monitoring Stack Recovery** | <45 minutes | <8 hours | Stack service restoration |
| **Dashboard Recovery** | <30 minutes | <7 days | Grafana configuration restoration |
| **Data Recovery** | <60 minutes | Variable | Historical data restoration |

---

## **📚 7. References & Documentation**

### **7.1 Monitoring Platform Standards**

| **Standard** | **Implementation** | **Documentation** |
|-------------|-------------------|-------------------|
| **Prometheus Documentation** | Metrics collection platform | [Prometheus Guides](https://prometheus.io/docs/) |
| **Grafana Documentation** | Visualization platform | [Grafana Documentation](https://grafana.com/docs/) |
| **Loki Documentation** | Log aggregation system | [Loki Documentation](https://grafana.com/docs/loki/) |

### **7.2 Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[node05](../hardware/node05-12600h-infrastructure-node.md)** | Physical host platform | Infrastructure foundation |
| **[All Cluster Infrastructure](../hardware/)** | Monitoring targets | Complete cluster coverage |
| **[pbs01](../infrastructure/backup/pbs01.md)** | Backup services | Data protection |

---

## **✅ 8. Validation & Testing**

### **8.1 Monitoring Platform Validation**

| **Test Type** | **Method** | **Expected Result** |
|--------------|------------|-------------------|
| **Stack Functionality** | Complete monitoring stack testing | All components operational |
| **Data Collection** | Grafana Alloy agent validation | Comprehensive metrics/logs collection |
| **Dashboard Access** | Grafana interface testing | Complete visualization access |
| **Alert Delivery** | AlertManager notification testing | Proper alert routing |

### **8.2 Security Testing**

| **Function** | **Validation Method** | **Success Criteria** |
|--------------|----------------------|---------------------|
| **CIS L2 Compliance** | Lynis security scanning | Maintain >85/100 score |
| **Monitoring Security** | Platform security audit | Secure monitoring access |
| **Network Security** | Dual-network validation | Proper network isolation |
| **Access Control** | Authentication testing | Restricted monitoring access |

---

## **📋 9. Conclusion**

### **9.1 Platform Summary**

proj-mon01 represents a comprehensive enterprise monitoring and observability platform implementing Prometheus, Grafana, Loki, AlertManager, and Grafana Alloy with CIS Controls v8 Level 2 security standards, providing complete infrastructure monitoring, specialized GPU and database monitoring, and comprehensive observability supporting operational excellence and infrastructure visibility across the astronomy research cluster.

### **9.2 Key Capabilities**

| **Capability** | **Implementation** | **Value** |
|---------------|-------------------|-----------|
| **Complete Monitoring Stack** | Prometheus, Grafana, Loki, AlertManager | Comprehensive observability |
| **Specialized Monitoring** | NVIDIA GPU, PostgreSQL exporters | Targeted performance tracking |
| **Dual Network Access** | Management and project VLAN monitoring | Complete infrastructure coverage |
| **Grafana Alloy** | Universal collection agent | Centralized data collection |

### **9.3 Operational Impact**

This virtual machine serves as the critical monitoring foundation enabling comprehensive infrastructure observability, performance tracking, and operational alerting across the enterprise astronomy research platform while maintaining enterprise security standards and providing essential visibility into system health, resource utilization, and operational performance.

### **9.4 Future Considerations**

Planned enhancements include expanded monitoring coverage, enhanced dashboard development, and advanced alerting optimization supporting the evolution toward comprehensive observability services and enterprise-grade monitoring supporting the growing operational visibility requirements of the astronomy platform.

---

## **📄 AI Collaboration Transparency**

**Human Author:** VintageDon - <https://github.com/vintagedon>  
**AI Contributor:** Claude (Anthropic)  
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)  
**Human Oversight:** Complete review and validation of all monitoring configurations, observability procedures, and platform implementations  

This document was collaboratively developed using systematic human-AI partnership. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and technical correctness.

Generated: 2025-07-20 | Human Author: VintageDon | AI Assistant: Claude Sonnet 4 | Review Status: Approved | Document Version: 1.0
