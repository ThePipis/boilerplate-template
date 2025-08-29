/* eslint-disable @typescript-eslint/no-var-requires */
// Usamos JS para no requerir tipos mientras es boilerplate.
const preset = require("../../packages/config/tailwind.preset.js");

module.exports = {
  content: ["./app/**/*.{ts,tsx}"],
  presets: [preset]
};
