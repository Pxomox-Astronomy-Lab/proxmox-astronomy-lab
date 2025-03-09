# **Grafana - Project-Level Data Visualization**

## **1. Service Overview**

Grafana is an **open-source analytics and visualization platform** designed for real-time monitoring and interactive dashboards. It supports a variety of **data sources, alerting mechanisms, and visualization tools**, making it an essential component for **data-driven insights**.

In **Proj-Apps01**, Grafana is deployed specifically for **project-level visualizations**, integrating with **big data databases, microservices, and select pipeline dashboards from `mon01`**.

## **2. Purpose & Scope**

This service provides **interactive and queryable dashboards** for project-specific monitoring and data analytics. It offers:

- **Big Data Analytics Dashboards** – Connects to **large-scale research and analytics databases**.
- **Microservices Metrics & Insights** – Integrates with **project-specific database sources** for real-time visualization.
- **Pipeline Monitoring Dashboards** – Select **workflow dashboards pulled from `mon01`**, providing insight into CI/CD, data pipelines, and automated processes.
- **Multi-Tenant Access Control** – Allows **team-based access to project dashboards**.
- **Custom Queries & Alerts** – Enables **query-based data exploration and real-time alerts**.

## **3. Service Architecture**

### **3.1. Grafana Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Grafana Version**            | `10.2.2`                        |
| **Database Backend**           | `PostgreSQL (lab-db01)`         |
| **Authentication**             | `Internal (Future Entra ID)`    |
| **Primary Data Sources**       | `Big Data DBs, Microservices DBs, Mon01 Pipelines` |
| **Access Control**             | `Role-Based & Team-Based`       |

### **3.2. Dependencies & Integration**

| Dependency                     | Role in Grafana Service           |
|--------------------------------|---------------------------------|
| **PostgreSQL (`lab-db01`)**    | Stores Grafana settings & metadata |
| **Big Data Databases**         | Provides research data sources for dashboards |
| **Microservices Databases**    | Supplies project-specific metrics & logging |
| **Grafana (`mon01`)**          | Pulls select dashboards for pipeline monitoring |
| **Reverse Proxy (Nginx Proxy Manager)** | Secures external Grafana access |

## **4. Security & Compliance Considerations**

- **Role-Based Access Control (RBAC):** Users and teams are assigned access to specific dashboards.
- **Encrypted Data at Rest:** All configurations and credentials are stored securely.
- **Audit Logging Enabled:** Tracks dashboard edits, queries, and login attempts.
- **Integration with Future Entra ID Authentication:** Planned for single sign-on (SSO) security.

## **5. Change Management**

All modifications to this service (including data source configurations, access policies, and dashboard management) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **6. Related Documentation**

- [PostgreSQL (`lab-db01`)](../database/postgresql-lab-db01.md)
- [Big Data Storage & Pipelines] (Internal KB Reference)
- [Grafana (`mon01`)](../monitoring/grafana-mon01.md)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)
