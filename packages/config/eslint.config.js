// Flat config
import js from "@eslint/js";
import ts from "typescript-eslint";
export default [
  js.configs.recommended,
  ...ts.configs.recommendedTypeChecked,
  {
    ignores: ["node_modules", "dist", ".next", "build"]
  }
];
