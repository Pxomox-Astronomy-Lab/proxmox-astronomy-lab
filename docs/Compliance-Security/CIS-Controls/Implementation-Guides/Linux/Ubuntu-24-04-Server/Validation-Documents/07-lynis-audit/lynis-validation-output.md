<!-- 
---
title: "Lynis Audit Results - Ubuntu 24.04 CIS L2"
description: "System hardening validation results from Lynis 3.0.9 on Ubuntu 24.04 Server with CIS L2 hardening"
author: "VintageDon"
tags: ["security", "compliance", "validation", "lynis", "hardening", "ubuntu-24-04", "cisv8"]
category: "Security Validation"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 📊 **Lynis Audit Results**

This document captures the output of a Lynis security audit performed on an Ubuntu 24.04 LTS server hardened to CIS Level 2 standards. The audit validates the effectiveness of the implemented security controls and identifies potential areas for improvement.

## 🔍 **Audit Information**

| **Attribute** | **Value** |
|--------------|-----------|
| **Lynis Version** | 3.0.9 |
| **Operating System** | Ubuntu 24.04 |
| **Kernel Version** | 6.8.0 |
| **Hostname** | tmp-ubuntu24-server-cis-0225 |
| **Audit Date** | 2025-03-16 |
| **Hardening Index** | 87/100 |
| **Tests Performed** | 255 |

## 🔐 **Security Components**

The following security components were detected and validated:

| **Component** | **Status** | **Details** |
|--------------|------------|-------------|
| **Firewall** | ✅ Active | iptables with properly configured policies |
| **Malware Scanner** | ✅ Installed | AIDE, chkrootkit, and RKHunter present |
| **AppArmor** | ✅ Enabled | 39 unconfined processes identified |
| **Auditd** | ✅ Enabled | Properly configured with logging |
| **File Integrity** | ✅ Configured | AIDE installed with database and configuration |
| **Fail2ban** | ✅ Active | Jail configuration enabled |

## 📋 **Key Findings**

### **Positive Security Controls**

| **Area** | **Finding** |
|----------|------------|
| **Boot Security** | UEFI and Secure Boot enabled with password-protected GRUB |
| **Filesystem** | Multiple partitions properly hardened with appropriate mount options |
| **Kernel Hardening** | 30/33 sysctl parameters properly set according to security profile |
| **USB Security** | USB storage driver disabled and authorization controls in place |
| **Account Security** | No accounts without passwords, proper password aging configured |
| **Network Security** | IPv6 disabled, firewall active, proper network parameters |
| **Entropy** | Sufficient kernel entropy available for cryptographic operations |

### **Suggestions for Improvement**

The audit identified 5 suggestions for further hardening:

1. **Lynis Version** - Current version is more than 4 months old, but no update is available at this time. Our deployment follows a 6-month image update cycle (0225 indicating February 2025 build), with the next update scheduled for August 2025.

2. **PAM Configuration** - Add password rounds and expire passwords to encrypt with new values. While current settings meet baseline compliance, increasing SHA rounds would provide additional protection against offline attacks.

3. **Account Expiration** - Set expire dates for all password-protected accounts. This is currently a policy gap as service accounts are configured without expiration to prevent operational disruption.

4. **Package Cleanup** - Purge 3 old/removed packages to remove configuration files and scripts. These are from prior test applications and pose minimal security risk.

5. **Kernel Parameters** - Three sysctl values differ from the scan profile:
   - **fs.protected_fifos**: Current setting balances application compatibility with security. Full hardening caused issues with legacy applications.
   - **fs.suid_dumpable**: Modified to support specific debugging requirements for development workloads.
   - **kernel.modules_disabled**: Set to allow specific hardware drivers to load dynamically, required for virtualization platform functionality.

## 🔄 **Kernel Parameters**

The following kernel parameters were validated against the security profile:

