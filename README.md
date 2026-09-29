# God's Eye View — Android

WebView cockpit around [bilawalsidhu/gods-eye-view](https://github.com/bilawalsidhu/gods-eye-view).

Upstream is a Vite + CesiumJS browser app. Live layers that go through the Node/Vite `/api` proxy only work when the WebView points at a running `npm run dev` / `npm run preview` server. Bundled `dist/` is globe + client-side feeds only.

## What this is

- Landscape immersive WebView
- WebGL / WebRTC / geolocation / mic permissions
- Two load modes:
  1. **LAN / emulator** — full app, including Vite proxies
  2. **Bundled assets** — `app/src/main/assets/www` after `scripts/sync-web-assets.sh`

This sandbox has no Android SDK. No APK was produced here. Open the project in Android Studio on your machine.

## Clone both sides

```bash
git clone --depth 1 https://github.com/bilawalsidhu/gods-eye-view.git
git clone https://github.com/jimmylovnjames/gods-eye-view-android.git
```

Upstream Node: 24.14.x or 26.x. Not 25.

```bash
cd gods-eye-view
npm ci
npm run doctor
npm run dev -- --host 0.0.0.0 --port 4173
```

Phone and laptop on the same LAN. Use the laptop LAN IP, not localhost.

Emulator: `http://10.0.2.2:4173`

## Build the APK

Android Studio → Open `gods-eye-view-android` → let Gradle sync → Run.

Or:

```bash
cd gods-eye-view-android
# Android Studio generates the wrapper on first open.
# Or: gradle wrapper --gradle-version 8.11.1
./gradlew :app:assembleDebug
```

Override the start URL:

```bash
./gradlew :app:assembleDebug -PgevWebUrl=http://192.168.1.42:4173
```

Long-press the globe after launch to change URL. Stored in SharedPreferences.

## Bundle a static build (optional, degraded)

```bash
cd gods-eye-view
npm run build
cd ../gods-eye-view-android
./scripts/sync-web-assets.sh ../gods-eye-view/dist
```

Then assemble. Voice / key-gated proxies that expect the Vite server will fail.

## Cost / ToS

Upstream MIT covers source only. Third-party data and Google/OpenAI/AIS keys are on you. See upstream `LICENSE` and `DATA_SOURCES.md`.

Do not ship a Play build that wraps Google Photorealistic 3D Tiles without your own Maps / Cesium ion credentials and a read of Google Maps Platform ToS.

## Existing wrappers (not this repo)

- https://github.com/WorldPixelMap/android-gods-eye-view — older snapshot + license lock
- https://github.com/Haseosama/L-oeil-de-Dieu — Capacitor fork
