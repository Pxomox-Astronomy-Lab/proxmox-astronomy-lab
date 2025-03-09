# **Redis Stack**

## **Overview**

Redis (Remote Dictionary Server) is an **open-source, in-memory key-value store** known for its **high-speed performance, low latency, and efficient caching**. It is widely used for **session storage, message brokering, real-time analytics, and distributed caching** in modern applications.

Redis supports **multiple data structures**, including **strings, hashes, lists, sets, and sorted sets**, making it highly versatile for various caching and queuing tasks.

**Official Website:** [Redis Official Website](https://redis.io/)

## **Role in the Lab**

Redis is deployed in the **Proxmox Astronomy Lab** to provide **high-speed caching, temporary data storage, and distributed queueing** for various applications and services. Its primary functions include:

- **High-Speed Caching:** Stores frequently accessed data to **reduce database load** and **speed up applications**.
- **Session Management:** Maintains session states for applications needing persistent yet fast storage.
- **Queueing System:** Supports **lightweight message queues** for event-driven services.
- **Temporary Data Storage:** Handles **short-lived data** that doesn’t require permanent database storage.
- **Scalability:** Can be used as a **standalone instance or clustered** for improved performance and redundancy.

## **Stack Components**

- **`docker-compose.yml`** – Defines the Redis service configuration, including versioning, ports, and volumes.
- **`stack.env.example`** – Provides a template for environment variables, containing example configurations.
- **`stack.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

### **Deploy via Portainer (Recommended)**

1. Navigate to **Portainer → Stacks**.
2. Create a **new stack** and select **Git Repository**.
3. Enter the repository URL:

   ```
   https://gitea.beardinthe.cloud/Portainer_Stacks/redis-stack.git
   ```

4. Deploy the stack.

### **Deploy via Docker Compose (Optional)**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/redis-stack.git
   ```

2. **Navigate to the Redis Stack Directory:**

   ```bash
   cd redis-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp stack.env.example stack.env
     ```

   - Edit `stack.env` and configure required values such as:

     ```ini
     REDIS_PASSWORD=securepassword
     ```

4. **Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

5. **Access Redis:**
   - Connect using a Redis client or CLI:

     ```bash
     redis-cli -h 127.0.0.1 -p 6379 -a securepassword
     ```

## **Additional Resources**

- **Redis Documentation:** [https://redis.io/docs/](https://redis.io/docs/)
- **Redis Docker Hub:** [https://hub.docker.com/_/redis](https://hub.docker.com/_/redis)
- **Community Support:** [https://forum.redis.io/](https://forum.redis.io/)
