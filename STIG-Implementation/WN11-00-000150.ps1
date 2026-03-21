<#
.SYNOPSIS
    This PowerShell script checks if the DisableExceptionChainValidation registry value is 
    set to 0 and fixes it if it is missing or incorrect to ensure SEHOP is enabled.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-21
    Last Modified   : 2026-03-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-00-000150

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$valueName = "DisableExceptionChainValidation"
$expectedValue = 0

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
