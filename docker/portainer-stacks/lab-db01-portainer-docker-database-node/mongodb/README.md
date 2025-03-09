# **MongoDB Stack**

## **Overview**

MongoDB is a **NoSQL document-oriented database** designed for high performance, scalability, and flexibility. Unlike traditional relational databases, MongoDB stores data in **JSON-like BSON format**, making it ideal for handling unstructured and semi-structured data. It is widely used for applications that require **schema-less storage, fast querying, and horizontal scalability**.

**Official Website:** [MongoDB Official Website](https://www.mongodb.com/)

## **Role in the Lab**

This deployment of MongoDB is used within the **Proxmox Astronomy Lab** to store and manage **unstructured and semi-structured data**. While S3-compatible object storage is available, MongoDB provides a **more structured yet flexible alternative** for data requiring indexing, fast querying, and real-time analysis.

- **Use Case:** Storing **unstructured** lab data, logs, metadata, and machine learning datasets.
- **Storage Strategy:** Utilizes dedicated volumes for **persistent storage and backups**.
- **Authentication & Security:** Supports **traditional .env-based credentials** and **Vault-based secret management** for secure deployments.

## **Stack Components**

- **`docker-compose.yml`** – Defines the MongoDB service configuration, including versioning, ports, and volumes.
- **`stack.env.example`** – Provides a template for environment variables, containing example credentials and configurations.
- **`stack.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

### **Deploy via Portainer (Recommended)**

1. Navigate to **Portainer → Stacks**.
2. Create a **new stack** and select **Git Repository**.
3. Enter the repository URL:

   ```
   https://gitea.beardinthe.cloud/Portainer_Stacks/mongodb-stack.git
   ```

4. Deploy the stack.

### **Deploy via Docker Compose (Optional)**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/mongodb-stack.git
   ```

2. **Navigate to the MongoDB Stack Directory:**

   ```bash
   cd mongodb-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp stack.env.example stack.env
     ```

   - Edit `stack.env` and configure required values such as:

     ```ini
     MONGO_INITDB_ROOT_USERNAME=admin
     MONGO_INITDB_ROOT_PASSWORD=securepassword
     ```

4. **Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

5. **Access MongoDB:**
   - Connect using a MongoDB client or CLI:

     ```bash
     mongo -u admin -p securepassword --host 127.0.0.1 --port 27017
     ```

## **Additional Resources**

- **MongoDB Documentation:** [https://www.mongodb.com/docs/](https://www.mongodb.com/docs/)
- **MongoDB Docker Hub:** [https://hub.docker.com/_/mongo](https://hub.docker.com/_/mongo)
- **Community Support:** [https://www.mongodb.com/community](https://www.mongodb.com/community)
