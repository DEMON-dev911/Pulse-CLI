$ErrorActionPreference = "Stop"

$assetUrl = "https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-windows-x86_64.zip"
$installDir = Join-Path $env:LOCALAPPDATA "Programs\Pulse"
$tempZip = Join-Path $env:TEMP "pulse-windows-x86_64.zip"
$tempDir = Join-Path $env:TEMP ("pulse-install-" + [guid]::NewGuid().ToString("N"))

try {
    Write-Host "Downloading Pulse for Windows..."
    Invoke-WebRequest -Uri $assetUrl -OutFile $tempZip
    Expand-Archive -LiteralPath $tempZip -DestinationPath $tempDir -Force

    $downloadedExe = Join-Path $tempDir "pulse.exe"
    if (-not (Test-Path -LiteralPath $downloadedExe -PathType Leaf)) {
        throw "The release archive does not contain pulse.exe at its root."
    }

    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    Move-Item -LiteralPath $downloadedExe -Destination (Join-Path $installDir "pulse.exe") -Force

    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $pathEntries = @($userPath -split ";" | Where-Object { $_.TrimEnd("\") -ne "" })
    $pathExists = $false
    foreach ($entry in $pathEntries) {
        if ($entry.Trim().TrimEnd("\") -ieq $installDir.TrimEnd("\")) {
            $pathExists = $true
            break
        }
    }

    if (-not $pathExists) {
        $newUserPath = if ([string]::IsNullOrWhiteSpace($userPath)) {
            $installDir
        } else {
            "$($userPath.TrimEnd(';'));$installDir"
        }
        [Environment]::SetEnvironmentVariable("Path", $newUserPath, "User")
    }

    Write-Host "Pulse installed successfully to $installDir." -ForegroundColor Cyan
    Write-Host "Restart your terminal, then run: pulse"
}
finally {
    Remove-Item -LiteralPath $tempZip -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}
