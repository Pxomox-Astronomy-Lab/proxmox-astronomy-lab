# Enabling PostgreSQL Extensions

Learn how to enable and configure PostgreSQL extensions to enhance database functionality for astronomical computing, AI/ML workloads, and scientific data analysis.

## Why We Do This

In the Proxmox Astronomy Lab, we leverage PostgreSQL extensions to transform our database servers into specialized scientific computing platforms optimized for astronomical data processing. While standard PostgreSQL provides robust relational database functionality, we implement extension-based enhancements because:

- **Astronomical Computing**: Extensions like q3c provide sphere indexing and coordinate system functions essential for DESI survey data analysis
- **AI/ML Integration**: pgvector enables vector similarity search directly in PostgreSQL, supporting our Ray-based machine learning pipelines
- **Performance Optimization**: Extensions like pg_stat_statements provide detailed query performance metrics for database optimization
- **Scientific Workflow Integration**: Native database functions reduce data movement and improve analysis pipeline performance

This approach is used consistently across proj-pg01 (primary DESI workloads) and pg02 (general project workloads) to provide enterprise-grade astronomical computing capabilities.

## Prerequisites

- PostgreSQL superuser access or user with CREATE EXTENSION privileges
- SSH access to database server or psql client connectivity
- Understanding of extension dependencies and compatibility
- PostgreSQL 12+ (tested with PostgreSQL 16 in our lab environment)

## Step-by-Step Instructions

### Step 1: Connect to PostgreSQL Database

```bash
# Connect to target database as superuser
sudo -u postgres psql -d your_database_name

# Alternative: Connect remotely
psql -h proj-pg01.lab.local -U postgres -d desi_data
```

Connect to the specific database where you want to enable extensions. Extensions are database-specific and must be enabled in each database where they will be used.

### Step 2: Check Available Extensions

```sql
-- List all available extensions in the PostgreSQL installation
SELECT name, default_version, comment 
FROM pg_available_extensions 
ORDER BY name;

-- Check currently installed extensions
SELECT extname, extversion 
FROM pg_extension 
ORDER BY extname;
```

Review available extensions to understand what functionality is accessible. This helps identify which extensions are already installed and what additional capabilities can be enabled.

### Step 3: Enable Core Astronomical Extensions

```sql
-- Enable q3c for spherical coordinate indexing and astronomy functions
CREATE EXTENSION IF NOT EXISTS q3c;

-- Enable pgvector for AI/ML vector operations and similarity search
CREATE EXTENSION IF NOT EXISTS vector;

-- Enable pg_stat_statements for query performance monitoring
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Enable pgcrypto for enhanced security functions
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

Enable the essential extensions for astronomical computing. The `IF NOT EXISTS` clause prevents errors if extensions are already installed, making scripts idempotent.

### Step 4: Configure Extension-Specific Settings

```sql
-- Configure q3c for optimal astronomical coordinate processing
-- (q3c configuration is typically handled automatically)

-- Configure pg_stat_statements tracking
-- Add to postgresql.conf:
-- shared_preload_libraries = 'pg_stat_statements'
-- pg_stat_statements.track = all
-- pg_stat_statements.max = 10000

-- Reset pg_stat_statements data
SELECT pg_stat_statements_reset();
```

Configure extension-specific parameters for optimal performance. Some extensions like pg_stat_statements require postgresql.conf modifications and database restart.

### Step 5: Verify Extension Functionality

```sql
-- Test q3c spherical functions
SELECT q3c_dist(0, 0, 1, 1) AS angular_distance_degrees;

-- Test pgvector functionality (if vector data exists)
SELECT vector_dims('[1,2,3]'::vector) AS vector_dimensions;

