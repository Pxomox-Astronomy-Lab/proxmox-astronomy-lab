<!-- 
---
title: "Services Configuration - CIS Ubuntu 24.04 L1 Implementation"
description: "Documentation of the services security controls implemented for Ubuntu Server 24.04 in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["hardening", "security", "cisv8", "ubuntu", "services", "ntp", "chrony"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# **Services Configuration - CIS Ubuntu 24.04 L1 Implementation**

## **1. Overview**

### **1.1 Purpose**

This document details the specific implementation of CIS Ubuntu 24.04 Level 1 controls related to service configuration within the Proxmox Astronomy Lab. It covers our approach to removing unnecessary services and properly configuring time synchronization services, which are critical for security logging, authentication, and forensic analysis.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Xinetd service removal | Application-specific services |
| Time synchronization configuration (chrony) | Desktop time synchronization |
| Service startup configuration | Custom time servers |
| Service validation methods | Network Time Security (NTS) implementation |

### **1.3 Target Audience**

This document is intended for System Engineers responsible for server deployment, Security Administrators verifying service configurations, and Compliance Auditors reviewing Tenable scan results.

---

## **2. Implementation Status**

The following table summarizes our implementation status for service-related CIS controls:

| **Control ID** | **Description** | **Implementation Status** | **Notes** |
|----------------|----------------|---------------------------|-----------|
| 2.1.1 | Ensure xinetd is not installed | ✅ Implemented | Package removed from base image |
| 2.2.1 | Ensure time synchronization is in use | ✅ Implemented | Using chrony for NTP |
| 2.2.2 | Ensure chrony is configured correctly | ✅ Implemented | Using standard NTP pool servers |

---

## **3. Xinetd Service Removal**

### **3.1 Current Implementation**

The xinetd service is not installed on our Ubuntu 24.04 servers, as verified by:

```bash
dpkg-query: package 'xinetd' is not installed and no information is available
```

### **3.2 Implementation Method**

Xinetd is excluded from our base image creation process. Additionally, we maintain the following in our `ubuntu-hardening` Ansible role to ensure compliance:

```yaml
- name: Ensure xinetd is not installed
  ansible.builtin.apt:
    name: xinetd
    state: absent
    purge: yes
  tags:
    - security
    - cis_2_1_1
```

This task runs during the weekly compliance checks to catch any unauthorized installations.

---

## **4. Time Synchronization**

### **4.1 Current Implementation**

Our Ubuntu 24.04 servers use chrony for time synchronization. The current status shows:

```bash
Status: install ok installed
● chrony.service - chrony, an NTP client/server
     Loaded: loaded (/usr/lib/systemd/system/chrony.service; enabled; preset: enabled)
     Active: active (running) since Sun 2025-03-16 10:37:15 EDT; 1h 55min ago
```

The timedatectl output confirms that system time is synchronized:

```bash
System clock synchronized: yes
NTP service: active
```

### **4.2 Chrony Configuration**

The chrony configuration uses the public NTP pool for time synchronization:

```bash
pool 0.pool.ntp.org iburst
pool 1.pool.ntp.org iburst
pool 2.pool.ntp.org iburst
pool 3.pool.ntp.org iburst
```

This configuration is applied during system deployment via our Ansible automation:

```yaml
- name: Configure chrony NTP servers
  ansible.builtin.template:
    src: chrony.conf.j2
    dest: /etc/chrony/chrony.conf
    owner: root
    group: root
    mode: '0644'
  notify: restart chrony
  tags:
    - security
    - cis_2_2_2
```

### **4.3 Systemd-timesyncd Status**

Systemd-timesyncd is not used on our systems as we've standardized on chrony:

```bash
Unit systemd-timesyncd.service could not be found.
```

### **4.4 Time Synchronization Performance**

The chrony tracking output shows that our time synchronization is working effectively:

```bash
Reference ID    : 17A88884 (time.circlevps.net)
Stratum         : 3
Ref time (UTC)  : Sun Mar 16 16:22:03 2025
System time     : 0.000113489 seconds fast of NTP time
Last offset     : +0.000131180 seconds
RMS offset      : 0.000382530 seconds
```

This indicates our servers maintain accurate time within 0.4 milliseconds of the NTP source.

---

## **5. Verification Methods**

### **5.1 Manual Verification**

System administrators can verify the current status of these controls by executing:

```bash
# Check xinetd installation status
dpkg -s xinetd 2>&1 | grep -E '(Status:|not installed)'

# Check chrony status
systemctl status chronyd
systemctl is-enabled chronyd

# Check time synchronization
chronyc tracking
timedatectl status | grep "synchronized"
```

