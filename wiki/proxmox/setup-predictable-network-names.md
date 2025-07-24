# Setting Up Predictable Network Names

Learn how to configure consistent network interface names across Proxmox VE nodes using udev rules to ensure reliable network configuration and automation.

## Why We Do This

In the Proxmox Astronomy Lab, we implement predictable network interface names to ensure consistent network configuration across our enterprise infrastructure. While modern systems use predictable naming schemes by default, we implement custom naming because:

- **Enterprise Consistency**: Custom interface names provide clear, logical naming that matches our network documentation and infrastructure diagrams
- **Automation Reliability**: Ansible playbooks and infrastructure automation depend on consistent interface names across all nodes in the 7-node cluster
- **Operational Clarity**: Descriptive names like `spf0` and `spf1` immediately identify SFP+ high-speed interfaces versus standard Ethernet ports
- **Configuration Management**: Consistent naming prevents network configuration drift and simplifies troubleshooting across identical hardware platforms

This approach is implemented consistently across all Proxmox nodes (node01-node07) to provide predictable network interface identification for enterprise infrastructure management.

## Prerequisites

- Administrative access to Proxmox VE node
- Knowledge of current network interface MAC addresses
- Understanding of udev rules and network interface naming
- Physical documentation of network port assignments and cable connections

## Step-by-Step Instructions

### Step 1: Identify Current Network Interfaces

```bash
# List all network interfaces with MAC addresses
ip link show

# Alternative method to see interface details
ip -br link

# Check current interface naming and addresses
cat /proc/net/dev

# View detailed interface information
lshw -class network
```

Document the current network interface names, MAC addresses, and their physical locations on the system for accurate mapping.

### Step 2: Map Physical Interfaces to Desired Names

```bash
# Identify interface types and locations
lspci | grep -i ethernet

# Check current systemd predictable names
networkctl status

# Document interface mapping (example from node01)
# eth0: 58:47:ca:76:76:fd - Onboard Ethernet (management)
# eth1: 58:47:ca:76:76:fe - Secondary Ethernet (unused)
# spf0: 58:47:ca:76:76:fb - SFP+ Port 0 (bond member)
# spf1: 58:47:ca:76:76:fc - SFP+ Port 1 (bond member)
```

Create a logical mapping between physical interfaces, their MAC addresses, and the desired interface names for your network architecture.

### Step 3: Create udev Rules File

```bash
# Create or edit the persistent network rules file
sudo nano /etc/udev/rules.d/70-persistent-net.rules

# Backup any existing rules first
sudo cp /etc/udev/rules.d/70-persistent-net.rules /etc/udev/rules.d/70-persistent-net.rules.backup 2>/dev/null || true
```

Create the udev rules file that will define the persistent network interface names based on MAC addresses.

### Step 4: Configure Network Interface Rules

```bash
# Configure udev rules for predictable interface names (example from node01)
cat << 'EOF' | sudo tee /etc/udev/rules.d/70-persistent-net.rules
# Proxmox Astronomy Lab - Node01 Network Interface Names
# Management and standard Ethernet interfaces
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fd", NAME="eth0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fe", NAME="eth1"

# High-speed SFP+ interfaces for LACP bonding
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fb", NAME="spf0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fc", NAME="spf1"
EOF
```

Create udev rules that map specific MAC addresses to your desired interface names. Use meaningful names that reflect the interface purpose and type.

### Step 5: Update Network Configuration Files

```bash
# Update /etc/network/interfaces to use new names
sudo nano /etc/network/interfaces

# Example update - change from systemd names to custom names
# Old: auto enp1s0f0
# New: auto spf0

# Verify no references to old interface names remain
grep -r "enp" /etc/network/
grep -r "eno" /etc/network/
```

Update your network configuration files to reference the new predictable interface names instead of the default systemd names.

### Step 6: Apply udev Rules

```bash
# Reload udev rules without reboot
sudo udevadm control --reload-rules

# Trigger udev rules for network devices
sudo udevadm trigger --subsystem-match=net

# Alternative: Force specific interface rename (if safe)
sudo ip link set enp1s0f0 name spf0 2>/dev/null || true
sudo ip link set enp1s0f1 name spf1 2>/dev/null || true
```

Apply the new udev rules to the running system. Some changes may require a reboot to take full effect.

### Step 7: Verify and Test Configuration

```bash
# Check if new interface names are active
ip -br link | grep -E "(eth0|eth1|spf0|spf1)"

# Verify udev rule matching
udevadm test-builtin net_id /sys/class/net/spf0 2>/dev/null | grep ID_NET_NAME

# Test network functionality with new names
ping -I eth0 -c 3 10.16.207.1
```

Verify that the new interface names are working correctly and that network functionality is maintained.

## Verification

Confirm predictable network interface naming is working correctly:

