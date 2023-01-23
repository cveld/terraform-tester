param(
    [Parameter(Mandatory = $true)]
    [string]
    [ValidateSet("Dev", "Prod")]
    $Environment,
    [Parameter(Mandatory = $true)]
    [string]
    [ValidateSet("azure-storageaccount-firewall-whitelist-example", "optional-key-value-pair-example", "shared-module-configuration-example")]
    $Example,
    [Parameter(Mandatory = $true)]
    [string]
    [ValidateSet("init", "plan")]
    $Command
)

function Test-Environment {
    $environmentPath = "$here\..\Examples\$Example\Environments\$Environment"
    Push-Location -Path $environmentPath
    
    try {
    . $here\..\Scripts\Invoke-Terraform.ps1 -Command $Command
    } finally {
        Pop-Location
    }
}

$here = Split-Path $MyInvocation.MyCommand.Path -Parent

$ErrorActionPreference = 'Stop'
Test-Environment