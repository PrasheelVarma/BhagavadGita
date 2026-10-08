# Bhagavad Gita (श्रीमद्भगवद्गीता)

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Audio](https://img.shields.io/badge/Audio-JustAudio%20%26%20Background-FF6F00?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)

<p align="center">
  <b>A dedicated, high-performance devotional audio player crafted with Flutter.</b><br>
  Immerse in the sacred 73-minute complete recitation of the Bhagavad Gita with rich animations, innovative chakra gestures, and background playback.
</p>

</div>

---

## 🌟 Key Features

### ☸️ Divine Chakra Seek Control
* **Circular Touch Scrubbing**: Interactive gesture ring around the sacred artwork allowing fluid, circular seeking.
* **Continuous Visual Feedback**: Rotational ray glows, animated sunburst aura, and real-time angle calculation during drag gestures.
* **Smart Time Select**: Dynamic step adjustments with tactile skip intervals.

### 🎵 Background Audio & Lock Screen Media
* **Seamless Background Playback**: Powered by `just_audio_background` and `audio_session` with full Android audio focus handling.
* **Notification Panel Integration**: Real-time seek bar, high-resolution artwork, play/pause, and fast forward/rewind directly from the lock screen and notification shade.
* **Headphone & Interruption Handling**: Automatically pauses on unplug/interruption and resumes gracefully.

### 🎛️ Sacred Playback Console
* **Interactive Playback Speed**: Quick-select playback rates (`0.75x`, `1.0x`, `1.25x`, `1.5x`, `2.0x`).
* **Devotional Sleep Timer**: Preset countdown intervals (15m, 30m, 45m, 60m) with live ticker and graceful fade out.
* **Infinite Repeat**: Single-track loop toggle for continuous chanting and meditation.
* **Smooth Seek Bar**: Interactive high-precision slider with responsive elapsed and total time tracking.

### 🎨 Devotional Aesthetics & Architecture
* **Saffron & Vermillion Palette**: Traditional temple color schemes with golden ornamentation and glassmorphic cards.
* **Animated Sacred Splash**: Dynamic entrance animation with glowing aura and sacred typographic reveals.
* **Locked Portrait Orientation**: Optimized for handheld viewing with zero pixel overflow across all device densities.
* **100% Offline**: Bundled complete 73-minute high-fidelity audio asset with instant load times and zero network reliance.

---

## 📱 Architecture & Structure

```
lib/
├── main.dart                          # Application entry, session setup & portrait lock
├── screens/
│   ├── player_screen.dart             # Main devotional player, chakra painter & console UI
│   └── splash_screen.dart             # Animated sacred splash entrance
└── services/
    └── audio_player_controller.dart   # Audio lifecycle, background service & state management
```

---

## 🛠️ Technology Stack

| Layer | Component |
|---|---|
| **Framework** | Flutter (Channel stable, Material 3) |
| **Language** | Dart 3 |
| **Audio Engine** | `just_audio` |
| **Background Service** | `just_audio_background` |
| **System Audio Focus** | `audio_session` |
| **Target Platform** | Android (API 21+) |

---

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (3.0.0 or higher)
* Android Studio / Android SDK (API 34 compatible)
* Java 11 / 17

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/PrasheelVarma/BhagavadGita-Website.git
   cd BhagavadGita-Website
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on connected device / emulator:**
   ```bash
   flutter run
   ```

---

## 📦 Building for Production

### Android Release APK (Split per ABI)
Generate optimized, lightweight standalone APKs:
```bash
flutter build apk --split-per-abi
```
*Output location:* `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`

### Android App Bundle (Google Play Store)
Generate the optimized publishing bundle:
```bash
flutter build appbundle
```
*Output location:* `build/app/outputs/bundle/release/app-release.aab`

---

## 📜 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
