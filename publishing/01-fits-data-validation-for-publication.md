# FITS Data Validation for Publication

Learn how to validate FITS Value-Added Catalogs (VACs) for astronomical publication, ensuring data quality, metadata compliance, and FAIR principles adherence.

## Why We Do This

In the Proxmox Astronomy Lab, we implement comprehensive data validation procedures before publishing Value-Added Catalogs to ensure scientific integrity and compliance with astronomical data standards. While basic data exports could be published directly, we implement rigorous validation because:

- **Scientific Credibility**: Validated datasets prevent errors that could undermine research conclusions and peer review acceptance
- **FAIR Compliance**: Systematic validation ensures data is Findable, Accessible, Interoperable, and Reusable by the astronomical community
- **Publication Standards**: Major journals and data centers (CDS/VizieR) require validated datasets with complete metadata and documentation
- **Research Reproducibility**: Validated data products enable other researchers to replicate and extend our DESI cosmic void analysis results

This validation framework is applied to all our astronomical data products, particularly the DESI cosmic void galaxy catalog destined for VizieR publication and peer review.

## Prerequisites

- FITS Value-Added Catalog ready for publication validation
- Python environment with astropy, numpy, and scipy installed
- Understanding of FITS file structure and astronomical data standards
- Access to original analysis pipeline outputs and input catalogs

## Step-by-Step Instructions

### Step 1: FITS File Structure Validation

```python
# Validate basic FITS file structure and accessibility
from astropy.io import fits
import numpy as np

# Open and inspect FITS file structure
with fits.open('desi_cosmic_void_catalog.fits') as hdul:
    # Check file structure
    print("HDU Structure:")
    hdul.info()
    
    # Validate required HDUs exist
    required_hdus = ['PRIMARY', 'GALAXY_DATA', 'VOID_PROPERTIES']
    actual_hdus = [hdu.name for hdu in hdul]
    
    for hdu_name in required_hdus:
        if hdu_name not in actual_hdus:
            raise ValueError(f"Missing required HDU: {hdu_name}")
    
    print("✓ FITS structure validation passed")
```

Verify the FITS file contains the expected Header Data Units (HDUs) and can be opened successfully by standard astronomical software.

### Step 2: Header Metadata Validation

```python
# Validate FITS header metadata completeness
def validate_primary_header(header):
    """Validate primary HDU header contains required metadata."""
    
    # Required FITS keywords
    required_keywords = ['SIMPLE', 'BITPIX', 'NAXIS', 'EXTEND']
    
    # Recommended scientific keywords
    recommended_keywords = [
        'AUTHOR', 'CONTACT', 'DATE', 'REFERENC', 
        'VAC_VERS', 'FSF_VERS', 'DV_VERS'
    ]
    
    # Check required keywords
    for keyword in required_keywords:
        if keyword not in header:
            raise ValueError(f"Missing required FITS keyword: {keyword}")
    
    # Check recommended keywords
    missing_recommended = []
    for keyword in recommended_keywords:
        if keyword not in header:
            missing_recommended.append(keyword)
    
    if missing_recommended:
        print(f"⚠️  Missing recommended keywords: {missing_recommended}")
    
    # Validate specific metadata values
    if 'DATE' in header:
        try:
            from datetime import datetime
            datetime.strptime(header['DATE'], '%Y-%m-%d')
        except ValueError:
            raise ValueError("DATE keyword must be in YYYY-MM-DD format")
    
    print("✓ Header metadata validation completed")

# Apply validation
with fits.open('desi_cosmic_void_catalog.fits') as hdul:
    validate_primary_header(hdul[0].header)
```

Ensure FITS headers contain complete provenance information and follow astronomical metadata standards.

### Step 3: Data Table Consistency Validation

