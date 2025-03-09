# **PostgreSQL Stack**

## **Overview**

PostgreSQL is an advanced, **open-source relational database management system (RDBMS)** known for its reliability, extensibility, and SQL compliance. It is widely used for **enterprise applications, microservices, and general-purpose database workloads**.

PostgreSQL supports advanced features such as **JSON storage, indexing, full-text search, and strong ACID compliance**, making it an ideal choice for structured data storage.

**Official Website:** [PostgreSQL Official Website](https://www.postgresql.org/)

## **Role in the Lab**

This deployment of PostgreSQL is used within the **Proxmox Astronomy Lab** for **lightweight application databases** that require structured SQL storage. Unlike the **primary research databases**, which are optimized for large-scale data processing, this PostgreSQL instance is designed for:

- **Lab-level applications** that require a SQL database.
- **Microservices** and lightweight services that need structured storage.
- **General-purpose transactional workloads** that do not require a dedicated research database.
- **Persistent storage** with dedicated volumes for reliability and backups.
- **Authentication & Security:** Supports both **traditional .env-based credentials** and **Vault-based secret management** for secure deployments.

## **Stack Components**

- **`docker-compose.yml`** – Defines the PostgreSQL service configuration, including versioning, ports, and volumes.
- **`stack.env.example`** – Provides a template for environment variables, containing example credentials and configurations.
- **`stack.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

### **Deploy via Portainer (Recommended)**

1. Navigate to **Portainer → Stacks**.
2. Create a **new stack** and select **Git Repository**.
3. Enter the repository URL:

   ```
   https://gitea.beardinthe.cloud/Portainer_Stacks/postgresql-stack.git
   ```

4. Deploy the stack.

### **Deploy via Docker Compose (Optional)**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/postgresql-stack.git
   ```

2. **Navigate to the PostgreSQL Stack Directory:**

   ```bash
   cd postgresql-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp stack.env.example stack.env
     ```

   - Edit `stack.env` and configure required values such as:

     ```ini
     POSTGRES_USER=admin
     POSTGRES_PASSWORD=securepassword
     POSTGRES_DB=lab_db
     ```

4. **Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

5. **Access PostgreSQL:**
   - Connect using a database client or via CLI:

     ```bash
     psql -U admin -h 127.0.0.1 -p 5432 -d lab_db
     ```

## **Additional Resources**

- **PostgreSQL Documentation:** [https://www.postgresql.org/docs/](https://www.postgresql.org/docs/)
- **PostgreSQL Docker Hub:** [https://hub.docker.com/_/postgres](https://hub.docker.com/_/postgres)
- **Community Support:** [https://www.postgresql.org/community/](https://www.postgresql.org/community/)
