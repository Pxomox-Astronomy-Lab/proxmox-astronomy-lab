# 🌐 CIS Ubuntu 24.04 LTS L2 Benchmark - Section 3: Network Configuration

This section provides detailed implementation guidance for hardening network configuration settings in accordance with the CIS Ubuntu 24.04 LTS Level 2 Benchmark. Properly configured network parameters protect systems from common network-based attacks and reduce the attack surface.

## 🔍 1. Overview

Network configuration hardening is a critical component of system security. This guide covers network parameter settings that defend against various attacks including packet spoofing, routing attacks, and denial of service attempts. Each control is explained with its security purpose and implementation steps.

### 1.1 Purpose

The purpose of this section is to:

- Ensure network interfaces and parameters are securely configured
- Protect against common network-based attacks
- Implement defense-in-depth for critical network services
- Reduce the system's network attack surface

### 1.2 Scope

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Network interface configuration | Application-specific network settings |
| System-wide network parameters | Firewall rules (covered in Section 4) |
| TCP/IP stack hardening | Advanced network routing configurations |
| Basic access controls | Network service configurations (covered in Sections 5-6) |

### 1.3 Cross-References

| **Framework** | **Control Reference** |
|--------------|------------------------|
| NIST SP 800-53 | SC-7, SC-5, CM-7 |
| ISO 27001:2022 | A.8.22, A.8.25, A.8.28 |
| MITRE ATT&CK | Initial Access, Defense Evasion |
| CIS Controls v8 | 4.6, 4.7, 12.3, 13.1, 13.6 |

## 📋 2. Controls Implementation

This section outlines each CIS control, its security importance, and specific implementation steps.

### 2.1 Network Parameters (Host Only)

These controls apply to end systems that do not perform router functions and focus on securing host-level network configuration.

#### 2.1.1 Ensure wireless interfaces are disabled

Wireless interfaces present additional attack vectors and should be disabled on server systems that don't require wireless connectivity. Disabling these interfaces reduces the attack surface and prevents potential unauthorized network access.

**Implementation:**

```bash
# Unload wireless modules
sudo modprobe -r ath
sudo modprobe -r bluetooth
sudo modprobe -r wifi
sudo modprobe -r iwl
sudo modprobe -r wext
sudo modprobe -r wl

# Blacklist wireless modules to prevent loading at boot
cat << EOF | sudo tee /etc/modprobe.d/blacklist-wireless.conf
blacklist ath
blacklist bluetooth
blacklist wifi
blacklist iwl
blacklist wext
blacklist wl
EOF

# Update initramfs
sudo update-initramfs -u
```

### 2.2 Network Parameters (Host and Router)

These parameters apply to all systems and are critical for protecting against routing-based attacks.

#### 2.2.1 Ensure IP forwarding is disabled

IP forwarding allows a system to forward packets between interfaces, which is needed for router functionality but presents security risks for standard servers. Unless the system is specifically intended to function as a router, IP forwarding should be disabled to prevent potential routing attacks.

**Implementation:**

```bash
# Set the parameter in running system
sudo sysctl -w net.ipv4.ip_forward=0
sudo sysctl -w net.ipv6.conf.all.forwarding=0

# Make the changes persistent
echo "net.ipv4.ip_forward = 0" | sudo tee /etc/sysctl.d/60-disable-ip-forward.conf
echo "net.ipv6.conf.all.forwarding = 0" | sudo tee -a /etc/sysctl.d/60-disable-ip-forward.conf
```

#### 2.2.2 Ensure packet redirect sending is disabled

ICMP redirects can potentially be used to override routing tables. Disabling ICMP redirect sending prevents attackers from manipulating network traffic flows from your system. This mitigates man-in-the-middle attacks that can exploit these redirects.

**Implementation:**

```bash
# Set the parameters in running system
sudo sysctl -w net.ipv4.conf.all.send_redirects=0
sudo sysctl -w net.ipv4.conf.default.send_redirects=0

# Make the changes persistent
cat << EOF | sudo tee /etc/sysctl.d/60-disable-send-redirects.conf
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
EOF
```

### 2.3 Network Protocol Security Parameters

These parameters provide protection against various protocol-level attacks and exploits. Proper configuration of these settings is essential for defending against network-based threats.

#### 2.3.1 Ensure source routed packets are not accepted

