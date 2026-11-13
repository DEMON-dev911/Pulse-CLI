$ErrorActionPreference = "Stop"

$installDir = Join-Path $env:LOCALAPPDATA "Programs\Pulse"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

$binaryPath = Join-Path $installDir "pulse.exe"
if (Test-Path -LiteralPath $binaryPath -PathType Leaf) {
    Remove-Item -LiteralPath $binaryPath -Force
}
if (Test-Path -LiteralPath $installDir -PathType Container) {
    $remainingItems = @(Get-ChildItem -LiteralPath $installDir -Force)
    if ($remainingItems.Count -eq 0) {
        Remove-Item -LiteralPath $installDir -Force
    }
}

$pathEntries = @($userPath -split ";" | Where-Object { $_.Trim() -ne "" })
$keptEntries = @($pathEntries | Where-Object { $_.Trim().TrimEnd("\") -ine $installDir.TrimEnd("\") })
if ($keptEntries.Count -ne $pathEntries.Count) {
    [Environment]::SetEnvironmentVariable("Path", ($keptEntries -join ";"), "User")
}

$answer = Read-Host "Remove Pulse configuration and data in $HOME\.pulse and $HOME\.config\pulse? [y/N]"
if ($answer -match "^(y|yes)$") {
    $pulseConfigPaths = @(
        (Join-Path $HOME ".pulse"),
        (Join-Path $HOME ".config\pulse")
    )
    foreach ($path in $pulseConfigPaths) {
        if (Test-Path -LiteralPath $path) {
            Remove-Item -LiteralPath $path -Recurse -Force
        }
    }
    Write-Host "Removed Pulse configuration and data."
} else {
    Write-Host "Kept Pulse configuration and data."
}

Write-Host "Pulse uninstallation complete. Restart your terminal if it was open."
