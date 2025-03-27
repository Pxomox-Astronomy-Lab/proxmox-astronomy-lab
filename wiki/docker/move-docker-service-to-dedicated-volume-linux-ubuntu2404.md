<!--  
---  
title: "Move Docker Data Directory to a Dedicated Volume on Ubuntu 24.04"  
description: "Procedure for relocating Docker's data directory to an alternate mount point (e.g., /mnt/docker) without using /var/lib/docker directly."  
author: "VintageDon"  
tags: ["docker", "ubuntu", "volume", "proxmox", "infrastructure"]  
category: "Infrastructure"  
kb_type: "Procedure"  
version: "1.0"  
status: "Published"  
last_updated: "2025-03-27"  
---  
-->

# 📄 **Move Docker Data Directory to a Dedicated Volume on Ubuntu 24.04**

This KB explains how to safely **move Docker’s data directory** to an **already mounted volume** (e.g., `/mnt/docker`) on Ubuntu 24.04. The standard location `/var/lib/docker` is not used directly — instead, Docker is reconfigured to use the mounted path via the `daemon.json`.

---

## 🔍 **1. Overview**

### **1.1 Purpose**

This procedure relocates the Docker data directory from its default location (`/var/lib/docker`) to a custom mount point (e.g., `/mnt/docker`) on a **dedicated disk** already mounted and formatted. This improves modularity, supports dedicated storage management, and ensures clean separation from system volumes.

### **1.2 Scope**

| In Scope | Out of Scope |
|----------|--------------|
| Moving existing Docker data | Creating or formatting new disks |
| Reconfiguring Docker's daemon | Changing Docker socket defaults |
| Verifying container functionality | Docker Compose or Kubernetes integration |

### **1.3 Target Audience**

Lab engineers and system admins managing container workloads on Proxmox-based Ubuntu 24.04 VMs.

---

## ⚙️ **2. Procedure**

### **2.1 Stop Docker Services**

```bash
sudo systemctl stop docker
sudo systemctl stop docker.socket
```

> 🛑 Important: Ensure no containers are running prior to stopping Docker.

---

### **2.2 Move Existing Docker Data (if present)**

```bash
sudo rsync -aP /var/lib/docker/ /mnt/docker/
```

> This preserves permissions and ensures all layers, volumes, and metadata are transferred.

---

### **2.3 Update Docker Daemon Configuration**

Create or modify `/etc/docker/daemon.json`:

```bash
sudo nano /etc/docker/daemon.json
```

Add the following (or update if it exists):

```json
{
  "data-root": "/mnt/docker"
}
```

---

### **2.4 Reload and Restart Docker**

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl start docker.socket
```

---

### **2.5 Verify Operation**

```bash
docker info | grep "Docker Root Dir"
```

Expected output:

```bash
Docker Root Dir: /mnt/docker
```

Check container and volume health:

```bash
docker ps -a
docker volume ls
```

---

## 🔄 **3. Process Integration**

### **3.1 ITIL Process Relationship**

| Process | Role |
|--------|------|
| Change Management | Documented and repeatable infrastructure procedure |
| Configuration Management | Daemon settings reflect correct Docker root path |
| Incident Management | Required for recovery scenarios involving disk space or corruption on the system volume |

---

## 📎 **4. References & Related Resources**

### **4.1 Related KB Articles**

| Article Title | KB ID | Relationship |
|---------------|-------|--------------|
| Add a Docker Volume to Ubuntu 24.04 | KB-INFRA-DOCKER-VOL-001 | Prerequisite: Preparing the mount point |

---

## ✅ **5. Approval & Review**

| Reviewer | Role | Approval Date | Status |
|----------|------|----------------|--------|
| VintageDon | Lead Engineer | 2025-03-27 | ✅ Approved |

---

## 📜 **6. Change Log**

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | 2025-03-27 | Initial KB | VintageDon |