Source routing allows a sender to specify the network path a packet should take, which can be exploited for routing attacks. Disabling the acceptance of source-routed packets prevents attackers from bypassing network security controls.

**Implementation:**

```bash
# Set the parameters in running system
sudo sysctl -w net.ipv4.conf.all.accept_source_route=0
sudo sysctl -w net.ipv4.conf.default.accept_source_route=0
sudo sysctl -w net.ipv6.conf.all.accept_source_route=0
sudo sysctl -w net.ipv6.conf.default.accept_source_route=0

# Make the changes persistent
cat << EOF | sudo tee /etc/sysctl.d/60-disable-source-routing.conf
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0
EOF
```

#### 2.3.2 Ensure ICMP redirects are not accepted

ICMP redirects can be used by attackers to alter the host's routing tables. Disabling the acceptance of ICMP redirects prevents malicious route modifications and potential network traffic hijacking.

**Implementation:**

```bash
# Set the parameters in running system
sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
sudo sysctl -w net.ipv4.conf.default.accept_redirects=0
sudo sysctl -w net.ipv6.conf.all.accept_redirects=0
sudo sysctl -w net.ipv6.conf.default.accept_redirects=0

# Make the changes persistent
cat << EOF | sudo tee /etc/sysctl.d/60-disable-accept-redirects.conf
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
EOF
```

#### 2.3.3 Ensure secure ICMP redirects are not accepted

Even "secure" ICMP redirects (from gateways on the default gateway list) can pose security risks. Disabling these redirects provides an additional layer of protection against routing table manipulation.

**Implementation:**

```bash
# Set the parameters in running system
sudo sysctl -w net.ipv4.conf.all.secure_redirects=0
sudo sysctl -w net.ipv4.conf.default.secure_redirects=0

# Make the changes persistent
cat << EOF | sudo tee /etc/sysctl.d/60-disable-secure-redirects.conf
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
EOF
```

#### 2.3.4 Ensure suspicious packets are logged

Logging suspicious packets helps in detecting potential network-based attacks. Enabling the logging of "martian" packets (those with impossible source addresses) provides valuable information for security monitoring and incident response.

**Implementation:**

```bash
# Set the parameters in running system
sudo sysctl -w net.ipv4.conf.all.log_martians=1
sudo sysctl -w net.ipv4.conf.default.log_martians=1

# Make the changes persistent
cat << EOF | sudo tee /etc/sysctl.d/60-enable-log-martians.conf
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
EOF
```

#### 2.3.5 Ensure broadcast ICMP requests are ignored

Broadcast ICMP echo requests are used in "Smurf" amplification DDoS attacks. Ignoring these requests prevents the system from being used as an amplification vector in such attacks.

**Implementation:**

```bash
# Set the parameter in running system
sudo sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1

# Make the change persistent
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" | sudo tee /etc/sysctl.d/60-disable-broadcast-icmp.conf
```

#### 2.3.6 Ensure bogus ICMP responses are ignored

Some routers violate network protocol standards by sending bogus responses to broadcast frames. Ignoring these responses reduces unnecessary network traffic and prevents potential exploitation.

**Implementation:**

```bash
# Set the parameter in running system
sudo sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

# Make the change persistent
echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" | sudo tee /etc/sysctl.d/60-ignore-bogus-icmp.conf
```

#### 2.3.7 Ensure Reverse Path Filtering is enabled

Reverse Path Filtering verifies that packets come from legitimate source addresses, preventing IP spoofing attacks. This control helps ensure that packets traversing the system have valid source and destination addresses.

**Implementation:**

```bash
# Set the parameters in running system
sudo sysctl -w net.ipv4.conf.all.rp_filter=1
sudo sysctl -w net.ipv4.conf.default.rp_filter=1

# Make the changes persistent
cat << EOF | sudo tee /etc/sysctl.d/60-enable-rp-filter.conf
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
EOF
```

#### 2.3.8 Ensure TCP SYN Cookies is enabled

SYN cookies protect against SYN flood attacks by validating connection attempts without maintaining full TCP connection state. This helps the system remain responsive even when under a SYN flood attack.

**Implementation:**

```bash
# Set the parameter in running system
sudo sysctl -w net.ipv4.tcp_syncookies=1

# Make the change persistent
echo "net.ipv4.tcp_syncookies = 1" | sudo tee /etc/sysctl.d/60-enable-tcp-syncookies.conf
```

