# **GLPI Stack**

## **Overview**

GLPI (**Gestionnaire Libre de Parc Informatique**) is an **open-source IT Service Management (ITSM) solution** that provides **IT asset management, ticketing, and ITIL-compliant service desk functionalities**. It is widely used for managing **hardware, software, incidents, and IT workflows** in an organized and structured way.

GLPI supports **multi-user environments, workflows, custom fields, and integrations with monitoring systems**, making it a critical component for **IT infrastructure and service management**.

**Official Website:** [GLPI Official Website](https://glpi-project.org/)

## **Role in the Lab**

GLPI is deployed in the **Proxmox Astronomy Lab** to serve as the **centralized ITIL-based service management system**. It is used for:

- **IT Asset Management:** Tracks and manages hardware, software, and network devices.
- **Ticketing System:** Provides an **ITIL-aligned service desk** for logging and managing incidents.
- **Change Management:** Tracks infrastructure modifications and service updates.
- **Service Management:** Organizes **lab-wide IT services, support workflows, and operational efficiency**.
- **User & Access Management:** Supports **multi-user roles, access policies, and authentication integrations**.
- **Database Backend:** Connects to **MariaDB on lab-db01** for persistent data storage.
- **Monitoring Integration:** Publishes **metrics for IT service performance and asset tracking**.

## **Stack Components**

- **`docker-compose.yml`** – Defines the GLPI service configuration, including versioning, ports, and volumes.
- **`stack.env.example`** – Provides a template for environment variables, containing example configurations.
- **`stack.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

### **Deploy via Portainer (Recommended)**

1. Navigate to **Portainer → Stacks**.
2. Create a **new stack** and select **Git Repository**.
3. Enter the repository URL:

   ```
   https://gitea.beardinthe.cloud/Portainer_Stacks/glpi-stack.git
   ```

4. Deploy the stack.

### **Deploy via Docker Compose (Optional)**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/glpi-stack.git
   ```

2. **Navigate to the GLPI Stack Directory:**

   ```bash
   cd glpi-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp stack.env.example stack.env
     ```

   - Edit `stack.env` and configure required values such as:

     ```ini
     GLPI_DB_HOST=lab-db01
     GLPI_DB_NAME=glpi
     GLPI_DB_USER=glpi
     GLPI_DB_PASSWORD=securepassword
     ```

4. **Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

5. **Access GLPI Web Interface:**
   - Open your browser and navigate to:

     ```
     http://localhost:8080
     ```

   - Complete the installation process and configure the service.

## **Additional Resources**

- **GLPI Documentation:** [https://glpi-project.org/documentation/](https://glpi-project.org/documentation/)
- **GLPI Docker Hub:** [https://hub.docker.com/r/glpi-project/glpi](https://hub.docker.com/r/glpi-project/glpi)
- **Community Support:** [https://forum.glpi-project.org/](https://forum.glpi-project.org/)
