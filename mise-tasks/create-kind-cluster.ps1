#MISE description="Create kind cluster"
param (
    [string]$ClusterName = "datalake",
    [string]$ConfigFile = "kind.yaml",
    [int]$Timeout = 120,
    [string]$KubeconfigFile = ".secrets/${ClusterName}-kubeconfig"
)

$ErrorActionPreference = "Stop"

# Check if the cluster already exists
$existingClusters = kind get clusters
if ($existingClusters -contains $ClusterName) {
    Write-Host "Kind cluster '$ClusterName' already exists. Skipping creation."
} else {
    Write-Host "Creating kind cluster '$ClusterName'..."
    kind create cluster --name "$ClusterName" --config "$ConfigFile"
    Write-Host "Kind cluster '$ClusterName' created!"
}

# Ensure directory exists
$kubeconfigDir = Split-Path -Parent $KubeconfigFile
if (-not (Test-Path -Path $kubeconfigDir)) {
    New-Item -ItemType Directory -Path $kubeconfigDir | Out-Null
}

Write-Host "Exporting kubeconfig to $KubeconfigFile"
kind get kubeconfig --name "$ClusterName" | Out-File -FilePath $KubeconfigFile -Encoding ASCII

$env:KUBECONFIG = $KubeconfigFile

Write-Host "Waiting for all nodes to be Ready..."
$endTime = (Get-Date).AddSeconds($Timeout)

while ($true) {
    $notReadyNodes = kubectl get nodes --no-headers 2>$null | Where-Object { $_ -notmatch 'Ready' }
    
    if (-not $notReadyNodes) {
        Write-Host "All nodes are Ready!"
        break
    }
    
    if ((Get-Date) -ge $endTime) {
        Write-Host "Timeout waiting for nodes to be Ready."
        kubectl get nodes
        exit 1
    }
    
    Start-Sleep -Seconds 2
}
