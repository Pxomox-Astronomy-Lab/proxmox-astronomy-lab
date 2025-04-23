<!-- 
---
title: "RKHunter Scan Results - Ubuntu 24.04 LTS CIS Golden Image"
description: "Results of RKHunter rootkit detection scan on the Ubuntu 24.04 LTS CIS hardened golden image"
author: "VintageDon"
tags: ["security", "validation", "rkhunter", "rootkit-detection", "ubuntu-24-04", "cisv8"]
category: "Security Validation"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔍 **RKHunter Scan Results**

## 🔍 **1. Overview**

This document presents the results of a RKHunter (Rootkit Hunter) scan performed on the **Ubuntu 24.04 LTS CIS hardened golden image**. The scan was conducted as part of the security validation process to ensure the system is free from rootkits, backdoors, and other malware.

RKHunter version 1.4.6 was used for this scan, providing comprehensive checking of system files, system commands, network interfaces, and system configuration for signs of compromise.

---

## 📊 **2. Scan Summary**

| **Metric** | **Result** | **Assessment** |
|------------|------------|----------------|
| **Scan Date** | 2025-03-16 | Current |
| **RKHunter Version** | 1.4.6 | Up-to-date |
| **Rootkits Checked** | 499 | Comprehensive coverage |
| **Files Checked** | 145 | Thorough system examination |
| **Suspect Files** | 4 | Known false positives (analyzed below) |
| **Possible Rootkits** | 0 | Clean system |
| **Scan Duration** | 1 minute 2 seconds | Efficient execution |

The scan indicates a **clean system** with only known false positives detected.

---

## 🛡️ **3. Key Findings**

### **3.1 System Command Checks**

System commands were verified for integrity and authenticity:

| **Check Type** | **Status** | **Assessment** |
|---------------|------------|----------------|
| **Strings Command** | ✅ OK | No issues detected |
| **Shared Libraries** | ✅ No preloading | No malicious library preloading |
| **LD_LIBRARY_PATH** | ✅ Not found | No path manipulation |
| **File Properties** | ⚠️ 4 warnings | Known false positives (strings, size) |

The warnings on file properties are associated with known binaries and represent false positives:

- /usr/bin/size
- /usr/bin/strings
- /usr/bin/x86_64-linux-gnu-size
- /usr/bin/x86_64-linux-gnu-strings

### **3.2 Rootkit Detection**

Comprehensive checks for known rootkits revealed no issues:

| **Rootkit Category** | **Result** | **Assessment** |
|---------------------|------------|----------------|
| **Known Rootkit Files** | ✅ None found | Clean system |
| **Suckit Rootkit** | ✅ Clean | No indication of compromise |
| **Hidden Files/Directories** | ✅ None suspicious | Only legitimate system hidden files |
| **Suspicious Strings** | ✅ None found | No indicators of compromise |

### **3.3 Malware Checks**

Additional checks for malware indicators showed no signs of compromise:

| **Check Type** | **Result** | **Assessment** |
|---------------|------------|----------------|
| **Process Analysis** | ✅ No suspicious files | Clean processes |
| **Login Backdoors** | ✅ None found | Secure authentication |
| **Sniffer Logs** | ✅ None found | No network monitoring malware |
| **Suspicious Directories** | ✅ None found | Clean filesystem |
| **Shared Memory Segments** | ✅ None suspicious | No covert channels detected |
| **Apache Backdoor** | ✅ Not found | Web server secure |

### **3.4 Linux-Specific Checks**

Kernel-level checks revealed no signs of compromise:

| **Check Type** | **Result** | **Assessment** |
|---------------|------------|----------------|
| **Loaded Kernel Modules** | ✅ OK | No suspicious modules |
| **Kernel Module Names** | ✅ OK | No disguised modules |

### **3.5 Network Checks**

Network interface and port checks showed no indications of compromise:

| **Check Type** | **Result** | **Assessment** |
|---------------|------------|----------------|
| **Backdoor Ports** | ✅ None found | No covert communication channels |
| **Promiscuous Interfaces** | ✅ None found | No network sniffing detected |

### **3.6 Local Host Checks**

System configuration and account checks revealed no security issues:

