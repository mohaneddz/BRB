<h1>
  <img src="assets/images/logo.png" alt="BRB icon" width="42" />
  BRB
</h1>

**BRB** is a Flutter app that watches your phone's motion, proximity, and location sensors while you're away from it, and is meant to alarm when someone picks it up or walks off with it. Built with Dart, `geolocator`, `sensors_plus`, `proximity_sensor`, `pedometer`, and `camera`.

## Screenshots

<p align="center">
  <img src="assets/images/screenshots/home.png" alt="Home screen" width="200" />
  <img src="assets/images/screenshots/presets.png" alt="Presets screen" width="200" />
  <img src="assets/images/screenshots/history.png" alt="History screen" width="200" />
  <img src="assets/images/screenshots/account.png" alt="Account screen" width="200" />
  <img src="assets/images/screenshots/settings.png" alt="Settings screen" width="200" />
</p>

## Status

The UI shell is largely built out, but the core "detect a pickup and alarm" pipeline is not wired up yet — the sensor services and the arm/disarm toggle exist independently of each other. See [Known gaps](#known-gaps) below.

## Features

**Working:**
- Settings (sensitivity, detection delay, alarm tone, dark mode, notifications, language) persisted via `shared_preferences`
- Account profile photo via camera capture or gallery picker, persisted locally
- History event cards deep-link into Google/Apple Maps from coordinates
- Individually-functional sensor wrappers: GPS distance tracking, accelerometer/gyroscope/magnetometer streams, proximity, step counting, in-app camera capture

**Not wired up yet:**
- Home screen's arm/disarm button is cosmetic — it flips a label between "ON!"/"OFF!" and does not start any sensor service, request permissions, or arm anything
- No logic anywhere combines sensor readings + sensitivity/delay settings into an actual "phone was picked up" decision or alarm trigger
- Presets and the Home configuration card hold their values in memory only (`useState`-style) — nothing persists or feeds detection
- History is 4 hardcoded identical entries, not a real event log
- Alarm tone/sound settings don't play anything; vibration toggle never calls the `vibration` package

## Tech

- Flutter · Dart
- `geolocator`, `sensors_plus`, `proximity_sensor`, `pedometer`, `camera`, `permission_handler`
- `shared_preferences`, `image_picker`, `path_provider`, `vibration`, `url_launcher`

## Getting Started

```bash
flutter pub get
flutter run
```

## Known gaps

Tracked in detail in project notes — highlights:
- Detection pipeline (sensors → decision → alarm) doesn't exist yet
- Home/Presets state isn't persisted
- History has no real data source
- Debug/release builds were broken by an outdated `google_fonts` pin (fixed)
</content>
