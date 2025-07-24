# Setting Up LACP Bond Configuration

Learn how to configure LACP (802.3ad) network bonding on Proxmox VE nodes to provide high-bandwidth, redundant network connectivity for enterprise infrastructure.

## Why We Do This

In the Proxmox Astronomy Lab, we implement LACP bonding to aggregate multiple network interfaces for enhanced performance and redundancy in our enterprise infrastructure. While single network interfaces could handle basic connectivity, we implement LACP bonding because:

- **High-Bandwidth Requirements**: Astronomical data processing requires high-throughput network connectivity for DESI dataset transfers and scientific computing workflows
- **Network Redundancy**: LACP provides automatic failover capabilities ensuring continuous operation during network interface failures or maintenance
- **Enterprise Performance**: Aggregated bandwidth supports multiple concurrent VM migrations, backup operations, and database replication across the 7-node cluster
- **Infrastructure Scaling**: Bonded interfaces enable high-performance storage replication and distributed computing communication for RKE2 Kubernetes operations

This configuration is implemented consistently across all Proxmox nodes (node01-node07) to provide enterprise-grade network infrastructure supporting both VM traffic and cluster operations.

## Prerequisites

- Two or more identical network interfaces on Proxmox VE node
- Managed switch supporting 802.3ad LACP (like our Mokerlink and Sodola switches)
- Administrative access to both Proxmox node and network switch
- Understanding of VLAN configuration and bridge networking concepts

## Step-by-Step Instructions

### Step 1: Identify Network Interfaces

```bash
# List all network interfaces and their status
ip -br link

# Check physical interface details
lspci | grep -i ethernet

# Verify interface names and MAC addresses
cat /proc/net/dev
```

Identify the physical network interfaces that will be used for the LACP bond. Note their names and MAC addresses for configuration and verification.

### Step 2: Configure Persistent Network Interface Names

```bash
# Create udev rules for consistent interface naming
sudo nano /etc/udev/rules.d/70-persistent-net.rules

# Add rules based on MAC addresses (example from node01)
cat << 'EOF' | sudo tee /etc/udev/rules.d/70-persistent-net.rules
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fe", NAME="eth0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fd", NAME="eth1"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fb", NAME="spf0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fc", NAME="spf1"
EOF
```

Configure persistent interface names using udev rules to ensure consistent naming across reboots and prevent interface name changes during system updates.

### Step 3: Configure Network Interfaces File

```bash
# Backup existing configuration
sudo cp /etc/network/interfaces /etc/network/interfaces.backup

# Edit network interfaces configuration
sudo nano /etc/network/interfaces
```

Configure the network interfaces file with LACP bonding and VLAN configuration following the enterprise network architecture.

### Step 4: Implement LACP Bond Configuration

```bash
# Configure bonding interfaces (example from node01)
cat << 'EOF' | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

# Management interface on main switch
iface eth0 inet manual

auto vmbr0
iface vmbr0 inet static
    address 10.16.207.61/24
    gateway 10.16.207.1
    bridge-ports eth0
    bridge-stp off
    bridge-fd 0

# Unused interface
iface eth1 inet manual

# SFP+ interfaces for high-speed bonding
auto spf0
iface spf0 inet manual
    post-up ethtool -K spf0 tso off

auto spf1
iface spf1 inet manual
    post-up ethtool -K spf1 tso off

# LACP bond configuration
auto bond0
iface bond0 inet manual
    bond-slaves spf0 spf1
    bond-miimon 100
    bond-mode 802.3ad
    bond-xmit-hash-policy layer2+3
    bond-lacp-rate slow

# Bridge for bonded interfaces
auto vmbr1
iface vmbr1 inet manual
    bridge-ports bond0
    bridge-stp off
    bridge-fd 0

# VLAN interfaces on bonded connection
auto vmbr1.10
iface vmbr1.10 inet static
    address 10.25.10.231/24

auto vmbr1.20
iface vmbr1.20 inet static
    address 10.25.20.231/24

auto vmbr1.30
iface vmbr1.30 inet static
    address 10.25.30.231/24

auto vmbr1.40
iface vmbr1.40 inet static
    address 10.25.40.231/24

auto vmbr1.50
iface vmbr1.50 inet static
    address 10.25.50.231/24

auto vmbr1.60
iface vmbr1.60 inet static
    address 10.25.60.231/24

source /etc/network/interfaces.d/*
EOF
```

Configure the complete network stack with LACP bonding, bridge interfaces, and VLAN segmentation for enterprise network architecture.

### Step 5: Configure Switch-Side LACP

