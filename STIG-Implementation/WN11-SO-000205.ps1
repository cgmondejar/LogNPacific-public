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
