[CmdletBinding()]
param([switch]$Auto)

$ErrorActionPreference = "Stop"
$Root = $PSScriptRoot
$ConfigHome = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } else { Join-Path $HOME ".config" }
$Config = Join-Path $ConfigHome "opencode"
$Destination = Join-Path $Config "skills/token-guard"

New-Item -ItemType Directory -Force -Path (Split-Path $Destination) | Out-Null

if (Test-Path $Destination) {
    $Existing = (Resolve-Path $Destination).Path.TrimEnd('\', '/')
    $Expected = $Root.TrimEnd('\', '/')
    if ($Existing -eq $Expected) {
        Write-Host "Token Guard is already installed."
    } else {
        throw "Destination already exists: $Destination`nMove it aside or install manually."
    }
} else {
    New-Item -ItemType Junction -Path $Destination -Target $Root | Out-Null
    Write-Host "Installed Token Guard at $Destination"
}

if ($Auto) {
    $Instructions = Join-Path $Config "AGENTS.md"
    $Line = '- For every nontrivial task (coding, debugging, research, configuration, or multiple steps), load and follow `token-guard` first. Simple stable answers need neither skills nor tools.'
    if (-not (Test-Path $Instructions)) {
        New-Item -ItemType File -Path $Instructions | Out-Null
    }
    $Content = Get-Content -Raw -Path $Instructions
    if (-not $Content.Contains($Line)) {
        Add-Content -Path $Instructions -Value "`n$Line" -Encoding UTF8
        Write-Host "Enabled automatic activation in $Instructions"
    }
}
