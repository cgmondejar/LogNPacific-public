<#
.SYNOPSIS
    Enforces SMB signing on both the client and server by requiring and enabling security 
    signatures, helping prevent man-in-the-middle (MITM) and relay attacks on SMB communications.

.NOTES
    Author          : Chrisvem Mondejar
    LinkedIn        : linkedin.com/in/cgmondejar/
    GitHub          : github.com/cgmondejar
    Date Created    : 2026-03-3
    Last Modified   : 2026-03-3
    Version         : 1.0
    CVEs            : CVE-2025-33073
    Plugin IDs      : 57608
    STIG-ID         : N/A

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Copy, paste, and run the script. No further instructions required. 
#>

# Enforces SMB signing to prevent relay/MITM attacks

Write-Host "Enforcing SMB signing..."

Set-SmbServerConfiguration `
    -RequireSecuritySignature $true `
    -EnableSecuritySignature $true `
    -Force

Set-SmbClientConfiguration `
    -RequireSecuritySignature $true `
    -EnableSecuritySignature $true `
    -Force

Write-Host "SMB signing is now required." -ForegroundColor Green
