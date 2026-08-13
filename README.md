<h1>
  <img src="assets/images/logo.png" alt="BRB icon" width="42" />
  BRB
</h1>

**BRB** is a Flutter app that watches your phone's motion, proximity, and location sensors while you're away from it, and alarms when someone picks it up or walks off with it. Built with Dart, `geolocator`, `sensors_plus`, `proximity_sensor`, `pedometer`, and `camera`.

## Screenshots

<p align="center">
  <img src="assets/images/screenshots/home.png" alt="Home screen" width="190" />
  <img src="assets/images/screenshots/alarm.png" alt="Alarm screen" width="190" />
  <img src="assets/images/screenshots/presets.png" alt="Presets screen" width="190" />
  <img src="assets/images/screenshots/history.png" alt="History screen" width="190" />
  <img src="assets/images/screenshots/settings.png" alt="Settings screen" width="190" />
</p>

## How it works

Arming Home starts `DetectionService`, which watches the sensors for the active mode and fires once a reading holds past threshold for the configured delay:

- **Pocket** - sudden motion, or the proximity sensor going from covered to uncovered
- **Sensitive** - same motion check, much lower threshold
- **Distant** - GPS distance from the arm point exceeds the configured range
- **Steps** - step counter advances past a small threshold

On trigger, `AlarmController` vibrates, plays an alert sound, optionally snaps a photo and grabs a GPS fix (per the active config), logs a real event to History, and shows a full-screen alarm screen that blocks the back gesture and (if a PIN is set in Settings) requires it to dismiss.

Presets, the Home configuration card, History events, and Account profile fields all persist via `shared_preferences` - nothing resets on restart.

## Known limitations

- Detection is heuristic (accelerometer-magnitude/proximity/GPS/step thresholds), not ML-based - it can false-trigger on a hard bump or miss a very gentle pickup.
- Alarm "tone" selection is persisted but not distinct per-tone audio - there are no bundled sound assets, so triggering plays the system alert sound.
- History shows raw coordinates, not a reverse-geocoded place name.
- Dark Mode toggle persists but doesn't switch themes yet - the app is dark-only.

## Tech

- Flutter · Dart
- `geolocator`, `sensors_plus`, `proximity_sensor`, `pedometer`, `camera`, `permission_handler`, `vibration`
- `shared_preferences`, `image_picker`, `path_provider`, `url_launcher`

## Getting Started

```bash
flutter pub get
flutter run
```
</content>
