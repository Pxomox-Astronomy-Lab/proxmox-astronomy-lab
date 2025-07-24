# Configuring Stats User for Postgres Exporter

Learn how to create and configure a dedicated monitoring user for postgres_exporter to collect PostgreSQL metrics for Prometheus-based observability infrastructure.

## Why We Do This

In the Proxmox Astronomy Lab, we implement dedicated monitoring users with minimal required permissions for our PostgreSQL observability infrastructure using postgres_exporter. While monitoring could be performed using administrative accounts, we implement this approach because:

- **Security Isolation**: Monitoring processes run with minimal privileges, preventing unauthorized access to sensitive astronomical data during metrics collection
- **Observability Integration**: Dedicated stats user enables seamless integration with our Prometheus/Grafana monitoring stack for database performance analysis
- **Compliance Requirements**: Follows principle of least privilege mandated by CIS Controls v8 and enterprise security frameworks for monitoring systems
- **Operational Visibility**: Provides detailed PostgreSQL metrics for optimizing DESI data processing workloads and scientific computing performance

This pattern is used consistently across proj-pg01 (primary DESI workloads) and pg02 (general project workloads) to provide enterprise-grade database observability for astronomical computing infrastructure.

## Prerequisites

- PostgreSQL superuser access or user with CREATEROLE and GRANT privileges
- Understanding of postgres_exporter deployment and configuration
- Access to PostgreSQL server (proj-pg01 or pg02 in lab environment)
- Prometheus monitoring infrastructure for metrics collection

## Step-by-Step Instructions

### Step 1: Connect to PostgreSQL Database

```bash
# Connect to PostgreSQL server as administrative user
sudo -u postgres psql

# Alternative: Connect remotely to lab database servers
psql -h proj-pg01.lab.local -U postgres -d postgres
```

Connect to the PostgreSQL instance using an account with sufficient privileges to create users and grant system-level access permissions for monitoring.

### Step 2: Create the Monitoring User

```sql
-- Create dedicated postgres_exporter monitoring user
CREATE USER postgres_exporter WITH LOGIN;

-- Set a secure password for the monitoring user
ALTER USER postgres_exporter PASSWORD 'SecureExporterPassword123!';

-- Ensure user cannot create databases or roles
ALTER USER postgres_exporter NOCREATEDB NOCREATEROLE;
```

Create the dedicated monitoring user with login privileges but restricted from creating databases or roles. Use a strong, unique password following organizational security policies.

### Step 3: Grant System Monitoring Permissions

```sql
-- Grant pg_monitor role for comprehensive system metrics access
GRANT pg_monitor TO postgres_exporter;

-- Grant specific permissions for detailed monitoring
GRANT SELECT ON pg_stat_database TO postgres_exporter;
GRANT SELECT ON pg_stat_replication TO postgres_exporter;
GRANT SELECT ON pg_stat_user_tables TO postgres_exporter;
GRANT SELECT ON pg_stat_user_indexes TO postgres_exporter;
```

Grant the pg_monitor role which provides read access to various statistics views. This role was introduced in PostgreSQL 10+ and provides appropriate permissions for monitoring tools.

### Step 4: Enable Extended Monitoring Capabilities

```sql
-- Grant access to pg_stat_statements for query performance monitoring
GRANT SELECT ON pg_stat_statements TO postgres_exporter;

-- Grant access to system administration functions (read-only)
GRANT EXECUTE ON FUNCTION pg_ls_dir(text) TO postgres_exporter;
GRANT EXECUTE ON FUNCTION pg_read_file(text) TO postgres_exporter;

-- Grant access to database size and statistics functions
GRANT EXECUTE ON FUNCTION pg_database_size(name) TO postgres_exporter;
GRANT EXECUTE ON FUNCTION pg_total_relation_size(regclass) TO postgres_exporter;
```

Provide access to extended monitoring functions that postgres_exporter uses to collect detailed database metrics, including query statistics and storage utilization.

### Step 5: Configure Connection Restrictions

```sql
-- Limit concurrent connections for monitoring user
ALTER USER postgres_exporter CONNECTION LIMIT 5;

-- Create or verify monitoring database exists
CREATE DATABASE postgres_exporter_db WITH OWNER postgres_exporter;

-- Grant connect permissions to monitoring database
GRANT CONNECT ON DATABASE postgres_exporter_db TO postgres_exporter;
```

Configure connection limits and create a dedicated database for monitoring operations if required by your postgres_exporter configuration.

### Step 6: Verify Monitoring Permissions

```sql
-- Check granted roles and permissions
SELECT 
    r.rolname as role_name,
    r.rolcanlogin as can_login,
    r.rolconnlimit as connection_limit,
    array_agg(m.rolname) as member_of_roles
FROM pg_roles r
LEFT JOIN pg_auth_members am ON r.oid = am.member
LEFT JOIN pg_roles m ON am.roleid = m.oid
WHERE r.rolname = 'postgres_exporter'
GROUP BY r.rolname, r.rolcanlogin, r.rolconnlimit;

-- Verify access to key monitoring views
\c postgres postgres_exporter
SELECT count(*) FROM pg_stat_database;
SELECT count(*) FROM pg_stat_user_tables;
```

