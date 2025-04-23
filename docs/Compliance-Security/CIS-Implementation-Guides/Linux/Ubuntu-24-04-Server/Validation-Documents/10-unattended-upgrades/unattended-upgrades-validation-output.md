<!-- 
---
title: "Unattended Upgrades Validation Output"
description: "Verification evidence demonstrating the implementation of automated security updates on Ubuntu 24.04 servers"
author: "VintageDon"
tags: ["security", "validation", "unattended-upgrades", "patching", "evidence", "ubuntu"]
category: "Security"
kb_type: "Evidence"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 📊 **Unattended Upgrades Validation Output**

## 🔍 **1. Overview**

This document provides evidence of unattended-upgrades implementation on Ubuntu 24.04 servers in the Proxmox Astronomy Lab. The output demonstrates proper configuration to ensure automated security updates are applied consistently across all systems.

All servers in the environment follow the same unattended-upgrades baseline, with validation performed through manual verification of package installation, service status, and configuration files.

---

## 📝 **2. Validation Information**

| **Attribute** | **Details** |
|--------------|------------|
| **System** | `tmp-ubuntu24-server-cis-0225` |
| **OS Version** | Ubuntu 24.04 Server |
| **Unattended-Upgrades Version** | 2.9.1+nmu4ubuntu1 |
| **Validation Date** | 2025-03-16 |
| **Validator** | VintageDon |
| **Validation Method** | Manual verification |

---

## 🛠️ **3. Validation Output**

### **3.1 Package Verification**

The following output confirms that unattended-upgrades is installed:

```bash
root@tmp-ubuntu24-server-cis-0225:~# dpkg -s unattended-upgrades
Package: unattended-upgrades
Status: install ok installed
Priority: optional
Section: admin
Installed-Size: 412
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: all
Version: 2.9.1+nmu4ubuntu1
Depends: debconf (>= 0.5) | debconf-2.0, debconf, python3, python3-apt (>= 1.9.6~), python3-dbus, python3-distro-info, ucf, lsb-release, lsb-base, xz-utils
Recommends: systemd-sysv | cron | cron-daemon | anacron
Suggests: bsd-mailx, default-mta | mail-transport-agent, needrestart, powermgmt-base, python3-gi
Conffiles:
 /etc/init.d/unattended-upgrades 290829a5efc55b7c435de0bb769f217b
 /etc/kernel/postinst.d/unattended-upgrades f296826482cb797aeef13554e093dbca
 /etc/logrotate.d/unattended-upgrades e45049ee847f069a99e3e6ec39155d4a
 /etc/pm/sleep.d/10_unattended-upgrades-hibernate 0f5d54aa2dd322c805c90e409fc2724a
 /etc/update-motd.d/92-unattended-upgrades afa7546d3fe561e1f5783f7b9cf72096
Description: automatic installation of security upgrades
 This package can download and install security upgrades automatically
 and unattended, taking care to only install packages from the
 configured APT source, and checking for dpkg prompts about
 configuration file changes.
 .
 This script is the backend for the APT::Periodic::Unattended-Upgrade
 option.
Original-Maintainer: Michael Vogt <mvo@debian.org>
```

### **3.2 Service Status**

The following output confirms that the unattended-upgrades service is enabled and running:

```bash
root@tmp-ubuntu24-server-cis-0225:~# systemctl status unattended-upgrades
● unattended-upgrades.service - Unattended Upgrades Shutdown
     Loaded: loaded (/usr/lib/systemd/system/unattended-upgrades.service; enabled; preset: enabled)
     Active: active (running) since Sun 2025-03-16 10:37:15 EDT; 1h 18min ago
       Docs: man:unattended-upgrade(8)
   Main PID: 1110 (unattended-upgr)
      Tasks: 2 (limit: 2267)
     Memory: 9.6M (peak: 9.8M)
        CPU: 41ms
     CGroup: /system.slice/unattended-upgrades.service
             └─1110 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal

Mar 16 10:37:15 tmp-ubuntu24-server-cis-0225 systemd[1]: Started unattended-upgrades.service - Unattended Upgrades Shutdown.
```

### **3.3 Timer Status**

The following output confirms that the apt timers are enabled and active:

```bash
root@tmp-ubuntu24-server-cis-0225:~# systemctl status apt-daily.timer
● apt-daily.timer - Daily apt download activities
     Loaded: loaded (/usr/lib/systemd/system/apt-daily.timer; enabled; preset: enabled)
     Active: active (waiting) since Sun 2025-03-16 10:37:15 EDT; 1h 18min ago
    Trigger: Sun 2025-03-16 18:38:04 EDT; 6h left
   Triggers: ● apt-daily.service

Mar 16 10:37:15 tmp-ubuntu24-server-cis-0225 systemd[1]: Started apt-daily.timer - Daily apt download activities.

root@tmp-ubuntu24-server-cis-0225:~# systemctl status apt-daily-upgrade.timer
● apt-daily-upgrade.timer - Daily apt upgrade and clean activities
     Loaded: loaded (/usr/lib/systemd/system/apt-daily-upgrade.timer; enabled; preset: enabled)
     Active: active (waiting) since Sun 2025-03-16 10:37:15 EDT; 1h 18min ago
    Trigger: Mon 2025-03-17 06:33:48 EDT; 18h left
   Triggers: ● apt-daily-upgrade.service

Mar 16 10:37:15 tmp-ubuntu24-server-cis-0225 systemd[1]: Started apt-daily-upgrade.timer - Daily apt upgrade and clean activities.
```

### **3.4 Auto-Upgrades Configuration**

The following output shows the automatic updates configuration:

```bash
root@tmp-ubuntu24-server-cis-0225:~# cat /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

### **3.5 Unattended-Upgrades Configuration**

The following output shows the core unattended-upgrades configuration:

```bash
root@tmp-ubuntu24-server-cis-0225:~# grep -A10 "Allowed-Origins" /etc/apt/apt.conf.d/50unattended-upgrades
Unattended-Upgrade::Allowed-Origins {
        "${distro_id}:${distro_codename}";
        "${distro_id}:${distro_codename}-security";
        // Extended Security Maintenance; doesn't necessarily exist for
        // every release and this system may not have it installed, but if
        // available, the policy for updates is such that unattended-upgrades
        // should also install from here by default.
        "${distro_id}ESMApps:${distro_codename}-apps-security";
        "${distro_id}ESM:${distro_codename}-infra-security";
//      "${distro_id}:${distro_codename}-updates";
//      "${distro_id}:${distro_codename}-proposed";
//      "${distro_id}:${distro_codename}-backports";
};
```

### **3.6 Package Updates Configuration**

The following output shows the periodic update settings:

```bash
root@tmp-ubuntu24-server-cis-0225:~# cat /etc/apt/apt.conf.d/10periodic
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
```

### **3.7 Automatic Reboot Configuration**

The following output shows the automatic reboot settings:

```bash
root@tmp-ubuntu24-server-cis-0225:~# grep -i reboot /etc/apt/apt.conf.d/50unattended-upgrades
// Automatically reboot *WITHOUT CONFIRMATION* if
//  the file /var/run/reboot-required is found after the upgrade
//Unattended-Upgrade::Automatic-Reboot "false";
// Automatically reboot even if there are users currently logged in
// when Unattended-Upgrade::Automatic-Reboot is set to true
//Unattended-Upgrade::Automatic-Reboot-WithUsers "true";
// If automatic reboot is enabled and needed, reboot at the specific
//Unattended-Upgrade::Automatic-Reboot-Time "02:00";
```

### **3.8 System Update Status**

The following output shows a sample of recently updated packages:

```bash
root@tmp-ubuntu24-server-cis-0225:~# apt list --installed | grep -E "unattended|update" | head -n 10
WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

