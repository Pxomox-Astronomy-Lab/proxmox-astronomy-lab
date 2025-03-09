# **🔐 Conditional Access Policy: `baseline-block-legacy-auth`**  

---

## **1️⃣ Introduction**  

This document details the **Microsoft Entra Conditional Access policy** that **blocks legacy authentication** across all resources. Legacy authentication methods, such as basic authentication and older protocols, **do not support modern security features like MFA** and pose a **high risk of credential-based attacks**. This policy ensures that only **modern authentication clients** are permitted.

---

## **2️⃣ Scope**  

| **Category**  | **Details**  |
|--------------|-------------|
| **In-Scope**  | ✅ All internal users  |
|              | ✅ All external users (B2B, service providers, guest researchers)  |
|              | ✅ All resources (Azure Arc-managed servers, on-prem services, Kasm, RDS, etc.)  |
| **Out-of-Scope**  | ❌ Break-glass admin accounts *(Excluded to ensure emergency access—PIM is recommended for control.)*  |

---

## **3️⃣ Policy Configuration**  

### **🔹 Assignments**  

| **Setting**  | **Details**  |
|-------------|-------------|
| **Users & Groups**  | ✅ All users included  |
| **Target Resources**  | ✅ All resources (Azure Arc-managed servers, Kasm, RDS, Grafana, TimescaleDB, and all on-prem apps)  |
| **Network Conditions**  | ❌ No exclusions—applies globally across all locations. |

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
| **Access Enforcement**  | ❌ Block access if legacy authentication is detected. |
| **Authentication Strength**  | ✅ Require `Modern Authentication` (if applicable). |

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
| **Blocking Legacy Authentication**  | ✅ Prevents credential stuffing, password spraying, and brute-force attacks  |
|                                      | ✅ Enforces modern authentication methods that support MFA  |
| **Ensuring Zero Exceptions**  | ✅ No exclusions apply—legacy authentication is fully deprecated  |
|                                      | ✅ Entra logs will monitor any legacy authentication attempts for auditing  |

---

## **5️⃣ References**  

| **Resource**  | **Link**  |
|--------------|----------|
| 🔗 Microsoft Docs - Conditional Access & Legacy Authentication  | [Learn More](https://learn.microsoft.com/en-us/entra/identity/conditional-access/block-legacy-authentication)  |
| 📜 Related KBs  | [Baseline MFA Policy](baseline-mfa-require-globally.md) |

---

## **Metadata**

```yaml
author: VintageDon
version: 1.0
visibility: private
```