```bash
# Document switch configuration requirements
# (Configuration varies by switch vendor)

# For Mokerlink switches - example configuration:
# interface port-channel 1
#   mode lacp active
#   lacp timeout short
# interface ethernet 1/1
#   channel-group 1 mode active
# interface ethernet 1/2
#   channel-group 1 mode active
```

Configure the network switch to support LACP on the ports connected to the bonded interfaces. This requires coordination with network administration.

### Step 6: Apply Network Configuration

```bash
# Restart networking services
sudo systemctl restart networking

# Alternative: Apply interfaces without full restart
sudo ifdown bond0 && sudo ifup bond0

# Restart network interfaces individually if needed
sudo ifdown vmbr1 && sudo ifup vmbr1
```

Apply the network configuration changes. In production environments, schedule this during maintenance windows to avoid service disruption.

## Verification

Verify LACP bond configuration and functionality:

```bash
# Check bond status and configuration
cat /proc/net/bonding/bond0

# Verify LACP partner information
cat /proc/net/bonding/bond0 | grep -A5 "Partner"

# Check interface status
ip -br link | grep -E "(spf0|spf1|bond0|vmbr1)"

# Verify VLAN interfaces are active
ip addr show | grep -E "vmbr1\."

# Test bond throughput (use with caution)
iperf3 -s &
iperf3 -c target_host -P 4 -t 30
```

### Expected Output

```bash
Bond status verification:
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
Bonding Mode: IEEE 802.3ad Dynamic link aggregation
Transmit Hash Policy: layer2+3 (2)
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0

802.3ad info
LACP rate: slow
Min links: 0
Aggregator selection policy (ad_select): stable

Slave Interface: spf0
MII Status: up
Speed: 10000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 58:47:ca:76:76:fb
Slave queue ID: 0
Aggregator ID: 1
Actor Churn State: monitoring
Partner Churn State: monitoring
Actor Churned Count: 0
Partner Churned Count: 0
```

## Troubleshooting

**Bond interfaces not coming up:** Check physical cable connections and switch configuration:

```bash
# Check physical link status
ethtool spf0 | grep "Link detected"
ethtool spf1 | grep "Link detected"

# Verify bond slave configuration
cat /sys/class/net/bond0/bonding/slaves

# Check for bonding module
lsmod | grep bonding
modprobe bonding
```

**LACP negotiation failures:** Verify switch-side LACP configuration and timing:

```bash
# Check LACP partner MAC and system priority
cat /proc/net/bonding/bond0 | grep -A10 "Partner Info"

# Monitor LACP PDU exchange
tcpdump -i spf0 ether proto 0x8809

# Verify bond mode and hash policy
cat /sys/class/net/bond0/bonding/mode
cat /sys/class/net/bond0/bonding/xmit_hash_policy
```

**Performance issues with bonded interface:** Check load balancing and interface utilization:

```bash
# Monitor individual interface traffic
watch -n 1 'cat /proc/net/dev | grep -E "(spf0|spf1)"'

# Check bond load distribution
cat /proc/net/bonding/bond0 | grep -A5 "Slave Interface"

# Verify MTU settings match across interfaces
ip link show spf0 | grep mtu
ip link show spf1 | grep mtu
ip link show bond0 | grep mtu
```

**VLAN interfaces not responding:** Verify VLAN configuration and switch trunk setup:

```bash
# Check VLAN interface configuration
ip addr show vmbr1.20

# Verify bridge configuration
bridge vlan show

# Test VLAN connectivity
ping -I vmbr1.20 10.25.20.1

# Check if VLANs are properly trunked on switch
tcpdump -i bond0 -e vlan
```

**Network performance degradation:** Analyze bond performance and optimize settings:

```bash
# Check bond statistics
cat /proc/net/bonding/bond0 | grep -E "(Packets|Bytes)"

# Monitor bond failover events
dmesg | grep -i bond

# Optimize receive/transmit settings
ethtool -G spf0 rx 4096 tx 4096
ethtool -G spf1 rx 4096 tx 4096

# Check interrupt distribution
cat /proc/interrupts | grep -E "(spf0|spf1)"
```

## Related Articles

- [Setting Up Predictable Network Names](setup-predictable-network-names.md)
- [Proxmox Network Configuration](../../infrastructure/proxmox/cluster-configuration.md)
- [VLAN Configuration Guide](../../hardware/networking/README.md)
- [Network Performance Optimization](../../monitoring/network-monitoring.md)

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-23 |
| **Last Updated** | 2025-07-23 |
| **Version** | 1.0 |

---
Tags: proxmox, networking, lacp, bonding, 802.3ad, high-availability, enterprise-networking, vlan