-- Verify pg_stat_statements is collecting data
SELECT query, calls, total_time 
FROM pg_stat_statements 
ORDER BY total_time DESC 
LIMIT 5;
```

Verify that extensions are functioning correctly by testing core functionality. This ensures proper installation and identifies any configuration issues.

### Step 6: Create Extension-Specific Database Objects

```sql
-- Example: Create astronomical coordinate index using q3c
-- (Applied to tables with RA/DEC columns)
-- CREATE INDEX idx_coords_q3c ON desi_spectra (q3c_ang2ipix(ra, dec));

-- Example: Create vector index for ML similarity search
-- (Applied to tables with vector columns)
-- CREATE INDEX idx_embeddings_vector ON spectra_embeddings 
-- USING ivfflat (embedding_vector) WITH (lists = 100);

-- Create monitoring view for extension usage
CREATE OR REPLACE VIEW extension_status AS
SELECT 
    extname AS extension_name,
    extversion AS version,
    nspname AS schema_name
FROM pg_extension e
JOIN pg_namespace n ON e.extnamespace = n.oid
ORDER BY extname;
```

Create database objects that leverage extension functionality, such as specialized indexes and monitoring views for operational visibility.

## Verification

Confirm extensions are properly installed and configured:

```bash
# Verify extensions are installed
psql -h proj-pg01.lab.local -U postgres -d desi_data -c "SELECT extname, extversion FROM pg_extension ORDER BY extname;"

# Test q3c astronomical functions
psql -h proj-pg01.lab.local -U postgres -d desi_data -c "SELECT q3c_dist(150.0, 2.0, 150.1, 2.1) AS distance_degrees;"

# Test pgvector functionality
psql -h proj-pg01.lab.local -U postgres -d desi_data -c "SELECT '[1,2,3]'::vector <-> '[1,2,4]'::vector AS euclidean_distance;"
```

### Expected Output

```sql
Extension verification:
   extname    | extversion 
--------------+------------
 pg_stat_statements | 1.9
 pgcrypto     | 1.3
 q3c          | 2.0.1
 vector       | 0.5.1

q3c distance calculation:
 distance_degrees 
------------------
 0.1414213562373095

Vector distance calculation:
 euclidean_distance 
--------------------
 1
```

## Troubleshooting

**Extension does not exist errors:** Verify that the extension package is installed on the system. For Ubuntu/Debian systems, install additional extensions:

```bash
# Install q3c extension
sudo apt-get install postgresql-16-q3c

# Install pgvector extension  
sudo apt-get install postgresql-16-pgvector

# Install additional contrib extensions
sudo apt-get install postgresql-contrib-16
```

**Permission denied errors:** Ensure you have superuser privileges or CREATE privilege on the database:

```sql
-- Check current user privileges
SELECT current_user, session_user;

-- Grant extension creation privileges to user
ALTER USER your_user CREATEDB;
```

**Configuration parameter errors:** Some extensions require postgresql.conf modifications and restart:

```bash
# Edit postgresql.conf
sudo nano /etc/postgresql/16/main/postgresql.conf

# Add required shared_preload_libraries
shared_preload_libraries = 'pg_stat_statements'

# Restart PostgreSQL
sudo systemctl restart postgresql
```

**Extension version conflicts:** Check compatibility between PostgreSQL version and extension versions. Upgrade or downgrade extensions as needed:

```sql
-- Check PostgreSQL version
SELECT version();

-- Upgrade extension to latest version
ALTER EXTENSION q3c UPDATE;
```

## Related Articles

- [Creating PostgreSQL Backup Readonly User](creating-backup-readonly-user.md)
- [Configuring Stats User for Postgres Exporter](configuring-stats-user-postgres-exporter.md)
- [High-Speed PostgreSQL Ingestion](../data-processing-and-pipelines/high-speed-postgresql-ingestion.md)
- [PostgreSQL Security Checklist](postgresql-security-checklist.md)
- [Vector Database Integration](../../ai-and-machine-learning/vector-databases/README.md)

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-23 |
| **Last Updated** | 2025-07-23 |
| **Version** | 1.0 |

---
Tags: postgresql, extensions, q3c, pgvector, astronomy, ai-ml, database-optimization, spherical-coordinates

---