Verify that the monitoring user has appropriate permissions and can access the required system views for metrics collection.

## Verification

Test the postgres_exporter user configuration and database connectivity:

```bash
# Test database connection with monitoring user
psql -h proj-pg01.lab.local -U postgres_exporter -d postgres -c "SELECT current_user, current_database();"

# Verify access to monitoring views
psql -h proj-pg01.lab.local -U postgres_exporter -d postgres -c "SELECT datname, numbackends, xact_commit FROM pg_stat_database LIMIT 5;"

# Test extended monitoring functions
psql -h proj-pg01.lab.local -U postgres_exporter -d postgres -c "SELECT pg_database_size('postgres') AS database_size_bytes;"
```

### Expected Output

```sql
Connection verification:
 current_user     | current_database 
------------------+------------------
 postgres_exporter | postgres

Database statistics access:
  datname  | numbackends | xact_commit 
-----------+-------------+-------------
 postgres  |           1 |        1234
 desi_data |           0 |         567
 template1 |           0 |           0

Database size function:
 database_size_bytes 
--------------------
            8876543
```

## Configuration for postgres_exporter

Configure postgres_exporter to use the monitoring user:

```bash
# Create postgres_exporter configuration file
sudo mkdir -p /etc/postgres_exporter
sudo tee /etc/postgres_exporter/postgres_exporter.env << EOF
# PostgreSQL connection configuration
DATA_SOURCE_NAME="postgresql://postgres_exporter:SecureExporterPassword123!@proj-pg01.lab.local:5432/postgres?sslmode=require"

# Enable extended metrics collection
PG_EXPORTER_EXTEND_QUERY_PATH="/etc/postgres_exporter/queries.yaml"
PG_EXPORTER_INCLUDE_DATABASES="postgres,desi_data,cosmic_voids"
PG_EXPORTER_AUTO_DISCOVER_DATABASES=true

# Disable default metrics that require superuser access
PG_EXPORTER_DISABLE_DEFAULT_METRICS=false
EOF
```

Configure postgres_exporter with the monitoring user credentials and appropriate database targets for the astronomical computing environment.

## Troubleshooting

**Permission denied errors:** Ensure the pg_monitor role is granted and the user has appropriate access:

```sql
-- Check if pg_monitor role exists (PostgreSQL 10+)
SELECT rolname FROM pg_roles WHERE rolname = 'pg_monitor';

-- If pg_monitor doesn't exist, grant individual permissions
GRANT SELECT ON pg_stat_activity TO postgres_exporter;
GRANT SELECT ON pg_stat_bgwriter TO postgres_exporter;
GRANT SELECT ON pg_stat_archiver TO postgres_exporter;
```

**Connection authentication failed:** Verify pg_hba.conf allows connections from monitoring systems:

```bash
# Check pg_hba.conf for monitoring user access
sudo grep postgres_exporter /etc/postgresql/16/main/pg_hba.conf

# Add entry if missing (example for local monitoring)
echo "host all postgres_exporter 10.25.20.0/24 md5" | sudo tee -a /etc/postgresql/16/main/pg_hba.conf
sudo systemctl reload postgresql
```

**Missing pg_stat_statements data:** Ensure the extension is enabled and configured:

```sql
-- Check if pg_stat_statements is installed
SELECT extname FROM pg_extension WHERE extname = 'pg_stat_statements';

-- Verify postgresql.conf has required settings
-- shared_preload_libraries = 'pg_stat_statements'
-- pg_stat_statements.track = all
```

**Metrics collection failures:** Check postgres_exporter logs and connectivity:

```bash
# Test postgres_exporter connectivity
curl -s http://localhost:9187/metrics | grep pg_up

# Check postgres_exporter service logs
sudo journalctl -u postgres_exporter -f

# Verify database connectivity from exporter host
pg_isready -h proj-pg01.lab.local -p 5432 -U postgres_exporter
```

## Related Articles

- [Creating PostgreSQL Backup Readonly User](creating-backup-readonly-user.md)
- [Enabling PostgreSQL Extensions](enabling-postgresql-extensions.md)
- [PostgreSQL Security Checklist](postgresql-security-checklist.md)
- [High-Speed PostgreSQL Ingestion](../data-processing-and-pipelines/high-speed-postgresql-ingestion.md)
- [Prometheus Monitoring Setup](../../monitoring/prometheus-setup.md)

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-23 |
| **Last Updated** | 2025-07-23 |
| **Version** | 1.0 |

---
Tags: postgresql, monitoring, prometheus, postgres-exporter, observability, metrics, database-monitoring, pg-monitor

---
