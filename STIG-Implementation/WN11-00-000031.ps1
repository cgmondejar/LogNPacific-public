<#
.SYNOPSIS
    This PowerShell script checks and enforces required BitLocker policy registry 
    settings for advanced startup and TPM authentication, ensuring the correct values 
    are configured based on whether Network Unlock is used.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-20
    Last Modified   : 2026-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-00-000031

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

# Set to $true if BitLocker Network Unlock is used, otherwise $false
$networkUnlock = $false

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

# Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Expected values
$useAdvancedStartup = 1
$useTPMValue = if ($networkUnlock) { 2 } else { 1 }

function Ensure-RegistryValue {
    param (
        [string]$Path,
        [string]$Name,
        [int]$ExpectedValue
    )

    try {
        $currentValue = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name

        if ($currentValue -eq $ExpectedValue) {
            Write-Output "Compliant: $Name is set to $ExpectedValue."
        }
        else {
            Write-Output "Non-compliant: $Name is set to $currentValue. Remediating..."
            Set-ItemProperty -Path $Path -Name $Name -Value $ExpectedValue -Type DWord
            Write-Output "Remediated: $Name is now set to $ExpectedValue."
        }
    }
    catch {
        Write-Output "Non-compliant: $Name does not exist. Creating and setting value..."
        New-ItemProperty -Path $Path -Name $Name -Value $ExpectedValue -PropertyType DWord -Force | Out-Null
        Write-Output "Remediated: $Name created and set to $ExpectedValue."
    }
}

# Apply settings
Ensure-RegistryValue -Path $regPath -Name "UseAdvancedStartup" -ExpectedValue $useAdvancedStartup
Ensure-RegistryValue -Path $regPath -Name "UseTPMPIN" -ExpectedValue $useTPMValue
Ensure-RegistryValue -Path $regPath -Name "UseTPMKeyPIN" -ExpectedValue $useTPMValue
