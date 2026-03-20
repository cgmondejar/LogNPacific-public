<#
.SYNOPSIS
    This PowerShell script configures LmCompatibilityLevel to 5, enforcing NTLMv2 authentication 
    only and disabling the insecure LM and NTLMv1 protocols.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-20
    Last Modified   : 2026-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

$keyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"

# Create the key if it doesn't exist (extremely unlikely, but safe)
if (-not (Test-Path $keyPath)) {
    New-Item -Path $keyPath -Force | Out-Null
}

# Set the value (DWORD = 5) → Send NTLMv2 response only, refuse LM & NTLM
Set-ItemProperty -Path $keyPath `
                 -Name "LmCompatibilityLevel" `
                 -Value 5 `
                 -Type DWord `
                 -Force

Write-Host "LmCompatibilityLevel set to 5 (NTLMv2 only, refuse LM/NTLM)" -ForegroundColor Green