| **Check Type** | **Result** | **Assessment** |
|---------------|------------|----------------|
| **System Startup Files** | ✅ Clean | No malware in startup |
| **UID 0 Accounts** | ✅ None found | No unauthorized root accounts |
| **Passwordless Accounts** | ✅ None found | All accounts secured |
| **SSH Root Access** | ✅ Not allowed | Secure SSH configuration |
| **SSH Protocol v1** | ⚠️ Warning | False positive, only v2 enabled |
| **Hidden Files/Directories** | ⚠️ Warning | Legitimate system files |

---

## 🔄 **4. False Positive Analysis**

The scan produced several warnings that have been analyzed and confirmed as false positives:

| **Warning** | **Analysis** | **Mitigation** |
|-------------|--------------|----------------|
| **Binary file warnings** | Standard system binaries with expected properties | Whitelisted in configuration |
| **SSH Protocol v1** | Configuration is secure but RKHunter misinterpreted comment in config | Verified SSH config - only Protocol 2 is enabled |
| **Hidden files warning** | Standard system hidden directories (.udev, .initramfs) | Whitelisted in configuration |

These warnings are consistent with a clean CIS-hardened system and do not represent security issues.

---

## 🔒 **5. Security Assessment**

Based on the RKHunter scan results, the system demonstrates a strong security posture:

- **No rootkits or backdoors** detected
- **System commands integrity** verified
- **Network interfaces** not in promiscuous mode
- **No unauthorized accounts** or security weaknesses
- **Minimal false positives** aligned with expected configuration

This scan confirms compliance with **CIS Control 10.5** (Anti-malware scanning) and supports the system's overall security posture.

---

## 📋 **6. Raw Scan Output**

Below is the complete, unmodified output from the RKHunter scan:

