<!-- 
---
title: "Project Infrastructure - Proxmox Astronomy Lab"
description: "Documentation of project-specific virtual machines, services, and workloads supporting the research and application infrastructure of the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "projects", "virtual-machines", "postgres", "timescale", "vdi", "docker"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["PostgreSQL", "TimescaleDB", "Remote Desktop", "Kasm Workspaces", "Docker"]
implements_policies: ["Data Management Policy", "Research Access Policy"]
phase: "phase-3"
---
-->

# 🔬 **Project Infrastructure - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

This section documents the **project-specific infrastructure components** that support the Proxmox Astronomy Lab's research and applications. Unlike the core infrastructure components that provide foundational services, these project VMs are dedicated to specific research workloads, data processing pipelines, and user-facing services.

The project infrastructure layer consists of **specialized virtual machines** that handle **database storage, geospatial analysis, time-series processing, application hosting, virtual desktop infrastructure, and shared file services**. These components collectively enable the lab's scientific research capabilities while providing the necessary interfaces for both internal and external collaborators.

---

# 💾 **2. Database Infrastructure**

## **2.1 PostgreSQL Database Server (proj-pg01)**

This VM provides the primary **PostgreSQL database service** for the lab, hosting structured research data, user authentication databases, and application data.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **PostgreSQL Database Server** | Core relational data storage for research data and application support | [PostgreSQL Documentation](./proj-pg01-postgresql.md) |

## **2.2 Specialized Database Services**

This component group provides specialized database capabilities for geospatial and time-series data.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **PostgreSQL with GIS (proj-pggis01)** | Spatial data storage with PostGIS extensions for astronomical coordinate mapping | [PostgreSQL GIS Documentation](./proj-pggis01-prostresql-with-gis.md) |
| **TimescaleDB (proj-pgts01)** | Time-series database optimized for astronomical observations and sensor data | [TimescaleDB Documentation](./proj-pgts01-timescale.md) |

---

# 👥 **3. User Access Infrastructure**

## **3.1 Remote Access Services**

These components provide secure, controlled access to lab resources for both internal and external users.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Remote Desktop Services (proj-rds01)** | Windows-based remote desktop environment for research tools and analysis | [RDS Documentation](./proj-rds01-staff-vdi.md) |
| **Kasm Workspaces (proj-kasm01)** | Browser-based virtual workspaces for secure remote collaboration | [Kasm Documentation](./proj-kasm01-kasm-workspaces-vdi-server.md) |

---

# 🖥️ **4. Application & Storage Infrastructure**

## **4.1 Application Hosting**

This component provides containerized application hosting for research-specific services.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Docker Application Node (proj-apps01)** | Containerized applications for research and data visualization | [Docker Apps Documentation](./proj-apps01-docker-application-node.md) |

## **4.2 Shared Storage**

This component provides structured file storage for research documentation and datasets.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **File Server (proj-fs01)** | Active Directory-integrated file shares for research data and documentation | [File Server Documentation](./proj-fs01-active-directory-file-shares.md) |

---

# 🔗 **5. Directory Contents**

This section provides direct navigation to all key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **PostgreSQL Database** | Documentation for proj-pg01 | [proj-pg01-postgresql.md](./proj-pg01-postgresql.md) |
| **PostgreSQL with GIS** | Documentation for proj-pggis01 | [proj-pggis01-prostresql-with-gis.md](./proj-pggis01-prostresql-with-gis.md) |
| **TimescaleDB** | Documentation for proj-pgts01 | [proj-pgts01-timescale.md](./proj-pgts01-timescale.md) |
| **Remote Desktop Services** | Documentation for proj-rds01 | [proj-rds01-staff-vdi.md](./proj-rds01-staff-vdi.md) |
| **Kasm Workspaces** | Documentation for proj-kasm01 | [proj-kasm01-kasm-workspaces-vdi-server.md](./proj-kasm01-kasm-workspaces-vdi-server.md) |
| **Docker Applications** | Documentation for proj-apps01 | [proj-apps01-docker-application-node.md](./proj-apps01-docker-application-node.md) |
| **File Server** | Documentation for proj-fs01 | [proj-fs01-active-directory-file-shares.md](./proj-fs01-active-directory-file-shares.md) |

---

# 🔄 **6. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Control Plane** | Core services supporting project infrastructure | [Control Plane Documentation](/infrastructure/control-plane/README.md) |
| **Kubernetes** | Container orchestration related to project deployments | [Kubernetes Documentation](/infrastructure/kubernetes/README.md) |
| **Observatory Hardware** | Data acquisition hardware feeding project databases | [Observatory Hardware Documentation](/infrastructure/observatory-hardware/README.md) |
| **Applications** | Software utilizing project infrastructure | [Applications Documentation](/docs/Applications/README.md) |
| **Research Projects** | Scientific work leveraging project infrastructure | [Research Projects Documentation](/docs/Research-Projects/README.md) |

---

# ✅ **7. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **8. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for project infrastructure | VintageDon |
