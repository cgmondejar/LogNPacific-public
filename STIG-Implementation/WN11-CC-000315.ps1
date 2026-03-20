<#
.SYNOPSIS
    This PowerShell script creates the Windows Installer policy key if it doesn't exist and explicitly sets the 
    AlwaysInstallElevated registry value to 0 (disabling the dangerous "install MSI packages with elevated 
    privileges without UAC" behavior).

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-20
    Last Modified   : 2026-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

$keyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"

# Create the key if it doesn't exist
if (-not (Test-Path $keyPath)) {
    New-Item -Path $keyPath -Force | Out-Null
}

# Set the value (DWORD = 0)
Set-ItemProperty -Path $keyPath `
                 -Name "AlwaysInstallElevated" `
                 -Value 0 `
                 -Type DWord `
                 -Force

Write-Host "AlwaysInstallElevated set to 0 (disabled)" -ForegroundColor Green
