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
