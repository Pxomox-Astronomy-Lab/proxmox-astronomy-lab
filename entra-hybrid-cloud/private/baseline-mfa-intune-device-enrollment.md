# **🔐 Conditional Access Policy: `baseline-mfa-intune-device-enrollment`**  

---

## **1️⃣ Introduction**  

This document details the **Microsoft Entra Conditional Access policy** that enforces **multi-factor authentication (MFA) for Intune device enrollment**. By requiring MFA during the enrollment process, this policy mitigates the risk of **unauthorized device registration**, ensuring that only authenticated users can enroll devices into **Intune for management**.

---

## **2️⃣ Scope**  

| **Category**  | **Details**  |
|--------------|-------------|
| **In-Scope**  | ✅ All internal users attempting to enroll a device in Intune  |
|              | ✅ All devices enrolling into Intune (Windows, Linux, and mobile)  |
| **Out-of-Scope**  | ❌ Existing enrolled devices *(Already managed; enforced via other policies.)*  |
|              | ❌ Break-glass admin accounts *(Excluded for emergency recovery.)*  |

---

## **3️⃣ Policy Configuration**  

### **🔹 Assignments**  

| **Setting**  | **Details**  |
|-------------|-------------|
| **Users & Groups**  | ✅ All users enrolling devices  |
| **Target Resources**  | ✅ Microsoft Intune Enrollment service  |
| **Network Conditions**  | ✅ No restrictions—applies globally  |

---

### **🔹 Client Apps**  

| **Category**  | **Selected Options**  |
|--------------|----------------------|
| **Modern Authentication Clients**  | ✅ Allowed *(Intune Enrollment Portal, Company Portal app, Microsoft Endpoint Manager clients.)*  |
| **Legacy Authentication Clients**  | ❌ Blocked *(Legacy mobile device management clients.)*  |

---

### **🔹 Grant Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Access Enforcement**  | ✅ Require `Passwordless MFA` before enrollment  |
| **Authentication Strength**  | ✅ Passwordless authentication required (FIDO2, Microsoft Authenticator) |

---

### **🔹 Session Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Sign-in Frequency**  | ✅ One-time enforcement per enrollment process  |
| **Persistent Browser Sessions**  | ✅ Inherits session settings from `baseline-mfa-require-globally`. |

---

## **4️⃣ Security & Compliance Notes**  

| **Category**  | **Security Justification**  |
|--------------|-----------------------------|
| **MFA Before Enrollment**  | ✅ Prevents unauthorized device registrations  |
|                                      | ✅ Ensures only approved users can enroll new devices  |
| **Legacy Enrollment Methods Blocked**  | ✅ Stops non-compliant device registration attempts  |
| **Strong Authentication Required**  | ✅ Ensures phishing-resistant authentication before device provisioning  |

---

## **5️⃣ References**  

| **Resource**  | **Link**  |
|--------------|----------|
| 🔗 Microsoft Docs - Conditional Access & Intune Enrollment  | [Learn More](https://learn.microsoft.com/en-us/mem/intune/protect/conditional-access-intune-common-ways-use)  |
| 📜 Related KBs  | [Baseline MFA Policy](baseline-mfa-require-globally.md), [Device Compliance Policies](p1-require-compliant-devices.md) |

---

## **Metadata**

```yaml
author: VintageDon
version: 1.0
visibility: private
```
