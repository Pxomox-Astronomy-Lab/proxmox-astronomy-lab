# Creating PostgreSQL Backup Readonly User

Learn how to create a dedicated readonly database user specifically for backup operations in PostgreSQL, ensuring secure automated backups without granting unnecessary permissions.

## Why We Do This

In the Proxmox Astronomy Lab, we implement dedicated backup users with minimal required permissions for our PostgreSQL database infrastructure. While backup operations could be performed using administrative accounts or the postgres superuser, we implement this approach because:

- **Security Isolation**: Backup processes run with minimal privileges, reducing attack surface and limiting potential impact of credential compromise
- **Audit Trail Clarity**: Dedicated backup user creates clear audit trails for backup-related database access distinct from administrative operations
- **Automated Operations**: Service accounts with readonly permissions enable secure automated backup workflows without human intervention
- **Compliance Alignment**: Follows principle of least privilege required by CIS Controls v8 and enterprise security frameworks

This pattern is used consistently across our PostgreSQL infrastructure including proj-pg01 (primary project workloads) and pg02 (general project workloads) for enterprise-grade backup operations.

## Prerequisites

- Administrative access to PostgreSQL server (superuser or user with CREATEROLE privileges)
- SSH access to the database server or psql client connectivity
- Basic understanding of PostgreSQL user management and permissions
- PostgreSQL 12+ (tested with PostgreSQL 16 in our lab environment)

## Step-by-Step Instructions

### Step 1: Connect to PostgreSQL as Administrator

```bash
# Connect to PostgreSQL using administrative account
sudo -u postgres psql

# Alternative: Connect remotely if configured
psql -h proj-pg01.lab.local -U postgres -d postgres
```

Connect to the PostgreSQL instance using an account with sufficient privileges to create users and grant permissions. In our lab environment, this is typically the postgres superuser account.

### Step 2: Create the Backup User Account

```sql
-- Create dedicated backup user with login capability
CREATE USER backup_readonly WITH LOGIN;

-- Set a secure password (replace with strong password)
ALTER USER backup_readonly PASSWORD 'SecureBackupPassword123!';
```

Create the dedicated backup user account with login privileges. Use a strong, unique password that follows your organization's password policy. This user will be used exclusively for backup operations.

### Step 3: Grant Database Connection Permissions

```sql
-- Grant connect privilege to specific databases
GRANT CONNECT ON DATABASE your_database_name TO backup_readonly;

-- For multiple databases, repeat for each database
GRANT CONNECT ON DATABASE desi_data TO backup_readonly;
GRANT CONNECT ON DATABASE cosmic_voids TO backup_readonly;

-- Alternative: Grant connect to all databases (use with caution)
GRANT CONNECT ON DATABASE postgres TO backup_readonly;
```

Grant the backup user permission to connect to the specific databases you need to backup. Replace `your_database_name` with the actual database names in your environment.

### Step 4: Grant Schema-Level Permissions

```sql
-- Connect to target database first
\c your_database_name

-- Grant usage on schemas
GRANT USAGE ON SCHEMA public TO backup_readonly;
GRANT USAGE ON SCHEMA astronomy_data TO backup_readonly;

-- Grant select permissions on all current tables
GRANT SELECT ON ALL TABLES IN SCHEMA public TO backup_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA astronomy_data TO backup_readonly;

-- Grant select permissions on future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO backup_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA astronomy_data GRANT SELECT ON TABLES TO backup_readonly;
```

Grant the necessary schema and table permissions. The user needs USAGE on schemas and SELECT on tables to read data for backup operations. The default privileges ensure future tables are automatically accessible.

### Step 5: Grant Sequence Access (for Complete Backups)

```sql
-- Grant usage on sequences for complete backup capability
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO backup_readonly;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA astronomy_data TO backup_readonly;

-- Grant usage on future sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO backup_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA astronomy_data GRANT USAGE ON SEQUENCES TO backup_readonly;
```

Grant sequence access to ensure pg_dump can capture sequence current values, which are necessary for complete database restoration.

### Step 6: Configure Connection Restrictions (Optional)

```sql
-- Create or modify user with connection restrictions
ALTER USER backup_readonly CONNECTION LIMIT 3;

-- Set allowed connection source (requires pg_hba.conf configuration)
-- This is handled in pg_hba.conf, not in SQL
```

Optionally restrict the number of concurrent connections for the backup user to prevent resource exhaustion during backup operations.

## Verification

Verify the backup user can successfully access database content for backup operations:

```bash
# Test database connection
psql -h proj-pg01.lab.local -U backup_readonly -d your_database_name -c "SELECT 1;"

# Test table access
psql -h proj-pg01.lab.local -U backup_readonly -d your_database_name -c "SELECT count(*) FROM pg_tables;"

# Test backup operation
pg_dump -h proj-pg01.lab.local -U backup_readonly -d your_database_name --schema-only > test_backup.sql
```

Successful output should show connection established, table count returned, and schema backup file created without errors.

### Expected Output

```sql
Connection successful:
 ?column? 
----------
        1
(1 row)

Table count:
 count 
-------
    15
(1 row)

Backup file created successfully with schema definitions
```

## Troubleshooting

**Permission denied for relation errors:** Ensure GRANT SELECT has been applied to all necessary schemas and tables. Check that you connected to the correct database when granting permissions.

```sql
-- Check current permissions
SELECT grantee, privilege_type, table_schema, table_name 
FROM information_schema.role_table_grants 
WHERE grantee = 'backup_readonly';
```

**Connection authentication failed:** Verify the password is correct and that pg_hba.conf allows connections from the backup user's source IP address.

**Role does not exist errors:** Ensure the backup_readonly user was created successfully by checking pg_roles:

```sql
SELECT rolname, rolcanlogin, rolconnlimit FROM pg_roles WHERE rolname = 'backup_readonly';
```

## Related Articles

- [PostgreSQL Security Checklist](postgresql-security-checklist.md)
- [Configuring Stats User for Postgres Exporter](configuring-stats-user-postgres-exporter.md)
- [High-Speed PostgreSQL Ingestion](../data-processing-and-pipelines/high-speed-postgresql-ingestion.md)
- [Managing Iperius Database Backups](../backups/managing-iperius-database-backups.md)

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-23 |
| **Last Updated** | 2025-07-23 |
| **Version** | 1.0 |

---
Tags: postgresql, backup, security, database-administration, readonly-user, cis-controls

---
