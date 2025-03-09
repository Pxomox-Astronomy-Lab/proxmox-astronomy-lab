# **Portainer Stacks Documentation**

## **Overview**

This document outlines the best practices and organization strategy for managing **Portainer Stacks** in the Proxmox Astronomy Lab. Our goal is to implement a **structured, GitOps-friendly** approach that ensures repeatability, consistency, and maintainability across all deployed services.

All stack configurations are version-controlled in **Gitea**, under the `Portainer_Stacks` organization, ensuring easy management and updates.

---

## **Portainer Stack Repository Structure**

### **1. Directory Layout**

Each **Portainer Stack** has a dedicated directory within `/docker/portainer-stacks/`, containing:

- `README.md` – Stack description, deployment instructions, and usage notes.
- `docker-compose.yml` – The Compose file defining the stack's services.
- `stack.env.example` – Example environment variables file.
- `stack.env` (Git ignored) – The production environment variables file, manually configured on each deployment.

#### **Example Structure:**

```
/docker/portainer-stacks/
│── portainer-gitea/
│   ├── README.md
│   ├── docker-compose.yml
│   ├── stack.env.example
│── portainer-wikijs/
│   ├── README.md
│   ├── docker-compose.yml
│   ├── stack.env.example
│── portainer-nextcloud/
│   ├── README.md
│   ├── docker-compose.yml
│   ├── stack.env.example
```

### **2. Gitea Repository Naming Convention**

Each Portainer Stack is stored in its own **dedicated repository** under `Portainer_Stacks` in Gitea.

#### **Repository Naming Format:**

```
portainer-[appname]
```

##### **Examples:**

- `portainer-gitea`
- `portainer-wikijs`
- `portainer-nextcloud`
- `portainer-minio`

This structure ensures a **clear, organized approach** while allowing **separate version control** for each service.

All repositories are hosted at:

```
https://gitea.beardinthe.cloud/Portainer_Stacks/
```

Git branches should be used to maintain a simple and structured workflow:

- `dev` (development branch)
- `main` (stable branch)
- `production` (final deployment-ready branch)

---

## **Best Practices for Managing Portainer Stacks**

### **1. Storage & Volume Considerations**

- All **Docker service storage** is located on **/mnt/docker** (except for `lab-port01`, which is control-only).
- **Named Docker volumes** are preferred over bind mounts for portability.
- Volume data is backed up separately from the application containers to allow easy restores.

### **2. Environment Variables & Secrets Management**

- **Passwords and sensitive values will be stored in Vault (`lab-vault01`) once ready.**
- Until Vault is available, values will be manually set in `stack.env` and replaced with Vault lookups later.
- **All environment files (`stack.env`) are Git ignored.** Only `stack.env.example` will be committed.
- Variables should be referenced in `docker-compose.yml` via environment substitution.

#### **Example:**

```yaml
environment:
  - DOMAIN=${DOMAIN}
  - GITEA_VERSION=${GITEA_VERSION}
  - ADMIN_PASSWORD=${ADMIN_PASSWORD}
```

When Vault is implemented, credentials will be added there, and the environment variables will reference placeholders that are replaced at runtime.

---

## **GitOps Deployment with Portainer**

### **1. Deploying Stacks from Gitea**

When deploying stacks via Portainer’s **"Use Repository"** feature:

- The **repository URL** (e.g., `https://gitea.beardinthe.cloud/Portainer_Stacks/portainer-gitea.git`) is specified.
- **Branch tracking** ensures updates are automatically pulled and applied.
- **`stack.env` must already exist in the repository before deployment.**

### **2. Stack Environment Files (`stack.env.example` Usage)**

Portainer requires that `stack.env` exist **before deployment**. To ensure safe usage:

1. **Commit only `stack.env.example` to Git.**
2. **On first deployment, copy the example file:**

   ```bash
   cp stack.env.example stack.env
   ```

3. **Manually configure values** in `stack.env`.

#### **Example `stack.env.example` File:**

```ini
GITEA_VERSION=1.19.2
DOMAIN=gitea.lab.internal
ADMIN_PASSWORD=changeme
```

---

## **Automated Stack Updates via Gitea**

With **GitOps principles**, all Portainer stacks are automatically updated when a new commit is pushed to Gitea.

#### **Update Flow:**

1. **Edit `docker-compose.yml` or `stack.env.example`.**
2. **Commit & push changes to Gitea.**
3. **Portainer automatically detects changes** and redeploys the stack.

To manually force an update in Portainer:

- Navigate to **Portainer → Stacks**.
- Select the stack → Click **Update the stack**.

---

## **Security & Access Controls**

- **Gitea repositories are private by default.**
- **Role-based access** ensures only authorized users can push changes.
- **Vault (`lab-vault01`) will be used for secret management once available.**
