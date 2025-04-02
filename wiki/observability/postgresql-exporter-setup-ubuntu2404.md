<!--
---
title: "PostgreSQL Exporter Setup (Ubuntu 24.04)"
description: "How to install and configure the Prometheus PostgreSQL Exporter on a hardened Ubuntu 24.04 system."
author: "VintageDon"
tags: ["monitoring", "postgresql", "exporter", "prometheus"]
category: "Monitoring"
kb_type: "Procedure"
version: "1.0"
status: "Published"
last_updated: "2025-03-30"
---
-->

# 📄 **PostgreSQL Exporter Setup (Ubuntu 24.04)**

This guide provides step-by-step instructions to install and configure the **Prometheus PostgreSQL Exporter** on a **CIS-hardened Ubuntu 24.04 system**. This allows Prometheus to collect key PostgreSQL metrics for observability.

---

## 🔍 **1. Overview**

### **1.1 Purpose**

To provide a secure and reliable setup of `postgres_exporter` for monitoring PostgreSQL metrics via Prometheus, with consideration for hardened lab environments.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Installation and systemd setup of `postgres_exporter` | Prometheus server configuration |
| Secure connection to PostgreSQL using a read-only user | Grafana dashboard setup |
| Enabling metrics for Timescale/PostgreSQL | Exporter container deployment (covered elsewhere) |

### **1.3 Target Audience**

- Lab Engineers
- System Administrators
- Observability Engineers

---

## ⚙️ **2. Installation & Configuration**

### **2.1 Prerequisites**

- Ubuntu 24.04 (CIS-hardened recommended)
- PostgreSQL installed and running
- A PostgreSQL user with read-only access for metrics collection

### **2.2 Create PostgreSQL Monitoring User**

```sql
-- Run inside PostgreSQL
CREATE USER postgres_exporter PASSWORD 'changeme';
GRANT CONNECT ON DATABASE your_database TO postgres_exporter;
GRANT USAGE ON SCHEMA public TO postgres_exporter;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO postgres_exporter;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO postgres_exporter;
```

### **2.3 Download and Install Exporter**

```bash
# Create user
sudo useradd -rs /bin/false postgres_exporter

# Download binary (latest release from GitHub)
wget https://github.com/prometheus-community/postgres_exporter/releases/latest/download/postgres_exporter_linux_amd64.tar.gz
tar -xzf postgres_exporter_linux_amd64.tar.gz
sudo mv postgres_exporter_linux_amd64/postgres_exporter /usr/local/bin/
```

### **2.4 Set Environment Variables**

Create the file `/etc/default/postgres_exporter`:

```bash
DATA_SOURCE_NAME="postgresql://postgres_exporter:changeme@localhost:5432/your_database?sslmode=disable"
```

> 🔐 **Security Note**: Replace `changeme` and ensure this file is readable **only by root**.

```bash
sudo chmod 600 /etc/default/postgres_exporter
sudo chown root:postgres_exporter /etc/default/postgres_exporter
```

---

### **2.5 Create systemd Service**

Create `/etc/systemd/system/postgres_exporter.service`:

```ini
[Unit]
Description=Prometheus PostgreSQL Exporter
After=network.target

[Service]
User=postgres_exporter
Group=postgres_exporter
EnvironmentFile=/etc/default/postgres_exporter
ExecStart=/usr/local/bin/postgres_exporter
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable and start the service:

```bash
sudo systemctl daemon-reexec
sudo systemctl enable --now postgres_exporter
```

---

## 🔄 **3. Integration & Metrics**

### **3.1 Prometheus Job Example**

Add this block to your Prometheus config:

```yaml
- job_name: 'postgres_exporter'
  static_configs:
    - targets: ['<vm-ip>:9187']
```

> Default port is **9187**.

---

## 🔒 **4. Security & Compliance**

| **Control** | **Implementation** | **Verification** |
|-------------|---------------------|------------------|
| Principle of Least Privilege | Dedicated DB read-only user | Confirm roles in PostgreSQL |
| Hardened System | Ubuntu 24.04 CISv8 Level 2 | Audit via CIS-CAT |
| Metrics Segregation | Only exposes metrics via read-only endpoint | Confirm Prometheus job target |
| Access Control | Systemd + user isolation | `ps -aux | grep postgres_exporter` shows non-root user |

---

## 📎 **5. References & Related Resources**

### **5.1 Related KB Articles**

| **Article Title** | **KB ID** | **Relationship** |
|------------------|-----------|------------------|
| Prometheus Setup (lab-mon01) | KB-MON-001 | Parent monitoring configuration |
| PostgreSQL Timescale Setup | KB-DB-TS01 | Base database setup |

### **5.2 External References**

| **Reference Type** | **Title** | **Location** |
|--------------------|-----------|--------------|
| GitHub Repository | Prometheus PostgreSQL Exporter | [github.com/prometheus-community/postgres_exporter](https://github.com/prometheus-community/postgres_exporter) |

---

## ✅ **6. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|--------------|----------|-------------------|------------|
| VintageDon | Lead Engineer | 2025-03-30 | ✅ Approved |

---

## 📜 **7. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|-------------|----------|-------------|------------|
| 1.0 | 2025-03-30 | Initial version | VintageDon |
