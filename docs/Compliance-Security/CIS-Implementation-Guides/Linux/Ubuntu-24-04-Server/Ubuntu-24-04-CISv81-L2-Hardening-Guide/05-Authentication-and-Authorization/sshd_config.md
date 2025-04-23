# =============================================================================
# SSHD CONFIGURATION - SECURITY HARDENED
# AUTHOR: VintageDon (https://github.com/vintagedon)
# REPO: https://github.com/vintagedon/proxmox-astronomy-lab
# COMPLIANCE: CIS 5.2.x, NIST AC-17, ISO 27001 A.9.1.2
# LAST UPDATED: 2025-03-16
# =============================================================================
# 
# This configuration implements security controls for SSH server access,
# including strong cryptography, authentication restrictions, session controls,
# and compliance with security benchmarks.
# 
# COVERED CONTROLS:
# - Access restrictions and multi-factor authentication
# - Secure cryptographic settings (ciphers, MACs, key exchange)
# - Session timeout and connection limits
# - Privilege separation and process hardening
# - Audit logging and monitoring integration
# =============================================================================

# -----------------------------------------------------------------------------
# CORE PROTOCOL AND CONNECTIVITY SETTINGS
# -----------------------------------------------------------------------------
# Specify SSH protocol version (only SSH v2 is secure)
Protocol 2

# Network binding settings
Port 22                     # Default SSH port
AddressFamily inet          # Limit to IPv4 only
ListenAddress 0.0.0.0       # Listen on all network interfaces

# Host key configuration
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# -----------------------------------------------------------------------------
# AUTHENTICATION SETTINGS
# -----------------------------------------------------------------------------
# Access control - specify users allowed to connect
AllowUsers crainbramp ansible

# Authentication methods
AuthenticationMethods publickey       # Require key-based authentication
PubkeyAuthentication yes              # Enable public key authentication
PasswordAuthentication no             # Disable password authentication
PermitEmptyPasswords no               # Prohibit empty passwords (CIS 5.2.11)
PermitRootLogin no                    # Disable root login (CIS 5.2.10)

# Hardening against unauthorized access
MaxAuthTries 3                        # Limit auth attempts (CIS 5.2.7)
LoginGraceTime 60                     # Timeout for login (CIS 5.2.17)
MaxStartups 10:30:60                  # Rate-limit connections (CIS 5.2.21)
MaxSessions 5                         # Limit concurrent sessions (CIS 5.2.22)

# -----------------------------------------------------------------------------
# SESSION CONFIGURATION
# -----------------------------------------------------------------------------
# Session timeout settings (CIS 5.2.16)
ClientAliveInterval 300               # Check client every 5 minutes
ClientAliveCountMax 2                 # Disconnect after 2 missed responses

# Security restrictions
StrictModes yes                       # Enforce file permission checking
PermitUserEnvironment no              # Prevent env variable forwarding (CIS 5.2.12)
PermitUserRC no                       # Disable user rc files

# Terminal settings
PermitTTY yes                         # Allow TTY allocation

# -----------------------------------------------------------------------------
# FORWARDING AND TUNNELING RESTRICTIONS
# -----------------------------------------------------------------------------
# Disable unnecessary tunneling (security risk)
X11Forwarding no                      # Disable X11 forwarding (CIS 5.2.6)
AllowAgentForwarding no               # Disable agent forwarding
AllowTcpForwarding no                 # Disable TCP forwarding (CIS 5.2.20)
GatewayPorts no                       # Prevent remote port forwarding

# -----------------------------------------------------------------------------
# CRYPTOGRAPHIC SETTINGS
# -----------------------------------------------------------------------------
# Enforce strong encryption (CIS 5.2.13)
Ciphers aes256-ctr,aes192-ctr,aes128-ctr

# Secure key exchange algorithms (CIS 5.2.15)
KexAlgorithms curve25519-sha256,ecdh-sha2-nistp384,ecdh-sha2-nistp521

# Strong message authentication codes (CIS 5.2.14)
MACs hmac-sha2-512,hmac-sha2-256

# -----------------------------------------------------------------------------
# LOGGING AND MONITORING
# -----------------------------------------------------------------------------
# Comprehensive logging for security monitoring
LogLevel VERBOSE                      # Detailed logging (CIS 5.2.5)

# -----------------------------------------------------------------------------
# ADDITIONAL SECURITY HARDENING
# -----------------------------------------------------------------------------
# Disable insecure authentication methods
IgnoreRhosts yes                      # Disable .rhosts files (CIS 5.2.8)
HostbasedAuthentication no            # Disable host-based auth (CIS 5.2.9)

# Performance and usability
UseDNS no                             # Don't resolve client hostnames

# Pre-login warning message (CIS 5.2.18)
Banner /etc/issue.net                 # Display legal banner

# PAM integration for advanced authentication (CIS 5.2.19)
UsePAM yes                            # Enable PAM support

# -----------------------------------------------------------------------------
# SUBSYSTEM CONFIGURATION
# -----------------------------------------------------------------------------
# Define allowed subsystems
Subsystem sftp /usr/lib/openssh/sftp-server

# -----------------------------------------------------------------------------
# USER-SPECIFIC CONFIGURATIONS
# -----------------------------------------------------------------------------
# Special settings for ansible user
Match User ansible
    PasswordAuthentication no         # Force key-based authentication
    X11Forwarding no                  # No X11 forwarding
    AllowTcpForwarding no             # No TCP forwarding
    # PermitTTY yes needed for ansible functionality