| **Parameter** | **Expected** | **Status** | **Justification** |
|---------------|-------------|------------|-------------------|
| dev.tty.ldisc_autoload | 0 | ✅ OK | |
| fs.protected_fifos | 2 | ❌ DIFFERENT | Modified for application compatibility |
| fs.protected_hardlinks | 1 | ✅ OK | |
| fs.protected_regular | 2 | ✅ OK | |
| fs.protected_symlinks | 1 | ✅ OK | |
| fs.suid_dumpable | 0 | ❌ DIFFERENT | Required for development debugging |
| kernel.core_uses_pid | 1 | ✅ OK | |
| kernel.ctrl-alt-del | 0 | ✅ OK | |
| kernel.dmesg_restrict | 1 | ✅ OK | |
| kernel.kptr_restrict | 2 | ✅ OK | |
| kernel.modules_disabled | 1 | ❌ DIFFERENT | Required for dynamic driver loading |
| kernel.perf_event_paranoid | 3 | ✅ OK | |
| kernel.randomize_va_space | 2 | ✅ OK | |
| kernel.sysrq | 0 | ✅ OK | |
| kernel.unprivileged_bpf_disabled | 1 | ✅ OK | |
| kernel.yama.ptrace_scope | 1-3 | ✅ OK | |
| net.core.bpf_jit_harden | 2 | ✅ OK | |
| net.ipv4.conf.all.accept_redirects | 0 | ✅ OK | |
| net.ipv4.conf.all.accept_source_route | 0 | ✅ OK | |
| net.ipv4.conf.all.bootp_relay | 0 | ✅ OK | |
| net.ipv4.conf.all.forwarding | 0 | ✅ OK | |
| net.ipv4.conf.all.log_martians | 1 | ✅ OK | |
| net.ipv4.conf.all.mc_forwarding | 0 | ✅ OK | |
| net.ipv4.conf.all.proxy_arp | 0 | ✅ OK | |
| net.ipv4.conf.all.rp_filter | 1 | ✅ OK | |
| net.ipv4.conf.all.send_redirects | 0 | ✅ OK | |
| net.ipv4.conf.default.accept_redirects | 0 | ✅ OK | |
| net.ipv4.conf.default.accept_source_route | 0 | ✅ OK | |
| net.ipv4.conf.default.log_martians | 1 | ✅ OK | |
| net.ipv4.icmp_echo_ignore_broadcasts | 1 | ✅ OK | |
| net.ipv4.icmp_ignore_bogus_error_responses | 1 | ✅ OK | |
| net.ipv4.tcp_syncookies | 1 | ✅ OK | |
| net.ipv4.tcp_timestamps | 0-1 | ✅ OK | |

## 📋 **Filesystem Security**

Filesystem mount points and their security status:

| **Mount Point** | **Status** |
|-----------------|------------|
| /boot | ✅ HARDENED |
| /dev | ⚠️ PARTIALLY HARDENED |
| /dev/shm | ✅ HARDENED |
| /home | ⚠️ PARTIALLY HARDENED |
| /run | ✅ HARDENED |
| /tmp | ✅ HARDENED |
| /var | ⚠️ DEFAULT |
| /var/log | ✅ HARDENED |
| /var/log/audit | ✅ HARDENED |
| /var/tmp | ✅ HARDENED |

## 🔒 **Encryption Status**

The system implements LUKS full-disk encryption with keys securely stored in TPM:

| **Mount Point** | **Status** |
|-----------------|------------|
| / on /dev/sda3 | ✅ ENCRYPTED (LUKS/TPM) |
| /var on /dev/sda6 | ✅ ENCRYPTED (LUKS/TPM) |
| /home on /dev/sda5 | ✅ ENCRYPTED (LUKS/TPM) |
| /tmp on /dev/sda4 | ✅ ENCRYPTED (LUKS/TPM) |
| /boot on /dev/sda2 | ✅ ENCRYPTED (LUKS/TPM) |
| /var/log on /dev/sda8 | ✅ ENCRYPTED (LUKS/TPM) |
| /var/tmp on /dev/sda7 | ✅ ENCRYPTED (LUKS/TPM) |
| /boot/efi on /dev/sda1 | ✅ ENCRYPTED (LUKS/TPM) |
| /var/log/audit on /dev/sda9 | ✅ ENCRYPTED (LUKS/TPM) |

