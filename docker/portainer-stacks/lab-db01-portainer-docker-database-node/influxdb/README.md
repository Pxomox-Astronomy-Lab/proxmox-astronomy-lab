# **InfluxDB Stack**

## **Overview**

InfluxDB is an open-source time series database (TSDB) designed for high-performance storage and retrieval of time-stamped data. It is commonly used for monitoring, analytics, and real-time data applications, offering a SQL-like query language and seamless integrations with visualization tools like Grafana.

**Official Website:** [InfluxDB Official Website](https://www.influxdata.com/products/influxdb/)

## Role in the Lab

This deployment of InfluxDB is designed as a lightweight metrics ingestion service for the Proxmox Astronomy Lab. It specifically collects Proxmox cluster metrics, utilizing only the metrics server option in Proxmox. Due to the minimal resource footprint of Proxmox metrics, this instance is optimized for efficiency while maintaining essential data visibility.

Data Retention: 90-day retention for all buckets (aligning with CISv8.1 minimum retention standards).

Primary Data Source: Proxmox Metrics Server.

Bucket Name: proxmox_cluster_metrics.

This ensures that historical cluster performance data remains available for compliance, monitoring, and analysis without excessive storage consumption.

## **Stack Components**

- **`docker-compose.yml`** – Defines the InfluxDB service configuration, including versioning, ports, and volumes.
- **`.env.example`** – Provides a template for environment variables, containing example credentials and configurations.
- **`.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/influxdb-stack.git
   ```

2. **Navigate to the InfluxDB Stack Directory:**

   ```bash
   cd influxdb-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp .env.example .env
     ```

   - Edit `.env` and configure required values such as:

     ```ini
     INFLUXDB_INIT_USERNAME=admin
     INFLUXDB_INIT_PASSWORD=securepassword
     INFLUXDB_INIT_ORG=Lab
     INFLUXDB_INIT_BUCKET=proxmox_cluster_metrics
     ```

4. **Deploy the Stack Using Portainer:**
   - Navigate to **Portainer → Stacks**.
   - Create a **new stack** and select **Git Repository**.
   - Enter the repository URL:

     ```
     https://gitea.beardinthe.cloud/Portainer_Stacks/influxdb-stack.git
     ```

   - Deploy the stack.

5. **(Optional) Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

6. **Access the InfluxDB UI:**
   - Open your browser and go to `http://localhost:8086`.
   - Log in using the credentials specified in `.env`.

## **Additional Resources**

- **InfluxDB Documentation:** [https://docs.influxdata.com/](https://docs.influxdata.com/)
- **InfluxDB GitHub Repository:** [https://github.com/influxdata/influxdb](https://github.com/influxdata/influxdb)
- **Community Support:** [InfluxData Community Forums](https://community.influxdata.com/)
