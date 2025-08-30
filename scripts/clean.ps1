\
# Limpia artefactos locales del monorepo
Write-Host "Cleaning workspace..." -ForegroundColor Cyan
$paths = @("node_modules", ".turbo", "pnpm-lock.yaml", ".next", "dist", "build", "coverage","apps/web/.next", "apps/api/dist", ".pnpm-store")
foreach ($p in $paths) {
  if (Test-Path $p) { Remove-Item -Recurse -Force $p }
}
Write-Host "Done." -ForegroundColor Green