The LUKS encryption implementation uses AES-256-XTS with keys secured in TPM 2.0, providing hardware-backed protection for encryption keys. This approach ensures data-at-rest security while enabling secure boot with appropriate authentication.

## 📋 **Raw Audit Output**

```bash
root@tmp-ubuntu24-server-cis-0225:~# lynis audit system

[ Lynis 3.0.9 ]

################################################################################
  Lynis comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
  welcome to redistribute it under the terms of the GNU General Public License.
  See the LICENSE file for details about using this software.

  2007-2021, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)
################################################################################


[+] Initializing program
------------------------------------
  - Detecting OS...                                           [ DONE ]
  - Checking profiles...                                      [ DONE ]

  ---------------------------------------------------
  Program version:           3.0.9
  Operating system:          Linux
  Operating system name:     Ubuntu
  Operating system version:  24.04
  Kernel version:            6.8.0
  Hardware platform:         x86_64
  Hostname:                  tmp-ubuntu24-server-cis-0225
  ---------------------------------------------------
  Profiles:                  /etc/lynis/default.prf /etc/lynis/custom.prf
  Log file:                  /var/log/lynis.log
  Report file:               /var/log/lynis-report.dat
  Report version:            1.0
  Plugin directory:          /etc/lynis/plugins
  ---------------------------------------------------
  Auditor:                   [Not Specified]
  Language:                  en
  Test category:             all
  Test group:                all
  ---------------------------------------------------
  - Program update status...                                  [ NO UPDATE ]

[+] System tools
------------------------------------
  - Scanning available tools...
  - Checking system binaries...

[+] Plugins (phase 1)
------------------------------------
 Note: plugins have more extensive tests and may take several minutes to complete

  - Plugin: debian
    [
[+] Debian Tests
------------------------------------
  - Checking for system binaries that are required by Debian Tests...
    - Checking /bin...                                        [ FOUND ]
    - Checking /sbin...                                       [ FOUND ]
    - Checking /usr/bin...                                    [ FOUND ]
    - Checking /usr/sbin...                                   [ FOUND ]
    - Checking /usr/local/bin...                              [ FOUND ]
    - Checking /usr/local/sbin...                             [ FOUND ]
  - Authentication:
    - PAM (Pluggable Authentication Modules):
      - libpam-tmpdir                                         [ Installed and Enabled ]
- File System Checks:
    - DM-Crypt, Cryptsetup & Cryptmount:
      - Checking / on /dev/sda3                               [ ENCRYPTED (LUKS/TPM) ]
      - Checking /var on /dev/sda6                            [ ENCRYPTED (LUKS/TPM) ]
      - Checking /home on /dev/sda5                           [ ENCRYPTED (LUKS/TPM) ]
      - Checking /tmp on /dev/sda4                            [ ENCRYPTED (LUKS/TPM) ]
      - Checking /boot on /dev/sda2                           [ ENCRYPTED (LUKS/TPM) ]
      - Checking /var/log on /dev/sda8                        [ ENCRYPTED (LUKS/TPM) ]
      - Checking /var/tmp on /dev/sda7                        [ ENCRYPTED (LUKS/TPM) ]
      - Checking /boot/efi on /dev/sda1                       [ ENCRYPTED (LUKS/TPM) ]
      - Checking /var/log/audit on /dev/sda9                  [ ENCRYPTED (LUKS/TPM) ]
  - Software:
    - apt-listchanges                                         [ Installed and enabled for apt ]
    - needrestart                                             [ Installed ]
    - fail2ban                                                [ Installed with jail.local ]
]

[+] Boot and services
------------------------------------
  - Service Manager                                           [ systemd ]
  - Checking UEFI boot                                        [ ENABLED ]
  - Checking Secure Boot                                      [ ENABLED ]
  - Checking presence GRUB2                                   [ FOUND ]
    - Checking for password protection                        [ OK ]
  - Check running services (systemctl)                        [ DONE ]
        Result: found 23 running services
  - Check enabled services at boot (systemctl)                [ DONE ]
        Result: found 55 enabled services
  - Check startup files (permissions)                         [ OK ]

[+] Kernel
------------------------------------
  - Checking default run level                                [ RUNLEVEL 5 ]
  - Checking CPU support (NX/PAE)
    CPU support: PAE and/or NoeXecute supported               [ FOUND ]
  - Checking kernel version and release                       [ DONE ]
  - Checking kernel type                                      [ DONE ]
  - Checking loaded kernel modules                            [ DONE ]
      Found 55 active modules
  - Checking Linux kernel configuration file                  [ FOUND ]
  - Checking default I/O kernel scheduler                     [ NOT FOUND ]
  - Checking for available kernel update                      [ OK ]
  - Checking core dumps configuration
    - configuration in systemd conf files                     [ DEFAULT ]
    - configuration in /etc/profile                           [ DEFAULT ]
    - 'hard' configuration in /etc/security/limits.conf       [ DISABLED ]
    - 'soft' config in /etc/security/limits.conf (implicit)   [ DISABLED ]
    - Checking setuid core dumps configuration                [ PROTECTED ]
  - Check if reboot is needed                                 [ NO ]

[+] Memory and Processes
------------------------------------
  - Checking /proc/meminfo                                    [ FOUND ]
  - Searching for dead/zombie processes                       [ NOT FOUND ]
  - Searching for IO waiting processes                        [ NOT FOUND ]
  - Search prelink tooling                                    [ NOT FOUND ]

[+] Users, Groups and Authentication
------------------------------------
  - Administrator accounts                                    [ OK ]
  - Unique UIDs                                               [ OK ]
  - Consistency of group files (grpck)                        [ OK ]
  - Unique group IDs                                          [ OK ]
  - Unique group names                                        [ OK ]
  - Password file consistency                                 [ OK ]
  - Password hashing methods                                  [ SUGGESTION ]
  - Password hashing rounds (minimum)                         [ CONFIGURED ]
  - Query system users (non daemons)                          [ DONE ]
  - NIS+ authentication support                               [ NOT ENABLED ]
  - NIS authentication support                                [ NOT ENABLED ]
  - Sudoers file(s)                                           [ FOUND ]
    - Permissions for directory: /etc/sudoers.d               [ WARNING ]
    - Permissions for: /etc/sudoers                           [ OK ]
    - Permissions for: /etc/sudoers.d/ansible                 [ OK ]
    - Permissions for: /etc/sudoers.d/README                  [ OK ]
  - PAM password strength tools                               [ OK ]
  - PAM configuration files (pam.conf)                        [ FOUND ]
  - PAM configuration files (pam.d)                           [ FOUND ]
  - PAM modules                                               [ FOUND ]
  - LDAP module in PAM                                        [ NOT FOUND ]
  - Accounts without expire date                              [ SUGGESTION ]
  - Accounts without password                                 [ OK ]
  - User password aging (minimum)                             [ CONFIGURED ]
  - User password aging (maximum)                             [ CONFIGURED ]
  - Checking expired passwords                                [ OK ]
  - Checking Linux single user mode authentication            [ OK ]
  - Determining default umask
    - umask (/etc/profile)                                    [ NOT FOUND ]
    - umask (/etc/login.defs)                                 [ OK ]
  - LDAP authentication support                               [ NOT ENABLED ]
  - Logging failed login attempts                             [ ENABLED ]

[+] Shells
------------------------------------
  - Checking shells from /etc/shells
    Result: found 9 shells (valid shells: 9).
    - Session timeout settings/tools                          [ NONE ]
  - Checking default umask values
    - Checking default umask in /etc/bash.bashrc              [ NONE ]
    - Checking default umask in /etc/profile                  [ NONE ]

[+] File systems
------------------------------------
  - Checking mount points
    - Checking /home mount point                              [ OK ]
    - Checking /tmp mount point                               [ OK ]
    - Checking /var mount point                               [ OK ]
  - Query swap partitions (fstab)                             [ OK ]
  - Testing swap partitions                                   [ OK ]
  - Testing /proc mount (hidepid)                             [ SUGGESTION ]
  - Checking for old files in /tmp                            [ OK ]
  - Checking /tmp sticky bit                                  [ OK ]
  - Checking /var/tmp sticky bit                              [ OK ]
  - ACL support root file system                              [ ENABLED ]
  - Mount options of /                                        [ OK ]
  - Mount options of /boot                                    [ HARDENED ]
  - Mount options of /dev                                     [ PARTIALLY HARDENED ]
  - Mount options of /dev/shm                                 [ HARDENED ]
  - Mount options of /home                                    [ PARTIALLY HARDENED ]
  - Mount options of /run                                     [ HARDENED ]
  - Mount options of /tmp                                     [ HARDENED ]
  - Mount options of /var                                     [ DEFAULT ]
  - Mount options of /var/log                                 [ HARDENED ]
  - Mount options of /var/log/audit                           [ HARDENED ]
  - Mount options of /var/tmp                                 [ HARDENED ]
  - Total without nodev:5 noexec:7 nosuid:4 ro or noexec (W^X): 7 of total 30
  - /var/tmp is not bound to /tmp                             [ NON DEFAULT ]
  - Checking Locate database                                  [ FOUND ]
  - Disable kernel support of some filesystems

[+] USB Devices
------------------------------------
  - Checking usb-storage driver (modprobe config)             [ DISABLED ]
  - Checking USB devices authorization                        [ ENABLED ]
  - Checking USBGuard                                         [ NOT FOUND ]

[+] Storage
------------------------------------
  - Checking firewire ohci driver (modprobe config)           [ DISABLED ]

[+] NFS
------------------------------------
  - Check running NFS daemon                                  [ NOT FOUND ]

[+] Name services
------------------------------------
  - Checking search domains                                   [ FOUND ]
  - Checking /etc/resolv.conf options                         [ FOUND ]
  - Checking /etc/hosts
    - Duplicate entries in hosts file                         [ NONE ]
    - Presence of configured hostname in /etc/hosts           [ FOUND ]
    - Hostname mapped to localhost                            [ NOT FOUND ]
    - Localhost mapping to IP address                         [ OK ]

[+] Ports and packages
------------------------------------
  - Searching package managers
    - Searching dpkg package manager                          [ FOUND ]
      - Querying package manager
    - Query unpurged packages                                 [ FOUND ]
    - debsums utility                                         [ FOUND ]
      - Cron job for debsums                                  [ FOUND ]
  - Checking security repository in sources.list.d directory  [ OK ]
  - Checking APT package database                             [ OK ]
  - Checking vulnerable packages                              [ OK ]
  - Checking upgradeable packages                             [ FOUND ]
  - Checking package audit tool                               [ INSTALLED ]
    Found: apt-check
  - Toolkit for automatic upgrades (unattended-upgrade)       [ FOUND ]

[+] Networking
------------------------------------
  - Checking IPv6 configuration                               [ DISABLED ]
  - Checking configured nameservers
    - Testing nameservers
        Nameserver: 127.0.0.53                                [ OK ]
    - DNSSEC supported (systemd-resolved)                     [ UNKNOWN ]
  - Checking default gateway                                  [ DONE ]
  - Getting listening ports (TCP/UDP)                         [ DONE ]
  - Checking promiscuous interfaces                           [ OK ]
  - Checking waiting connections                              [ OK ]
  - Checking status DHCP client
  - Checking for ARP monitoring software                      [ NOT FOUND ]

[+] Printers and Spools
------------------------------------
  - Checking cups daemon                                      [ NOT FOUND ]
  - Checking lp daemon                                        [ NOT RUNNING ]

[+] Software: e-mail and messaging
------------------------------------
  - Postfix status                                            [ RUNNING ]
    - Postfix configuration                                   [ FOUND ]

[+] Software: firewalls
------------------------------------
  - Checking iptables kernel module                           [ FOUND ]
    - Checking iptables policies of chains                    [ FOUND ]
    - Checking for unused rules                               [ OK ]
  - Checking host based firewall                              [ ACTIVE ]

[+] Software: webserver
------------------------------------
  - Checking Apache                                           [ NOT FOUND ]
  - Checking nginx                                            [ NOT FOUND ]

[+] SSH Support
------------------------------------
  - Checking running SSH daemon                               [ FOUND ]
    - Searching SSH configuration                             [ FOUND ]
    - OpenSSH option: AllowUsers                              [ FOUND ]
    - OpenSSH option: AllowGroups                             [ NOT FOUND ]

[+] SNMP Support
------------------------------------
  - Checking running SNMP daemon                              [ NOT FOUND ]

[+] Databases
------------------------------------
    No database engines found

[+] LDAP Services
------------------------------------
  - Checking OpenLDAP instance                                [ NOT FOUND ]

[+] PHP
------------------------------------
  - Checking PHP                                              [ NOT FOUND ]

[+] Squid Support
------------------------------------
  - Checking running Squid daemon                             [ NOT FOUND ]

[+] Logging and files
------------------------------------
  - Checking for a running log daemon                         [ OK ]
    - Checking Syslog-NG status                               [ NOT FOUND ]
    - Checking systemd journal status                         [ FOUND ]
    - Checking Metalog status                                 [ NOT FOUND ]
    - Checking RSyslog status                                 [ FOUND ]
    - Checking RFC 3195 daemon status                         [ NOT FOUND ]
    - Checking minilogd instances                             [ NOT FOUND ]
  - Checking logrotate presence                               [ OK ]
  - Checking log directories (static list)                    [ DONE ]
  - Checking open log files                                   [ DONE ]
  - Checking deleted files in use                             [ DONE ]

[+] Insecure services
------------------------------------
  - Installed inetd package                                   [ NOT FOUND ]
  - Installed xinetd package                                  [ OK ]
    - xinetd status
  - Installed rsh client package                              [ OK ]
  - Installed rsh server package                              [ OK ]
  - Installed telnet client package                           [ OK ]
  - Installed telnet server package                           [ NOT FOUND ]
  - Checking NIS client installation                          [ OK ]
  - Checking NIS server installation                          [ OK ]
  - Checking TFTP client installation                         [ OK ]
  - Checking TFTP server installation                         [ OK ]

[+] Banners and identification
------------------------------------
  - /etc/issue                                                [ FOUND ]
    - /etc/issue contents                                     [ OK ]
  - /etc/issue.net                                            [ FOUND ]
    - /etc/issue.net contents                                 [ OK ]

[+] Scheduled tasks
------------------------------------
  - Checking crontab and cronjob files                        [ DONE ]

[+] Accounting
------------------------------------
  - Checking accounting information                           [ OK ]
  - Checking sysstat accounting data                          [ ENABLED ]
  - Checking auditd                                           [ ENABLED ]
    - Checking audit configuration file                       [ OK ]
    - Checking auditd log file                                [ FOUND ]

[+] Time and Synchronization
------------------------------------
  - NTP daemon found: chronyd                                 [ FOUND ]
  - Checking for a running NTP daemon or client               [ OK ]

[+] Cryptography
------------------------------------
  - Checking for expired SSL certificates [0/151]             [ NONE ]
  - Found 0 encrypted and 1 unencrypted swap devices in use.  [ OK ]
  - Kernel entropy is sufficient                              [ YES ]
  - HW RNG & rngd                                             [ NO ]
  - SW prng                                                   [ NO ]
  - MOR variable not found                                    [ WEAK ]

[+] Virtualization
------------------------------------

[+] Containers
------------------------------------

[+] Security frameworks
------------------------------------
  - Checking presence AppArmor                                [ FOUND ]
    - Checking AppArmor status                                [ ENABLED ]
        Found 39 unconfined processes
  - Checking presence SELinux                                 [ NOT FOUND ]
  - Checking presence TOMOYO Linux                            [ NOT FOUND ]
  - Checking presence grsecurity                              [ NOT FOUND ]
  - Checking for implemented MAC framework                    [ OK ]

[+] Software: file integrity
------------------------------------
  - Checking file integrity tools
    - AIDE                                                    [ FOUND ]
      - AIDE config file                                      [ FOUND ]
      - AIDE database                                         [ FOUND ]
  - dm-integrity (status)                                     [ DISABLED ]
  - dm-verity (status)                                        [ DISABLED ]
      - AIDE config (Checksum)                                [ OK ]
  - Checking presence integrity tool                          [ FOUND ]

[+] Software: System tooling
------------------------------------
  - Checking presence of Fail2ban                             [ FOUND ]
2025-03-16 10:40:09,754 fail2ban.configreader   [36823]: WARNING 'allowipv6' not defined in 'Definition'. Using default one: 'auto'
    - Checking Fail2ban jails                                 [ ENABLED ]
  - Checking for IDS/IPS tooling                              [ FOUND ]

[+] Software: Malware
------------------------------------
  - Checking chkrootkit                                       [ FOUND ]
  - Checking Rootkit Hunter                                   [ FOUND ]
pgrep: pattern that searches for process name longer than 15 characters will result in zero matches
Try `pgrep -f' option to match against the complete command line.
  - Malware software components                               [ FOUND ]
    - Active agent                                            [ NOT FOUND ]
    - Rootkit scanner                                         [ FOUND ]

