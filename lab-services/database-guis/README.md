<!-- ---
title: "Database & Storage GUIs - Proxmox Astronomy Lab"
description: "Documentation for web-based database and storage management interfaces."
author: "VintageDon"
tags: ["database", "storage", "gui", "admin tools"]
category: "Lab Services"
kb_type: "Service Overview"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **Database & Storage GUIs Overview**

## **1. Purpose**

This directory contains **web-based graphical user interfaces (GUIs)** for managing lab databases and object storage. These tools provide **staff with direct, user-friendly access** to query, monitor, and maintain database systems.

## **2. Available Interfaces**

The following services are deployed within the lab:

| **Service**          | **Description**                                      | **Hosted On**    | **Access URL**                 |
|----------------------|--------------------------------------------------|-----------------|---------------------------------|
| **pgAdmin**         | PostgreSQL database management tool             | `lab-apps01`     | `https://pgadmin.beardinthe.cloud`     |
| **phpMyAdmin**      | GUI for MariaDB/MySQL administration            | `lab-apps01`     | `https://phpmyadmin.beardinthe.cloud`  |
| **Redis Commander** | Web UI for Redis key-value store                 | `lab-apps01`     | `https://redis.beardinthe.cloud`       |
| **Milvus Insight**  | GUI for Milvus Vector Database (AI workloads)    | `lab-apps01`     | `https://milvus.beardinthe.cloud`      |
| **MinIO Console**   | Object storage management UI                     | `mon01`          | `https://minio.beardinthe.cloud`       |

## **3. Deployment & Dependencies**

All GUIs run as **containerized applications** on designated infrastructure nodes. Their configurations include:

- **Reverse Proxy Access** via Nginx (on `lab-apps01`)
- **TLS Encryption** via internal certificates
- **Authentication via GUI-based login (no SSO yet)**

## **4. Next Steps**

✅ **All database GUIs deployed & documented.**  
📌 **Next: Validate role-based access control for each service.**  
📌 **Future Enhancements: Implement SSO authentication & centralized logging.**  

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ⏳ In Progress |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

