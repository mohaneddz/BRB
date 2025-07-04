/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{ts,tsx}"],
  presets: [require("nativewind/preset")],
  theme: {
    extend: {
      colors: {
        // Primary
        primary: '#f8231c',
        'primary-light': '#ff504b',
        'primary-dark': '#b71813',
        'primary-hover': '#e01c15',
        'primary-transparent': 'rgba(248, 35, 28, 0.2)',

        // Background
        'bg-dark': '#0a0a09',
        'bg-dark-soft': '#121210',
        'bg-dark-transparent': 'rgba(10, 10, 9, 0.9)',

        'bg-light': '#ffffff',
        'bg-light-muted': '#f5f5f5',
        'bg-light-transparent': 'rgba(255, 255, 255, 0.9)',

        // Foreground
        fg: '#181816',
        'fg-muted': '#2a2a28',
        'fg-light': '#3d3d3a',

        // Text
        'text-disabled': '#696969',
        'text-disabled-light': '#a0a0a0',

        'text-enabled': '#ffffff',
        'text-enabled-dark': '#ededed',
        'text-enabled-contrast': '#000000',

        // Borders & Shadows
        'border-color': '#292926',
        'border-color-light': '#e0e0e0',
        'shadow-color': 'rgba(0, 0, 0, 0.25)',

        // Status
        success: '#00c36d',
        warning: '#ffc107',
        error: '#ff3b3b',
      },
      fontFamily: {
        sans: ['ZenDots'],
      },
    },
  },
  plugins: [],
  native: {
    // 👇 Register components used with className
    classes: ['Pressable', 'View', 'Text'],
  },
}