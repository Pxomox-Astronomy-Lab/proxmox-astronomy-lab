# **🔐 Conditional Access Policy: `baseline-access-geofencing-usa`**  

---

## **1️⃣ Introduction**  

This document details the **Microsoft Entra Conditional Access policy** that enforces **geofencing restrictions**, allowing only sign-ins from within the **United States** for all users. This policy helps mitigate **unauthorized access attempts from foreign locations**, reducing the attack surface and enhancing security for **Azure Arc-managed resources, Kasm, RDS, and other critical services**.

---

## **2️⃣ Scope**  

| **Category**  | **Details**  |
|--------------|-------------|
| **In-Scope**  | ✅ All internal users  |
|              | ✅ All external users (B2B, service providers, guest researchers)  |
|              | ✅ All resources (Azure Arc-managed servers, on-prem services)  |
| **Out-of-Scope**  | ❌ Break-glass admin accounts *(Excluded to ensure emergency access—PIM is recommended for control.)*  |
|              | ❌ VPN-based access *(Handled separately via Entra Private Access policies.)*  |

---

## **3️⃣ Policy Configuration**  

### **🔹 Assignments**  

| **Setting**  | **Details**  |
|-------------|-------------|
| **Users & Groups**  | ✅ All users included  |
| **Target Resources**  | ✅ All resources (Azure Arc-managed servers and all on-prem apps)  |
| **Network Conditions**  | ✅ Allow **United States** only  |
|                        | ❌ Block **all other geolocations** |

---

### **🔹 Client Apps**  

| **Category**  | **Selected Options**  |
|--------------|----------------------|
| **Modern Authentication Clients**  | ✅ Allowed *(Browser, mobile apps, and desktop clients that use modern authentication.)*  |
| **Legacy Authentication Clients**  | ❌ Blocked *(Exchange ActiveSync, legacy SMTP, POP, IMAP, and older non-modern auth clients.)*  |

---

### **🔹 Grant Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Access Enforcement**  | ❌ Block access from non-U.S. locations  |
| **Authentication Strength**  | ✅ Require `Passwordless MFA` |

---

### **🔹 Session Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Sign-in Frequency**  | ✅ Inherits session controls from `baseline-mfa-require-globally`. |
| **Persistent Browser Sessions**  | ✅ Inherits session controls from `baseline-mfa-require-globally`. |

---

## **4️⃣ Security & Compliance Notes**  

| **Category**  | **Security Justification**  |
|--------------|-----------------------------|
| **Geofencing Enforcement**  | ✅ Prevents unauthorized access from foreign IPs and malicious locations  |
|                                      | ✅ Reduces risk of phishing attempts from overseas threat actors  |
| **Exclusions for VPN Access**  | ✅ Remote users outside the U.S. must authenticate via **Entra Private Access VPN alternative**  |
|                                      | ✅ Ensures compliance with **regional access control policies** |

---

## **5️⃣ References**  

| **Resource**  | **Link**  |
|--------------|----------|
| 🔗 Microsoft Docs - Conditional Access & Location-Based Restrictions  | [Learn More](https://learn.microsoft.com/en-us/entra/identity/conditional-access/location-based-policies)  |
| 📜 Related KBs  | [Baseline MFA Policy](baseline-mfa-require-globally.md), [Private Access Policies](suite-private-access-kasm-restriction.md) |

---

## **Metadata**

```yaml
author: VintageDon
version: 1.0
visibility: private
```
