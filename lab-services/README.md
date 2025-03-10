<!-- ---
title: "Lab Services - Proxmox Astronomy Lab"
description: "Overview of persistent lab-wide services, including database and storage management GUIs."
author: "VintageDon"
tags: ["lab services", "database", "storage", "monitoring", "tools"]
category: "Lab Services"
kb_type: "Service Overview"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **Lab Services Overview**

## **1. Purpose**

The **Lab Services directory** houses documentation for **persistent, lab-wide tools** that provide essential **administration, monitoring, and management functionality**. These services are **not node-specific** but are instead **shared across the lab infrastructure**.

## **2. Categories of Services**

The lab services are structured into **logical groups** to ensure easy access and clear documentation.

### **2.1 Database & Storage GUIs**

These web-based interfaces allow **staff-level access** to database and storage management tools.
📌 **[Database & Storage GUIs →](./database-guis/README.md)**

| **Service**          | **Purpose**                                   |
|----------------------|----------------------------------------------|
| **pgAdmin**         | PostgreSQL management GUI                    |
| **phpMyAdmin**      | MariaDB/MySQL database management            |
| **Redis Commander** | Redis key-value store visualization          |
| **Milvus Insight**  | GUI for Milvus Vector Database (AI workloads) |
| **MinIO Console**   | Web UI for MinIO object storage              |

## **3. Service Hosting & Access**

All services run in **containerized environments** on designated infrastructure nodes. Their access URLs are configured using **internal DNS**.

| **Service**          | **Hosted On**    | **Access URL**                 |
|----------------------|-----------------|---------------------------------|
| **pgAdmin**         | `lab-apps01`     | `https://pgadmin.lab.local`     |
| **phpMyAdmin**      | `lab-apps01`     | `https://phpmyadmin.lab.local`  |
| **Redis Commander** | `lab-apps01`     | `https://redis.lab.local`       |
| **Milvus Insight**  | `lab-apps01`     | `https://milvus.lab.local`      |
| **MinIO Console**   | `mon01`          | `https://minio.lab.local`       |

## **4. Next Steps**

✅ **Primary database GUIs deployed & documented.**  
📌 **Next: Ensure all necessary staff access is configured.**  
📌 **Future Enhancements: Automate GUI deployments via Ansible.**  

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

