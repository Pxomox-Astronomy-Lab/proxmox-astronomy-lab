# **MariaDB Stack**

## **Overview**

MariaDB is an open-source relational database management system (RDBMS) that is a drop-in replacement for MySQL. It was forked from MySQL to maintain open-source licensing while enhancing performance, security, and scalability. MariaDB is widely used for applications requiring structured data storage, offering advanced clustering and replication features.

**Official Website:** [MariaDB Official Website](https://mariadb.org/)

## **Role in the Lab**

This deployment of MariaDB is used for applications within the **Proxmox Astronomy Lab** that require **SQL databases but do not support PostgreSQL**. It ensures compatibility for software that relies on MySQL/MariaDB while maintaining lab-wide database consistency.

- **Database Engine:** MariaDB 10.6 (Last version before diverging from MySQL).
- **Use Case:** Applications that require MySQL-compatible storage but do not support PostgreSQL.
- **Storage & Persistence:** All data is stored in a dedicated volume to ensure durability and easy backup management.
- **Authentication:** Uses either **traditional .env credentials** or **Vault-based secrets** for production environments.

## **Stack Components**

- **`docker-compose.yml`** – Defines the MariaDB service configuration, including versioning, ports, and volumes.
- **`stack.env.example`** – Provides a template for environment variables, containing example credentials and configurations.
- **`stack.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

### **Deploy via Portainer (Recommended)**

1. Navigate to **Portainer → Stacks**.
2. Create a **new stack** and select **Git Repository**.
3. Enter the repository URL:

   ```
   https://gitea.beardinthe.cloud/Portainer_Stacks/mariadb-stack.git
   ```

4. Deploy the stack.

### **Deploy via Docker Compose (Optional)**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/mariadb-stack.git
   ```

2. **Navigate to the MariaDB Stack Directory:**

   ```bash
   cd mariadb-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp stack.env.example stack.env
     ```

   - Edit `stack.env` and configure required values such as:

     ```ini
     MARIADB_ROOT_PASSWORD=securepassword
     MARIADB_DATABASE=example_db
     MARIADB_USER=example_user
     MARIADB_PASSWORD=example_password
     ```

4. **Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

5. **Access MariaDB:**
   - Connect using a database client or:

     ```bash
     mysql -u example_user -p -h 127.0.0.1 -P 3306 example_db
     ```

## **Additional Resources**

- **MariaDB Documentation:** [https://mariadb.org/documentation/](https://mariadb.org/documentation/)
- **MariaDB Docker Hub:** [https://hub.docker.com/_/mariadb](https://hub.docker.com/_/mariadb)
- **Community Support:** [https://mariadb.org/community/](https://mariadb.org/community/)