[+] File Permissions
------------------------------------

[+] Home directories
------------------------------------
  - Permissions of home directories                           [ OK ]
  - Ownership of home directories                             [ OK ]
  - Checking shell history files                              [ OK ]

[+] Kernel Hardening
------------------------------------
  - Comparing sysctl key pairs with scan profile
    - dev.tty.ldisc_autoload (exp: 0)                         [ OK ]
    - fs.protected_fifos (exp: 2)                             [ DIFFERENT ]
    - fs.protected_hardlinks (exp: 1)                         [ OK ]
    - fs.protected_regular (exp: 2)                           [ OK ]
    - fs.protected_symlinks (exp: 1)                          [ OK ]
    - fs.suid_dumpable (exp: 0)                               [ DIFFERENT ]
    - kernel.core_uses_pid (exp: 1)                           [ OK ]
    - kernel.ctrl-alt-del (exp: 0)                            [ OK ]
    - kernel.dmesg_restrict (exp: 1)                          [ OK ]
    - kernel.kptr_restrict (exp: 2)                           [ OK ]
    - kernel.modules_disabled (exp: 1)                        [ DIFFERENT ]
    - kernel.perf_event_paranoid (exp: 3)                     [ OK ]
    - kernel.randomize_va_space (exp: 2)                      [ OK ]
    - kernel.sysrq (exp: 0)                                   [ OK ]
    - kernel.unprivileged_bpf_disabled (exp: 1)               [ OK ]
    - kernel.yama.ptrace_scope (exp: 1 2 3)                   [ OK ]
    - net.core.bpf_jit_harden (exp: 2)                        [ OK ]
    - net.ipv4.conf.all.accept_redirects (exp: 0)             [ OK ]
    - net.ipv4.conf.all.accept_source_route (exp: 0)          [ OK ]
    - net.ipv4.conf.all.bootp_relay (exp: 0)                  [ OK ]
    - net.ipv4.conf.all.forwarding (exp: 0)                   [ OK ]
    - net.ipv4.conf.all.log_martians (exp: 1)                 [ OK ]
    - net.ipv4.conf.all.mc_forwarding (exp: 0)                [ OK ]
    - net.ipv4.conf.all.proxy_arp (exp: 0)                    [ OK ]
    - net.ipv4.conf.all.rp_filter (exp: 1)                    [ OK ]
    - net.ipv4.conf.all.send_redirects (exp: 0)               [ OK ]
    - net.ipv4.conf.default.accept_redirects (exp: 0)         [ OK ]
    - net.ipv4.conf.default.accept_source_route (exp: 0)      [ OK ]
    - net.ipv4.conf.default.log_martians (exp: 1)             [ OK ]
    - net.ipv4.icmp_echo_ignore_broadcasts (exp: 1)           [ OK ]
    - net.ipv4.icmp_ignore_bogus_error_responses (exp: 1)     [ OK ]
    - net.ipv4.tcp_syncookies (exp: 1)                        [ OK ]
    - net.ipv4.tcp_timestamps (exp: 0 1)                      [ OK ]

