# Script to wrap markdown metadata blocks in HTML comments
# Run from the root directory of your repository

# Find all .md files recursively
$mdFiles = Get-ChildItem -Path . -Filter "*.md" -Recurse -File

foreach ($file in $mdFiles) {
    Write-Host "Processing: $($file.FullName)"
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if the file starts with a metadata block
    if ($content -match "(?s)^---\r?\n(.*?)\r?\n---\r?\n") {
        $metadataBlock = $Matches[0]
        $metadataContent = $Matches[1]
        
        # Make sure the metadata block contains a title field
        if ($metadataContent -match "title:") {
            # Create the new content with HTML comments around the metadata
            $newContent = $content -replace [regex]::Escape($metadataBlock), "<!-- $metadataBlock -->`r`n"
            
            # Write the modified content back to the file
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "  Modified metadata block in $($file.FullName)" -ForegroundColor Green
        } else {
            Write-Host "  Metadata block found but no title field in $($file.FullName)" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  No metadata block found in $($file.FullName)" -ForegroundColor Yellow
    }
}

Write-Host "Processing complete." -ForegroundColor Green