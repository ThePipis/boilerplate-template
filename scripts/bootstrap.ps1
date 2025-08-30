\
param(
  [switch]$InstallDeps = $true,
  [switch]$StartSupabase = $false
)

Write-Host "Bootstrap repo..." -ForegroundColor Cyan

if ($InstallDeps) {
  Write-Host "Installing dependencies (pnpm i)..." -ForegroundColor Yellow
  pnpm i
}

if ($StartSupabase) {
  if (-not (Get-Command supabase -ErrorAction SilentlyContinue)) {
    Write-Error "Supabase CLI no encontrado. Instala: npm i -g supabase"
    exit 1
  }
  Write-Host "Starting Supabase..." -ForegroundColor Yellow
  supabase start
  if (Test-Path "scripts/load-supabase-env.ps1") {
    .\scripts\load-supabase-env.ps1
  } else {
    Write-Warning "scripts/load-supabase-env.ps1 no encontrado."
  }
}

Write-Host "Bootstrap OK." -ForegroundColor Green
