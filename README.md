# Bhagavad Gita Audio Player

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Web](https://img.shields.io/badge/Web-4285F4?style=for-the-badge&logo=googlechrome&logoColor=white)
![Contributions](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg?style=for-the-badge)

<p align="center">
  A cross-platform audio player built with Flutter for the complete 73-minute Telugu recitation of the Bhagavad Gita by Sri Ghantasala Venkateswara Rao. Available for Android and Web.
</p>

</div>

---

## Overview

This project provides a standalone audio playback application designed specifically for long-form listening. It is implemented in Flutter and supports both a native Android application with background audio services and a responsive web application for desktop and mobile browsers.

The complete audio track is bundled directly within the app assets (`assets/audio.m4a`), enabling full offline playback on Android without requiring network connectivity or external streaming services.

---

## Features

### Audio Playback & Controls
- **Offline Playback**: Bundled 73-minute high-fidelity audio asset requiring zero network access for playback on Android.
- **Dual Seek Controls**: Interactive circular dial scrubber around the album artwork for radial touch seeking, paired with a linear progress slider.
- **Playback Speed**: Adjustable speed presets (`0.75x`, `1.0x`, `1.25x`, `1.5x`, `2.0x`).
- **Sleep Timer**: Countdown timer presets (`15m`, `30m`, `45m`, `60m`) with a real-time countdown display and graceful stop on completion.
- **Loop Mode**: Single-track repeat toggle for continuous playback.
- **Position Tracking**: Real-time elapsed and total duration indicators with responsive scrubbing feedback.

### System Integration (Android)
- **Background Audio**: Seamless background playback when the application is minimized or the screen is locked, powered by `just_audio_background`.
- **Media Notification & Lock Screen**: Android notification drawer integration featuring playback controls (Play, Pause, Seek), track details, and artwork display.
- **Audio Focus Management**: Configured via `audio_session` to handle phone calls, alarms, and headphone unplugging (pauses on disconnect).

### Web Experience
- **Responsive Layout**: Adaptive UI optimized for desktop monitors, tablets, and mobile web browsers.
- **Multi-Page Interface**: Dedicated pages for Home, Player, About, and Contact, with persistent audio playback across page navigation.

### Privacy & Simplicity
- **No Sign-In Required**: No accounts, authentication flows, or cloud dependencies.
- **Zero Telemetry**: No third-party analytics SDKs, trackers, or ads.

---

## Tech Stack

| Component | Technology | Description |
| --- | --- | --- |
| **Framework** | Flutter (Material 3) | Cross-platform UI toolkit |
| **Language** | Dart 3 | Application logic and state management |
| **Audio Engine** | `just_audio` | Asset decoding and playback controls |
| **Background Service** | `just_audio_background` | Android foreground service and media notification |
| **Audio Session** | `audio_session` | System audio focus and hardware route management |
| **Target Platforms** | Android (API 21+), Web | Standalone APK/AAB and static web build |

---

## Project Structure

```
BhagavadGita/
├── docs/                              # System documentation & technical specifications
│   ├── ARCHITECTURE.md                # System architecture, state machine & math design
│   └── PRODUCT_SPECIFICATION.md       # Product capabilities, audio provenance & specs
├── lib/
│   ├── main.dart                      # App entry point, orientation lock & platform routing
│   ├── screens/
│   │   ├── player_screen.dart         # Mobile audio player screen with dial & controls
│   │   └── splash_screen.dart         # Startup splash screen
│   ├── services/
│   │   └── audio_player_controller.dart # Audio state management, session lifecycle & playback logic
│   └── web/
│       ├── pages/
│       │   ├── about_page.dart        # Project information & rendition background
│       │   ├── contact_page.dart      # Project links & developer info
│       │   ├── home_page.dart         # Spacedesk-standard product portal & download grid
│       │   └── player_page.dart       # Web-optimized audio player wrapper
│       ├── theme.dart                 # Web design tokens, typography & color palette
│       ├── website_app.dart           # Responsive web application shell & navigation
│       └── widgets/
│           ├── website_footer.dart    # Reusable web footer with sitemap & copyright
│           └── website_header.dart    # Sticky glassmorphic navigation header
```

---

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio / Android SDK (API 34 compatible)
- Java 11 or 17

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/PrasheelVarma/BhagavadGita.git
   cd BhagavadGita
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run locally:**

   - **Android:**
     ```bash
     flutter run -d android
     ```

   - **Web (Chrome):**
     ```bash
     flutter run -d chrome
     ```

---

## Building for Production

### Android

- **Split APKs (optimized per ABI):**
  ```bash
  flutter build apk --split-per-abi
  ```
  *Output:* `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`

- **App Bundle (Google Play Store):**
  ```bash
  flutter build appbundle
  ```
  *Output:* `build/app/outputs/bundle/release/app-release.aab`

### Web

Generate optimized static web assets:

```bash
flutter build web --release
```

*Output:* `build/web/`

---

## 🎙️ Audio Credits

The audio recording featured in this project is the complete Telugu rendition of the Bhagavad Gita sung by **Sri Ghantasala Venkateswara Rao**.

The maintainer does not claim ownership of the audio recording. Full credit is given to Sri Ghantasala Venkateswara Rao for his iconic performance and contribution. The recording remains subject to the rights of its respective copyright owners.

---

## 📜 Code Usage

This repository is publicly available for viewing and reference.

- **Usage Restrictions:** No license is granted for general reuse, modification, redistribution, or independent re-publication of this project's source code.
- **Contributions:** If you would like to help improve or develop this application, you are welcome to contribute directly to this repository. Proposals, bug fixes, and improvements can be submitted via issues or pull requests, subject to maintainer review and approval.