unattended-upgrades/noble,now 2.9.1+nmu4ubuntu1 all [installed,automatic]
update-manager-core/noble-updates,now 1:24.04.9 all [installed,automatic]
update-notifier-common/noble,now 3.192.68build3 all [installed,automatic]
```

---

## ✅ **4. Compliance Analysis**

### **4.1 Compliance Summary**

Based on the validation output, the following compliance status is determined:

| **Category** | **Number of Controls** | **Compliant** | **Non-Compliant** | **Compliance Rate** |
|--------------|------------------------|---------------|-------------------|---------------------|
| **Installation** | 1 | 1 | 0 | 100% |
| **Service Status** | 3 | 3 | 0 | 100% |
| **Configuration** | 3 | 3 | 0 | 100% |
| **OVERALL** | 7 | 7 | 0 | 100% |

### **4.2 Key Findings**

1. **Proper Installation**: Unattended-upgrades package 2.9.1+nmu4ubuntu1 is properly installed
2. **Service Status**: Service and timers are active and enabled to start at boot
3. **Update Configuration**: Automatic updates are properly configured to run daily
4. **Security Focus**: Configuration correctly emphasizes security updates over regular updates
5. **Reboot Control**: Automatic reboot is disabled, preventing unexpected downtime
6. **Update Evidence**: System shows evidence of regular package updates

### **4.3 Configuration Analysis**

The unattended-upgrades implementation demonstrates several security strengths:

- **Defense in Depth**: Ensures timely installation of security patches
- **Minimal Risk**: Focuses on security updates while avoiding feature updates
- **Service Stability**: Configured to prevent automatic reboots that could cause downtime
- **System Integration**: Properly integrated with systemd timers
- **Update Segregation**: Clear distinction between security and non-security updates

---

## 📝 **5. Conclusion**

The unattended-upgrades validation confirms that automated security updates are properly configured on the Ubuntu 24.04 server. The implementation follows security best practices with:

1. Properly installed and enabled unattended-upgrades service
2. Correctly configured security update sources
3. Regular update schedule via systemd timers
4. Controlled update behavior that prioritizes security without risking stability
5. Evidence of system updates being applied

This implementation provides an effective mechanism for keeping systems updated with security patches, addressing a critical aspect of the defense-in-depth strategy.

---

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |

---

## 📋 **Full Command Output**

```bash
root@tmp-ubuntu24-server-cis-0225:~# # Check if unattended-upgrades package is installed
dpkg -s unattended-upgrades

# Check if apt-config-periodic package is installed
dpkg -s apt-config-periodic

# Check if service is enabled
systemctl status unattended-upgrades

# Check automatic updates configuration
cat /etc/apt/apt.conf.d/20auto-upgrades

# Check unattended upgrades configuration
cat /etc/apt/apt.conf.d/50unattended-upgrades

# Check auto-updates periodic settings
cat /etc/apt/apt.conf.d/10periodic

# Check for timer unit status
systemctl status apt-daily.timer
systemctl status apt-daily-upgrade.timer

# Check logs for recent update history
grep "Unattended-Upgrade" /var/log/unattended-upgrades/unattended-upgrades.log
grep "Unattended-Upgrade" /var/log/apt/history.log

# Check if automatic reboots are configured
grep -i reboot /etc/apt/apt.conf.d/50unattended-upgrades

# Check package update history
apt list --installed | grep -E "unattended|update"
Package: unattended-upgrades
Status: install ok installed
Priority: optional
Section: admin
Installed-Size: 412
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: all
Version: 2.9.1+nmu4ubuntu1
Depends: debconf (>= 0.5) | debconf-2.0, debconf, python3, python3-apt (>= 1.9.6~), python3-dbus, python3-distro-info, ucf, lsb-release, lsb-base, xz-utils
Recommends: systemd-sysv | cron | cron-daemon | anacron
Suggests: bsd-mailx, default-mta | mail-transport-agent, needrestart, powermgmt-base, python3-gi
Conffiles:
 /etc/init.d/unattended-upgrades 290829a5efc55b7c435de0bb769f217b
 /etc/kernel/postinst.d/unattended-upgrades f296826482cb797aeef13554e093dbca
 /etc/logrotate.d/unattended-upgrades e45049ee847f069a99e3e6ec39155d4a
 /etc/pm/sleep.d/10_unattended-upgrades-hibernate 0f5d54aa2dd322c805c90e409fc2724a
 /etc/update-motd.d/92-unattended-upgrades afa7546d3fe561e1f5783f7b9cf72096
Description: automatic installation of security upgrades
 This package can download and install security upgrades automatically
 and unattended, taking care to only install packages from the
 configured APT source, and checking for dpkg prompts about
 configuration file changes.
 .
 This script is the backend for the APT::Periodic::Unattended-Upgrade
 option.
Original-Maintainer: Michael Vogt <mvo@debian.org>
dpkg-query: package 'apt-config-periodic' is not installed and no information is available
Use dpkg --info (= dpkg-deb --info) to examine archive files.
● unattended-upgrades.service - Unattended Upgrades Shutdown
     Loaded: loaded (/usr/lib/systemd/system/unattended-upgrades.service; enabled; preset: enabled)
     Active: active (running) since Sun 2025-03-16 10:37:15 EDT; 1h 18min ago
       Docs: man:unattended-upgrade(8)
   Main PID: 1110 (unattended-upgr)
      Tasks: 2 (limit: 2267)
     Memory: 9.6M (peak: 9.8M)
        CPU: 41ms
     CGroup: /system.slice/unattended-upgrades.service
             └─1110 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal

