# **🔐 Conditional Access Policy: `baseline-mfa-join-register-devices`**  

---

## **1️⃣ Introduction**  

This document details the **Microsoft Entra Conditional Access policy** that **enforces multi-factor authentication (MFA) when users join or register devices**. This policy prevents **unauthorized device additions**, ensuring that only authenticated users can register devices into **the environment**.

---

## **2️⃣ Scope**  

| **Category**  | **Details**  |
|--------------|-------------|
| **In-Scope**  | ✅ All internal users attempting to join or register a device  |
|              | ✅ All devices registering with Entra ID  |
| **Out-of-Scope**  | ❌ Break-glass admin accounts *(Excluded for emergency recovery.)*  |
|              | ❌ Existing registered devices *(Already enrolled; enforced via separate policies.)*  |

---

## **3️⃣ Policy Configuration**  

### **🔹 Assignments**  

| **Setting**  | **Details**  |
|-------------|-------------|
| **Users & Groups**  | ✅ All users joining or registering devices  |
|             | ❌ Exclusions: `SG_Identity_Users_AllowedToJoinDevices` *(Temporary bypass group for Ops.)*  |
| **Target Resources**  | ✅ Device registration & join services  |
| **Network Conditions**  | ✅ No restrictions—applies globally  |

---

### **🔹 Client Apps**  

| **Category**  | **Selected Options**  |
|--------------|----------------------|
| **Modern Authentication Clients**  | ✅ Allowed *(Applies to Windows, macOS, Linux, and mobile enrollment clients.)*  |
| **Legacy Authentication Clients**  | ❌ Blocked *(Older non-modern authentication methods.)*  |

---

### **🔹 Grant Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Access Enforcement**  | ✅ Require `Passwordless MFA` before registration  |
| **Authentication Strength**  | ✅ Phishing-resistant authentication required (FIDO2, Microsoft Authenticator) |

---

### **🔹 Session Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Sign-in Frequency**  | ✅ One-time enforcement per registration process  |
| **Persistent Browser Sessions**  | ✅ Inherits session settings from `baseline-mfa-require-globally`. |

---

## **4️⃣ Security & Compliance Notes**  

| **Category**  | **Security Justification**  |
|--------------|-----------------------------|
| **MFA Before Device Registration**  | ✅ Prevents unauthorized device join attempts  |
|                                      | ✅ Reduces risk of compromised accounts adding unmanaged devices  |
| **Legacy Join Methods Blocked**  | ✅ Ensures only modern authentication is used  |
| **Controlled Device Registration**  | ✅ Temporary bypass group exists for operational flexibility  |

---

## **5️⃣ References**  

| **Resource**  | **Link**  |
|--------------|----------|
| 🔗 Microsoft Docs - Conditional Access & Device Registration  | [Learn More](https://learn.microsoft.com/en-us/entra/identity/conditional-access/howto-conditional-access-policy-register-device)  |
| 📜 Related KBs  | [Baseline MFA Policy](baseline-mfa-require-globally.md), [Device Compliance Policies](p1-require-compliant-devices.md) |

---

## **Metadata**

```yaml
author: VintageDon
version: 1.0
visibility: private
```
