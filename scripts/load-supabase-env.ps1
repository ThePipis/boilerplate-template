<# load-supabase-env.ps1
   Carga variables de entorno para Supabase local en la sesión actual.
   Lee puertos desde supabase/config.toml y claves con `supabase secrets list --json`.
#>

[CmdletBinding()]
param(
  [string]$ProjectRoot = (Get-Location).Path,
  [string]$HostAddr    = "127.0.0.1",
  [string]$PgUser      = "postgres",
  [string]$PgPassword = "postgres",
  # Nota: string a propósito (local). Si quieres SecureString, lo cambiamos.
  [string]$PgDatabase  = "postgres",
  [switch]$Persist                      # Si se pasa, también guarda con setx (próximas sesiones).
)

function Fail($msg) { Write-Error $msg; exit 1 }

if (-not (Get-Command supabase -ErrorAction SilentlyContinue)) {
  Fail "Supabase CLI no encontrado. Instala: npm i -g supabase  (o scoop install supabase)."
}

# --- 1) Puertos desde config.toml (con defaults) ---
$cfgPath = Join-Path $ProjectRoot "supabase\config.toml"
$apiPort = 54321; $dbPort = 54322; $studioPort = 54323

if (Test-Path $cfgPath) {
  $toml = Get-Content $cfgPath -Raw
  $api   = [regex]::Match($toml, '(?ms)^\s*\[api\].*?^\s*port\s*=\s*(\d+)', 'IgnoreCase,Multiline')
  $db    = [regex]::Match($toml, '(?ms)^\s*\[db\].*?^\s*port\s*=\s*(\d+)', 'IgnoreCase,Multiline')
  $studio= [regex]::Match($toml, '(?ms)^\s*\[studio\].*?^\s*port\s*=\s*(\d+)', 'IgnoreCase,Multiline')
  if ($api.Success)   { $apiPort    = [int]$api.Groups[1].Value }
  if ($db.Success)    { $dbPort     = [int]$db.Groups[1].Value }
  if ($studio.Success){ $studioPort = [int]$studio.Groups[1].Value }
} else {
  Write-Warning "No se encontró supabase/config.toml. Uso defaults: api=$apiPort, db=$dbPort, studio=$studioPort."
}

# --- 2) Secrets (JSON) ---
try {
  $secretsJson = supabase secrets list --local -o json 2>$null
  if (-not $secretsJson) { Fail "No se pudieron leer secretos. ¿Ejecutaste 'supabase start' en este proyecto?" }
  $secrets = $secretsJson | ConvertFrom-Json
} catch { Fail "Fallo al convertir secretos JSON. Salida: $secretsJson" }

function Get-Secret([string]$name) {
  ($secrets | Where-Object { $_.name -eq $name } | Select-Object -First 1).value
}
$anon   = Get-Secret "SUPABASE_ANON_KEY"
$svcKey = Get-Secret "SUPABASE_SERVICE_ROLE_KEY"
if (-not $anon -or -not $svcKey) { Fail "Faltan claves: SUPABASE_ANON_KEY o SUPABASE_SERVICE_ROLE_KEY." }


# --- 3) Exportar a la SESIÓN ACTUAL ---
$env:SUPABASE_URL              = "http://$($HostAddr):$($apiPort)"
$env:SUPABASE_ANON_KEY         = $anon
$env:SUPABASE_SERVICE_ROLE_KEY = $svcKey

$env:PGHOST     = $HostAddr
$env:PGPORT     = "$dbPort"
$env:PGUSER     = $PgUser
$env:PGPASSWORD = $PgPassword
$env:PGDATABASE = $PgDatabase
$env:DATABASE_URL= "postgresql://$($PgUser):$($PgPassword)@$($HostAddr):$($dbPort)/$($PgDatabase)"

# --- 4) Persistencia opcional ---
if ($Persist) {
  foreach ($k in "SUPABASE_URL","SUPABASE_ANON_KEY","SUPABASE_SERVICE_ROLE_KEY","PGHOST","PGPORT","PGUSER","PGPASSWORD","PGDATABASE","DATABASE_URL") {
    setx $k "$(${env:$k})" | Out-Null
  }
}

# --- 5) Resumen ---
Write-Host "✅ Entorno Supabase cargado (sesión actual):" -ForegroundColor Green
Write-Host "  SUPABASE_URL=$($env:SUPABASE_URL)"
Write-Host "  SUPABASE_ANON_KEY=***"
Write-Host "  SUPABASE_SERVICE_ROLE_KEY=***"
Write-Host "  PGHOST=$($env:PGHOST)  PGPORT=$($env:PGPORT)  PGDATABASE=$($env:PGDATABASE)"
Write-Host "  DATABASE_URL=$($env:DATABASE_URL)"
Write-Host "  Studio:  http://$($HostAddr):$($studioPort)" -ForegroundColor DarkGray
Write-Host "  API:     $($env:SUPABASE_URL)/rest/v1" -ForegroundColor DarkGray
Write-Host "`nAhora puedes ejecutar 'gemini' en esta misma terminal."
