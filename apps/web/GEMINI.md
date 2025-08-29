# GEMINI WEB (Next.js)

## Objetivo
App web con **Next.js (App Router)**, integrada con:
- TailwindCSS para estilos.
- Radix UI como base de componentes accesibles.
- TanStack Query para gestión de datos.
- Zustand para estado global ligero.
- React Hook Form + Zod para validaciones robustas.
- Autenticación con Supabase (compatible con SSR).
- Soporte para rutas públicas y protegidas.

## Tareas
- **Layout/UI**:
  - Layout base responsive.
  - Configuración tipográfica.
  - Soporte para dark mode con persistencia.
  - Skeletons, toasts y error boundaries por ruta.

- **Páginas iniciales**:
  - `/` (landing mínima).
  - `/auth/(login|register|reset)`.
  - `/dashboard`.
  - `/settings`.

- **Datos**:
  - Cliente de datos con fetcher + validación con Zod.
  - Hooks usando TanStack Query (lista/create/update/delete).
  - Uso de Server Actions seguras (sin exponer secretos).

- **Testing**:
  - Playwright: smoke tests de login y CRUD mínimo.

## Reglas
- Accesibilidad: usar roles/aria y contrastes correctos.
- No exponer claves sensibles en cliente.
- Cookies httpOnly para tokens si aplica.
- Formularios con RHF + Zod resolver.
- UX: micro-animaciones accesibles (ej. focus, hover).