```bash
# Verify interface names match configuration
ip -br link

# Check udev rule application
systemctl status systemd-udevd

# Verify network configuration uses correct names
grep -E "(eth0|eth1|spf0|spf1)" /etc/network/interfaces

# Test interface functionality
ping -I eth0 -c 1 8.8.8.8
ethtool spf0 | grep "Link detected"
```

### Expected Output

```bash
Interface verification:
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
eth0             UP             58:47:ca:76:76:fd <BROADCAST,MULTICAST,UP,LOWER_UP>
eth1             DOWN           58:47:ca:76:76:fe <BROADCAST,MULTICAST>
spf0             UP             58:47:ca:76:76:fb <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP>
spf1             UP             58:47:ca:76:76:fb <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP>

Network configuration verification:
auto eth0
iface eth0 inet manual

auto spf0
iface spf0 inet manual
    post-up ethtool -K spf0 tso off

auto spf1
iface spf1 inet manual
    post-up ethtool -K spf1 tso off
```

## Advanced Configuration

### Node-Specific Customization

```bash
# Create node-specific udev rules for different hardware
# For nodes with different network card arrangements

# Node01-05 (Mini PCs with integrated + SFP+)
cat << 'EOF' | sudo tee /etc/udev/rules.d/70-persistent-net.rules
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fd", NAME="eth0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fe", NAME="eth1"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fb", NAME="spf0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="58:47:ca:76:76:fc", NAME="spf1"
EOF

# Node07 (GPU node with different network layout)
cat << 'EOF' | sudo tee /etc/udev/rules.d/70-persistent-net.rules
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="aa:bb:cc:dd:ee:01", NAME="eth0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="aa:bb:cc:dd:ee:02", NAME="eth1"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="aa:bb:cc:dd:ee:03", NAME="nic0"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="aa:bb:cc:dd:ee:04", NAME="nic1"
EOF
```

### Integration with Ansible Automation

```bash
# Template for Ansible deployment
# File: roles/networking/templates/70-persistent-net.rules.j2

{% for interface in network_interfaces %}
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="{{ interface.mac }}", NAME="{{ interface.name }}"
{% endfor %}

# Ansible task to deploy rules
- name: Configure predictable network interface names
  template:
    src: 70-persistent-net.rules.j2
    dest: /etc/udev/rules.d/70-persistent-net.rules
    mode: '0644'
  notify:
    - reload udev rules
    - restart networking
```

## Troubleshooting

**Interface names not changing after udev rule creation:** Verify rule syntax and reload udev:

```bash
# Check udev rule syntax
udevadm test /sys/class/net/enp1s0f0

# Manually reload and trigger rules
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=net --action=add

# Check systemd journal for udev errors
journalctl -u systemd-udevd | grep -i error
```

**Network interfaces disappear after configuration:** Check for conflicting rules and naming:

```bash
# Verify no conflicting systemd naming
systemctl status systemd-networkd

# Check for multiple udev rules files
ls -la /etc/udev/rules.d/*net*

# Verify MAC addresses in rules match hardware
ip link show | grep -E "(ether|link)"
cat /etc/udev/rules.d/70-persistent-net.rules
```

**Inconsistent interface names across reboots:** Ensure udev rules are properly formatted:

```bash
# Test udev rule matching
udevadm test-builtin net_id /sys/class/net/eth0

# Check rule file permissions and syntax
ls -la /etc/udev/rules.d/70-persistent-net.rules
udevadm verify /etc/udev/rules.d/70-persistent-net.rules

# Verify rule loading during boot
journalctl -b | grep -i "70-persistent-net"
```

**Network configuration errors after rename:** Update all references to old names:

```bash
# Find all references to old interface names
grep -r "enp" /etc/
grep -r "eno" /etc/

# Check Proxmox VE configuration
grep -r "enp" /etc/pve/

# Update any remaining configuration files
sudo find /etc -name "*.conf" -o -name "*.cfg" | xargs grep -l "enp1s0f0"
```

**DHCP or static IP issues after rename:** Verify network manager configuration:

```bash
# Check if NetworkManager is managing interfaces
nmcli device status

# Disable NetworkManager for specific interfaces if needed
echo "[keyfile]
unmanaged-devices=interface-name:eth0;interface-name:spf0;interface-name:spf1" | sudo tee /etc/NetworkManager/conf.d/10-unmanaged-devices.conf

# Restart networking services
sudo systemctl restart networking
```

## Related Articles

- [Setting Up LACP Bond Configuration](setup-lacp-bond.md)
- [Proxmox Network Architecture](../../infrastructure/proxmox/cluster-configuration.md)
- [Ansible Network Configuration](../../automation-and-orchestration/ansible-playbook-basics.md)
- [Network Hardware Documentation](../../hardware/networking/README.md)

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-23 |
| **Last Updated** | 2025-07-23 |
| **Version** | 1.0 |

---
Tags: proxmox, networking, udev, predictable-names, interface-naming, automation, enterprise-networking
