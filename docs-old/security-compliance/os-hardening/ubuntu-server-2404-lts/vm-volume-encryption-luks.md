---
title: "Configuring LUKS Encryption with TPM Auto-Unlock for Lab VMs"
description: "Step-by-step guide to setting up LUKS encryption with TPM-bound auto-unlock on Ubuntu VMs, ensuring compliance with CISv8 encryption-at-rest requirements."
author: "VintageDon"
tags: ["TPM", "LUKS", "Encryption", "Security", "Compliance", "Ubuntu"]
category: "Security"
kb_type: "Implementation"
version: "1.0"
status: "Draft"
last_updated: "2025-03-02"
---

# **🔐 Configuring LUKS Encryption with TPM Auto-Unlock for Lab VMs**

## **1. Introduction**

All **Ubuntu VMs in the lab** boot via **UEFI and have full TPM support**. This provides an opportunity to securely encrypt disk volumes using **LUKS (Linux Unified Key Setup) with TPM-based auto-unlock**.

This method ensures that **log storage and sensitive data are encrypted at rest**, meeting **CISv8 compliance** without requiring manual passphrase entry at each reboot. Instead, the TPM securely stores the key and automatically unlocks the encrypted volume upon boot.

This KB details the **step-by-step implementation** for configuring **LUKS encryption with TPM-bound unlocking** on the lab’s **golden template** VMs.

---

## **2. Scope**

| **Category**           | **Description**                                                                                    |
| ---------------------- | -------------------------------------------------------------------------------------------------- |
| **In-Scope**           | Configuring LUKS encryption with TPM-bound auto-unlock on Ubuntu VMs.                              |
| **Out-of-Scope**       | Full-disk encryption requiring manual input at boot.                                               |
| **Compliance Mapping** | CISv8 3.14 (Log Encryption), NIST AU-9 (Protect Audit Logs), ISO 27001 A.12.3.1 (Data Encryption). |

---

## **3. Prerequisites**

Before proceeding, ensure the following:

- The VM boots via **UEFI with a TPM2 device available**.
- `systemd-cryptenroll` is installed (Ubuntu 22.04+ includes this by default).
- The target disk is formatted and **ready for encryption**.
- You have administrative privileges (root or sudo access).

---

## **4. Implementation Steps**

### **Step 1: Verify TPM Availability**

Run the following to check if TPM2 is detected:

```bash
tpm2_getcap properties-fixed
```

You should see TPM properties output. If TPM is missing, ensure it's enabled in the VM settings.

### **Step 2: Encrypt the Target Volume with LUKS**

Identify the partition you want to encrypt:

```bash
lsblk
```

Then, encrypt it using LUKS:

```bash
cryptsetup luksFormat --type luks2 /dev/nvmeXnY
```

> Replace `/dev/nvmeXnY` with your actual disk/partition.

### **Step 3: Enroll TPM for Auto-Unlock**

Bind the encryption key to the TPM2 module:

```bash
systemd-cryptenroll --tpm2-device=auto /dev/nvmeXnY
```

This generates and stores a TPM-bound key inside the TPM chip, preventing it from being extracted.

### **Step 4: Configure Auto-Unlock in crypttab**

Edit `/etc/crypttab` and add the following entry:

```plaintext
logvol UUID=<LUKS-UUID> none tpm2
```

Find the LUKS UUID:

```bash
blkid /dev/nvmeXnY
```

### **Step 5: Update Initramfs**

To ensure TPM unlock works during boot, update the initramfs:

```bash
update-initramfs -u
```

### **Step 6: Reboot and Verify**

Restart the VM and check if the volume is automatically unlocked:

```bash
df -h | grep logvol
```

If the encrypted volume is mounted automatically, TPM-based unlocking is successful.

---

## **5. Security & Compliance Considerations**

### **5.1 Why This Approach?**

- **Encryption at rest:** Ensures that **logs and sensitive data remain encrypted**, even if disks are accessed outside the VM.
- **Operationally seamless:** The VM automatically unlocks the volume **without requiring a passphrase** at boot.
- **TPM-bound keys are secure:** The key **never leaves the TPM** and is unusable if extracted.

### **5.2 Compliance Mapping**

| **Framework**      | **Requirement**                   | **Implementation**                           |
| ------------------ | --------------------------------- | -------------------------------------------- |
| CISv8 3.14         | Encrypt logs at rest              | LUKS encryption for log storage              |
| NIST AU-9          | Protect audit logs from tampering | TPM-bound encryption prevents key extraction |
| ISO 27001 A.12.3.1 | Ensure data encryption at rest    | Auto-unlock mechanism secures storage        |

> **Key Takeaway:** TPM-based LUKS encryption balances **security and operational efficiency**, ensuring compliance while avoiding manual unlock steps at each boot.

---

## **6. Summary**

✅ **LUKS with TPM2 auto-unlock ensures encrypted storage without manual passphrase entry.**\
✅ **Meets CISv8 encryption-at-rest requirements for log storage.**\
✅ **Enhances security by binding keys to TPM, preventing extraction.**\
✅ **This method is implemented on all golden template VMs for standardized security.**

📌 **This KB is referenced in the golden template documentation and compliance mappings.** 🚀
