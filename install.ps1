<#
.SYNOPSIS
    Pulse — Automated Windows Installer
.DESCRIPTION
    Builds the release binary and installs `pulse.exe` so it can be run from any
    command prompt or PowerShell terminal on Windows (x86_64 / ARM64).
    Automatically configures User or System PATH environment variables.
.PARAMETER Dir
    Custom installation directory (e.g. -Dir "C:\Tools\pulse")
.PARAMETER System
    Install system-wide to "$env:ProgramFiles\pulse" (requires Administrator privileges)
.PARAMETER NoPath
    Do not modify PATH environment variables
.PARAMETER SkipBuild
    Install an already-built "target\release\pulse.exe" without compiling
.PARAMETER Help
    Show this help message
.EXAMPLE
    .\install.ps1
.EXAMPLE
    .\install.ps1 -System
.EXAMPLE
    .\install.ps1 -Dir "C:\bin" -SkipBuild
#>

[CmdletBinding()]
param(
    [string]$Dir = "",
    [switch]$System,
    [switch]$NoPath,
    [switch]$SkipBuild,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

if ($Help) {
    Get-Help $MyInvocation.MyCommand.Path -Detailed
    exit 0
}

# ---------------------------------------------------------------------------
# Output formatting & ANSI color support
# ---------------------------------------------------------------------------
$esc = [char]27
$C_RESET   = "$esc[0m"
$C_BOLD    = "$esc[1m"
$C_DIM     = "$esc[2m"
$C_RED     = "$esc[1;31m"
$C_GREEN   = "$esc[1;32m"
$C_YELLOW  = "$esc[1;33m"
$C_CYAN    = "$esc[1;36m"

function Write-Info([string]$msg)  { Write-Host "${C_CYAN}▸${C_RESET} $msg" }
function Write-Ok([string]$msg)    { Write-Host "${C_GREEN}✓${C_RESET} $msg" }
function Write-Warn([string]$msg)  { Write-Host "${C_YELLOW}!${C_RESET} $msg" }
function Write-Err([string]$msg)   { Write-Host "${C_RED}✗${C_RESET} $msg" }
function Die([string]$msg)         { Write-Err $msg; exit 1 }
function Write-Step([string]$msg)  { Write-Host "`n${C_BOLD}$msg${C_RESET}" }

function Test-IsAdmin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
if (-not $ScriptDir) {
    $ScriptDir = Get-Location
}
Set-Location $ScriptDir

$BinName = "pulse.exe"

# ---------------------------------------------------------------------------
# 1. Toolchain Check
# ---------------------------------------------------------------------------
Write-Step "1/5  Checking the Rust toolchain"
$cargoCmd = Get-Command "cargo" -ErrorAction SilentlyContinue
if (-not $cargoCmd) {
    Die "cargo not found. Please install Rust via https://rustup.rs or `winget install Rustlang.Rustup`"
}
$cargoVersion = & cargo --version
Write-Ok "$cargoVersion"

# ---------------------------------------------------------------------------
# 2. Build Release Binary
# ---------------------------------------------------------------------------
if (-not $SkipBuild) {
    Write-Step "2/5  Building release binary (cargo build --release)"
    Write-Info "Compiling with full optimizations and Windows bindings..."
    & cargo build --release
    if ($LASTEXITCODE -ne 0) {
        Die "cargo build --release failed with exit code $LASTEXITCODE"
    }
    Write-Ok "Build finished successfully"
} else {
    Write-Step "2/5  Skipping build (-SkipBuild)"
}

$SrcBin = Join-Path $ScriptDir "target\release\$BinName"
if (-not (Test-Path $SrcBin)) {
    Die "Binary not found at $SrcBin (run without -SkipBuild)"
}
Write-Ok "Found binary: $SrcBin"

# ---------------------------------------------------------------------------
# 3. Select Installation Directory
# ---------------------------------------------------------------------------
Write-Step "3/5  Selecting install directory"

if ($Dir -ne "") {
    $InstallDir = $Dir
} elseif ($System) {
    if (-not (Test-IsAdmin)) {
        Die "System installation (-System) requires Administrator privileges. Run PowerShell as Administrator."
    }
    $InstallDir = Join-Path $env:ProgramFiles "pulse"
} else {
    # Per-user install: prefer %USERPROFILE%\.cargo\bin if it exists, otherwise %LOCALAPPDATA%\Programs\pulse
    $cargoBin = Join-Path $env:USERPROFILE ".cargo\bin"
    if (Test-Path $cargoBin) {
        $InstallDir = $cargoBin
    } else {
        $InstallDir = Join-Path $env:LOCALAPPDATA "Programs\pulse"
    }
}

if (-not (Test-Path $InstallDir)) {
    try {
        New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
        Write-Ok "Created directory $InstallDir"
    } catch {
        Die "Cannot create directory $InstallDir: $_"
    }
}
Write-Ok "Install directory: $InstallDir"

# ---------------------------------------------------------------------------
# 4. Copy the Binary
# ---------------------------------------------------------------------------
Write-Step "4/5  Installing the binary"
$DestBin = Join-Path $InstallDir $BinName

if (Test-Path $DestBin) {
    Write-Info "Replacing existing $DestBin"
}

# Staged copy to avoid partial writes
$TmpBin = Join-Path $InstallDir ".${BinName}.new"
try {
    Copy-Item -Path $SrcBin -Destination $TmpBin -Force
    Move-Item -Path $TmpBin -Destination $DestBin -Force
} catch {
    Die "Failed to install binary (is pulse.exe currently running?): $_"
}

try {
    $verOut = & "$DestBin" --version
    Write-Ok "Installed: $DestBin ($verOut)"
} catch {
    Write-Warn "Installed to $DestBin, but executing `--version` failed: $_"
}

# ---------------------------------------------------------------------------
# 5. PATH Configuration
# ---------------------------------------------------------------------------
Write-Step "5/5  Configuring PATH"

$pathReady = $false
$currentPathEntries = ($env:Path -split ';') | ForEach-Object { $_.TrimEnd('\') }
$normalizedInstallDir = $InstallDir.TrimEnd('\')

if ($currentPathEntries -contains $normalizedInstallDir) {
    Write-Ok "$InstallDir is already in PATH"
    $pathReady = $true
} elseif ($NoPath) {
    Write-Warn "Skipping PATH modification (-NoPath)"
} else {
    $scope = if ($System) { "Machine" } else { "User" }
    Write-Info "Adding $InstallDir to $scope PATH..."

    try {
        $regPath = [Environment]::GetEnvironmentVariable("Path", $scope)
        if (-not $regPath) { $regPath = "" }
        $regEntries = ($regPath -split ';') | ForEach-Object { $_.TrimEnd('\') }

        if (-not ($regEntries -contains $normalizedInstallDir)) {
            $newRegPath = if ($regPath.EndsWith(';') -or $regPath -eq '') {
                "$regPath$InstallDir"
            } else {
                "$regPath;$InstallDir"
            }
            [Environment]::SetEnvironmentVariable("Path", $newRegPath, $scope)
            Write-Ok "Persisted $InstallDir to $scope PATH"
        }

        # Update active PowerShell session environment as well
        $env:Path = "$env:Path;$InstallDir"
        $pathReady = $true
    } catch {
        Write-Warn "Failed to update $scope PATH: $_"
    }
}

# ---------------------------------------------------------------------------
# Complete
# ---------------------------------------------------------------------------
Write-Step "Done"
if ($pathReady) {
    Write-Host "  Run it from any command prompt or PowerShell:"
    Write-Host "    ${C_CYAN}${C_BOLD}pulse${C_RESET}`n"
} else {
    Write-Host "  Add this directory to your PATH manually:"
    Write-Host "    ${C_CYAN}$InstallDir${C_RESET}`n"
}

