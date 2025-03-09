---
title: "Redis Commander - Redis Management GUI"
description: "Documentation for Redis Commander, the graphical user interface for managing Redis databases."
author: "VintageDon"
tags: ["database", "redis", "redis commander", "gui"]
category: "Lab Services"
kb_type: "Service Documentation"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---

# **Redis Commander - Redis Management GUI**

## **1. Overview**

Redis Commander is a **web-based graphical interface** for **managing Redis instances**. It provides a user-friendly way to inspect keys, execute commands, and monitor Redis performance.

## **2. Access Information**

| **Service**          | **Hosted On**    | **Access URL**               |
|----------------------|-----------------|------------------------------|
| **Redis Commander** | `lab-apps01`     | `https://redis.beardinthe.cloud`    |

### **2.1 Authentication**

- **Login Method**: Web-based authentication (Redis credentials required).
- **User Accounts**: Authentication handled at the Redis instance level.
- **SSO Status**: Not implemented yet (planned for future update).

## **3. Features**

| **Feature**          | **Description**                                     |
|----------------------|--------------------------------------------------|
| Key Inspection      | Browse, edit, and delete Redis keys.              |
| Command Execution  | Run Redis commands directly from the GUI.         |
| Performance Monitoring | View Redis instance memory and CPU usage.      |
| Database Switching | Connect to multiple Redis databases.               |
| JSON & Hash Viewer | Structured views for JSON and hash data types.     |

## **4. Deployment Details**

- **Runs as a containerized service** on `lab-apps01`.
- **Reverse proxied via Nginx** for SSL termination.
- **Uses Redis authentication** (not integrated with external authentication at this time).

## **5. Next Steps**

✅ **Redis Commander deployed & accessible.**  
📌 **Next: Document Redis connection configurations for standard lab use.**  
📌 **Future Enhancements: Implement role-based access control & enhanced monitoring.**  

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