```bash
root@tmp-ubuntu24-server-cis-0225:~# rkhunter --check
[ Rootkit Hunter version 1.4.6 ]

Checking system commands...

  Performing 'strings' command checks
    Checking 'strings' command                               [ OK ]

  Performing 'shared libraries' checks
    Checking for preloading variables                        [ None found ]
    Checking for preloaded libraries                         [ None found ]
    Checking LD_LIBRARY_PATH variable                        [ Not found ]

  Performing file properties checks
    Checking for prerequisites                               [ OK ]
    /usr/sbin/adduser                                        [ OK ]
    /usr/sbin/chroot                                         [ OK ]
    /usr/sbin/cron                                           [ OK ]
    /usr/sbin/depmod                                         [ OK ]
    /usr/sbin/fsck                                           [ OK ]
    /usr/sbin/groupadd                                       [ OK ]
    /usr/sbin/groupdel                                       [ OK ]
    /usr/sbin/groupmod                                       [ OK ]
    /usr/sbin/grpck                                          [ OK ]
    /usr/sbin/ifconfig                                       [ OK ]
    /usr/sbin/init                                           [ OK ]
    /usr/sbin/insmod                                         [ OK ]
    /usr/sbin/ip                                             [ OK ]
    /usr/sbin/lsmod                                          [ OK ]
    /usr/sbin/modinfo                                        [ OK ]
    /usr/sbin/modprobe                                       [ OK ]
    /usr/sbin/nologin                                        [ OK ]
    /usr/sbin/pwck                                           [ OK ]
    /usr/sbin/rmmod                                          [ OK ]
    /usr/sbin/route                                          [ OK ]
    /usr/sbin/rsyslogd                                       [ OK ]
    /usr/sbin/runlevel                                       [ OK ]
    /usr/sbin/sshd                                           [ OK ]
    /usr/sbin/sulogin                                        [ OK ]
    /usr/sbin/sysctl                                         [ OK ]
    /usr/sbin/useradd                                        [ OK ]
    /usr/sbin/userdel                                        [ OK ]
    /usr/sbin/usermod                                        [ OK ]
    /usr/sbin/vipw                                           [ OK ]
    /usr/sbin/unhide                                         [ OK ]
    /usr/sbin/unhide-linux                                   [ OK ]
    /usr/sbin/unhide-posix                                   [ OK ]
    /usr/sbin/unhide-tcp                                     [ OK ]
    /usr/bin/awk                                             [ OK ]
    /usr/bin/basename                                        [ OK ]
    /usr/bin/bash                                            [ OK ]
    /usr/bin/cat                                             [ OK ]
    /usr/bin/chattr                                          [ OK ]
    /usr/bin/chmod                                           [ OK ]
    /usr/bin/chown                                           [ OK ]
    /usr/bin/cp                                              [ OK ]
    /usr/bin/curl                                            [ OK ]
    /usr/bin/cut                                             [ OK ]
    /usr/bin/date                                            [ OK ]
    /usr/bin/df                                              [ OK ]
    /usr/bin/diff                                            [ OK ]
    /usr/bin/dirname                                         [ OK ]
    /usr/bin/dmesg                                           [ OK ]
    /usr/bin/dpkg                                            [ OK ]
    /usr/bin/dpkg-query                                      [ OK ]
    /usr/bin/du                                              [ OK ]
    /usr/bin/echo                                            [ OK ]
    /usr/bin/ed                                              [ OK ]
    /usr/bin/egrep                                           [ OK ]
    /usr/bin/env                                             [ OK ]
    /usr/bin/fgrep                                           [ OK ]
    /usr/bin/file                                            [ OK ]
    /usr/bin/find                                            [ OK ]
    /usr/bin/fuser                                           [ OK ]
    /usr/bin/grep                                            [ OK ]
    /usr/bin/groups                                          [ OK ]
    /usr/bin/head                                            [ OK ]
    /usr/bin/id                                              [ OK ]
    /usr/bin/ip                                              [ OK ]
    /usr/bin/ipcs                                            [ OK ]
    /usr/bin/kill                                            [ OK ]
    /usr/bin/killall                                         [ OK ]
    /usr/bin/last                                            [ OK ]
    /usr/bin/lastlog                                         [ OK ]
    /usr/bin/ldd                                             [ OK ]
    /usr/bin/less                                            [ OK ]
    /usr/bin/locate                                          [ OK ]
    /usr/bin/logger                                          [ OK ]
    /usr/bin/login                                           [ OK ]
    /usr/bin/ls                                              [ OK ]
    /usr/bin/lsattr                                          [ OK ]
    /usr/bin/lsmod                                           [ OK ]
    /usr/bin/lsof                                            [ OK ]
    /usr/bin/lynx                                            [ OK ]
    /usr/bin/mail                                            [ OK ]
    /usr/bin/md5sum                                          [ OK ]
    /usr/bin/mktemp                                          [ OK ]
    /usr/bin/more                                            [ OK ]
    /usr/bin/mount                                           [ OK ]
    /usr/bin/mv                                              [ OK ]
    /usr/bin/netstat                                         [ OK ]
    /usr/bin/newgrp                                          [ OK ]
    /usr/bin/passwd                                          [ OK ]
    /usr/bin/perl                                            [ OK ]
    /usr/bin/pgrep                                           [ OK ]
    /usr/bin/ping                                            [ OK ]
    /usr/bin/pkill                                           [ OK ]
    /usr/bin/ps                                              [ OK ]
    /usr/bin/pstree                                          [ OK ]
    /usr/bin/pwd                                             [ OK ]
    /usr/bin/readlink                                        [ OK ]
    /usr/bin/rkhunter                                        [ OK ]
    /usr/bin/runcon                                          [ OK ]
    /usr/bin/sed                                             [ OK ]
    /usr/bin/sh                                              [ OK ]
    /usr/bin/sha1sum                                         [ OK ]
    /usr/bin/sha224sum                                       [ OK ]
    /usr/bin/sha256sum                                       [ OK ]
    /usr/bin/sha384sum                                       [ OK ]
    /usr/bin/sha512sum                                       [ OK ]
    /usr/bin/size                                            [ Warning ]
    /usr/bin/sort                                            [ OK ]
    /usr/bin/ssh                                             [ OK ]
    /usr/bin/stat                                            [ OK ]
    /usr/bin/strace                                          [ OK ]
    /usr/bin/strings                                         [ Warning ]
    /usr/bin/su                                              [ OK ]
    /usr/bin/sudo                                            [ OK ]
    /usr/bin/tail                                            [ OK ]
    /usr/bin/telnet                                          [ OK ]
    /usr/bin/test                                            [ OK ]
    /usr/bin/top                                             [ OK ]
    /usr/bin/touch                                           [ OK ]
    /usr/bin/tr                                              [ OK ]
    /usr/bin/uname                                           [ OK ]
    /usr/bin/uniq                                            [ OK ]
    /usr/bin/users                                           [ OK ]
    /usr/bin/vmstat                                          [ OK ]
    /usr/bin/w                                               [ OK ]
    /usr/bin/watch                                           [ OK ]
    /usr/bin/wc                                              [ OK ]
    /usr/bin/wget                                            [ OK ]
    /usr/bin/whatis                                          [ OK ]
    /usr/bin/whereis                                         [ OK ]
    /usr/bin/which                                           [ OK ]
    /usr/bin/who                                             [ OK ]
    /usr/bin/whoami                                          [ OK ]
    /usr/bin/numfmt                                          [ OK ]
    /usr/bin/kmod                                            [ OK ]
    /usr/bin/systemd                                         [ OK ]
    /usr/bin/systemctl                                       [ OK ]
    /usr/bin/gawk                                            [ OK ]
    /usr/bin/locate.findutils                                [ OK ]
    /usr/bin/bsd-mailx                                       [ OK ]
    /usr/bin/dash                                            [ OK ]
    /usr/bin/x86_64-linux-gnu-size                           [ Warning ]
    /usr/bin/x86_64-linux-gnu-strings                        [ Warning ]
    /usr/bin/inetutils-telnet                                [ OK ]
    /usr/bin/which.debianutils                               [ OK ]
    /usr/lib/systemd/systemd                                 [ OK ]

Checking for rootkits...

  Performing check of known rootkit files and directories
    55808 Trojan - Variant A                                 [ Not found ]
    ADM Worm                                                 [ Not found ]
    AjaKit Rootkit                                           [ Not found ]
    Adore Rootkit                                            [ Not found ]
    aPa Kit                                                  [ Not found ]
    Apache Worm                                              [ Not found ]
    Ambient (ark) Rootkit                                    [ Not found ]
    Balaur Rootkit                                           [ Not found ]
    BeastKit Rootkit                                         [ Not found ]
    beX2 Rootkit                                             [ Not found ]
    BOBKit Rootkit                                           [ Not found ]
    cb Rootkit                                               [ Not found ]
    CiNIK Worm (Slapper.B variant)                           [ Not found ]
    Danny-Boy's Abuse Kit                                    [ Not found ]
    Devil RootKit                                            [ Not found ]
    Diamorphine LKM                                          [ Not found ]
    Dica-Kit Rootkit                                         [ Not found ]
    Dreams Rootkit                                           [ Not found ]
    Duarawkz Rootkit                                         [ Not found ]
    Ebury backdoor                                           [ Not found ]
    Enye LKM                                                 [ Not found ]
    Flea Linux Rootkit                                       [ Not found ]
    Fu Rootkit                                               [ Not found ]
    Fuck`it Rootkit                                          [ Not found ]
    GasKit Rootkit                                           [ Not found ]
    Heroin LKM                                               [ Not found ]
    HjC Kit                                                  [ Not found ]
    ignoKit Rootkit                                          [ Not found ]
    IntoXonia-NG Rootkit                                     [ Not found ]
    Irix Rootkit                                             [ Not found ]
    Jynx Rootkit                                             [ Not found ]
    Jynx2 Rootkit                                            [ Not found ]
    KBeast Rootkit                                           [ Not found ]
    Kitko Rootkit                                            [ Not found ]
    Knark Rootkit                                            [ Not found ]
    ld-linuxv.so Rootkit                                     [ Not found ]
    Li0n Worm                                                [ Not found ]
    Lockit / LJK2 Rootkit                                    [ Not found ]
    Mokes backdoor                                           [ Not found ]
    Mood-NT Rootkit                                          [ Not found ]
    MRK Rootkit                                              [ Not found ]
    Ni0 Rootkit                                              [ Not found ]
    Ohhara Rootkit                                           [ Not found ]
    Optic Kit (Tux) Worm                                     [ Not found ]
    Oz Rootkit                                               [ Not found ]
    Phalanx Rootkit                                          [ Not found ]
    Phalanx2 Rootkit                                         [ Not found ]
    Phalanx2 Rootkit (extended tests)                        [ Not found ]
    Portacelo Rootkit                                        [ Not found ]
    R3dstorm Toolkit                                         [ Not found ]
    RH-Sharpe's Rootkit                                      [ Not found ]
    RSHA's Rootkit                                           [ Not found ]
    Scalper Worm                                             [ Not found ]
    Sebek LKM                                                [ Not found ]
    Shutdown Rootkit                                         [ Not found ]
    SHV4 Rootkit                                             [ Not found ]
    SHV5 Rootkit                                             [ Not found ]
    Sin Rootkit                                              [ Not found ]
    Slapper Worm                                             [ Not found ]
    Sneakin Rootkit                                          [ Not found ]
    'Spanish' Rootkit                                        [ Not found ]
    Suckit Rootkit                                           [ Not found ]
    Superkit Rootkit                                         [ Not found ]
    TBD (Telnet BackDoor)                                    [ Not found ]
    TeLeKiT Rootkit                                          [ Not found ]
    T0rn Rootkit                                             [ Not found ]
    trNkit Rootkit                                           [ Not found ]
    Trojanit Kit                                             [ Not found ]
    Tuxtendo Rootkit                                         [ Not found ]
    URK Rootkit                                              [ Not found ]
    Vampire Rootkit                                          [ Not found ]
    VcKit Rootkit                                            [ Not found ]
    Volc Rootkit                                             [ Not found ]
    Xzibit Rootkit                                           [ Not found ]
    zaRwT.KiT Rootkit                                        [ Not found ]
    ZK Rootkit                                               [ Not found ]

  Performing additional rootkit checks
    Suckit Rootkit additional checks                         [ OK ]
    Checking for possible rootkit files and directories      [ None found ]
    Checking for possible rootkit strings                    [ None found ]

  Performing malware checks
    Checking running processes for suspicious files          [ None found ]
    Checking for login backdoors                             [ None found ]
    Checking for sniffer log files                           [ None found ]
    Checking for suspicious directories                      [ None found ]
    Checking for suspicious (large) shared memory segments   [ None found ]
    Checking for Apache backdoor                             [ Not found ]

  Performing Linux specific checks
    Checking loaded kernel modules                           [ OK ]
    Checking kernel module names                             [ OK ]

