# https://github.com/L4DK
# AdminTeamsRunner by L4

param (
    [string]$u,
    [string]$f
)

if (($f.Length -eq 0) -or ($u.Length -eq 0)) {
    Exit
}

$credentials = Get-Credential -UserName ($env:USERDOMAIN + "\" + $u) -Message "Enter your administrative credentials"

try {
    $batch_name = 'support_hd.bat'
    $batch_code = '@echo off && start "" "{0}" && timeout 2' -f $f
    New-Item -Path "C:\Windows\Temp" -Name $batch_name -Value $batch_code -Force | Out-Null

    Start-Process -Credential $credentials -ArgumentList "-NoProfile -Command &{Start-Process powershell.exe -ArgumentList 'C:\Windows\Temp\$batch_name' -Verb RunAs}"
} catch {
    Write-Host "An error occurred while launching the program: $Error[0]"
    Exit
}