[+] Hardening
------------------------------------
    - Installed compiler(s)                                   [ FOUND ]
    - Installed malware scanner                               [ FOUND ]
    - Non-native binary formats                               [ FOUND ]

[+] Custom tests
------------------------------------
  - Running custom tests...                                   [ NONE ]

[+] Plugins (phase 2)
------------------------------------

================================================================================

  -[ Lynis 3.0.9 Results ]-

  Great, no warnings

  Suggestions (5):
  ----------------------------
  * This release is more than 4 months old. Check the website or GitHub to see if there is an update available. [LYNIS]
      https://cisofy.com/lynis/controls/LYNIS/

  * Check PAM configuration, add rounds if applicable and expire passwords to encrypt with new values [AUTH-9229]
      https://cisofy.com/lynis/controls/AUTH-9229/

  * When possible set expire dates for all password protected accounts [AUTH-9282]
      https://cisofy.com/lynis/controls/AUTH-9282/

  * Purge old/removed packages (3 found) with aptitude purge or dpkg --purge command. This will cleanup old configuration files, cron jobs and startup scripts. [PKGS-7346]
      https://cisofy.com/lynis/controls/PKGS-7346/

  * One or more sysctl values differ from the scan profile and could be tweaked [KRNL-6000]
    - Solution : Change sysctl value or disable test (skip-test=KRNL-6000:<sysctl-key>)
      https://cisofy.com/lynis/controls/KRNL-6000/

  Follow-up:
  ----------------------------
  - Show details of a test (lynis show details TEST-ID)
  - Check the logfile for all details (less /var/log/lynis.log)
  - Read security controls texts (https://cisofy.com)
  - Use --upload to upload data to central system (Lynis Enterprise users)

================================================================================

  Lynis security scan details:

  Hardening index : 87 [#################   ]
  Tests performed : 255
  Plugins enabled : 1

  Components:
  - Firewall               [V]
  - Malware scanner        [V]

  Scan mode:
  Normal [V]  Forensics [ ]  Integration [ ]  Pentest [ ]

  Lynis modules:
  - Compliance status      [?]
  - Security audit         [V]
  - Vulnerability scan     [V]

  Files:
  - Test and debug information      : /var/log/lynis.log
  - Report data                     : /var/log/lynis-report.dat

================================================================================

  Lynis 3.0.9

  Auditing, system hardening, and compliance for UNIX-based systems
  (Linux, macOS, BSD, and others)

  2007-2021, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)

================================================================================

```

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial audit results documentation | VintageDon |
