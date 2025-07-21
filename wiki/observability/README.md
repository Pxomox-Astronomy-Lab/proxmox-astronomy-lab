# 📊 **Observability**

This wiki section provides practical how-to guides for observability and monitoring systems across the Proxmox Astronomy Lab infrastructure. The documentation covers essential monitoring setup procedures including database monitoring, email system monitoring, and GPU performance tracking using Prometheus exporters and Grafana dashboards for comprehensive infrastructure visibility.

## **Overview**

Observability represents a critical component of enterprise infrastructure management, providing comprehensive visibility into system performance, resource utilization, and operational health across the 7-node hybrid Kubernetes and VM architecture. The Proxmox Astronomy Lab implements a comprehensive observability stack using Prometheus for metrics collection, Grafana for visualization, and Loki for log aggregation following the "if it can be collected, we do" philosophy. The monitoring architecture includes specialized exporters for PostgreSQL databases, NVIDIA GPU performance tracking, and SMTP email system monitoring ensuring complete infrastructure visibility.

This wiki provides hands-on procedures for monitoring engineers, infrastructure teams, and system administrators implementing observability solutions. Each guide covers tested procedures specific to Ubuntu 24.04 deployments with considerations for enterprise monitoring requirements and integration with the centralized mon01 monitoring stack.

---

## **📂 Directory Contents**

This section provides navigation to all observability setup guides and procedures.

### **📋 Core Exporter Setup**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[postgresql-exporter-setup-ubuntu2404.md](postgresql-exporter-setup-ubuntu2404.md)** | PostgreSQL database monitoring setup on Ubuntu 24.04 | Database performance and health monitoring |
| **[smtp-exporter-setup-ubuntu2404.md](smtp-exporter-setup-ubuntu2404.md)** | SMTP email system monitoring configuration | Email system health and delivery monitoring |
| **[nvidia-gpu-exporter-setup-ubuntu2404.md](nvidia-gpu-exporter-setup-ubuntu2404.md)** | NVIDIA GPU performance monitoring setup | GPU utilization and thermal monitoring |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[monitoring-troubleshooting-guide.md](monitoring-troubleshooting-guide.md)** | Common monitoring issues and resolution procedures | Monitoring engineers |
| **[grafana-dashboard-configuration.md](grafana-dashboard-configuration.md)** | Setting up and customizing Grafana dashboards | Infrastructure teams |

---

## **🏗️ Repository Structure**

```markdown
wiki/observability/
├── README.md                                    # This overview document
├── postgresql-exporter-setup-ubuntu2404.md     # PostgreSQL monitoring setup (existing)
├── smtp-exporter-setup-ubuntu2404.md           # SMTP email monitoring setup
├── nvidia-gpu-exporter-setup-ubuntu2404.md     # NVIDIA GPU monitoring setup
├── monitoring-troubleshooting-guide.md         # Monitoring system troubleshooting
└── grafana-dashboard-configuration.md          # Grafana dashboard management
```

---

## **🔧 Lab Monitoring Architecture**

The observability stack centers around **mon01** with comprehensive monitoring coverage:

### **Core Monitoring Stack**

| **Component** | **Purpose** | **Integration** |
|---------------|-------------|-----------------|
| **Prometheus** | Metrics collection and storage | Central metrics aggregation |
| **Grafana** | Visualization and dashboards | Unified monitoring interface |
| **Loki** | Log aggregation and analysis | Centralized log management |
| **AlertManager** | Alert routing and notification | Proactive issue notification |
| **Grafana Alloy** | Metrics and logging agent | Distributed metrics collection |

### **Specialized Exporters**

| **Exporter** | **Target Systems** | **Metrics Coverage** |
|--------------|-------------------|---------------------|
| **PostgreSQL Exporter** | proj-pg01, proj-pgsql02 | Database performance, connections, query metrics |
| **SMTP Exporter** | Email infrastructure | Mail delivery success, queue depths, response times |
| **NVIDIA GPU Exporter** | proj-gpu01 (RTX A4000) | GPU utilization, temperature, memory usage, power draw |
| **Node Exporter** | All Ubuntu 24.04 VMs | System metrics, CPU, memory, disk, network |
| **SNMP Exporter** | Network switches | Network interface statistics, bandwidth utilization |

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **Observability Integration** |
|--------------|------------------|------------------------------|
| **[databases/](../databases/README.md)** | Database monitoring | PostgreSQL exporter and stats user configuration |
| **[k8s/](../k8s/README.md)** | Kubernetes monitoring | Container and cluster metrics collection |
| **[docker/](../docker/README.md)** | Container monitoring | Docker container metrics and logging |

### **Platform Integration**

| **Category** | **Relationship** | **Observability Integration** |
|--------------|------------------|------------------------------|
| **[ai/](../../ai/README.md)** | GPU monitoring | NVIDIA exporter for ML workload monitoring |
| **[security/](../../security/README.md)** | Security monitoring | Log analysis and alert correlation |
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Monitoring automation | Ansible-driven exporter deployment |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within observability implementation.

### **For Monitoring Engineers**

**Start Here:** [postgresql-exporter-setup-ubuntu2404.md](postgresql-exporter-setup-ubuntu2404.md)  
**Email Monitoring:** [smtp-exporter-setup-ubuntu2404.md](smtp-exporter-setup-ubuntu2404.md)  
**GPU Monitoring:** [nvidia-gpu-exporter-setup-ubuntu2404.md](nvidia-gpu-exporter-setup-ubuntu2404.md)  
**Dashboard Setup:** [grafana-dashboard-configuration.md](grafana-dashboard-configuration.md)

### **For Infrastructure Engineers**

**Start Here:** [grafana-dashboard-configuration.md](grafana-dashboard-configuration.md)  
**Database Monitoring:** [postgresql-exporter-setup-ubuntu2404.md](postgresql-exporter-setup-ubuntu2404.md)  
**System Monitoring:** [nvidia-gpu-exporter-setup-ubuntu2404.md](nvidia-gpu-exporter-setup-ubuntu2404.md)  
**Troubleshooting:** [monitoring-troubleshooting-guide.md](monitoring-troubleshooting-guide.md)

### **For System Administrators**

**Start Here:** [monitoring-troubleshooting-guide.md](monitoring-troubleshooting-guide.md)  
**Service Monitoring:** [smtp-exporter-setup-ubuntu2404.md](smtp-exporter-setup-ubuntu2404.md)  
**Performance Monitoring:** [nvidia-gpu-exporter-setup-ubuntu2404.md](nvidia-gpu-exporter-setup-ubuntu2404.md)  
**Database Health:** [postgresql-exporter-setup-ubuntu2404.md](postgresql-exporter-setup-ubuntu2404.md)

### **For Research Engineers**

**Start Here:** [nvidia-gpu-exporter-setup-ubuntu2404.md](nvidia-gpu-exporter-setup-ubuntu2404.md)  
**Database Performance:** [postgresql-exporter-setup-ubuntu2404.md](postgresql-exporter-setup-ubuntu2404.md)  
**Dashboard Access:** [grafana-dashboard-configuration.md](grafana-dashboard-configuration.md)  
**Issue Resolution:** [monitoring-troubleshooting-guide.md](monitoring-troubleshooting-guide.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: prometheus, grafana, postgresql-exporter, smtp-exporter, nvidia-gpu-exporter, monitoring