#### 2.3.9 Ensure IPv6 router advertisements are not accepted

If IPv6 is enabled, router advertisements should be disabled to prevent unauthorized network reconfiguration. This control mitigates IPv6-specific routing attacks.

**Implementation:**

```bash
# Set the parameters in running system
sudo sysctl -w net.ipv6.conf.all.accept_ra=0
sudo sysctl -w net.ipv6.conf.default.accept_ra=0

# Make the changes persistent
cat << EOF | sudo tee /etc/sysctl.d/60-disable-ipv6-router-advertisements.conf
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
EOF
```

### 2.4 Access Control Configuration

These controls implement basic host-based access restrictions through TCP Wrappers, providing an additional layer of network security.

#### 2.4.1 Ensure TCP Wrappers is installed

TCP Wrappers provides host-based access control for network services and logs connection attempts. While modern systems often use other mechanisms, TCP Wrappers remains a useful additional layer of defense.

**Implementation:**

```bash
sudo apt install tcpd
```

#### 2.4.2 Ensure /etc/hosts.allow is configured

The `/etc/hosts.allow` file specifies which hosts are permitted to connect to the system. Properly configuring this file helps restrict network access to authorized clients only.

**Implementation:**

```bash
cat << 'EOF' | sudo tee /etc/hosts.allow
# /etc/hosts.allow: list of hosts that are allowed to access the system.
#                   See the manual pages hosts_access(5) and hosts_options(5).

# Allow all local network connections from lab subnets
sshd: 127.0.0.1 10.25.10.0/24 10.25.20.0/24 10.25.30.0/24 10.25.40.0/24 10.25.50.0/24 10.25.60.0/24
ALL: localhost
ALL: 127.0.0.1

# Allow specific lab subnets
ALL: 10.25.10.0/24
ALL: 10.25.20.0/24
ALL: 10.25.30.0/24
ALL: 10.25.40.0/24
ALL: 10.25.50.0/24
ALL: 10.25.60.0/24

# End of file
EOF
```

#### 2.4.3 Ensure /etc/hosts.deny is configured

The `/etc/hosts.deny` file specifies which hosts are denied access to the system. Implementing a default deny policy with logging provides stronger security and valuable audit information.

**Implementation:**

```bash
cat << 'EOF' | sudo tee /etc/hosts.deny
# /etc/hosts.deny: list of hosts that are not allowed to access the system.
#                  See the manual pages hosts_access(5) and hosts_options(5).

# Deny by default and log the connection
ALL: ALL: spawn /bin/echo "$(date) | Connection attempt from %h to %d" >> /var/log/tcpwrappers.log

# End of file
EOF

# Create the log file with proper permissions
sudo touch /var/log/tcpwrappers.log
sudo chmod 640 /var/log/tcpwrappers.log
```

#### 2.4.4 Ensure permissions on /etc/hosts.allow and /etc/hosts.deny are configured

Proper permissions on TCP Wrapper configuration files prevent unauthorized modifications. These files should be owned by root with restricted permissions.

**Implementation:**

```bash
# Set proper ownership and permissions
sudo chown root:root /etc/hosts.allow
sudo chmod 644 /etc/hosts.allow
sudo chown root:root /etc/hosts.deny
sudo chmod 644 /etc/hosts.deny
```

## 🧪 3. Validation

The `03-network-configuration-check.sh` script provides a way to validate compliance with all the controls in this section. The script checks each setting and reports the status.

### 3.1 Running the Validation Script

```bash
# Make the script executable
chmod +x 03-network-configuration-check.sh

# Run the script with root privileges
sudo ./03-network-configuration-check.sh
```

### 3.2 Interpreting Results

The script outputs PASS/FAIL status for each control. For any failed checks, review the current settings displayed and apply the remediation steps provided in this document.

## 🔗 4. Related Documentation

| **Document** | **Description** | **Location** |
|------------|----------------|-------------|
| CIS Ubuntu 24.04 L2 Benchmark | Complete benchmark documentation | [CIS Benchmarks](https://www.cisecurity.org/benchmark/ubuntu_linux/) |
| Ubuntu Network Configuration | Official Ubuntu documentation | [Ubuntu Documentation](https://ubuntu.com/server/docs) |
| TCP Wrappers Manual | Manual for TCP Wrappers configuration | `man hosts_access` and `man hosts_options` |

## ✅ Approval & Review

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## 📜 Change Log

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |
