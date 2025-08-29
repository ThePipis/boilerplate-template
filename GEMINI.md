# GEMINI PROJECT ORCHESTRATOR

## Objetivo
Operar este repo como monorepo profesional (web + api + packages) y entregar valor incremental, usando `PLAN.md` como fuente de verdad.

## Prioridades
1) Si `PLAN.md` no existe, **créalo** con la plantilla de este archivo y úsalo como checklist vivo.  
2) Cada tarea: rama `feature/<slug>`, PR con diff y tests mínimos.  
3) Loop de calidad: Lint → Typecheck → Tests → Playwright (web) → Supertest (api).  
4) Si falla: activar **Fixer** (auto-sanación). Repetir hasta verde.  
5) Actualizar `PLAN.md` **antes y después** de cada cambio.

## Agentes
- **Planner:** genera/actualiza `PLAN.md` (roadmap, dependencias, criterios de aceptación, riesgos). *No cambia código.*
- **Developer:** implementa SOLO lo marcado como Pendiente en `PLAN.md`. Tipado estricto, pruebas mínimas del cambio.
- **Tester:** corre linters, typecheck, unit/e2e. Reporta fallos en `PLAN.md`.
- **Fixer (Auto-Heal):** aplica parches mínimos para poner todo en verde sin añadir deuda ni librerías nuevas.
- **Refactorer:** factoriza, elimina duplicación, mueve a `packages/*` sin cambiar comportamiento.
- **Security:** revisa cabeceras, CORS, rate-limit, RLS, inyección, gestión de secrets.
- **Docs:** actualiza README/CHANGELOG y ejemplos.

> Orden por defecto: **Planner → Developer → Tester → (Fixer)* → Tester → Docs**.

## Tareas iniciales (si `apps/` vacío)
- Sembrar monorepo pnpm + Turborepo.
- `apps/web`: Next.js (App Router) + Tailwind + TanStack Query + Supabase Auth + rutas protegidas + RHF+Zod.
- `apps/api`: NestJS **ESM** + Prisma + módulos auth/users/profiles + OpenAPI + Helmet/Throttler.
- `packages/db`: Prisma schema (User, Profile, AuditLog) + migración inicial.
- `packages/ui` y `packages/config`: design system y presets.
- Scripts locales: `dev`, `build`, `lint`, `test`, `typecheck` (turbo).
- Tests smoke e2e (login + CRUD básico).

## Reglas de modificación
- No forzar Vite en Next.js. Si SPA, usar `apps/web` con Vite + React Router (opción B).
- Toda entrada/salida validada con Zod.
- Sin secretos en repo; `.env` + `.env.example`.

## Plantilla semilla de PLAN.md (si no existe)
```md
# PLAN

## Roadmap
- [ ] Bootstrap monorepo (turbo, pnpm, workspaces)
- [ ] Frontend (Next.js) base + Tailwind + Auth
- [ ] Backend (NestJS) base + Prisma + OpenAPI
- [ ] Integración Web↔API (hooks, fetchers, Zod)
- [ ] Tests (unit + e2e)
- [ ] Observabilidad y seguridad
- [ ] Docs y limpieza

## Estado
**Hecho:**  
- …

**Pendiente:**  
- …

## Criterios de aceptación
- Lint/typecheck OK.
- Unit + e2e en verde.
- Auth funcional (email/password) con RLS en Supabase.
- README actualizado.

## Riesgos/Mitigaciones
- …
```

## Supabase Local — política del proyecto
- Este proyecto usa un **stack Supabase propio** con puertos fijos definidos en `supabase/config.toml`.
- El Planner **debe**:
  1) Crear/actualizar `supabase/config.toml` con los puertos de este proyecto.
  2) Ejecutar `supabase start` si el stack no está arriba.
  3) Añadir tarea en `PLAN.md` para **cargar secretos** en entorno de la terminal activa (sin persistir en repo).
  4) Verificar MCP:
     - `supabase-rest` → `${env:SUPABASE_URL}/rest/v1`
     - `supabase-sql` → usa `PGHOST/PGPORT/PGDATABASE/PGUSER/PGPASSWORD`.

### Plantilla `supabase/config.toml` (ports de ejemplo, offset=20)
```toml
[api]
port = 54341
[db]
port = 54342
[studio]
port = 54343
```

### Carga de secretos en entorno (Windows PowerShell, sesión actual)
```powershell
# Obtener secretos locales y exportarlos
$s = supabase secrets list --json | ConvertFrom-Json
$env:SUPABASE_URL = "http://127.0.0.1:54341"
$env:SUPABASE_ANON_KEY = ($s | Where-Object {$_.name -eq "SUPABASE_ANON_KEY"}).value
$env:SUPABASE_SERVICE_ROLE_KEY = ($s | Where-Object {$_.name -eq "SUPABASE_SERVICE_ROLE_KEY"}).value
# Postgres (usa config.toml/db.port)
$env:PGHOST="127.0.0.1"; $env:PGPORT="54342"; $env:PGDATABASE="postgres"; $env:PGUSER="postgres"; $env:PGPASSWORD="postgres"
```
> Alternativa macOS/Linux (bash): parsear `supabase/.env` o `supabase secrets list --json` y exportar con `export VAR=...`.

### MCP esperado (resumen)
- **supabase-rest**: `@supabase/mcp-server-postgrest` con:
  - `--apiUrl ${env:SUPABASE_URL}/rest/v1`
  - `--apiKey ${env:SUPABASE_SERVICE_ROLE_KEY}`
- **supabase-sql**: server Python `tools/mcp_supabase_sql.py` con `PG*` del entorno.

### Guardas operativas
- Si `supabase start` falla por puertos en uso, **incrementar offset** y reescribir `config.toml`; luego reintentar.
- Nunca imprimir claves en respuestas. Usar `${env:VAR}` en ejemplos.

### Supabase local – pasos previos obligatorios
1) Asegurar `supabase/config.toml` con puertos únicos (si están ocupados, subir offset).
2) `supabase start`.
3) `.\scripts\load-supabase-env.ps1` (carga SUPABASE_URL, keys y PG*).
4) Verificar `/mcp` (deben aparecer `supabase-rest` y `supabase-sql`).
