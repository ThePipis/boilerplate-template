// ⚠️ Fallback SOLO para el boilerplate sin deps instaladas.
// Cuando ejecutes `pnpm i`, puedes borrar este archivo.

declare module 'react/jsx-runtime' {
  export const jsx: any;
  export const jsxs: any;
  export const Fragment: any;
}

declare namespace JSX {
  // Evita "no existe JSX.IntrinsicElements"
  interface IntrinsicElements {
    [elemName: string]: any;
  }
}
// 👇 extra para poder usar `React.ReactNode` sin dependencias
declare namespace React {
  type ReactNode = any;
}