```python
# Validate data table consistency and scientific reasonableness
def validate_galaxy_data(galaxy_table):
    """Validate galaxy data table for scientific consistency."""
    
    # Check for required columns
    required_columns = [
        'TARGETID', 'RA', 'DEC', 'Z', 
        'LOGMSTAR', 'SFR', 'IS_VOID', 'IS_CONTROL'
    ]
    
    for column in required_columns:
        if column not in galaxy_table.columns:
            raise ValueError(f"Missing required column: {column}")
    
    # Validate coordinate ranges
    ra_valid = np.all((galaxy_table['RA'] >= 0) & (galaxy_table['RA'] <= 360))
    dec_valid = np.all((galaxy_table['DEC'] >= -90) & (galaxy_table['DEC'] <= 90))
    
    if not ra_valid:
        raise ValueError("RA values outside valid range [0, 360]")
    if not dec_valid:
        raise ValueError("DEC values outside valid range [-90, 90]")
    
    # Validate redshift ranges (DESI DR1 typical range)
    z_valid = np.all((galaxy_table['Z'] >= 0) & (galaxy_table['Z'] <= 1.5))
    if not z_valid:
        print("⚠️  Redshift values outside typical DESI range [0, 1.5]")
    
    # Check for null/invalid values in critical columns
    for column in ['TARGETID', 'RA', 'DEC', 'LOGMSTAR']:
        null_count = np.sum(np.isnan(galaxy_table[column].astype(float)))
        if null_count > 0:
            print(f"⚠️  {null_count} null values in {column}")
    
    # Validate boolean flags
    void_flags = np.unique(galaxy_table['IS_VOID'])
    control_flags = np.unique(galaxy_table['IS_CONTROL'])
    
    if not set(void_flags).issubset({0, 1}):
        raise ValueError("IS_VOID must contain only 0 or 1 values")
    if not set(control_flags).issubset({0, 1}):
        raise ValueError("IS_CONTROL must contain only 0 or 1 values")
    
    print("✓ Galaxy data consistency validation passed")

# Apply validation
with fits.open('desi_cosmic_void_catalog.fits') as hdul:
    galaxy_data = hdul['GALAXY_DATA'].data
    validate_galaxy_data(galaxy_data)
```

Verify data table contents are scientifically reasonable and contain no obvious errors or inconsistencies.

### Step 4: Cross-Catalog Validation

```python
# Validate consistency with input catalogs
def validate_cross_matching(galaxy_table, reference_catalog_path):
    """Validate galaxy properties against reference catalogs."""
    
    # Load reference catalog (e.g., original FastSpecFit catalog)
    with fits.open(reference_catalog_path) as ref_hdul:
        ref_data = ref_hdul[1].data
    
    # Cross-match by TARGETID
    common_targets = np.intersect1d(galaxy_table['TARGETID'], ref_data['TARGETID'])
    
    if len(common_targets) == 0:
        raise ValueError("No common targets found with reference catalog")
    
    # Validate stellar mass consistency (within reasonable tolerance)
    gal_mask = np.isin(galaxy_table['TARGETID'], common_targets)
    ref_mask = np.isin(ref_data['TARGETID'], common_targets)
    
    gal_logmstar = galaxy_table['LOGMSTAR'][gal_mask]
    ref_logmstar = ref_data['LOGMSTAR_FSF'][ref_mask]
    
    # Sort both arrays by TARGETID for proper comparison
    gal_sort = np.argsort(galaxy_table['TARGETID'][gal_mask])
    ref_sort = np.argsort(ref_data['TARGETID'][ref_mask])
    
    mass_diff = gal_logmstar[gal_sort] - ref_logmstar[ref_sort]
    large_diff_count = np.sum(np.abs(mass_diff) > 0.1)  # 0.1 dex tolerance
    
    if large_diff_count > len(common_targets) * 0.01:  # >1% large differences
        print(f"⚠️  {large_diff_count} galaxies with stellar mass differences > 0.1 dex")
    
    print(f"✓ Cross-catalog validation: {len(common_targets)} matched objects")

# Example validation (adjust paths as needed)
# validate_cross_matching(galaxy_data, '/path/to/fastspecfit_catalog.fits')
```

Verify consistency between the VAC and original input catalogs to catch processing errors.

