<#
.SYNOPSIS
    Checks if the SuppressionPolicy registry value is set to 4096 across multiple file-type 
    runasuser paths and fixes it if any are missing or incorrect to enforce the required policy.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-21
    Last Modified   : 2026-03-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000039

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

$paths = @(
    "HKLM:\SOFTWARE\Classes\batfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\cmdfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\exefile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\mscfile\shell\runasuser"
)

$valueName = "SuppressionPolicy"
$expectedValue = 4096

foreach ($regPath in $paths) {

    # Ensure registry path exists
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    try {
        $currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction Stop | Select-Object -ExpandProperty $valueName

        if ($currentValue -eq $expectedValue) {
            Write-Output "Compliant: $valueName is set to $expectedValue at $regPath."
        }
        else {
            Write-Output "Non-compliant: $valueName is set to $currentValue at $regPath. Remediating..."
            Set-ItemProperty -Path $regPath -Name $valueName -Value $expectedValue -Type DWord
            Write-Output "Remediated: $valueName is now set to $expectedValue at $regPath."
        }
    }
    catch {
        Write-Output "Non-compliant: $valueName does not exist at $regPath. Creating and setting value..."
        New-ItemProperty -Path $regPath -Name $valueName -Value $expectedValue -PropertyType DWord -Force | Out-Null
        Write-Output "Remediated: $valueName created and set to $expectedValue at $regPath."
    }
}