Checking the network...

  Performing checks on the network ports
    Checking for backdoor ports                              [ None found ]

  Performing checks on the network interfaces
    Checking for promiscuous interfaces                      [ None found ]

Checking the local host...

  Performing system boot checks
    Checking for local host name                             [ Found ]
    Checking for system startup files                        [ Found ]
    Checking system startup files for malware                [ None found ]

  Performing group and account checks
    Checking for passwd file                                 [ Found ]
    Checking for root equivalent (UID 0) accounts            [ None found ]
    Checking for passwordless accounts                       [ None found ]
    Checking for passwd file changes                         [ None found ]
    Checking for group file changes                          [ None found ]
    Checking root account shell history files                [ OK ]

  Performing system configuration file checks
    Checking for an SSH configuration file                   [ Found ]
    Checking if SSH root access is allowed                   [ Not allowed ]
    Checking if SSH protocol v1 is allowed                   [ Warning ]
    Checking for other suspicious configuration settings     [ None found ]
    Checking for a running system logging daemon             [ Found ]
    Checking for a system logging configuration file         [ Found ]
    Checking if syslog remote logging is allowed             [ Not allowed ]

  Performing filesystem checks
    Checking /dev for suspicious file types                  [ None found ]
    Checking for hidden files and directories                [ Warning ]

System checks summary
=====================

File properties checks...
    Files checked: 145
    Suspect files: 4

Rootkit checks...
    Rootkits checked : 499
    Possible rootkits: 0

Applications checks...
    All checks skipped

The system checks took: 1 minute and 2 seconds

All results have been written to the log file: /var/log/rkhunter.log

One or more warnings have been found while checking the system.
Please check the log file (/var/log/rkhunter.log)
```

---

## ✅ **7. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **8. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial scan results documentation | VintageDon |
