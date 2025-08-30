declare module "react" {
  export type ReactNode = any;
  const React: any;
  export default React;
}
declare module "react-dom" {
  const x: any;
  export = x;
}
declare module "react/jsx-runtime" {
  const jsx: any;
  const jsxs: any;
  const Fragment: any;
  export { jsx, jsxs, Fragment };
}
