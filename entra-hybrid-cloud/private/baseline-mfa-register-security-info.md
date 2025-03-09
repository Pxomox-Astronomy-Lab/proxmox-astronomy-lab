# **🔐 Conditional Access Policy: `baseline-mfa-register-security-info`**  

---

## **1️⃣ Introduction**  

This document details the **Microsoft Entra Conditional Access policy** that **enforces multi-factor authentication (MFA) when users register or update their security information**. This policy prevents **unauthorized changes** to authentication factors, ensuring that **only verified users can modify their security settings**.

---

## **2️⃣ Scope**  

| **Category**  | **Details**  |
|--------------|-------------|
| **In-Scope**  | ✅ All internal users attempting to update security info  |
|              | ✅ All external users with authentication method modification access  |
| **Out-of-Scope**  | ❌ Break-glass admin accounts *(Excluded for emergency recovery.)*  |
|              | ❌ Temporary exclusions via `SG_Identity_Users_AllowedToRegisterSecurityInfo` *(For Ops use only.)* |

---

## **3️⃣ Policy Configuration**  

### **🔹 Assignments**  

| **Setting**  | **Details**  |
|-------------|-------------|
| **Users & Groups**  | ✅ All users  |
|             | ❌ Exclusions: `SG_Identity_Users_AllowedToRegisterSecurityInfo` *(Temporary bypass for Ops.)*  |
| **Target Resources**  | ✅ Security info registration service  |
| **Network Conditions**  | ✅ No restrictions—applies globally  |

---

### **🔹 Client Apps**  

| **Category**  | **Selected Options**  |
|--------------|----------------------|
| **Modern Authentication Clients**  | ✅ Allowed *(Web-based and modern authentication clients.)*  |
| **Legacy Authentication Clients**  | ❌ Blocked *(Older authentication clients that do not support MFA.)*  |

---

### **🔹 Grant Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Access Enforcement**  | ✅ Require `Passwordless MFA` before modifying security information  |
| **Authentication Strength**  | ✅ Phishing-resistant authentication required (FIDO2, Microsoft Authenticator) |

---

### **🔹 Session Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Sign-in Frequency**  | ✅ One-time enforcement per security info update session  |
| **Persistent Browser Sessions**  | ✅ Inherits session settings from `baseline-mfa-require-globally`. |

---

## **4️⃣ Security & Compliance Notes**  

| **Category**  | **Security Justification**  |
|--------------|-----------------------------|
| **MFA Before Security Info Updates**  | ✅ Prevents attackers from modifying authentication factors if credentials are compromised  |
|                                      | ✅ Reduces risk of MFA reset attacks and account takeovers  |
| **Legacy Authentication Blocked**  | ✅ Ensures security settings can only be modified via modern authentication methods  |
| **Controlled Temporary Bypass**  | ✅ Allows Ops flexibility for onboarding but does not permit permanent exclusions  |

---

## **5️⃣ References**  

| **Resource**  | **Link**  |
|--------------|----------|
| 🔗 Microsoft Docs - Conditional Access & Security Info Registration  | [Learn More](https://learn.microsoft.com/en-us/entra/identity/conditional-access/howto-conditional-access-policy-registration)  |
| 📜 Related KBs  | [Baseline MFA Policy](baseline-mfa-require-globally.md), [Device Compliance Policies](p1-require-compliant-devices.md) |

---

## **Metadata**

```yaml
author: VintageDon
version: 1.0
visibility: private
```
