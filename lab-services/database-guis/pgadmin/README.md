---
title: "pgAdmin - PostgreSQL Management GUI"
description: "Documentation for pgAdmin, the graphical user interface for PostgreSQL database management."
author: "VintageDon"
tags: ["database", "postgresql", "pgadmin", "gui"]
category: "Lab Services"
kb_type: "Service Documentation"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---

# **pgAdmin - PostgreSQL Management GUI**

## **1. Overview**

pgAdmin is the **official web-based GUI for managing PostgreSQL databases** in the lab. It provides an intuitive interface for querying, modifying, and administering PostgreSQL instances.

## **2. Access Information**

| **Service**  | **Hosted On**    | **Access URL**                |
|-------------|-----------------|-------------------------------|
| **pgAdmin** | `lab-apps01`     | `https://pgadmin.beardinthe.cloud`   |

### **2.1 Authentication**

- **Login Method**: Web-based authentication (admin credentials required).
- **User Accounts**: Local accounts configured per team requirements.
- **SSO Status**: Not implemented yet (planned for future update).

## **3. Features**

| **Feature**              | **Description**                                      |
|--------------------------|--------------------------------------------------|
| Database Querying        | Run SQL queries and visualize results.            |
| Schema Management       | Create, modify, and delete schemas and tables.    |
| User & Role Management  | Configure PostgreSQL access control.              |
| Backup & Restore        | Perform database exports and imports.             |
| Performance Monitoring  | View live database statistics.                     |

## **4. Deployment Details**

- **Runs as a containerized service** on `lab-apps01`.
- **Reverse proxied via Nginx** for SSL termination.
- **Uses internal PostgreSQL authentication** (not LDAP/SSO at this time).

## **5. Next Steps**

✅ **pgAdmin deployed & accessible.**  
📌 **Next: Document database connection configurations for standard lab use.**  
📌 **Future Enhancements: Implement centralized authentication & role-based access control.**  

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
