<#
.SYNOPSIS
    This PowerShell script sets NoNameReleaseOnDemand to 1 to prevent NetBIOS name 
    release attacks by disabling on-demand name releases over the network.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-21
    Last Modified   : 2026-03-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

$keyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Netbt\Parameters"

# Create the key if it doesn't exist (extremely unlikely, but safe)
if (-not (Test-Path $keyPath)) {
    New-Item -Path $keyPath -Force | Out-Null
}

# Set the value (DWORD = 1) → Prevents NetBIOS name release on demand
Set-ItemProperty -Path $keyPath `
                 -Name "NoNameReleaseOnDemand" `
                 -Value 1 `
                 -Type DWord `
                 -Force

Write-Host "NoNameReleaseOnDemand set to 1 (enabled / protected)" -ForegroundColor Green
