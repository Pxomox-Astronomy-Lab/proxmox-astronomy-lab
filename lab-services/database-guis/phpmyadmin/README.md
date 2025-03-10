<!-- ---
title: "phpMyAdmin - MySQL/MariaDB Management GUI"
description: "Documentation for phpMyAdmin, the graphical user interface for managing MySQL/MariaDB databases."
author: "VintageDon"
tags: ["database", "mysql", "mariadb", "phpmyadmin", "gui"]
category: "Lab Services"
kb_type: "Service Documentation"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **phpMyAdmin - MySQL/MariaDB Management GUI**

## **1. Overview**

phpMyAdmin is a **web-based database administration tool** for **MySQL/MariaDB**. It provides an intuitive interface for managing databases, tables, users, and permissions.

## **2. Access Information**

| **Service**      | **Hosted On**    | **Access URL**                     |
|-----------------|-----------------|-------------------------------------|
| **phpMyAdmin**  | `lab-apps01`     | `https://phpmyadmin.lab.local`     |

### **2.1 Authentication**

- **Login Method**: Web-based authentication (database user credentials required).
- **User Accounts**: Credentials managed within MySQL/MariaDB.
- **SSO Status**: Not implemented yet (planned for future update).

## **3. Features**

| **Feature**              | **Description**                                      |
|--------------------------|--------------------------------------------------|
| Database Querying        | Run SQL queries and visualize results.            |
| Table Management        | Create, modify, and delete tables.                 |
| User & Privilege Management | Configure database users and access control.    |
| Export & Import         | Perform database backups and restores.             |
| Server Monitoring       | View live MySQL/MariaDB statistics.                 |

## **4. Deployment Details**

- **Runs as a containerized service** on `lab-apps01`.
- **Reverse proxied via Nginx** for SSL termination.
- **Uses database authentication** (no external authentication at this time).

## **5. Next Steps**

✅ **phpMyAdmin deployed & accessible.**  
📌 **Next: Document MySQL/MariaDB connection configurations for standard lab use.**  
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

