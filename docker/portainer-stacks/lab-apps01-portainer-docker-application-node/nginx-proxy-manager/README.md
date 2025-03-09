# **Nginx Proxy Manager Stack**

## **Overview**

Nginx Proxy Manager (NPM) is a **self-hosted reverse proxy and SSL certificate management solution**. It provides an intuitive **web-based interface** to manage Nginx proxies, SSL certificates, and access control, making it an excellent tool for **handling internal and external services**.

NPM supports **Cloudflare DNS challenges**, **Let's Encrypt SSL certificates**, and **custom proxy configurations**, ensuring secure and flexible routing for various services.

**Official Website:** [Nginx Proxy Manager](https://nginxproxymanager.com/)

## **Role in the Lab**

In the **Proxmox Astronomy Lab**, Nginx Proxy Manager is responsible for **managing and securing access to lab-level services**. It is used for:

- **Reverse Proxy for Lab Services:** Routes traffic to internal services such as Portainer nodes, the monitoring stack, and other static infrastructure components.
- **SSL Management:** Issues and renews **wildcard SSL certificates (`*.beardinthe.cloud`)** using Cloudflare DNS challenges.
- **Cloudflare Integration:** Automates SSL issuance and DNS record management via Cloudflare API.
- **Access Control:** Restricts or allows access to internal services based on defined security policies.
- **Traffic Optimization:** Handles caching, compression, and load balancing where needed.

## **Stack Components**

- **`docker-compose.yml`** – Defines the Nginx Proxy Manager service configuration, including versioning, ports, and volumes.
- **`stack.env.example`** – Provides a template for environment variables, containing example configurations.
- **`stack.env`** – Used for actual environment-specific configurations (Git ignored for security).
- **`README.md`** – Documentation for this stack.

## **Setup Instructions**

### **Deploy via Portainer (Recommended)**

1. Navigate to **Portainer → Stacks**.
2. Create a **new stack** and select **Git Repository**.
3. Enter the repository URL:

   ```
   https://gitea.beardinthe.cloud/Portainer_Stacks/nginx-proxy-manager-stack.git
   ```

4. Deploy the stack.

### **Deploy via Docker Compose (Optional)**

1. **Clone the Repository:**

   ```bash
   git clone https://gitea.beardinthe.cloud/Portainer_Stacks/nginx-proxy-manager-stack.git
   ```

2. **Navigate to the NPM Stack Directory:**

   ```bash
   cd nginx-proxy-manager-stack
   ```

3. **Prepare Environment Variables:**
   - Copy the example environment file:

     ```bash
     cp stack.env.example stack.env
     ```

   - Edit `stack.env` and configure required values such as:

     ```ini
     CF_API_EMAIL=email@example.com
     CF_API_KEY=your-cloudflare-api-key
     ```

4. **Deploy the Stack Using Docker Compose:**

   ```bash
   docker-compose up -d
   ```

5. **Access Nginx Proxy Manager Web Interface:**
   - Open your browser and navigate to:

     ```
     http://localhost:81
     ```

   - Log in using the default credentials (<admin@example.com> / changeme) and update them.

## **Additional Resources**

- **Nginx Proxy Manager Documentation:** [https://nginxproxymanager.com/guide/](https://nginxproxymanager.com/guide/)
- **Docker Hub:** [https://hub.docker.com/r/jc21/nginx-proxy-manager](https://hub.docker.com/r/jc21/nginx-proxy-manager)
- **Community Support:** [https://github.com/NginxProxyManager/nginx-proxy-manager/discussions](https://github.com/NginxProxyManager/nginx-proxy-manager/discussions)