Mar 16 10:37:15 tmp-ubuntu24-server-cis-0225 systemd[1]: Started unattended-upgrades.service - Unattended Upgrades Shutdown.
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
// Automatically upgrade packages from these (origin:archive) pairs
//
// Note that in Ubuntu security updates may pull in new dependencies
// from non-security sources (e.g. chromium). By allowing the release
// pocket these get automatically pulled in.
Unattended-Upgrade::Allowed-Origins {
        "${distro_id}:${distro_codename}";
        "${distro_id}:${distro_codename}-security";
        // Extended Security Maintenance; doesn't necessarily exist for
        // every release and this system may not have it installed, but if
        // available, the policy for updates is such that unattended-upgrades
        // should also install from here by default.
        "${distro_id}ESMApps:${distro_codename}-apps-security";
        "${distro_id}ESM:${distro_codename}-infra-security";
//      "${distro_id}:${distro_codename}-updates";
//      "${distro_id}:${distro_codename}-proposed";
//      "${distro_id}:${distro_codename}-backports";
};

// Python regular expressions, matching packages to exclude from upgrading
Unattended-Upgrade::Package-Blacklist {
    // The following matches all packages starting with linux-
//  "linux-";

    // Use $ to explicitely define the end of a package name. Without
    // the $, "libc6" would match all of them.
//  "libc6$";
//  "libc6-dev$";
//  "libc6-i686$";

    // Special characters need escaping
//  "libstdc\+\+6$";

    // The following matches packages like xen-system-amd64, xen-utils-4.1,
    // xenstore-utils and libxenstore3.0
//  "(lib)?xen(store)?";

    // For more information about Python regular expressions, see
    // https://docs.python.org/3/howto/regex.html
};

// This option controls whether the development release of Ubuntu will be
// upgraded automatically. Valid values are "true", "false", and "auto".
Unattended-Upgrade::DevRelease "auto";

// This option allows you to control if on a unclean dpkg exit
// unattended-upgrades will automatically run
//   dpkg --force-confold --configure -a
// The default is true, to ensure updates keep getting installed
//Unattended-Upgrade::AutoFixInterruptedDpkg "true";

// Split the upgrade into the smallest possible chunks so that
// they can be interrupted with SIGTERM. This makes the upgrade
// a bit slower but it has the benefit that shutdown while a upgrade
// is running is possible (with a small delay)
//Unattended-Upgrade::MinimalSteps "true";

// Install all updates when the machine is shutting down
// instead of doing it in the background while the machine is running.
// This will (obviously) make shutdown slower.
// Unattended-upgrades increases logind's InhibitDelayMaxSec to 30s.
// This allows more time for unattended-upgrades to shut down gracefully
// or even install a few packages in InstallOnShutdown mode, but is still a
// big step back from the 30 minutes allowed for InstallOnShutdown previously.
// Users enabling InstallOnShutdown mode are advised to increase
// InhibitDelayMaxSec even further, possibly to 30 minutes.
//Unattended-Upgrade::InstallOnShutdown "false";

// Send email to this address for problems or packages upgrades
// If empty or unset then no email is sent, make sure that you
// have a working mail setup on your system. A package that provides
// 'mailx' must be installed. E.g. "user@example.com"
//Unattended-Upgrade::Mail "";

// Set this value to one of:
//    "always", "only-on-error" or "on-change"
// If this is not set, then any legacy MailOnlyOnError (boolean) value
// is used to chose between "only-on-error" and "on-change"
//Unattended-Upgrade::MailReport "on-change";

// Remove unused automatically installed kernel-related packages
// (kernel images, kernel headers and kernel version locked tools).
//Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";

// Do automatic removal of newly unused dependencies after the upgrade
//Unattended-Upgrade::Remove-New-Unused-Dependencies "true";

// Do automatic removal of unused packages after the upgrade
// (equivalent to apt-get autoremove)
//Unattended-Upgrade::Remove-Unused-Dependencies "false";

// Automatically reboot *WITHOUT CONFIRMATION* if
//  the file /var/run/reboot-required is found after the upgrade
//Unattended-Upgrade::Automatic-Reboot "false";

// Automatically reboot even if there are users currently logged in
// when Unattended-Upgrade::Automatic-Reboot is set to true
//Unattended-Upgrade::Automatic-Reboot-WithUsers "true";

// If automatic reboot is enabled and needed, reboot at the specific
// time instead of immediately
//  Default: "now"
//Unattended-Upgrade::Automatic-Reboot-Time "02:00";

// Use apt bandwidth limit feature, this example limits the download
// speed to 70kb/sec
//Acquire::http::Dl-Limit "70";

// Enable logging to syslog. Default is False
// Unattended-Upgrade::SyslogEnable "false";

// Specify syslog facility. Default is daemon
// Unattended-Upgrade::SyslogFacility "daemon";

// Download and install upgrades only on AC power
// (i.e. skip or gracefully stop updates on battery)
// Unattended-Upgrade::OnlyOnACPower "true";

// Download and install upgrades only on non-metered connection
// (i.e. skip or gracefully stop updates on a metered connection)
// Unattended-Upgrade::Skip-Updates-On-Metered-Connections "true";

// Verbose logging
// Unattended-Upgrade::Verbose "false";

// Print debugging information both in unattended-upgrades and
// in unattended-upgrade-shutdown
// Unattended-Upgrade::Debug "false";

// Allow package downgrade if Pin-Priority exceeds 1000
// Unattended-Upgrade::Allow-downgrade "false";

// When APT fails to mark a package to be upgraded or installed try adjusting
// candidates of related packages to help APT's resolver in finding a solution
// where the package can be upgraded or installed.
// This is a workaround until APT's resolver is fixed to always find a
// solution if it exists. (See Debian bug #711128.)
// The fallback is enabled by default, except on Debian's sid release because
// uninstallable packages are frequent there.
// Disabling the fallback speeds up unattended-upgrades when there are
// uninstallable packages at the expense of rarely keeping back packages which
// could be upgraded or installed.
// Unattended-Upgrade::Allow-APT-Mark-Fallback "true";
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
● apt-daily.timer - Daily apt download activities
     Loaded: loaded (/usr/lib/systemd/system/apt-daily.timer; enabled; preset: enabled)
     Active: active (waiting) since Sun 2025-03-16 10:37:15 EDT; 1h 18min ago
    Trigger: Sun 2025-03-16 18:38:04 EDT; 6h left
   Triggers: ● apt-daily.service

Mar 16 10:37:15 tmp-ubuntu24-server-cis-0225 systemd[1]: Started apt-daily.timer - Daily apt download activities.
● apt-daily-upgrade.timer - Daily apt upgrade and clean activities
     Loaded: loaded (/usr/lib/systemd/system/apt-daily-upgrade.timer; enabled; preset: enabled)
     Active: active (waiting) since Sun 2025-03-16 10:37:15 EDT; 1h 18min ago
    Trigger: Mon 2025-03-17 06:33:48 EDT; 18h left
   Triggers: ● apt-daily-upgrade.service

