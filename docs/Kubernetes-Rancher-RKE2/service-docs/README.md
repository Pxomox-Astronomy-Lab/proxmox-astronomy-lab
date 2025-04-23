<!-- 
---
title: "RKE2 Service Documentation"
description: "Documentation for core services running on the RKE2 Kubernetes cluster in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["kubernetes", "rke2", "services", "documentation"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
---
-->

# 🔧 RKE2 Service Documentation

# 🔍 1. Overview

This directory contains detailed documentation for core services operating within the Proxmox Astronomy Lab's RKE2 Kubernetes cluster. These documents provide authoritative references for the configuration, management, and operational procedures for critical Kubernetes components that support our research infrastructure.

Each service document follows our standardized knowledge base format, ensuring consistency across documentation while providing comprehensive technical details, security controls, and operational guidance.

---

# 🖥️ 2. Core Kubernetes Services

## 2.1 Management & Access Services

These services provide the foundational management layer for our Kubernetes environment.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Rancher Management** | Cluster management interface | [Rancher Management](rancher-management.md) |
| **Traefik Ingress** | Ingress controller and traffic routing | [Traefik Ingress](traefik-ingress.md) |

## 2.2 Security & Runtime Services

Services that provide security capabilities and specialized runtime support.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Cert-Manager** | Certificate lifecycle automation | [Cert-Manager](cert-manager.md) |
| **NVIDIA GPU Operator** | GPU enablement for scientific computing | [GPU Operator](gpu-operator.md) |

---

# 🗂️ 3. Directory Contents

This section provides direct navigation to all documents in this directory:

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Cert-Manager** | Automated TLS certificate management | [Cert-Manager](cert-manager.md) |
| **GPU Operator** | NVIDIA GPU enablement service | [GPU Operator](gpu-operator.md) |
| **Rancher Management** | Kubernetes management platform | [Rancher Management](rancher-management.md) |
| **Traefik Ingress** | Ingress controller configuration | [Traefik Ingress](traefik-ingress.md) |

---

# 🔄 4. Related Documentation

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Cluster Overview** | Core RKE2 architecture | [Cluster Overview](../01-rke2-cluster-overview.md) |
| **Operational Procedures** | Day-to-day management | [Operational Procedures](../operational/README.md) |
| **Cluster Upgrades** | Version management | [Cluster Upgrades](../cluster-upgrades.md) |
| **Monitoring & Alerting** | Observability configuration | [Monitoring & Alerting](../monitoring-alerting.md) |

---

# ✅ 5. Approval & Review

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |

---

# 📜 6. Change Log

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial documentation structure | VintageDon |
