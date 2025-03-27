# Define base directory for Portainer stacks
$baseDir = ".\"

# Define the Portainer nodes and their corresponding application stacks
$portainerNodes = @{
    "lab-apps01-portainer-docker-application-node" = @("gitea", "wikijs", "glpi", "zitadel", "nginx-proxy-manager", "homer", "vault")
    "lab-db01-portainer-docker-database-node" = @("postgresql", "mariadb", "mongodb", "influxdb", "redis", "rabbitmq")
    "proj-apps01-portainer-docker-application-node" = @("gitea", "grafana", "nextcloud", "dashy")
}

# Loop through each Portainer node and create the application directories and files
foreach ($node in $portainerNodes.Keys) {
    $nodePath = Join-Path $baseDir $node
    foreach ($app in $portainerNodes[$node]) {
        $appPath = Join-Path $nodePath $app
        # Create application directory if it doesn't exist
        if (!(Test-Path $appPath)) {
            New-Item -ItemType Directory -Path $appPath -Force | Out-Null
        }
        # Create required files
        New-Item -ItemType File -Path (Join-Path $appPath "docker-compose.yml") -Force | Out-Null
        New-Item -ItemType File -Path (Join-Path $appPath "stack.env.example") -Force | Out-Null
        New-Item -ItemType File -Path (Join-Path $appPath "stack.env") -Force | Out-Null
        New-Item -ItemType File -Path (Join-Path $appPath "README.md") -Force | Out-Null
    }
}

Write-Host "Portainer stack directories and files created successfully."