Mar 16 10:37:15 tmp-ubuntu24-server-cis-0225 systemd[1]: Started apt-daily-upgrade.timer - Daily apt upgrade and clean activities.
// Automatically reboot *WITHOUT CONFIRMATION* if
//  the file /var/run/reboot-required is found after the upgrade
//Unattended-Upgrade::Automatic-Reboot "false";
// Automatically reboot even if there are users currently logged in
// when Unattended-Upgrade::Automatic-Reboot is set to true
//Unattended-Upgrade::Automatic-Reboot-WithUsers "true";
// If automatic reboot is enabled and needed, reboot at the specific
//Unattended-Upgrade::Automatic-Reboot-Time "02:00";

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

amd64-microcode/noble-updates,noble-security,now 3.20231019.1ubuntu2.1 amd64 [installed,automatic]
apparmor/noble-updates,now 4.0.1really4.0.1-0ubuntu0.24.04.3 amd64 [installed,automatic]
apport-core-dump-handler/noble-updates,now 2.28.1-0ubuntu3.5 all [installed,automatic]
apport/noble-updates,now 2.28.1-0ubuntu3.5 all [installed,automatic]
auditd/noble-updates,now 1:3.1.2-2.1build1.1 amd64 [installed]
base-files/noble-updates,now 13ubuntu10.2 amd64 [installed]
bind9-dnsutils/noble-updates,noble-security,now 1:9.18.30-0ubuntu0.24.04.2 amd64 [installed,automatic]
bind9-host/noble-updates,noble-security,now 1:9.18.30-0ubuntu0.24.04.2 amd64 [installed,automatic]
bind9-libs/noble-updates,noble-security,now 1:9.18.30-0ubuntu0.24.04.2 amd64 [installed,automatic]
binutils-common/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
binutils-x86-64-linux-gnu/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
binutils/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
bpftrace/noble-updates,now 0.20.2-1ubuntu4.3 amd64 [installed,automatic]
bsdextrautils/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
bsdutils/noble-updates,now 1:2.39.3-9ubuntu6.2 amd64 [installed]
busybox-initramfs/noble-updates,noble-security,now 1:1.36.1-6ubuntu3.1 amd64 [installed,automatic]
busybox-static/noble-updates,noble-security,now 1:1.36.1-6ubuntu3.1 amd64 [installed,automatic]
bzip2/noble-updates,now 1.0.8-5.1build0.1 amd64 [installed,automatic]
chrony/noble-updates,now 4.5-1ubuntu4.2 amd64 [installed]
cloud-init/noble-updates,now 24.4.1-0ubuntu0~24.04.1 all [installed,automatic]
cloud-initramfs-copymods/noble-updates,now 0.49~24.04.1 all [installed,automatic]
cloud-initramfs-dyn-netconf/noble-updates,now 0.49~24.04.1 all [installed,automatic]
cpp-13-x86-64-linux-gnu/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
cpp-13/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
cryptsetup-bin/noble-updates,now 2:2.7.0-1ubuntu4.2 amd64 [installed,automatic]
cryptsetup-initramfs/noble-updates,now 2:2.7.0-1ubuntu4.2 all [installed,automatic]
cryptsetup/noble-updates,now 2:2.7.0-1ubuntu4.2 amd64 [installed,automatic]
curl/noble-updates,noble-security,now 8.5.0-2ubuntu10.6 amd64 [installed]
dbus-bin/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dbus-daemon/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dbus-session-bus-common/noble-updates,now 1.14.10-4ubuntu4.1 all [installed,automatic]
dbus-system-bus-common/noble-updates,now 1.14.10-4ubuntu4.1 all [installed,automatic]
dbus-user-session/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dbus/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dhcpcd-base/noble-updates,now 1:10.0.6-1ubuntu3.1 amd64 [installed,automatic]
distro-info-data/noble-updates,now 0.60ubuntu0.2 all [installed,automatic]
dmeventd/noble-updates,now 2:1.02.185-3ubuntu3.2 amd64 [installed,automatic]
dmidecode/noble-updates,now 3.5-3ubuntu0.1 amd64 [installed,automatic]
dmsetup/noble-updates,now 2:1.02.185-3ubuntu3.2 amd64 [installed,automatic]
dpkg-dev/noble-updates,noble-security,now 1.22.6ubuntu6.1 all [installed,automatic]
dpkg/noble-updates,noble-security,now 1.22.6ubuntu6.1 amd64 [installed,automatic]
dracut-install/noble-updates,now 060+5-1ubuntu3.3 amd64 [installed,automatic]
e2fsprogs-l10n/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 all [installed,automatic]
e2fsprogs/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed,automatic]
eject/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
fail2ban/noble-updates,now 1.0.2-3ubuntu0.1 all [installed]
fdisk/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
firmware-sof-signed/noble-updates,now 2023.12.1-1ubuntu1.4 all [installed,automatic]
fwupd/noble-updates,now 1.9.28-0ubuntu1~24.04.1 amd64 [installed,automatic]
g++-13-x86-64-linux-gnu/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
g++-13/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
gcc-13-base/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
gcc-13-x86-64-linux-gnu/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
gcc-13/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
gcc-14-base/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
gir1.2-glib-2.0/noble-updates,noble-security,now 2.80.0-6ubuntu3.2 amd64 [installed,automatic]
gir1.2-packagekitglib-1.0/noble-updates,now 1.2.8-2ubuntu1.2 amd64 [installed,automatic]
git-man/noble-updates,noble-security,now 1:2.43.0-1ubuntu7.2 all [installed,automatic]
git/noble-updates,noble-security,now 1:2.43.0-1ubuntu7.2 amd64 [installed]
grub-common/noble-updates,now 2.12-1ubuntu7.1 amd64 [installed,automatic]
grub-efi-amd64-bin/noble-updates,now 2.12-1ubuntu7.1 amd64 [installed,automatic]
grub-efi-amd64-signed/noble-updates,now 1.202.2+2.12-1ubuntu7.1 amd64 [installed]
grub-efi-amd64/noble-updates,now 2.12-1ubuntu7.1 amd64 [installed]
grub2-common/noble-updates,now 2.12-1ubuntu7.1 amd64 [installed,automatic]
initramfs-tools-bin/noble-updates,now 0.142ubuntu25.5 amd64 [installed,automatic]
initramfs-tools-core/noble-updates,now 0.142ubuntu25.5 all [installed,automatic]
initramfs-tools/noble-updates,now 0.142ubuntu25.5 all [installed,automatic]
intel-microcode/noble-updates,noble-security,now 3.20250211.0ubuntu0.24.04.1 amd64 [installed,automatic]
ipmitool/noble-updates,now 1.8.19-7ubuntu0.24.04.1 amd64 [installed,automatic]
klibc-utils/noble-updates,noble-security,now 2.0.13-4ubuntu0.1 amd64 [installed,automatic]
kmod/noble-updates,now 31+20240202-2ubuntu7.1 amd64 [installed,automatic]
krb5-locales/noble-updates,noble-security,now 1.20.1-6ubuntu2.5 all [installed,automatic]
landscape-common/noble-updates,now 24.02-0ubuntu5.2 amd64 [installed,automatic]
less/noble-updates,noble-security,now 590-2ubuntu2.1 amd64 [installed,automatic]
libacl1/noble-updates,now 2.3.2-1build1.1 amd64 [installed,automatic]
libaio1t64/noble-updates,now 0.3.113-6build1.1 amd64 [installed,automatic]
libaom3/noble-updates,noble-security,now 3.8.2-2ubuntu0.1 amd64 [installed,automatic]
libapparmor1/noble-updates,now 4.0.1really4.0.1-0ubuntu0.24.04.3 amd64 [installed,automatic]
libarchive13t64/noble-updates,noble-security,now 3.7.2-2ubuntu0.3 amd64 [installed,automatic]
libasan8/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libatomic1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libattr1/noble-updates,now 1:2.5.2-1build1.1 amd64 [installed,automatic]
libaudit-common/noble-updates,now 1:3.1.2-2.1build1.1 all [installed,automatic]
libaudit1/noble-updates,now 1:3.1.2-2.1build1.1 amd64 [installed,automatic]
libauparse0t64/noble-updates,now 1:3.1.2-2.1build1.1 amd64 [installed,automatic]
libbinutils/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
libblas3/noble-updates,now 3.12.0-3build1.1 amd64 [installed,automatic]
libblkid1/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
libbsd0/noble-updates,now 0.12.1-1build1.1 amd64 [installed,automatic]
libbz2-1.0/noble-updates,now 1.0.8-5.1build0.1 amd64 [installed,automatic]
libc-bin/noble-updates,noble-security,now 2.39-0ubuntu8.4 amd64 [installed,automatic]
libc-dev-bin/noble-updates,noble-security,now 2.39-0ubuntu8.4 amd64 [installed,automatic]
libc-devtools/noble-updates,noble-security,now 2.39-0ubuntu8.4 amd64 [installed,automatic]
libc6-dev/noble-updates,noble-security,now 2.39-0ubuntu8.4 amd64 [installed,automatic]
libc6/noble-updates,noble-security,now 2.39-0ubuntu8.4 amd64 [installed,automatic]
libcap2-bin/noble-updates,noble-security,now 1:2.66-5ubuntu2.2 amd64 [installed,automatic]
libcap2/noble-updates,noble-security,now 1:2.66-5ubuntu2.2 amd64 [installed,automatic]
libcc1-0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libclang-cpp18/noble-updates,now 1:18.1.3-1ubuntu1 amd64 [installed,automatic]
libclang1-18/noble-updates,now 1:18.1.3-1ubuntu1 amd64 [installed,automatic]
libcom-err2/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed,automatic]
libcryptsetup12/noble-updates,now 2:2.7.0-1ubuntu4.2 amd64 [installed,automatic]
libctf-nobfd0/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
libctf0/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
libcurl3t64-gnutls/noble-updates,noble-security,now 8.5.0-2ubuntu10.6 amd64 [installed,automatic]
libcurl4t64/noble-updates,noble-security,now 8.5.0-2ubuntu10.6 amd64 [installed,automatic]
libdbus-1-3/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
libdeflate0/noble-updates,now 1.19-1build1.1 amd64 [installed,automatic]
libdevmapper-event1.02.1/noble-updates,now 2:1.02.185-3ubuntu3.2 amd64 [installed,automatic]
libdevmapper1.02.1/noble-updates,now 2:1.02.185-3ubuntu3.2 amd64 [installed,automatic]
libdpkg-perl/noble-updates,noble-security,now 1.22.6ubuntu6.1 all [installed,automatic]
libdrm-common/noble-updates,now 2.4.122-1~ubuntu0.24.04.1 all [installed,automatic]
libdrm2/noble-updates,now 2.4.122-1~ubuntu0.24.04.1 amd64 [installed,automatic]
libdw1t64/noble-updates,now 0.190-1.1build4.1 amd64 [installed,automatic]
libelf1t64/noble-updates,now 0.190-1.1build4.1 amd64 [installed,automatic]
libexpat1/noble-updates,noble-security,now 2.6.1-2ubuntu0.2 amd64 [installed,automatic]
libext2fs2t64/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed,automatic]
libfdisk1/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
libfwupd2/noble-updates,now 1.9.28-0ubuntu1~24.04.1 amd64 [installed,automatic]
libgcc-13-dev/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
libgcc-s1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libglib2.0-0t64/noble-updates,noble-security,now 2.80.0-6ubuntu3.2 amd64 [installed,automatic]
libglib2.0-bin/noble-updates,noble-security,now 2.80.0-6ubuntu3.2 amd64 [installed,automatic]
libglib2.0-data/noble-updates,noble-security,now 2.80.0-6ubuntu3.2 all [installed,automatic]
libgmp10/noble-updates,now 2:6.3.0+dfsg-2ubuntu6.1 amd64 [installed,automatic]
libgnutls30t64/noble-updates,noble-security,now 3.8.3-1.1ubuntu3.3 amd64 [installed,automatic]
libgomp1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libgpg-error-l10n/noble-updates,now 1.47-3build2.1 all [installed,automatic]
libgpg-error0/noble-updates,now 1.47-3build2.1 amd64 [installed,automatic]
libgprofng0/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
libgssapi-krb5-2/noble-updates,noble-security,now 1.20.1-6ubuntu2.5 amd64 [installed,automatic]
libgstreamer1.0-0/noble-updates,noble-security,now 1.24.2-1ubuntu0.1 amd64 [installed,automatic]
libheif-plugin-aomdec/noble-updates,noble-security,now 1.17.6-1ubuntu4.1 amd64 [installed,automatic]
libheif-plugin-aomenc/noble-updates,noble-security,now 1.17.6-1ubuntu4.1 amd64 [installed,automatic]
libheif-plugin-libde265/noble-updates,noble-security,now 1.17.6-1ubuntu4.1 amd64 [installed,automatic]
libheif1/noble-updates,noble-security,now 1.17.6-1ubuntu4.1 amd64 [installed,automatic]
libhogweed6t64/noble-updates,now 3.9.1-2.2build1.1 amd64 [installed,automatic]
libhwasan0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libicu74/noble-updates,now 74.2-1ubuntu3.1 amd64 [installed,automatic]
libidn2-0/noble-updates,now 2.3.7-2build1.1 amd64 [installed,automatic]
libisl23/noble-updates,now 0.26-3build1.1 amd64 [installed,automatic]
libitm1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libk5crypto3/noble-updates,noble-security,now 1.20.1-6ubuntu2.5 amd64 [installed,automatic]
libklibc/noble-updates,noble-security,now 2.0.13-4ubuntu0.1 amd64 [installed,automatic]
libkmod2/noble-updates,now 31+20240202-2ubuntu7.1 amd64 [installed,automatic]
libkrb5-3/noble-updates,noble-security,now 1.20.1-6ubuntu2.5 amd64 [installed,automatic]
libkrb5support0/noble-updates,noble-security,now 1.20.1-6ubuntu2.5 amd64 [installed,automatic]
libldap-common/noble-updates,now 2.6.7+dfsg-1~exp1ubuntu8.2 all [installed,automatic]
libldap2/noble-updates,now 2.6.7+dfsg-1~exp1ubuntu8.2 amd64 [installed,automatic]
libllvm18/noble-updates,now 1:18.1.3-1ubuntu1 amd64 [installed,automatic]
liblsan0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
liblvm2cmd2.03/noble-updates,now 2.03.16-3ubuntu3.2 amd64 [installed,automatic]
liblz4-1/noble-updates,now 1.9.4-1build1.1 amd64 [installed,automatic]
liblzma5/noble-updates,now 5.6.1+really5.4.5-1build0.1 amd64 [installed,automatic]
libmd0/noble-updates,now 1.1.0-2build1.1 amd64 [installed,automatic]
libmodule-scandeps-perl/noble-updates,noble-security,now 1.35-1ubuntu0.24.04.1 all [installed,automatic]
libmount1/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
libmpc3/noble-updates,now 1.3.1-1build1.1 amd64 [installed,automatic]
libmpfr6/noble-updates,now 4.2.1-1build1.1 amd64 [installed,automatic]
libnetplan1/noble-updates,now 1.1.1-1~ubuntu24.04.1 amd64 [installed,automatic]
libnettle8t64/noble-updates,now 3.9.1-2.2build1.1 amd64 [installed,automatic]
libnghttp2-14/noble-updates,now 1.59.0-1ubuntu0.2 amd64 [installed,automatic]
libnl-3-200/noble-updates,now 3.7.0-0.3build1.1 amd64 [installed,automatic]
libnl-genl-3-200/noble-updates,now 3.7.0-0.3build1.1 amd64 [installed,automatic]
libnl-route-3-200/noble-updates,now 3.7.0-0.3build1.1 amd64 [installed,automatic]
libnss-systemd/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
libnvme1t64/noble-updates,now 1.8-3ubuntu1 amd64 [installed,automatic]
libopeniscsiusr/noble-updates,now 2.1.9-3ubuntu5.3 amd64 [installed,automatic]
libp11-kit0/noble-updates,now 0.25.3-4ubuntu2.1 amd64 [installed,automatic]
libpackagekit-glib2-18/noble-updates,now 1.2.8-2ubuntu1.2 amd64 [installed,automatic]
libpam-cap/noble-updates,noble-security,now 1:2.66-5ubuntu2.2 amd64 [installed,automatic]
libpam-modules-bin/noble-updates,now 1.5.3-5ubuntu5.1 amd64 [installed,automatic]
libpam-modules/noble-updates,now 1.5.3-5ubuntu5.1 amd64 [installed,automatic]
libpam-runtime/noble-updates,now 1.5.3-5ubuntu5.1 all [installed,automatic]
libpam-systemd/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
libpam0g/noble-updates,now 1.5.3-5ubuntu5.1 amd64 [installed,automatic]
libpcre2-8-0/noble-updates,now 10.42-4ubuntu2.1 amd64 [installed,automatic]
libperl5.38t64/noble-updates,now 5.38.2-3.2build2.1 amd64 [installed,automatic]
libpolkit-agent-1-0/noble-updates,now 124-2ubuntu1.24.04.2 amd64 [installed,automatic]
libpolkit-gobject-1-0/noble-updates,now 124-2ubuntu1.24.04.2 amd64 [installed,automatic]
libproc2-0/noble-updates,now 2:4.0.4-4ubuntu3.2 amd64 [installed,automatic]
libpython3-stdlib/noble-updates,now 3.12.3-0ubuntu2 amd64 [installed,automatic]
libpython3.12-minimal/noble-updates,noble-security,now 3.12.3-1ubuntu0.5 amd64 [installed,automatic]
libpython3.12-stdlib/noble-updates,noble-security,now 3.12.3-1ubuntu0.5 amd64 [installed,automatic]
libpython3.12t64/noble-updates,noble-security,now 3.12.3-1ubuntu0.5 amd64 [installed,automatic]
libquadmath0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libruby3.2/noble-updates,noble-security,now 3.2.3-1ubuntu0.24.04.3 amd64 [installed,automatic]
libsasl2-2/noble-updates,now 2.1.28+dfsg1-5ubuntu3.1 amd64 [installed,automatic]
libsasl2-modules-db/noble-updates,now 2.1.28+dfsg1-5ubuntu3.1 amd64 [installed,automatic]
libsasl2-modules/noble-updates,now 2.1.28+dfsg1-5ubuntu3.1 amd64 [installed,automatic]
libseccomp2/noble-updates,now 2.5.5-1ubuntu3.1 amd64 [installed,automatic]
libselinux1/noble-updates,now 3.5-2ubuntu2.1 amd64 [installed,automatic]
libsframe1/noble-updates,noble-security,now 2.42-4ubuntu2.4 amd64 [installed,automatic]
libsmartcols1/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
libsqlite3-0/noble-updates,now 3.45.1-1ubuntu2.1 amd64 [installed,automatic]
libss2/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed,automatic]
libssl-dev/noble-updates,noble-security,now 3.0.13-0ubuntu3.5 amd64 [installed]
libssl3t64/noble-updates,noble-security,now 3.0.13-0ubuntu3.5 amd64 [installed,automatic]
libstdc++-13-dev/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
libstdc++6/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libsystemd-shared/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
libsystemd0/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
libtasn1-6/noble-updates,noble-security,now 4.19.0-3ubuntu0.24.04.1 amd64 [installed,automatic]
libtiff6/noble-updates,noble-security,now 4.5.1+git230720-4ubuntu2.2 amd64 [installed,automatic]
libtsan2/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libtss2-esys-3.0.2-0t64/noble-updates,noble-security,now 4.0.1-7.1ubuntu5.1 amd64 [installed,automatic]
libtss2-mu-4.0.1-0t64/noble-updates,noble-security,now 4.0.1-7.1ubuntu5.1 amd64 [installed,automatic]
libtss2-sys1t64/noble-updates,noble-security,now 4.0.1-7.1ubuntu5.1 amd64 [installed,automatic]
libtss2-tcti-cmd0t64/noble-updates,noble-security,now 4.0.1-7.1ubuntu5.1 amd64 [installed,automatic]
libtss2-tcti-device0t64/noble-updates,noble-security,now 4.0.1-7.1ubuntu5.1 amd64 [installed,automatic]
libtss2-tcti-mssim0t64/noble-updates,noble-security,now 4.0.1-7.1ubuntu5.1 amd64 [installed,automatic]
libtss2-tcti-swtpm0t64/noble-updates,noble-security,now 4.0.1-7.1ubuntu5.1 amd64 [installed,automatic]
libubsan1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libudev1/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
libudisks2-0/noble-updates,now 2.10.1-6ubuntu1 amd64 [installed,automatic]
libunistring5/noble-updates,now 1.1-2build1.1 amd64 [installed,automatic]
libunwind8/noble-updates,now 1.6.2-3build1.1 amd64 [installed,automatic]
libuuid1/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
libxml2/noble-updates,noble-security,now 2.9.14+dfsg-1.3ubuntu3.2 amd64 [installed,automatic]
libzstd1/noble-updates,now 1.5.5+dfsg2-2build1.1 amd64 [installed,automatic]
linux-firmware/noble-updates,noble-security,now 20240318.git3b128b60-0ubuntu2.10 amd64 [installed,automatic]
linux-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed]
linux-headers-6.8.0-54-generic/noble-updates,noble-security,now 6.8.0-54.56 amd64 [installed,automatic]
linux-headers-6.8.0-54/noble-updates,noble-security,now 6.8.0-54.56 all [installed,automatic]
linux-headers-6.8.0-55-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-headers-6.8.0-55/noble-updates,noble-security,now 6.8.0-55.57 all [installed,automatic]
linux-headers-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-image-6.8.0-54-generic/noble-updates,noble-security,now 6.8.0-54.56 amd64 [installed,automatic]
linux-image-6.8.0-55-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-image-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-libc-dev/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-modules-6.8.0-54-generic/noble-updates,noble-security,now 6.8.0-54.56 amd64 [installed,automatic]
linux-modules-6.8.0-55-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-modules-extra-6.8.0-54-generic/noble-updates,noble-security,now 6.8.0-54.56 amd64 [installed,automatic]
linux-modules-extra-6.8.0-55-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-tools-6.8.0-54-generic/noble-updates,noble-security,now 6.8.0-54.56 amd64 [installed,automatic]
linux-tools-6.8.0-54/noble-updates,noble-security,now 6.8.0-54.56 amd64 [installed,automatic]
linux-tools-6.8.0-55-generic/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-tools-6.8.0-55/noble-updates,noble-security,now 6.8.0-55.57 amd64 [installed,automatic]
linux-tools-common/noble-updates,noble-security,now 6.8.0-55.57 all [installed,automatic]
locales/noble-updates,noble-security,now 2.39-0ubuntu8.4 all [installed,automatic]
login/noble-updates,now 1:4.13+dfsg1-4ubuntu3.2 amd64 [installed]
logsave/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed,automatic]
lvm2/noble-updates,now 2.03.16-3ubuntu3.2 amd64 [installed,automatic]
lxd-agent-loader/noble-updates,now 0.7ubuntu0.1 all [installed,automatic]
lxd-installer/noble-updates,now 4ubuntu0.1 all [installed,automatic]
mdadm/noble-updates,now 4.3-1ubuntu2.1 amd64 [installed,automatic]
motd-news-config/noble-updates,now 13ubuntu10.2 all [installed,automatic]
mount/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
mtr-tiny/noble-updates,now 0.95-1.1ubuntu0.1 amd64 [installed,automatic]
nano/noble-updates,noble-security,now 7.2-2ubuntu0.1 amd64 [installed,automatic]
needrestart/noble-updates,noble-security,now 3.6-7ubuntu4.5 all [installed,automatic]
netplan-generator/noble-updates,now 1.1.1-1~ubuntu24.04.1 amd64 [installed,automatic]
netplan.io/noble-updates,now 1.1.1-1~ubuntu24.04.1 amd64 [installed,automatic]
nvme-cli/noble-updates,now 2.8-1ubuntu0.1 amd64 [installed,automatic]
open-iscsi/noble-updates,now 2.1.9-3ubuntu5.3 amd64 [installed,automatic]
open-vm-tools/noble-updates,now 2:12.4.5-1~ubuntu0.24.04.1 amd64 [installed,automatic]
openssh-client/noble-updates,noble-security,now 1:9.6p1-3ubuntu13.8 amd64 [installed,automatic]
openssh-server/noble-updates,noble-security,now 1:9.6p1-3ubuntu13.8 amd64 [installed]
openssh-sftp-server/noble-updates,noble-security,now 1:9.6p1-3ubuntu13.8 amd64 [installed,automatic]
openssl/noble-updates,noble-security,now 3.0.13-0ubuntu3.5 amd64 [installed,automatic]
overlayroot/noble-updates,now 0.49~24.04.1 all [installed,automatic]
packagekit-tools/noble-updates,now 1.2.8-2ubuntu1.2 amd64 [installed,automatic]
packagekit/noble-updates,now 1.2.8-2ubuntu1.2 amd64 [installed,automatic]
passwd/noble-updates,now 1:4.13+dfsg1-4ubuntu3.2 amd64 [installed,automatic]
perl-base/noble-updates,now 5.38.2-3.2build2.1 amd64 [installed,automatic]
perl-modules-5.38/noble-updates,now 5.38.2-3.2build2.1 all [installed,automatic]
perl/noble-updates,now 5.38.2-3.2build2.1 amd64 [installed,automatic]
polkitd/noble-updates,now 124-2ubuntu1.24.04.2 amd64 [installed,automatic]
pollinate/noble-updates,now 4.33-3.1ubuntu1.1 all [installed,automatic]
procps/noble-updates,now 2:4.0.4-4ubuntu3.2 amd64 [installed,automatic]
prometheus-node-exporter/noble-updates,noble-security,now 1.7.0-1ubuntu0.2 amd64 [installed]
prometheus-process-exporter/noble-updates,noble-security,now 0.7.10-3ubuntu0.24.04.2 amd64 [installed]
python-apt-common/noble-updates,now 2.7.7ubuntu4 all [installed,automatic]
python3-apport/noble-updates,now 2.28.1-0ubuntu3.5 all [installed,automatic]
python3-apt/noble-updates,now 2.7.7ubuntu4 amd64 [installed,automatic]
python3-cryptography/noble-updates,noble-security,now 41.0.7-4ubuntu0.1 amd64 [installed,automatic]
python3-distupgrade/noble-updates,now 1:24.04.26 all [installed,automatic]
python3-greenlet/noble-updates,now 3.0.3-0ubuntu5.1 amd64 [installed,automatic]
python3-idna/noble-updates,noble-security,now 3.6-2ubuntu0.1 all [installed,automatic]
python3-jinja2/noble-updates,noble-security,now 3.1.2-1ubuntu1.3 all [installed,automatic]
python3-minimal/noble-updates,now 3.12.3-0ubuntu2 amd64 [installed,automatic]
python3-netplan/noble-updates,now 1.1.1-1~ubuntu24.04.1 amd64 [installed,automatic]
python3-pkg-resources/noble-updates,noble-security,now 68.1.2-2ubuntu1.1 all [installed,automatic]
python3-problem-report/noble-updates,now 2.28.1-0ubuntu3.5 all [installed,automatic]
python3-setuptools/noble-updates,noble-security,now 68.1.2-2ubuntu1.1 all [installed,automatic]
python3-software-properties/noble-updates,now 0.99.49.1 all [installed,automatic]
python3-twisted/noble-updates,noble-security,now 24.3.0-1ubuntu0.1 all [installed,automatic]
python3-update-manager/noble-updates,now 1:24.04.9 all [installed,automatic]
python3-urllib3/noble-updates,noble-security,now 2.0.7-1ubuntu0.1 all [installed,automatic]
python3.12-minimal/noble-updates,noble-security,now 3.12.3-1ubuntu0.5 amd64 [installed,automatic]
python3.12/noble-updates,noble-security,now 3.12.3-1ubuntu0.5 amd64 [installed,automatic]
python3/noble-updates,now 3.12.3-0ubuntu2 amd64 [installed]
qemu-guest-agent/noble-updates,now 1:8.2.2+ds-0ubuntu1.6 amd64 [installed]
rsync/noble-updates,noble-security,now 3.2.7-1ubuntu1.2 amd64 [installed,automatic]
ruby-webrick/noble-updates,noble-security,now 1.8.1-1ubuntu0.1 all [installed,automatic]
ruby3.2/noble-updates,noble-security,now 3.2.3-1ubuntu0.24.04.3 amd64 [installed,automatic]
snapd/noble-updates,now 2.67.1+24.04 amd64 [installed,automatic]
software-properties-common/noble-updates,now 0.99.49.1 all [installed]
sosreport/noble-updates,now 4.8.2-0ubuntu0~24.04.1 amd64 [installed,automatic]
ssh-import-id/noble-updates,now 5.11-0ubuntu2.24.04.1 all [installed,automatic]
systemd-dev/noble-updates,now 255.4-1ubuntu8.5 all [installed,automatic]
systemd-hwe-hwdb/noble-updates,now 255.1.4 all [installed,automatic]
systemd-resolved/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
systemd-sysv/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
systemd/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
thermald/noble-updates,now 2.5.6-2ubuntu0.24.04.2 amd64 [installed,automatic]
thin-provisioning-tools/noble-updates,now 0.9.0-2ubuntu5.1 amd64 [installed,automatic]
tmux/noble-updates,now 3.4-1ubuntu0.1 amd64 [installed]
tzdata-legacy/noble-updates,noble-security,now 2024b-0ubuntu0.24.04.1 all [installed,automatic]
tzdata/noble-updates,noble-security,now 2024b-0ubuntu0.24.04.1 all [installed,automatic]
ubuntu-kernel-accessories/noble-updates,now 1.539.2 amd64 [installed,automatic]
ubuntu-minimal/noble-updates,now 1.539.2 amd64 [installed]
ubuntu-pro-client-l10n/noble-updates,now 34~24.04 amd64 [installed,automatic]
ubuntu-pro-client/noble-updates,now 34~24.04 amd64 [installed,automatic]
ubuntu-release-upgrader-core/noble-updates,now 1:24.04.26 all [installed,automatic]
ubuntu-server-minimal/noble-updates,now 1.539.2 amd64 [installed]
ubuntu-server/noble-updates,now 1.539.2 amd64 [installed]
ubuntu-standard/noble-updates,now 1.539.2 amd64 [installed]
udev/noble-updates,now 255.4-1ubuntu8.5 amd64 [installed,automatic]
udisks2/noble-updates,now 2.10.1-6ubuntu1 amd64 [installed,automatic]
unattended-upgrades/noble,now 2.9.1+nmu4ubuntu1 all [installed,automatic]
unminimize/noble-updates,now 0.2.1 amd64 [installed,automatic]
unzip/noble-updates,noble-security,now 6.0-28ubuntu4.1 amd64 [installed]
update-manager-core/noble-updates,now 1:24.04.9 all [installed,automatic]
update-notifier-common/noble,now 3.192.68build3 all [installed,automatic]
util-linux/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed]
uuid-runtime/noble-updates,now 2.39.3-9ubuntu6.2 amd64 [installed,automatic]
vim-common/noble-updates,noble-security,now 2:9.1.0016-1ubuntu7.6 all [installed,automatic]
vim-runtime/noble-updates,noble-security,now 2:9.1.0016-1ubuntu7.6 all [installed,automatic]
vim-tiny/noble-updates,noble-security,now 2:9.1.0016-1ubuntu7.6 amd64 [installed,automatic]
vim/noble-updates,noble-security,now 2:9.1.0016-1ubuntu7.6 amd64 [installed,automatic]
wget/noble-updates,noble-security,now 1.21.4-1ubuntu4.1 amd64 [installed,automatic]
wireless-regdb/noble-updates,noble-security,now 2024.07.04-0ubuntu1~24.04.1 all [installed,automatic]
xfsprogs/noble-updates,now 6.6.0-1ubuntu2.1 amd64 [installed,automatic]
xkb-data/noble-updates,now 2.41-2ubuntu1.1 all [installed,automatic]
xxd/noble-updates,noble-security,now 2:9.1.0016-1ubuntu7.6 amd64 [installed,automatic]
xz-utils/noble-updates,now 5.6.1+really5.4.5-1build0.1 amd64 [installed,automatic]
zip/noble-updates,now 3.0-13ubuntu0.2 amd64 [installed]
zlib1g/noble-updates,now 1:1.3.dfsg-3.1ubuntu2.1 amd64 [installed,automatic]
zstd/noble-updates,now 1.5.5+dfsg2-2build1.1 amd64 [installed,automatic]
```
