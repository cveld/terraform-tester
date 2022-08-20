param(
    [Parameter(Mandatory = $true)]
    [string]
    [ValidateSet("Dev", "Prod")]
    $TestScenario
)

function Test-Environment {
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $EnvironmentPath
    )
    Push-Location -Path $EnvironmentPath
    terraform init
    terraform plan
    Pop-Location
}

switch ($TestScenario) {
    'Dev' { Test-Environment -EnvironmentPath .\Environments\Dev }
    'Prod' { Test-Environment -EnvironmentPath .\Environments\Prod }
    default { Write-Warning -Message "Unknown test scenario '$TestScenario'." -WarningAction Continue }
}