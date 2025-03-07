---
title: "Fail2Ban Verification on Golden Image"
description: "Verification and validation of Fail2Ban's functionality on the hardened Ubuntu 24.04 golden image."
author: "VintageDon"
tags: ["Fail2Ban", "Security", "Hardened Image", "Golden Image", "Intrusion Prevention"]
category: "Security Monitoring"
kb_type: "Validation Report"
version: "1.1"
status: "Draft"
last_updated: "2025-03-04"
---

# **Fail2Ban Verification on Ubuntu 24.04 LTS Golden Image**

## **1. Purpose**  

Fail2Ban is an **intrusion prevention system** that monitors authentication logs for **repeated failed login attempts** and **automatically bans offending IPs** to prevent brute-force attacks. This article validates **Fail2Ban’s effectiveness on the Ubuntu 24.04 LTS Golden Image** by confirming:  

- The **service is running** and enabled on boot.  
- It is **monitoring and filtering SSH login attempts**.  
- It **bans unauthorized access attempts** after multiple failures.  
- Ban actions are **logged and enforced via firewall rules**.  

---

## **2. Scope**  

Fail2Ban is configured **by default** on the golden image and deployed across all **Ubuntu 24.04 LTS** lab virtual machines. The verification process covers:  

| **Verification Area**          | **Description** |
|--------------------------------|----------------|
| **Service Status**             | Ensures Fail2Ban is running and enabled on boot. |
| **Active Jails**               | Confirms SSH login attempts are monitored. |
| **Brute-Force Attack Simulation** | Tests Fail2Ban’s detection and response to unauthorized logins. |
| **Ban Validation**             | Checks that Fail2Ban correctly blocks attackers. |
| **Firewall Rules**             | Verifies that IP bans are enforced via `iptables`. |
| **Logging & Compliance**       | Ensures all actions are logged for audit purposes. |

🚀 **Fail2Ban must remain active across all deployed VMs to maintain SSH intrusion protection.**

---

## **3. Compliance Mapping**  

Fail2Ban contributes to **intrusion detection and account security compliance** under multiple security frameworks. The following table outlines the relevant mappings:  

| **Framework**  | **Control Mapping** |
|--------------|------------------|
| **CISv8**  | - CIS Control 5: Account Management  |  
|            | - CIS Control 6: Access Control Management  |  
|            | - CIS Control 9: Secure Configuration Management  |  
| **NIST 800-53**  | - AC-7: Unsuccessful Login Attempts  |  
|                | - SI-4: System Monitoring  |  
|                | - CM-7: Least Functionality  |  
| **ISO 27001**  | - A.9.2: User Access Management  |  
|                | - A.12.4: Logging and Monitoring  |  

✅ **Fail2Ban enforces security best practices by preventing brute-force attacks, monitoring failed authentication attempts, and ensuring access control integrity.**

---

## **4. Fail2Ban Service Verification**  

To ensure Fail2Ban is **active and running**, check its systemd service status:  

```bash
systemctl status fail2ban
```

### **Expected Output:**  

```plaintext
● fail2ban.service - Fail2Ban Service
     Loaded: loaded (/usr/lib/systemd/system/fail2ban.service; enabled; preset: enabled)
     Active: active (running) since Tue 2025-03-04 02:10:48 EST; 36min ago
```

✅ **Fail2Ban is active and starts automatically on boot.**

---

## **5. Checking Active Jails**  

Fail2Ban uses **jails** to monitor authentication logs. To list active jails:  

```bash
fail2ban-client status
```

### **Expected Output:**  

```plaintext
Status
|- Number of jail:      1
`- Jail list:   sshd
```

✅ **Fail2Ban is actively monitoring SSH authentication attempts.**

---

## **6. Simulating Unauthorized Access**  

To verify that Fail2Ban **detects and bans repeated failed logins**, simulate a brute-force attempt:  

```bash
ssh invalid_user@10.25.10.201
```

### **Expected Outcome:**  

After **three failed attempts**, SSH access is **blocked**:

```plaintext
ssh: connect to host 10.25.10.201 port 22: Connection refused
```

✅ **Fail2Ban successfully blocks unauthorized SSH attempts.**

---

## **7. Confirming Banned IPs**  

After an IP is banned, check its status:  

```bash
fail2ban-client status sshd
```

### **Expected Output:**  

```plaintext
Status for the jail: sshd
|- Filter
|  |- Currently failed: 0
|  |- Total failed:     3
|  `- File list:        /var/log/auth.log
`- Actions
   |- Currently banned: 1
   |- Total banned:     1
   `- Banned IP list:   10.25.10.17
```

✅ **Fail2Ban successfully detects and bans the offending IP.**

---

## **8. Verifying Ban Logs**  

Fail2Ban logs all ban actions. To review logged bans:  

```bash
grep "Ban" /var/log/fail2ban.log
```

### **Expected Output:**  

```plaintext
2025-03-04 02:48:52,902 fail2ban.actions        [796]: NOTICE  [sshd] Ban 10.25.10.17
```

✅ **Ban actions are logged for audit and compliance tracking.**

---

## **9. Confirming Firewall Rules**  

Fail2Ban integrates with **iptables** to enforce bans. To verify firewall rules:  

```bash
iptables -L -n --line-numbers | grep f2b
```

### **Expected Output:**  

```plaintext
1    f2b-sshd   6    --  0.0.0.0/0            0.0.0.0/0            multiport dports 22
Chain f2b-sshd (1 references)
```

✅ **Fail2Ban enforces IP bans via firewall rules.**

---

## **10. Manually Unbanning an IP**  

To **remove** a banned IP:  

```bash
fail2ban-client set sshd unbanip 10.25.10.17
```

### **Expected Output:**  

```plaintext
1
```

✅ **Fail2Ban allows manual unbans when required.**

---

## **11. Conclusion**  

| **Test**                                      | **Status** |
|----------------------------------------------|------------|
| Fail2Ban service is running                  | ✅ Passed |
| Fail2Ban is monitoring SSH logins            | ✅ Passed |
| Unauthorized access attempts detected        | ✅ Passed |
| Offending IPs are banned                     | ✅ Passed |
| Ban actions are logged in `/var/log/fail2ban.log` | ✅ Passed |
| Firewall (`iptables`) confirms enforcement   | ✅ Passed |
| Manual unban functionality verified          | ✅ Passed |

🚀 **Fail2Ban is fully operational on the golden image, actively protecting against brute-force SSH attacks.**

---

## ✅ **Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | ✅ DRAFT |

---

## 📜 **Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |
| 1.1 | 2025-03-04 | Added compliance mappings & structured headings | VintageDon |
