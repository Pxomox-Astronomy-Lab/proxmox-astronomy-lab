# **RabbitMQ Stack**

## **Overview**

RabbitMQ is a lightweight, open-source **message broker** that implements the **Advanced Message Queuing Protocol (AMQP)**. It is used for **reliable messaging, workload distribution, and asynchronous communication** between systems. RabbitMQ supports **multiple messaging protocols**, **high availability**, and **persistent message storage**, making it ideal for distributed systems.

**Official Website:** [RabbitMQ Official Website](https://www.rabbitmq.com/)

## **Role in the Lab**

RabbitMQ is deployed in the **Proxmox Astronomy Lab** as the primary **message broker** for handling **JSON file transfers, telemetry data, and internal lab communications**. It is essential for ensuring **reliable data flow between edge nodes and the lab**, allowing for **buffered, fault-tolerant messaging** in case of network disruptions.

- **Primary Use Case:** Moving JSON files from **edge nodes** to the lab for processing.
- **Internal Lab Messaging:** Handles inter-service communication within the lab.
- **Reliable Queueing:** Manages data flow efficiently, ensuring that connectivity issues do not result in data loss.
- **Lightweight & Scalable:** Suitable for **both edge and lab deployments**, with minimal resource requirements.

## **Stack Components**

- **`docker-compose.yml`** – Defines the RabbitMQ service configuration, including versioning, ports, and volumes.
- **`stack.env.example`** – Provides a template for environment variables, containing example credentials and configurations.
- **`stack.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

### **Deploy via Portainer (Recommended)**

1. Navigate to **Portainer → Stacks**.
2. Create a **new stack** and select **Git Repository**.
3. Enter the repository URL:

   ```
   https://gitea.beardinthe.cloud/Portainer_Stacks/rabbitmq-stack.git
   ```

4. Deploy the stack.

### **Deploy via Docker Compose (Optional)**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/rabbitmq-stack.git
   ```

2. **Navigate to the RabbitMQ Stack Directory:**

   ```bash
   cd rabbitmq-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp stack.env.example stack.env
     ```

   - Edit `stack.env` and configure required values such as:

     ```ini
     RABBITMQ_DEFAULT_USER=admin
     RABBITMQ_DEFAULT_PASS=securepassword
     ```

4. **Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

5. **Access RabbitMQ Management Interface:**
   - Open your browser and navigate to:

     ```
     http://localhost:15672
     ```

   - Log in using the credentials from `stack.env`.

## **Additional Resources**

- **RabbitMQ Documentation:** [https://www.rabbitmq.com/documentation.html](https://www.rabbitmq.com/documentation.html)
- **RabbitMQ Docker Hub:** [https://hub.docker.com/_/rabbitmq](https://hub.docker.com/_/rabbitmq)
- **Community Support:** [https://groups.google.com/g/rabbitmq-users](https://groups.google.com/g/rabbitmq-users)
