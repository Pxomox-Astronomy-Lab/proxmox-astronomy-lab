# Moving Docker Data Directory to Custom Location

Learn how to install Docker and configure it to use a custom data directory instead of the default `/var/lib/docker` location. This allows you to place Docker's data on a dedicated volume or drive.

## Why We Do This

In the Proxmox Astronomy Lab, we always move Docker's data directory to dedicated volumes. While Docker can run perfectly well in its default location, we implement this pattern because:

- **Volume Isolation**: Keeps all container data, images, and volumes on our dedicated `/mnt/data` volume, separate from the system drive
- **Workload Portability**: With Docker data on a dedicated volume, entire container environments can be moved between systems by simply attaching the data volume
- **Backup Simplicity**: Our volume-based backup strategy captures all Docker data in one location, including containers, images, volumes, and networks
- **System Protection**: Prevents Docker's potentially large data footprint from filling up the system drive and affecting OS operations

This approach is used consistently across all lab systems that run containerized workloads.

## Prerequisites

- Ubuntu 24.04 server with root/sudo access
- A dedicated data volume already mounted (e.g., `/mnt/data` from our previous article)
- Internet connectivity for downloading Docker installation script
- System should be updated before proceeding

## Step-by-Step Instructions

### Step 1: Download and Install Docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

Downloads and runs Docker's official installation script. This script automatically detects your OS version and installs the appropriate Docker packages. The installation will take a few minutes and will display progress information.

### Step 2: Stop Docker Services

```bash
systemctl stop docker.socket
systemctl stop docker
```

Stops both the Docker daemon and socket before making configuration changes. The socket must be stopped first, then the main Docker service. This ensures no Docker operations are running while we modify the configuration.

### Step 3: Create Docker Configuration Directory

```bash
mkdir -p /etc/docker
```

Creates the Docker configuration directory if it doesn't already exist. The `-p` flag ensures parent directories are created as needed and won't error if the directory already exists.

### Step 4: Create Docker Configuration File

```bash
cat <<EOF > /etc/docker/daemon.json
{
  "data-root": "/mnt/data"
}
EOF
```

Creates the Docker daemon configuration file that tells Docker to use `/mnt/data` instead of the default `/var/lib/docker` location. This JSON configuration file controls various Docker daemon settings.

### Step 5: Start Docker Services

```bash
systemctl start docker.socket
systemctl start docker
```

Restarts Docker services with the new configuration. The socket service should be started first, followed by the main Docker daemon. Docker will automatically create its directory structure in the new location.

### Step 6: Verify New Data Location

```bash
docker info | grep "Docker Root Dir"
```

Confirms that Docker is now using the new data directory. This command should show `/mnt/data` as the Docker Root Directory instead of the default `/var/lib/docker`.

## Verification

Check that Docker is running properly and using the correct location:

```bash
# Verify Docker is active
systemctl status docker

# Confirm data directory location
docker info | grep "Docker Root Dir"

# Check available space on data volume
df -h /mnt/data

# Test Docker functionality
docker run hello-world
```

You should see Docker Root Dir pointing to `/mnt/data`, and the hello-world container should run successfully.

## Troubleshooting

**Docker fails to start:** Check that the `/mnt/data` directory exists and is writable. Verify the JSON syntax in `/etc/docker/daemon.json` is correct (commas, brackets, quotes).

**Permission denied errors:** Ensure the data directory has appropriate permissions:

```bash
chown root:root /mnt/data
chmod 755 /mnt/data
```

**Old Docker data still consuming space:** The original `/var/lib/docker` directory may still contain old data. After confirming everything works, you can remove it:

```bash
rm -rf /var/lib/docker
```

**Configuration not taking effect:** Restart the Docker daemon after configuration changes:

```bash
systemctl restart docker
```

**JSON syntax errors:** Validate your daemon.json file:

```bash
cat /etc/docker/daemon.json | python3 -m json.tool
```

## Related Articles

- Adding a Second Drive for Data Storage on Ubuntu 24.04
- Docker Container Backup and Restore Strategies
- Managing Docker Volumes and Networks

---

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | [2025-07-19] |
| **Last Updated** | [2025-07-19] |
| **Version** | 1.0 |

---
Tags: docker, ubuntu, configuration, storage, containers, data-directory
