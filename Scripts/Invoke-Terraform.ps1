param(
    [Parameter(Mandatory = $true)]
    [string]
    [ValidateSet("Apply", "Init", "Console", "Plan", "State")]
    $Command,
    [switch]
    $Refresh
)

class TerraformCliException : Exception {
    [string] $ErrorRecord
    [int32] $LastExitCode

    TerraformCliException($Message, $ErrorRecord, $LastExitCode) : base($Message) {
        $this.ErrorRecord = $ErrorRecord
        $this.LastExitCode = $LastExitCode
    }
}

function Invoke-TerraformCli {
    $allArgs = $PsBoundParameters.Values + $args
    # The default stderr encoding in PowerShell is ibm850, which erroreously converts special chars in Terraform cli output
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    terraform $allArgs 2>&1 | Tee-Object -Variable allOutput
    $stderr = $allOutput | Where-Object { $_ -is [System.Management.Automation.ErrorRecord] }
    $stdout = $allOutput | Where-Object { $_ -isnot [System.Management.Automation.ErrorRecord] }
    if ($LASTEXITCODE -ne 0) {
        throw [TerraformCliException]::new(
            "Terraform cli errored with code $LastExitCode`: $stderr",
            $stderr,
            $LastExitCode
        )
    }
}

function Tee-ObjectNoColor {
    [CmdletBinding()]
    Param(
        [Parameter(Position=0, Mandatory=$false, ValueFromPipeline=$true)]
        [string]$InputObject,

        [Parameter(Position=1, Mandatory=$true)]
        [string]$FilePath
    )

    begin {
        Remove-Item -Path $FilePath -ErrorAction SilentlyContinue
    }

    process {
        $cleanedObject = $InputObject -replace "`e\[\d+(;\d+)?m"
        $cleanedObject | Out-File $FilePath -Append
        $InputObject | Out-Host
    }
}

function Invoke-TerraformPlan {
    if ($Refresh) {
        Invoke-TerraformCli plan -out terraform.plan | Tee-ObjectNoColor -FilePath terraform.plan.out
    } else {
        Invoke-TerraformCli plan -out terraform.plan -refresh=false | Tee-ObjectNoColor -FilePath terraform.plan.out
    }
}

switch ($Command) {
    'Apply' { terraform apply terraform.plan }
    'Console' { Invoke-TerraformCli console }
    'Init' { Invoke-TerraformCli init -backend-config="backend.cfg" }
    'Plan' { Invoke-TerraformPlan }
    'State' { Invoke-TerraformCli show -json | ConvertFrom-Json }
    default { Write-Warning -Message "Unknown command '$Command'." -WarningAction Continue }
}