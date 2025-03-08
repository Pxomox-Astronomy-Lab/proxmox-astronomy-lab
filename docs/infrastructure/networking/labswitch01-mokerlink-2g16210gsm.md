---
title: "LabSwitch01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of LabSwitch01, including infrastructure, security, compliance, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "networking", "switching", "proxmox"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.1"
status: "Draft"
last_updated: "2025-03-07"
---

# **LabSwitch01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

LabSwitch01 is the **primary network switch** for the Proxmox Astronomy Lab, responsible for **VLAN segmentation, network traffic optimization, and high-speed connectivity** between compute nodes, storage, and virtualized workloads. It provides **L3 routing, link aggregation (LAG), jumbo frame support, and port security** to ensure **low-latency and high-throughput operations** across the lab’s infrastructure【83:0†proxmox-astronomy-lab-hardware-overview.md】.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | NET-SW01 |
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
| **Throughput** | 10Gbps for storage, 2.5Gbps for compute | Interface statistics |
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

LabSwitch01 is a **Mokerlink 2G16210GSM** managed switch with **16 × 2.5G RJ45 ports and 2 × 10G SFP uplinks**【83:0†proxmox-astronomy-lab-hardware-overview.md】. It provides **VLAN-based segmentation, inter-VLAN routing, and network redundancy** across all infrastructure components.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Device Name** | LabSwitch01 |
| **Model** | Mokerlink 2G16210GSM |
| **Firmware** | Latest Stable Release |
| **Ports** | 16 × 2.5G RJ45, 2 × 10G SFP |
| **Networking** | VLAN segmentation for compute, storage, and control plane traffic |
| **Management** | Web UI, CLI, API access |

### **3.3 VLAN Configuration**  

| **VLAN ID** | **Purpose** | **Subnet** |
|------------|------------|------------|
| 5 | Management | 192.168.5.0/24 |
| 10 | Control Plane | 192.168.10.0/24 |
| 20 | Production | 192.168.20.0/24 |
| 30 | Development | 192.168.30.0/24 |
| 40 | Provisioning | 192.168.40.0/24 |
| 50 | Migration | 192.168.50.0/24 |
| 60 | ClusterFail | 192.168.60.0/24 |

### **3.4 Port Mapping**  

| **Port** | **Usage** |
|---------|----------|
| 1-4 | Management & Control Plane (VLAN5, VLAN10) |
| 5-12 | Compute Nodes (VLAN10, VLAN20) |
| 13-16 | Storage (VLAN50) |
| SFP+ 1-2 | 10Gbps Uplinks to LabSwitch02 (LAG) |

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