### **5.2 Automated Verification**

We use a custom verification script (`/scripts/cis-services.sh`) that runs weekly to verify compliance:

```bash
#!/bin/bash
# CIS-verify-services.sh - Checks CIS Ubuntu 24.04 service controls
# Control 2.1.1, 2.2.1, 2.2.2

# Initialize variables
xinetd_status="❌ FAIL: xinetd is installed"
time_sync_status="❌ FAIL: No time synchronization service is active"
chrony_config_status=""
chrony_sync_status=""

# Check Control 2.1.1 - Xinetd not installed
if ! dpkg -s xinetd &>/dev/null; then
    xinetd_status="✅ PASS: xinetd is not installed"
fi

# Check Control 2.2.1 - Time synchronization is in use
if systemctl is-active chronyd &>/dev/null || systemctl is-active systemd-timesyncd &>/dev/null; then
    time_sync_status="✅ PASS: Time synchronization service is active"
fi

# Check Control 2.2.2 - Chrony is properly configured
if systemctl is-active chronyd &>/dev/null; then
    # Check NTP server configuration
    if grep -E "^(server|pool)" /etc/chrony/chrony.conf | grep -q "pool.ntp.org"; then
        chrony_config_status="✅ PASS: Chrony is configured with proper NTP pool servers"
    else
        chrony_config_status="⚠️ WARNING: Chrony is running but may not have standard NTP servers configured"
    fi
    
    # Check synchronization status
    if chronyc tracking | grep -q "Stratum"; then
        chrony_sync_status="✅ PASS: Chrony is synchronized with time source"
    else
        chrony_sync_status="⚠️ WARNING: Chrony may not be properly synchronized"
    fi
elif systemctl is-active systemd-timesyncd &>/dev/null; then
    chrony_config_status="⚠️ WARNING: Using systemd-timesyncd instead of chrony"
    # No need to set chrony_sync_status as it's not relevant
else
    chrony_config_status="❌ FAIL: No time synchronization service is configured"
    # No need to set chrony_sync_status as it's not relevant
fi

# Print the report
echo "CIS Ubuntu 24.04 Service Controls Verification"
echo "==============================================="
echo
echo "Control 2.1.1 - Xinetd Service:"
echo "$xinetd_status"
echo
echo "Control 2.2.1 - Time Synchronization:"
echo "$time_sync_status"
echo
echo "Control 2.2.2 - Chrony Configuration:"
if [ -n "$chrony_config_status" ]; then
    echo "$chrony_config_status"
fi
if [ -n "$chrony_sync_status" ]; then
    echo "$chrony_sync_status"
fi

# Set exit status
if [[ "$xinetd_status" == *"FAIL"* ]] || [[ "$time_sync_status" == *"FAIL"* ]] || [[ "$chrony_config_status" == *"FAIL"* ]] || [[ "$chrony_sync_status" == *"FAIL"* ]]; then
    exit 1
else
    exit 0
fi
```

When executed, the script produces a clean report showing the compliance status:

```
CIS Ubuntu 24.04 Service Controls Verification
===============================================

Control 2.1.1 - Xinetd Service:
✅ PASS: xinetd is not installed

Control 2.2.1 - Time Synchronization:
✅ PASS: Time synchronization service is active

Control 2.2.2 - Chrony Configuration:
✅ PASS: Chrony is configured with proper NTP pool servers
✅ PASS: Chrony is synchronized with time source
```

This verification script is scheduled via cron to run daily, with results logged to `/var/log/cis-compliance.log` and failures triggering alerts via our monitoring system.

---

## **6. Process Integration**

### **6.1 ITIL Process Relationship**

| **ITIL Process** | **Relationship to Service Controls** |
|-----------------|----------------------------------------|
| Change Management | Changes to time synchronization require RFC |
| Configuration Management | NTP server configuration tracked in CMDB |
| Security Management | Time source integrity verification |
| Incident Management | Time synchronization failures trigger alerts |

### **6.2 Role Responsibilities**

| **Role** | **Responsibility Related to This Article** |
|----------|--------------------------------------------|
| System Engineer | Maintains chrony configuration |
| Security Administrator | Verifies service compliance in Tenable reports |
| Network Administrator | Ensures firewall rules allow NTP traffic (UDP 123) |
| Monitoring Engineer | Maintains time synchronization alerting |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial version | VintageDon |
