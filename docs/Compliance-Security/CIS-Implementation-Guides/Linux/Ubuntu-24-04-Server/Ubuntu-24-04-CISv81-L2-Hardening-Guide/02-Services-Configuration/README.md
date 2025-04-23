<!-- 
---
title: "CIS Ubuntu 24.04 Level 2 Services Configuration"
description: "Detailed guidance for implementing CIS Level 2 services configuration controls for Ubuntu Server 24.04"
author: "VintageDon"
tags: ["security", "hardening", "ubuntu", "cisv8", "compliance", "services", "daemons"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🛡️ **CIS Ubuntu 24.04 Level 2 Services Configuration**

## 🔍 **1. Overview**

This section provides detailed guidance for implementing **CIS Level 2 services security controls** for Ubuntu Server 24.04 systems. These controls focus on reducing the attack surface by disabling unnecessary services, securing required services, and ensuring proper time synchronization.

Level 2 services hardening extends the baseline Level 1 requirements with additional restrictions and enhanced security configurations, particularly for time synchronization services. By following these guidelines, systems will maintain only essential services with secure configurations.

### **1.1 Purpose**

This guide serves to:

- Document required service configurations for CIS Level 2 compliance
- Provide implementation guidance for removing or securing services
- Establish verification methods for service-related security controls
- Outline remediation steps for non-compliant configurations

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Ubuntu Server 24.04 service configurations | Desktop environment services |
| Network service removal and hardening | Application-specific service configurations |
| Time synchronization security | Container orchestration services |
| Service client removal | Third-party service hardening |

### **1.3 Target Audience**

This guide is intended for:

- System Administrators responsible for server security
- Security Personnel implementing compliance controls
- IT Operations staff managing Ubuntu server environments
- Auditors verifying CIS compliance

---

## 📊 **2. Control Objectives**

The services security controls address several key security objectives:

1. **Reduce attack surface** by removing unnecessary network services
2. **Minimize daemon exposure** by disabling or uninstalling non-essential services
3. **Secure time synchronization** to ensure accurate audit logs and security functions
4. **Restrict client utilities** that could pose security risks
5. **Configure remaining services securely** to prevent abuse

These controls follow the principle of least functionality, ensuring only essential services are present on the system.

---

## 🔒 **3. Service Removal Requirements**

### **3.1 Network Services (inetd)**

The following legacy network services must be removed to eliminate potential vulnerabilities:

| **Service** | **Package** | **Security Risk** | **CIS Control** |
|-------------|------------|-------------------|----------------|
| **xinetd** | xinetd | Deprecated super-server | 2.1.1 |
| **inetd** | openbsd-inetd | Legacy network service daemon | 2.1.2 |

### **3.2 Special Purpose Services**

Special purpose services often present unnecessary risk in server environments:

| **Service Category** | **Packages** | **Justification for Removal** | **CIS Control** |
|---------------------|--------------|-------------------------------|----------------|
| **X Window System** | xserver-xorg* | Graphical systems unnecessary on servers | 2.2.1 |
| **Avahi Server** | avahi-daemon | Multicast DNS services create network risks | 2.2.2 |
| **Print Services** | cups | Print services rarely needed on servers | 2.2.3 |
| **DHCP Server** | isc-dhcp-server | Should be dedicated service if needed | 2.2.4 |
| **LDAP Server** | slapd | Directory services should be dedicated | 2.2.5 |
| **NFS Server** | nfs-kernel-server | File sharing increases attack surface | 2.2.6 |
| **DNS Server** | bind9 | DNS should be dedicated service | 2.2.7 |
| **FTP Server** | vsftpd | Insecure file transfer protocol | 2.2.8 |
| **Web Server** | apache2 | Web services should be dedicated | 2.2.9 |
| **Mail Servers** | dovecot-imapd dovecot-pop3d | Email services should be dedicated | 2.2.10 |
| **Samba** | samba | Windows file sharing increases risk | 2.2.11 |
| **HTTP Proxy** | squid | Proxy services should be dedicated | 2.2.12 |
| **SNMP Server** | snmpd | Monitoring should use more secure alternatives | 2.2.13 |
| **rsync Service** | rsync (daemon mode) | File transfer should use more secure alternatives | 2.2.15 |
| **NIS Server** | nis | Legacy authentication not recommended | 2.2.16 |

### **3.3 Client Utilities**

Client utilities often unnecessary on servers and may introduce risk:

| **Client** | **Package** | **Risk** | **CIS Control** |
|------------|------------|----------|----------------|
| **NIS Client** | nis | Legacy authentication | 2.3.1 |
| **r-commands** | rsh-client | Insecure remote access | 2.3.2 |
| **talk** | talk | Insecure communication | 2.3.3 |
| **telnet** | telnet | Cleartext authentication | 2.3.4 |
| **LDAP Client** | ldap-utils | Directory service client | 2.3.5 |
| **RPC Client** | rpcbind | Legacy remote procedure calls | 2.3.6 |

---

## 💻 **4. Implementation Guidelines**

### **4.1 Removing Unnecessary Services**

For unneeded services, the standard removal procedure is:

```bash
# Check if a package is installed
dpkg -s PACKAGE_NAME

# Remove the package if installed
apt purge PACKAGE_NAME
```

For example, to remove X Window System:

```bash
apt purge xserver-xorg*
```

### **4.2 Mail Transfer Agent Configuration**

If mail transfer functionality is required, restrict it to local-only mode:

```bash
# For Postfix (most common)
postconf -e "inet_interfaces = loopback-only"
systemctl restart postfix
```

### **4.3 Time Synchronization**

Level 2 requires not only time synchronization but authenticated time sources:

#### **4.3.1 Chrony Configuration (Recommended)**

```bash
# Install chrony
apt install chrony

# Configure with authenticated sources
cat << EOF >> /etc/chrony/chrony.conf
server ntp1.example.com iburst key 1
server ntp2.example.com iburst key 1
keyfile /etc/chrony/chrony.keys
EOF

# Setup authentication keys
cat << EOF > /etc/chrony/chrony.keys
1 SHA256 AVeryLongAndSecurePassword
EOF

chmod 640 /etc/chrony/chrony.keys
chown root:root /etc/chrony/chrony.keys

# Restart service
systemctl restart chrony
```

### **4.4 Masking Unnecessary Services**

Services that can't be removed should be masked to prevent activation:

```bash
# Mask snapd services (if not required)
systemctl mask snapd.socket snapd.service
systemctl mask snapd.apparmor.service snapd.autoimport.service
systemctl mask snapd.core-fixup.service snapd.seeded.service
systemctl mask snapd.recovery-chooser-trigger.service
systemctl mask snapd.system-shutdown.service
systemctl mask snapd.snap-repair.timer

# Mask MOTD news (unnecessary for servers)
systemctl mask motd-news.timer update-notifier-motd.timer

# Mask LVM monitor (if using hard partitions instead of LVM)
systemctl mask lvm2-monitor.service
```

**Note:** In our lab environment, we use dedicated hard partitions rather than LVM for better control and security isolation, so we disable the LVM monitor service.

---

## 🔄 **5. Verification Methods**

Use the provided verification script to validate compliance:

```bash
sudo ./02-CISv81-L2-ubuntu2404-verify-services.sh
```

### **5.1 Sample Verification Output**

Here's a sample output from a compliant system:

```bash
2.1 inetd Services
======================================================================

2.1.1 - Ensure xinetd is not installed
Status: PASS - Package xinetd is not installed

2.1.2 - Ensure openbsd-inetd is not installed
Status: PASS - Package openbsd-inetd is not installed


2.2 Special Purpose Services
======================================================================

2.2.1 - Ensure X Window System is not installed
Status: PASS - No packages matching pattern xserver-xorg are installed

[...additional passing checks...]

2.4.2 - Ensure time synchronization is configured to use authenticated sources
Status: PASS - chrony is configured to use authenticated sources
```

Any FAIL or WARNING results require remediation according to the provided guidance.

---

## 🔍 **6. Level 2 vs Level 1 Controls**

Level 2 extends the Level 1 requirements with these additional controls:

| **Level 2 Control** | **Description** | **Not in Level 1** |
|---------------------|----------------|-------------------|
| 2.4.2 | Ensure time synchronization uses authenticated sources | ✓ Level 2 only |
| 2.5.1 | Ensure NTP implementation is secured with restrict statements | ✓ Level 2 only |
| 2.5.2 | Ensure systemd-timesyncd has secure pool settings | ✓ Level 2 only |
| 2.5.3 | Ensure unnecessary services are removed or masked | ✓ Level 2 only |

These additional controls provide enhanced security for time synchronization and service management, which are particularly important for high-security environments.

## 🔄 **6.1 Compliance Framework Mapping**

The services configuration controls map to several NIST 800-53 Rev 5 and ISO 27001:2022 controls:

| **CIS Control** | **NIST 800-53 Control** | **ISO 27001:2022 Control** |
|-----------------|--------------------------|----------------------------|
| 2.1.x (inetd Services) | CM-7: Least Functionality | A.8.9: Configuration management |
| 2.2.x (Special Purpose Services) | CM-7(1): Periodic Review | A.8.2: Authorized use of assets |
| 2.3.x (Service Clients) | CM-7(2): Prevent Program Execution | A.8.8: Management of technical vulnerabilities |
| 2.4.x (Time Synchronization) | AU-8(1): Synchronization with Authoritative Time Source | A.12.1: Operational procedures and responsibilities |
| 2.5.x (Additional Hardening) | SC-7: Boundary Protection | A.13.1: Network security |

This mapping helps demonstrate how CIS controls satisfy requirements across multiple compliance frameworks and provides traceability for audit purposes.

---

## ⚠️ **7. Common Issues and Troubleshooting**

| **Issue** | **Solution** |
|-----------|-------------|
| **Service dependencies** | Check for dependent packages before removal with `apt-cache rdepends` |
| **Email functionality** | If mail delivery stops working, ensure local MTA is still functioning |
| **Clock drift with secured NTP** | Ensure firewall rules allow NTP traffic to authorized servers |
| **Breaking snap-based applications** | If required, unmask specific snap services rather than all |

Document any necessary exceptions in the security exceptions register with appropriate compensating controls.

---

## 🔗 **8. Related Documentation**

| **Document** | **Purpose** | **Location** |
|--------------|------------|-------------|
| **CIS Ubuntu 24.04 L1 Services Guide** | Less restrictive baseline | [L1 Guide](../../Ubuntu-24-04-CISv81-L1-Hardening-Guide/02-Services-Configuration/README.md) |
| **Service Security Exceptions** | Documented exceptions | [Exceptions Register](../../../compliance-security/security-exceptions.md) |
| **Ansible Service Hardening Role** | Automation | [Ansible Roles](../../../security-automation/ansible/roles/cis-service-hardening/README.md) |

---

## ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Services Configuration documentation | VintageDon |