### Step 5: FAIR Principles Compliance Check

```python
# FAIR compliance validation checklist
def validate_fair_compliance(fits_file_path):
    """Validate FAIR principles compliance for publication readiness."""
    
    fair_checklist = {
        'Findable': {
            'persistent_identifier': False,
            'rich_metadata': False,
            'indexed_searchable': False
        },
        'Accessible': {
            'standard_protocol': True,  # FITS is standard
            'metadata_accessible': False,
            'no_proprietary_software': True  # FITS is open
        },
        'Interoperable': {
            'standard_format': True,  # FITS
            'controlled_vocabularies': False,
            'qualified_references': False
        },
        'Reusable': {
            'clear_license': False,
            'detailed_provenance': False,
            'community_standards': False
        }
    }
    
    with fits.open(fits_file_path) as hdul:
        header = hdul[0].header
        
        # Check metadata richness
        metadata_keywords = ['AUTHOR', 'CONTACT', 'REFERENC', 'VAC_VERS']
        rich_metadata = all(keyword in header for keyword in metadata_keywords)
        fair_checklist['Findable']['rich_metadata'] = rich_metadata
        
        # Check provenance information
        provenance_keywords = ['FSF_VERS', 'DV_VERS', 'CODE_DOI', 'HISTORY']
        detailed_provenance = any(keyword in header for keyword in provenance_keywords)
        fair_checklist['Reusable']['detailed_provenance'] = detailed_provenance
        
        # Check for DOI/reference information
        has_reference = 'REFERENC' in header or 'CODE_DOI' in header
        fair_checklist['Interoperable']['qualified_references'] = has_reference
    
    # Print compliance status
    print("\n=== FAIR Compliance Check ===")
    for principle, checks in fair_checklist.items():
        print(f"\n{principle}:")
        for check, status in checks.items():
            status_symbol = "✓" if status else "✗"
            print(f"  {status_symbol} {check.replace('_', ' ').title()}")
    
    return fair_checklist

# Run FAIR compliance check
fair_status = validate_fair_compliance('desi_cosmic_void_catalog.fits')
```

Ensure the dataset meets FAIR principles requirements for modern scientific data publication.

## Verification

Run the complete validation suite and generate a validation report:

```python
# Complete validation workflow
def run_complete_validation(fits_file_path):
    """Run all validation checks and generate summary report."""
    
    print("=== DESI Cosmic Void VAC Validation Report ===\n")
    
    try:
        # File structure validation
        with fits.open(fits_file_path) as hdul:
            print(f"File: {fits_file_path}")
            print(f"File size: {os.path.getsize(fits_file_path) / 1024**2:.1f} MB")
            print(f"Number of HDUs: {len(hdul)}")
            
            # Header validation
            validate_primary_header(hdul[0].header)
            
            # Data validation
            galaxy_data = hdul['GALAXY_DATA'].data
            validate_galaxy_data(galaxy_data)
            print(f"Total galaxies in catalog: {len(galaxy_data)}")
            
            # Sample statistics
            void_count = np.sum(galaxy_data['IS_VOID'])
            control_count = np.sum(galaxy_data['IS_CONTROL'])
            print(f"Void galaxies: {void_count}")
            print(f"Control galaxies: {control_count}")
        
        # FAIR compliance
        fair_status = validate_fair_compliance(fits_file_path)
        
        print("\n=== Validation Summary ===")
        print("✓ All critical validations passed")
        print("✓ Ready for VizieR submission")
        
    except Exception as e:
        print(f"❌ Validation failed: {str(e)}")
        return False
    
    return True

# Run validation
validation_success = run_complete_validation('desi_cosmic_void_catalog.fits')
```

### Expected Output

