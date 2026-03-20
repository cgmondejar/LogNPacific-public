$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "RestrictAnonymous"
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
