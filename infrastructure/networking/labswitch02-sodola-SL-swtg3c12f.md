<!-- ---
title: "LabSwitch02 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of LabSwitch02, including infrastructure, security, compliance, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "networking", "switching", "proxmox"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **LabSwitch02 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

LabSwitch02 is the **secondary network switch** for the Proxmox Astronomy Lab, responsible for **10Gbps interconnects, aggregation of high-speed traffic, and storage network segmentation**. It provides **L3 routing, link aggregation (LAG), jumbo frame support, and security enforcement** to optimize **data transfer rates between compute nodes, storage appliances, and key infrastructure services**【83:0†proxmox-astronomy-lab-hardware-overview.md】.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | NET-SW02 |
| **Service Type**   | Network Infrastructure |
| **Service Category** | Switching |
| **Business Criticality** | High |
| **Service Owner**  | Lab Engineer |

### **1.3 Service Hours**  

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 |
| **Support Hours** | Best-effort during business hours |
| **Maintenance Windows** | As required, change-controlled |

---

## **2. Service Level Agreements**  

### **2.1 Service Level Targets**  

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Network Availability** | 99.99% uptime | Prometheus alerts |
| **Latency** | ≤ 2ms internal, ≤ 5ms external | Grafana network monitoring |
| **Throughput** | 10Gbps for compute/storage traffic | Interface statistics |
| **Recovery Time** | RTO: 2 hours | Configuration restore test |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Network health and uptime monitoring |
| **Grafana** | Traffic visualization and performance analysis |
| **Loki** | Log aggregation for debugging |
| **Wazuh** | Security monitoring and intrusion detection |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

LabSwitch02 is a **Sodola SL-SWTG3C12F** managed switch with **12 × 10G SFP+ ports**【83:0†proxmox-astronomy-lab-hardware-overview.md】. It functions as the **primary high-speed aggregation switch**, ensuring **efficient communication between storage, compute, and research workloads**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Device Name** | LabSwitch02 |
| **Model** | Sodola SL-SWTG3C12F |
| **Firmware** | Latest Stable Release |
| **Ports** | 12 × 10G SFP+ |
| **Networking** | High-speed data transfer and network backbone aggregation |
| **Management** | Web UI, CLI, API access |

### **3.3 VLAN Configuration**  

| **VLAN ID** | **Purpose** | **Subnet** |
|------------|------------|------------|
| 5 | Management | 192.168.5.0/24 |
| 10 | Control Plane | 192.168.10.0/24 |
| 20 | Production | 192.168.20.0/24 |
| 50 | Storage/Migration | 192.168.50.0/24 |
| 60 | ClusterFail | 192.168.60.0/24 |

### **3.4 Port Mapping**  

| **Port** | **Usage** |
|---------|----------|
| 1-4 | Storage (VLAN50) |
| 5-8 | Compute Nodes (VLAN10, VLAN20) |
| 9-10 | Interconnect to LabSwitch01 (LAG) |
| 11-12 | Reserved for future expansion |

---

## **4. Service Management**  

### **4.1 Access Management**  

| **User Role** | **Access Level** | **Authorization Process** |
|--------------|----------------|---------------------------|
| **Lab Engineer** | Full Admin | CLI & Web UI Access |
| **Network Admin** | Configuration Management | Role-Based Access |
| **Infrastructure Ops** | Read-Only Monitoring | Role-Based |
| **Service Desk** | Limited Read | Ticket-Only Access |
| **Change Manager** | Approves network changes | ITIL CAB Process |

### **4.2 Incident Management**  

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Switch Failure** | High | P1 | 15 min | 2 hours |
| **Network Outage** | High | P1 | 15 min | 2 hours |
| **Performance Degradation** | Medium | P2 | 30 min | 6 hours |

---

## **5. Security and Compliance**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CISv8.1 Level 1 (Networking) |
| **Security Monitoring** | NIST 800-53 |
| **Backup & Recovery** | ISO 27001 |

---

## **6. Related Documentation**  

| **Document Type** | **Document Name** |
|-------------------|-------------------|
| **Infrastructure Overview** | Proxmox Astronomy Lab Network Architecture |
| **Security Policy** | CISv8 Compliance Framework |

---


