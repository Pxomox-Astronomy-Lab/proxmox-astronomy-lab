<!-- ---
title: "Attu - Milvus Vector Database Management GUI"
description: "Documentation for Attu, the graphical user interface for managing Milvus vector database instances."
author: "VintageDon"
tags: ["database", "milvus", "vector database", "attu", "gui"]
category: "Lab Services"
kb_type: "Service Documentation"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **Attu - Milvus Vector Database Management GUI**

## **1. Overview**  

Attu is a **web-based management tool** for **Milvus vector databases**, providing an intuitive UI for querying, managing, and visualizing vector search workloads. It is essential for handling **AI/ML-driven datasets** within the lab's research environment.  

📌 **Attu Data Explorer Screenshot:**  
![milvus-attu-data-explorer](/assets/images/milvus-attu-data-explorer.png)  

### **1.1 External Resources**  

- **Milvus Official Website**: [https://milvus.io](https://milvus.io)  
- **Attu GitHub Repository**: [https://github.com/zilliztech/attu](https://github.com/zilliztech/attu)  

## **2. Access Information**

| **Service**  | **Hosted On**    | **Access URL**                  |
|-------------|-----------------|----------------------------------|
| **Attu**    | `lab-apps01`     | `https://milvus.beardinthe.cloud` |

### **2.1 Authentication**

- **Login Method**: Web-based authentication (database credentials required).
- **User Accounts**: Local authentication within Milvus.
- **SSO Status**: Not implemented yet (planned for future update).

## **3. Features**

| **Feature**             | **Description**                                      |
|-------------------------|--------------------------------------------------|
| Vector Search Queries  | Run and visualize vector similarity searches.    |
| Database Management    | Create, modify, and delete collections.          |
| Index Configuration    | Set up and manage indexing strategies.           |
| Performance Monitoring | View real-time Milvus instance statistics.       |
| Multi-Node Management | Connect to and manage distributed Milvus clusters. |

## **4. Deployment Details**

- **Runs as a containerized service** on `lab-apps01`.
- **Reverse proxied via Nginx** for SSL termination.
- **Uses Milvus authentication** (no external authentication at this time).

## **5. Next Steps**

✅ **Attu deployed & accessible.**  
📌 **Next: Document vector search best practices for lab research.**  
📌 **Future Enhancements: Implement role-based access control & expanded monitoring.**  

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ⏳ In Progress |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation, renamed to Attu | VintageDon |

