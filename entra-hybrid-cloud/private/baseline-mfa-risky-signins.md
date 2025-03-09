# **🔐 Conditional Access Policy: `baseline-mfa-risky-signins`**  

---

## **1️⃣ Introduction**  

This document details the **Microsoft Entra Conditional Access policy** that **enforces multi-factor authentication (MFA) for risky sign-ins**. This policy ensures that any **login attempt classified as risky by Microsoft Entra's Identity Protection** requires **strong authentication before access is granted**. By enforcing this policy, unauthorized access attempts due to **compromised credentials, unusual activity, or automated attack patterns** are mitigated.

---

## **2️⃣ Scope**  

| **Category**  | **Details**  |
|--------------|-------------|
| **In-Scope**  | ✅ All internal users  |
|              | ✅ All external users (B2B, service providers, guest researchers)  |
| **Out-of-Scope**  | ❌ Break-glass admin accounts *(Excluded for emergency recovery.)*  |

---

## **3️⃣ Policy Configuration**  

### **🔹 Assignments**  

| **Setting**  | **Details**  |
|-------------|-------------|
| **Users & Groups**  | ✅ All users  |
| **Target Resources**  | ✅ All resources  |
| **Risk Conditions**  | ✅ **User risk:** High or medium  |
|                      | ✅ **Sign-in risk:** High or medium  |
| **Network Conditions**  | ✅ No restrictions—applies globally  |

---

### **🔹 Client Apps**  

| **Category**  | **Selected Options**  |
|--------------|----------------------|
| **Modern Authentication Clients**  | ✅ Allowed *(Web-based, mobile, and desktop authentication clients.)*  |
| **Legacy Authentication Clients**  | ❌ Blocked *(Older authentication clients that do not support MFA.)*  |

---

### **🔹 Grant Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Access Enforcement**  | ✅ Require `Passwordless MFA` for all high-risk sign-ins  |
| **Authentication Strength**  | ✅ Phishing-resistant authentication required (FIDO2, Microsoft Authenticator) |
| **Risk Mitigation**  | ✅ Require user risk remediation (password reset) if high risk is detected |

---

### **🔹 Session Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Sign-in Frequency**  | ✅ Force reauthentication for high-risk sessions  |
| **Persistent Browser Sessions**  | ✅ Inherits session settings from `baseline-mfa-require-globally`. |

---

## **4️⃣ Security & Compliance Notes**  

| **Category**  | **Security Justification**  |
|--------------|-----------------------------|
| **Enforcing MFA for Risky Sign-ins**  | ✅ Stops compromised accounts from accessing resources  |
|                                      | ✅ Mitigates credential stuffing and automated login attempts  |
| **Risk-Based Access Control**  | ✅ Uses Microsoft’s AI-driven risk assessment to detect compromised accounts  |
| **Remediation for High-Risk Users**  | ✅ Ensures high-risk users must reset passwords before regaining access  |

---

## **5️⃣ References**  

| **Resource**  | **Link**  |
|--------------|----------|
| 🔗 Microsoft Docs - Conditional Access & Risk-Based Authentication  | [Learn More](https://learn.microsoft.com/en-us/entra/identity/conditional-access/howto-conditional-access-policy-risk)  |
| 📜 Related KBs  | [Baseline MFA Policy](baseline-mfa-require-globally.md), [Risk-Based Authentication](p2-risk-based-authentication.md) |

---

## **Metadata**

```yaml
author: VintageDon
version: 1.0
visibility: private
```
