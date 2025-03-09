# **🔐 Conditional Access Policy: `baseline-mfa-require-globally`**  

---

## **1️⃣ Introduction**  

This document details the **Microsoft Entra Conditional Access policy** enforcing **passwordless multi-factor authentication (MFA) globally** for all users. This policy ensures that all sign-ins require **strong authentication**, improving security while allowing temporary exclusions for onboarding and device registration.

---

## **2️⃣ Scope**  

| **Category**  | **Details**  |
|--------------|-------------|
| **In-Scope**  | ✅ All internal users  |
|              | ✅ All external users (B2B, service providers, guest researchers)  |
|              | ✅ All resources (Azure Arc-managed servers, on-prem services, Kasm, RDS, etc.)  |
| **Out-of-Scope**  | ❌ Break-glass admin accounts *(Excluded as a contingency measure, with PIM recommended instead.)*  |
|              | ❌ Temporary exclusion groups (for onboarding & device registration)  |
|              | ➝ `SG_Identity_Users_MFAExcluded` *(Temporary MFA exclusion group)*  |
|              | ➝ `SG_Identity_Users_AllowedToRegisterSecurityInfo` *(For onboarding security info registration without MFA.)*  |
|              | ➝ `SG_Identity_Users_AllowedToJoinDevices` *(For device join operations without MFA.)*  |

---

## **3️⃣ Policy Configuration**  

### **🔹 Assignments**  

| **Setting**  | **Details**  |
|-------------|-------------|
| **Users & Groups**  | ✅ All users included  |
|             | ❌ Exclusions: `SG_Identity_Users_MFAExcluded`, `SG_Identity_Users_AllowedToRegisterSecurityInfo`, `SG_Identity_Users_AllowedToJoinDevices`  |
| **Target Resources**  | ✅ All resources (Azure Arc-managed servers, Kasm, RDS, Grafana, TimescaleDB, and all on-prem apps)  |
| **Network Conditions**  | ❌ Exclusions: `main-office` *(Static residential IP for lab operations)*, `Multifactor authentication trusted IPs` *(Temporary bypass group for MFA in trusted locations.)*  |

---

### **🔹 Client Apps**  

| **Category**  | **Selected Options**  |
|--------------|----------------------|
| **Modern Authentication Clients**  | ✅ Browser-based authentication *(Web logins, Kasm, RDS, etc.)*  |
|                                      | ✅ Mobile apps and desktop clients *(Microsoft 365, SSH, RDP clients, API integrations.)*  |
| **Legacy Authentication Clients**  | ✅ Exchange ActiveSync clients  |
|                                    | ✅ Other legacy clients  |

---

### **🔹 Grant Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Authentication Strength**  | ✅ Require `Passwordless MFA` *(Microsoft Authenticator, FIDO2, Windows Hello.)*  |
| **Terms of Use Enforcement**  | ✅ Require acknowledgment of `proxmox-astronomy-lab-terms-of-use` before access  |
| **Device Compliance Enforcement**  | ❌ Not enforced globally *(Handled in separate device-based policies.)*  |

---

### **🔹 Session Controls**  

| **Control**  | **Setting**  |
|-------------|-------------|
| **Sign-in Frequency**  | ✅ Every `3 days` *(Users must reauthenticate every 3 days.)*  |
| **Persistent Browser Sessions**  | ✅ `Always persistent` *(Users remain signed in after closing the browser.)*  |
| **Token Protection**  | ❌ Not available in this setup *(Greyed out in UI.)*  |

---

## **4️⃣ Security & Compliance Notes**  

| **Category**  | **Security Justification**  |
|--------------|-----------------------------|
| **Passwordless MFA Requirement**  | ✅ Stronger security than SMS/OTP-based MFA  |
|                                      | ✅ Prevents MFA phishing attacks & fatigue attacks  |
| **Persistent Browser Sessions**  | ✅ Enhances user experience without compromising security  |
|                                      | ✅ Higher-risk access groups will have stricter session limits in separate policies  |
| **Temporary Exclusions for Ops**  | ✅ Onboarding groups allow flexibility while maintaining strong authentication for all other users  |
| **Break-Glass Account Considerations**  | ❌ Break-glass accounts should use `Privileged Identity Management (PIM)` instead of permanent exclusions  |

---

## **5️⃣ References**  

| **Resource**  | **Link**  |
|--------------|----------|
| 🔗 Microsoft Docs - Conditional Access  | [Learn More](https://learn.microsoft.com/en-us/entra/conditional-access/)  |
| 📜 Related KBs  | [Privileged Access Controls](privileged-access.md), [Device Compliance Policies](device-compliance.md)  |

---

## **Metadata**

```yaml
author: VintageDon
version: 1.0
visibility: private
```
