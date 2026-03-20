<#
.SYNOPSIS
    This PowerShell script sets the NTLMMinClientSec registry value to 0x20080000 (537395200), 
    enforcing NTLMv2 session security with 128-bit encryption on the client side for enhanced security.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-20
    Last Modified   : 2026-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000215

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

# Set NTLMMinClientSec to 0x20080000 (Require NTLMv2 + 128-bit encryption)
$keyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"

# Create the key path if it doesn't exist (very rare, but safe)
if (-not (Test-Path $keyPath)) {
    New-Item -Path $keyPath -Force | Out-Null
}

Set-ItemProperty -Path $keyPath `
                 -Name "NTLMMinClientSec" `
                 -Value 0x20080000 `
                 -Type DWord `
                 -Force

Write-Host "NTLMMinClientSec set to 0x20080000 (537395200)" -ForegroundColor Green
