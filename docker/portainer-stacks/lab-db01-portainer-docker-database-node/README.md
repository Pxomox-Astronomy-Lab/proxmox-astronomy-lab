# **Lab-DB01 Portainer - Docker Database Node**

## **Overview**

The `lab-db01` node serves as the **primary database host** for containerized database workloads in the Proxmox Astronomy Lab. This node is managed via **Portainer** and is dedicated to hosting **core database services**, ensuring reliable, structured data storage across the lab infrastructure.

📌 **This directory contains multiple database-related stacks, each with its own subdirectory.**

---

## **Role of Lab-DB01 in the Lab**

`Lab-DB01` is responsible for **storing and managing structured data** across multiple research and operational applications. It provides:

- **Relational Databases** for application backends.
- **NoSQL Databases** for high-performance workloads.
- **Time-Series Databases** for real-time data collection.
- **Caching & Messaging Services** to optimize system efficiency.

This ensures **efficient, persistent, and structured storage** for both **lab-wide and research-specific** workloads.

---

## **Stacks Deployed on Lab-DB01**

Each database service is deployed as a **stack within Portainer**, ensuring modularity and ease of management.

### **1. PostgreSQL (Relational Database Service)**

📂 **[PostgreSQL Stack](postgresql/README.md)**

- Provides a **general-purpose relational database**.
- Used for structured data storage for various applications.
- Supports advanced features such as GIS extensions via PostGIS.

### **2. MariaDB (Alternative SQL Database)**

📂 **[MariaDB Stack](mariadb/README.md)**

- A **lightweight SQL database** optimized for **web applications**.
- Supports high-availability clustering.

### **3. MongoDB (NoSQL Document Database)**

📂 **[MongoDB Stack](mongodb/README.md)**

- A **high-performance document-oriented database**.
- Ideal for applications requiring **flexible, JSON-based storage**.

### **4. InfluxDB (Time-Series Database)**

📂 **[InfluxDB Stack](influxdb/README.md)**

- Optimized for **time-series data storage and retrieval**.
- Used for **sensor data, monitoring metrics, and SDR data streams**.

### **5. Redis (Caching & Key-Value Store)**

📂 **[Redis Stack](redis/README.md)**

- **In-memory key-value store** for caching and rapid lookups.
- Used to **accelerate query performance** across various applications.

### **6. RabbitMQ (Messaging Queue Service)**

📂 **[RabbitMQ Stack](rabbitmq/README.md)**

- Message broker for **event-driven architectures**.
- Used for **asynchronous communication between services**.

---

## **Deployment & Management**

- All database stacks are managed via **Portainer**.
- Updates and changes are handled through **GitOps** workflows.
- Repositories for stacks are stored under:

  ```
  https://gitea.beardinthe.cloud/Portainer_Stacks/
  ```

- Each stack follows the **structured folder format**:

  ```
  /docker/portainer-stacks/lab-db01-portainer-docker-database-node/
  │── postgresql/
  │   ├── README.md
  │   ├── docker-compose.yml
  │   ├── stack.env.example
  │── mariadb/
  │   ├── README.md
  │── mongodb/
  │   ├── README.md
  │── influxdb/
  │   ├── README.md
  │── redis/
  │   ├── README.md
  │── rabbitmq/
  │   ├── README.md
  ```

---

## **Next Steps**

- Refer to individual **database stack READMEs** for setup details.
- Ensure proper data persistence configurations for each service.
- Follow **GitOps workflows** for database stack management.

🚀 **Lab-DB01 ensures structured, efficient, and scalable database management for all research and operational applications in the lab.**
