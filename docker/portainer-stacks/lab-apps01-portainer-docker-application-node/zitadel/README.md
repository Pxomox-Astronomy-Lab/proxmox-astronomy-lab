# **Zitadel - Identity & Access Management (IAM) Service**

## **1. Service Overview**

Zitadel is a **self-hosted identity and access management (IAM) platform** that provides **authentication, authorization, and user federation**. It serves as an **SSO bridge**, allowing applications to authenticate against **Entra ID (formerly Azure AD) securely without directly exposing Entra to public endpoints**.

The **self-hosted version of Zitadel** includes the full **enterprise feature set**, enabling complete control over identity management, access control, and security policies within the **Proxmox Astronomy Lab**.

## **2. Purpose & Scope**

This service is responsible for **securing access to legacy and modern web applications** that need to integrate with **Entra ID**. It provides:

- **SSO for Legacy Web GUIs** – Acts as a bridge to **authenticate older applications** that do not support **modern authentication methods** (OIDC/SAML).
- **Proxy Authentication for Modern Applications** – Allows **modern applications** that already support Entra authentication to **authenticate via Zitadel** instead of directly exposing Entra.
- **Conditional Access Policy Enforcement** – Ensures **all authentication requests follow Entra ID's security policies**.
- **Multi-Tenant Identity Management** – Manages user authentication across **multiple internal and external applications**.
- **Secure Federation & Delegated Authentication** – Enables **external identity provider (IdP) connections** while maintaining security controls.

## **3. Service Architecture**

### **3.1. Zitadel Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Zitadel Version**            | `2.41.1`                        |
| **Authentication Methods**     | OIDC, SAML, Passwordless        |
| **Database Backend**           | PostgreSQL (`lab-db01`)         |
| **Entra ID Integration**       | Enabled (OIDC Federation)       |
| **Public Endpoint Exposure**   | Restricted (Zitadel is the authentication proxy) |
| **Access Control**             | Role-Based & Policy-Based       |

### **3.2. Dependencies & Integration**

| Dependency                     | Role in Zitadel Service           |
|--------------------------------|---------------------------------|
| **PostgreSQL (`lab-db01`)**    | Stores Zitadel user data & policies |
| **Entra ID (Azure AD)**        | Acts as the primary identity provider (IdP) |
| **Reverse Proxy (Nginx Proxy Manager)** | Secures external Zitadel access |

## **4. Entra ID Federation - Secure Authentication Proxy**

Zitadel enables **secure authentication proxying** to Entra ID by:

1. **Handling Authentication Requests** – Applications authenticate with Zitadel instead of directly exposing Entra.
2. **Federating with Entra ID** – Zitadel validates credentials **against Entra ID policies**.
3. **Applying Conditional Access Policies** – Zitadel ensures that authentication **meets Entra security requirements** before granting access.
4. **Returning Authentication Tokens** – Applications receive a **Zitadel-issued token**, securing access without direct Entra exposure.

## **5. Security & Compliance Considerations**

- **Role-Based & Policy-Based Access Control** – User permissions are strictly defined.
- **Logging & Auditing Enabled** – Authentication requests are logged for compliance.
- **Zero Trust Model Alignment** – Ensures all authentication requests are verified before granting access.
- **Entra Conditional Policies Enforced** – Zitadel inherits Entra’s security policies.

## **6. Change Management**

All modifications to this service (including identity provider settings, authentication policies, and access rules) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **7. Related Documentation**

- [PostgreSQL (`lab-db01`)](../database/postgresql-lab-db01.md)
- [Nginx Proxy Manager](../networking/nginx-proxy-manager.md)
- [Entra ID Federation Guide] (Internal KB Reference)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)
