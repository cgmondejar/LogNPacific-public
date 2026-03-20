<#
.SYNOPSIS
    Checks if the RequireSecuritySignature registry value is set to 1 under the LanmanWorkstation 
    parameters and fixes it if it is missing or incorrect to ensure SMB signing is enforced.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-20
    Last Modified   : 2026-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000100

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$valueName = "RequireSecuritySignature"
$expectedValue = 1

try {
    $currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction Stop | Select-Object -ExpandProperty $valueName

    if ($currentValue -eq $expectedValue) {
        Write-Output "Compliant: $valueName is set to $expectedValue."
    }
    else {
        Write-Output "Non-compliant: $valueName is set to $currentValue. Remediating..."
        Set-ItemProperty -Path $regPath -Name $valueName -Value $expectedValue -Type DWord
        Write-Output "Remediated: $valueName is now set to $expectedValue."
    }
}
catch {
    Write-Output "Non-compliant: $valueName does not exist. Creating and setting value..."
    New-ItemProperty -Path $regPath -Name $valueName -Value $expectedValue -PropertyType DWord -Force | Out-Null
    Write-Output "Remediated: $valueName created and set to $expectedValue."
}
