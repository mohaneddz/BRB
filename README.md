# brb

A hackathon prototype for a proximity/distance-based alarm concept — the idea being "leave your phone behind and get alerted" (name suggests "be right back"). Users define named presets (e.g. GYM, HOME, OFFICE), each with a distance threshold, a delay, vibration/lock toggles, and volume/sound settings.

**This project was abandoned mid-hackathon** — the final commit message is literally "I'm ditching react native." It's kept here as a UI/concept sketch, not a working app.

## What's built

- Expo Router navigation shell with Home, Presets, History, and Settings pages
- Presets screen: full in-memory CRUD (add/edit/delete a preset) via a modal with distance/delay inputs, vibration/lock checkboxes, and volume/sound sliders — not persisted, not wired to any real proximity or alarm logic
- Home screen renders a looping SVG animation with a static "OFF" label — an arm/disarm toggle appears to have been planned but has no `onPress` handler
- Custom UI kit (Checkbox, Modal, Slider, Icon, Navigation) built from scratch on NativeWind

## What's missing

- No actual distance/proximity detection or alarm-triggering logic
- No persistence — presets reset on reload
- No arm/disarm behavior wired up on the Home screen
- History screen is a static shell only

## Tech stack

Expo SDK 53 · React Native 0.79 · React 19 · expo-router v5 · NativeWind (Tailwind for RN) · TypeScript · lucide-react-native · react-native-svg

## Status

Archived. Only two commits exist total (init, then the abandonment commit). Not under active development.

## Getting started

```bash
npm install
npx expo start
```
