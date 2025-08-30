import type { Config } from "tailwindcss";
const preset = require("@acme/config/tailwind.preset");

export default {
  content: ["./app/**/*.{ts,tsx}", "./components/**/*.{ts,tsx}"],
  presets: [preset]
} satisfies Config;
