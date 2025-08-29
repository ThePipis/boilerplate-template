# 🚀 Monorepo Boilerplate (Next.js + NestJS + Supabase)

Este boilerplate provee una base profesional para aplicaciones **fullstack** con frontend, backend y packages compartidos, integrado con Supabase local.

---

## 📦 Stack incluido

### Frontend (apps/web)
- Next.js (App Router)
- React + TypeScript
- TailwindCSS + Radix UI
- Zustand (estado global ligero)
- TanStack Query (estado remoto)
- React Hook Form + Zod (formularios y validación)
- Supabase Auth (SSR-safe)

### Backend (apps/api)
- NestJS en modo ESM
- Prisma ORM (conexión a Supabase Postgres)
- Módulos base: Auth, Users, Profiles, Health, Audit
- Swagger/OpenAPI
- Helmet + Throttler (seguridad)
- Logger con Pino

### Packages
- `packages/db`: schema Prisma + cliente
- `packages/ui`: design system (Tailwind + Radix)
- `packages/config`: ESLint flat, Prettier, Tailwind preset, tsconfig base

### Infraestructura
- Monorepo con **pnpm workspaces** + **Turborepo**
- Testing: Vitest + Playwright (web), Jest + Supertest (api)
- Observabilidad: healthcheck, logging, error boundaries

---

## ⚙️ Requisitos
- Node.js ≥ 20
- pnpm ≥ 8
- Docker Desktop (para Supabase local)
- Extensiones recomendadas en VSCode:
  - Tailwind CSS IntelliSense
  - Prisma
  - ESLint

---

## ▶️ Cómo empezar

### 1. Clonar el repo
```bash
git clone <url-del-repo>
cd <nombre-del-repo>
```

### 2. Instalar dependencias
```bash
pnpm install
```

### 3. Levantar Supabase local
Configura un `supabase/config.toml` único por proyecto (offset de puertos).
```bash
supabase start
```

### 4. Cargar secretos en entorno
Windows PowerShell:
```powershell
.\scripts\load-supabase-env.ps1
```
Linux/macOS:
```bash
source scripts/load-supabase-env.sh
```

### 5. Levantar dev servers
```bash
pnpm dev
```
Esto corre **web** y **api** en paralelo vía Turborepo.

---

## 📂 Estructura
```
apps/
  web/   → Next.js frontend
  api/   → NestJS backend
packages/
  db/       → Prisma schema + cliente
  ui/       → Design system (Tailwind + Radix)
  config/   → ESLint, Prettier, tsconfig, tailwind preset
scripts/
  load-supabase-env.ps1 → carga secretos Supabase en sesión
  load-supabase-env.sh  → idem en bash
supabase/
  config.toml → puertos del stack local
  .branches   → metadata de supabase start
  .temp       → metadata temporal
.gemini/
  GEMINI.md → reglas globales de interacción
```

---

## 🧪 Testing
- **Frontend**: Vitest + Playwright
- **Backend**: Jest + Supertest
- **E2E básicos**: login + CRUD mínimo

Ejecutar:
```bash
pnpm test
```

---

## 🔒 Reglas clave
- Nunca subir `node_modules`, `.turbo`, `.env`, `pnpm-lock.yaml` (ya en `.gitignore`).
- Los secrets siempre en `.env` o cargados en entorno; **nunca en el repo**.
- Validar todas las entradas/salidas con **Zod**.
- Usar commits con **Conventional Commits**.
- `PLAN.md` es la fuente de verdad: se actualiza antes y después de cada cambio.

---

## 🌐 MCP / Gemini CLI
- MCP `supabase-rest`: PostgREST para CRUD (usa `SUPABASE_URL` + `SERVICE_ROLE_KEY`).
- MCP `supabase-sql`: conexión directa a Postgres para migraciones (`PG*` vars).
- Gemini CLI usa `PLAN.md` y los `GEMINI.md` jerárquicos para planificar y ejecutar tareas.

---

## 📝 Roadmap inicial
- [ ] Bootstrap del monorepo (pnpm + turbo)
- [ ] Web base con Next.js + Tailwind + Auth
- [ ] API base con NestJS + Prisma + Supabase
- [ ] Integración Web ↔ API
- [ ] Tests (unit + e2e)
- [ ] Seguridad y observabilidad
- [ ] Documentación y limpieza

---

## 📜 Licencia
MIT
