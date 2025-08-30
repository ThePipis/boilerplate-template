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

### 3.🚦 Escenarios de arranque

A continuación, los modos de trabajo más comunes. Elige uno.
🔹 Solo Frontend (Next.js)

```bash
pnpm -F web dev
# http://localhost:3000
```

Funciona sin base de datos o con SQLite (por defecto, si configuras .env).

### 🔹3.1 Levantar Solo Backend (NestJS)

A continuación, los modos de trabajo más comunes. Elige uno.
🔹 Solo Frontend (Next.js)

```bash
pnpm -F api ts-node apps/api/src/main.ts
# http://localhost:3001/api/health
```

Puedes usar SQLite, Postgres o Supabase según .env.

### 🔹3.2 Fullstack (Web + API en paralelo)

```bash
pnpm dev

```

Levanta ambos con Turborepo.

    🔹Web → http://localhost:3000

    🔹API → http://localhost:3001

### 4.🗄️ Opciones de base de datos

### 🔹4.1 SQLite (simple y por defecto)

Crea/edita .env en la raíz:

```bash
DATABASE_URL="file:./dev.db"
```

Inicializa Prisma:

```bash
pnpm --filter @acme/db prisma generate
pnpm --filter @acme/db prisma migrate dev --name init
```

Útil para desarrollo rápido sin depender de Docker ni servicios externos.

### 🔹4.2 Supabase local (Postgres completo)

Cada proyecto puede tener su propia instancia (aislada por carpeta).
Inicializar en el proyecto que la va a usar (ej. raíz o apps/web/apps/api, según tu flujo):

```bash
supabase init        # crea ./supabase/
supabase start       # levanta la instancia local (elige puertos libres automáticamente)
```

Exportar credenciales a tu sesión
🔹 Windows PowerShell:

```powershell
.\scripts\load-supabase-env.ps1
```

🔹 Linux/macOS:

```bash
source scripts/load-supabase-env.sh
```

Ejemplo de .env (ajusta <PUERTO> según tu instancia):

```bash
DATABASE_URL="postgresql://postgres:postgres@127.0.0.1:<PUERTO>/postgres"
SUPABASE_URL=http://localhost:<PUERTO>
SUPABASE_ANON_KEY=...
SUPABASE_SERVICE_ROLE_KEY=...
```

Con esto, tanto apps/api (Prisma) como apps/web (Auth/REST) pueden apuntar a tu Supabase local.

### 5. 🧰 Scripts útiles (root package.json)

```bash
pnpm -F web dev                  # Levanta solo el Frontend
pnpm -F api ts-node apps/api/src/main.ts   # Levanta solo el Backend
pnpm dev                         # Levanta Web + API en paralelo (Turborepo)
pnpm test                        # Ejecuta tests (ver secciones de Testing)
```

Puedes añadir scripts adicionales (lint, build, format) según tus preferencias.

## 6. 📂 Estructura

```
apps/
  web/    → Next.js frontend
  api/    → NestJS backend
packages/
  db/       → Prisma schema + cliente
  ui/       → Design system
  config/   → ESLint, Prettier, Tailwind preset, tsconfig base
types/      → stubs TS para React, NestJS, Tailwind, Node
scripts/    → carga de variables y utilidades (Supabase, etc.)
supabase/   → config.toml y metadata por proyecto (si se usa)
```

## 7. 🧪 Testing

- **Frontend**: Vitest
- **Backend**: Jest + Supertest
  Ejecutar:

```bash
pnpm test
```

---

## 8. 🔒 Reglas clave

- Nunca subir `node_modules`, `.turbo`, `.env`, `pnpm-lock.yaml` (ya en `.gitignore`).
- Los secrets siempre en `.env` o cargados en entorno; **nunca en el repo**.
- Validar todas las entradas/salidas con **Zod**.
- Usar commits con **Conventional Commits**.
- `PLAN.md` es la fuente de verdad: se actualiza antes y después de cada cambio.

---

## 9. 🌐 MCP / Gemini CLI

- Compatible para que Gemini CLI genere/iterei sobre este boilerplate.
- MCP `supabase-rest`: PostgREST para CRUD (usa `SUPABASE_URL` + `SERVICE_ROLE_KEY`).
- MCP `supabase-sql`: conexión directa a Postgres para migraciones (`PG*` vars).
- Gemini CLI usa `PLAN.md` y los `GEMINI.md` jerárquicos para planificar y ejecutar tareas.
- `PLAN.md` y `GEMINI.md` guían la planificación automática.
- MCP integrado:
  - supabase-rest: CRUD vía PostgREST (`SUPABASE_URL` + `SERVICE_ROLE_KEY`).
  - supabase-sql: conexión directa a Postgres (variables PG\*).
- Puedes levantar Supabase por proyecto, de forma aislada y reutilizable.

---

## 10.🧭 Primer push a Git (opcional)

```bash
git init
git add .
git commit -m "Boilerplate inicial limpio y funcional"
git branch -M main
git remote add origin <URL-DEL-REPO>
git push -u origin main
```

---
