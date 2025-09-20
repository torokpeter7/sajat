# Mentés például: InstallAppsAdmin.ps1

# Ellenőrizzük, hogy adminisztrátori joggal fut-e
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Újraindítás rendszergazdaként
    $argList = "-NoProfile -ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`""
    Start-Process powershell -Verb RunAs -ArgumentList $argList
    Exit
}

# Lista az alkalmazásokról
$apps = @(
    "Brave.Brave",              
    "Famatech.AdvancedIPScanner",
    "AngryIP.AngerIPScanner",
    "Discord.Discord",
    "Git.Git",
    "HDSentinel.HDSentinel",
    "Microsoft.Office",
    "Notion.Notion",
    "Oracle.VirtualBox",
    "VSCodium.VSCodium",
    "WinSCP.WinSCP",
    "WiresharkFoundation.Wireshark"
)

# Telepítés winget segítségével
foreach ($app in $apps) {
    Write-Output "Telepítés: $app"
    winget install --id=$app --silent --accept-package-agreements --accept-source-agreements
}

Write-Output "Az összes alkalmazás telepítése befejeződött!"
Pause
