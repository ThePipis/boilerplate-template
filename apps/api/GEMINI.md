# GEMINI API (NestJS)

## Objetivo
API modular en ESM con:
- Autenticación y autorización básica (Auth, RolesGuard).
- Módulos de Users, Profiles, Health, Audit.
- Integración con Prisma apuntando a Supabase (local o remoto).
- Documentación automática con OpenAPI (Swagger).

## Tareas
- **Infraestructura**:
  - Configuración centralizada con Zod.
  - Logger con Pino.
  - Helmet, CORS, Throttler (rate limiting).
  - Manejo de errores y validación global.

- **Base de datos**:
  - Prisma conectado a Supabase (usar SSL si es remoto).
  - Seeds y migraciones con `prisma migrate`.
  - Scripts de mantenimiento (reset, db:push, seed).

- **Aplicación**:
  - DTOs con `class-validator` + mapeos a Prisma.
  - Endpoints CRUD con paginación y filtros.
  - RBAC básico con RolesGuard.
  - Healthcheck en `/health`.

- **Tests**:
  - Unit tests con Jest.
  - e2e con Supertest (mínimo Auth y Users).

## Reglas
- No incluir secrets en el repo:
  - Usar `.env` y `.env.example` para todas las variables.
- Definir rate limit en rutas sensibles (ej. Auth, login).
- Manejo de errores consistente (filtros globales).
- Mantener OpenAPI actualizado con los DTOs.