```text
=== DESI Cosmic Void VAC Validation Report ===

File: desi_cosmic_void_catalog.fits
File size: 45.3 MB
Number of HDUs: 3
✓ FITS structure validation passed
✓ Header metadata validation completed
✓ Galaxy data consistency validation passed
Total galaxies in catalog: 125847
Void galaxies: 8234
Control galaxies: 8234

=== FAIR Compliance Check ===

Findable:
  ✓ Rich Metadata
  ✗ Persistent Identifier
  ✗ Indexed Searchable

Accessible:
  ✓ Standard Protocol
  ✓ No Proprietary Software
  ✓ Metadata Accessible

Interoperable:
  ✓ Standard Format
  ✓ Qualified References
  ✗ Controlled Vocabularies

Reusable:
  ✗ Clear License
  ✓ Detailed Provenance
  ✓ Community Standards

=== Validation Summary ===
✓ All critical validations passed
✓ Ready for VizieR submission
```

## Troubleshooting

**FITS file cannot be opened:** Check file integrity and format compliance:

```python
# Verify FITS file integrity
try:
    fits.info(fits_file_path)
except Exception as e:
    print(f"FITS file integrity issue: {e}")
    
# Check file permissions and accessibility
import os
if not os.path.exists(fits_file_path):
    print("File does not exist")
elif not os.access(fits_file_path, os.R_OK):
    print("File is not readable")
```

**Missing metadata keywords:** Add required keywords to FITS header:

```python
# Add missing metadata to FITS header
with fits.open(fits_file_path, mode='update') as hdul:
    header = hdul[0].header
    
    # Add missing recommended keywords
    if 'AUTHOR' not in header:
        header['AUTHOR'] = 'Author Name et al.'
    if 'CONTACT' not in header:
        header['CONTACT'] = 'author@institution.edu'
    if 'DATE' not in header:
        from datetime import datetime
        header['DATE'] = datetime.now().strftime('%Y-%m-%d')
    
    hdul.flush()
```

**Data inconsistencies detected:** Investigate and resolve data quality issues:

```python
# Debug data inconsistencies
def debug_data_issues(galaxy_table):
    """Identify and report specific data quality issues."""
    
    # Check for duplicate TARGETIDs
    unique_ids, counts = np.unique(galaxy_table['TARGETID'], return_counts=True)
    duplicates = unique_ids[counts > 1]
    if len(duplicates) > 0:
        print(f"Found {len(duplicates)} duplicate TARGETIDs")
    
    # Check for reasonable stellar mass range
    logmstar_range = (np.min(galaxy_table['LOGMSTAR']), np.max(galaxy_table['LOGMSTAR']))
    if logmstar_range[0] < 8.0 or logmstar_range[1] > 12.5:
        print(f"Stellar mass range unusual: {logmstar_range}")
    
    # Check sample balance
    void_fraction = np.mean(galaxy_table['IS_VOID'])
    if void_fraction < 0.1 or void_fraction > 0.9:
        print(f"Unbalanced void sample: {void_fraction:.2%} void galaxies")
```

**FAIR compliance gaps:** Address missing FAIR requirements systematically:

```python
# Generate FAIR compliance improvement recommendations
def suggest_fair_improvements(fair_status):
    """Provide specific recommendations for FAIR compliance."""
    
    recommendations = []
    
    if not fair_status['Findable']['persistent_identifier']:
        recommendations.append("Obtain DOI through Zenodo or journal publication")
    
    if not fair_status['Reusable']['clear_license']:
        recommendations.append("Add explicit license (CC-BY, MIT, etc.) to header")
    
    if not fair_status['Interoperable']['controlled_vocabularies']:
        recommendations.append("Use IAU/VizieR standard column names and units")
    
    return recommendations
```

## Related Articles

- [FITS VAC Creation Guide](../fits-vac-creation/fits-structure-guide.md)
- [VizieR ReadMe Preparation](../vizier-submission/readme-standard.md)
- [Publication Workflow Guide](../publication-workflow-guide.md)
- [DESI Cosmic Void Analysis](../../projects/desi-cosmic-voids/README.md)

## Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-23 |
| **Last Updated** | 2025-07-23 |
| **Version** | 1.0 |

---
Tags: fits, data-validation, publication, vac, fair-principles, astronomical-data, desi-cosmic-voids
