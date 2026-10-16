# Bhagavad Gita Product Specification & Technical Guide

**Document Version:** 1.0.0  
**Associated Codebase:** `PrasheelVarma/BhagavadGita`  
**Platforms:** Android (v1.0 Native APK) & Web Application

---

## 1. Product Overview

The Bhagavad Gita Audio Player is a dedicated, distraction-free player for the revered Telugu recitation and commentary associated with **Sri Ghantasala Venkateswara Rao** (~73 minutes).

The application is built to provide an uninterrupted listening experience:
1. **Distraction-Free:** Dedicated strictly to this recording, without commercial advertisements, social feeds, or recommendation algorithms.
2. **Offline Android Playback:** The Android release packages the audio file (`assets/audio.m4a`) directly into the APK, enabling playback without network access.
3. **Account-Free Access:** Requires no user registration, account sign-in, or login flows.

---

## 2. Platform Comparison

| Capability | Web Application (`/player`) | Native Android App (v1.0 APK) |
|---|---|---|
| **Installation** | Instant browser streaming (no installation) | Manual APK sideload / installation |
| **Network Access** | Requires connection on page load | Offline; audio is bundled in the APK |
| **Audio File Path** | Web asset stream | `assets/audio.m4a` (~27 MB) bundled locally |
| **Background Audio** | Dependent on browser tab lifecycle | Native Android foreground service (`just_audio_background`) |
| **Lock-Screen Controls** | Basic browser media session | System lock-screen media controls & artwork |
| **Notification Drawer** | Browser media notification | Native Android `MediaStyle` notification with seek |
| **Audio Focus** | Managed by browser | Handles phone calls & headphone unplugging (`audio_session`) |
| **Sleep Timer** | Presets: 15m, 30m, 45m, 60m | Presets: 15m, 30m, 45m, 60m |
| **Speed Control** | 0.75x, 1.0x, 1.25x, 1.5x, 2.0x | 0.75x, 1.0x, 1.25x, 1.5x, 2.0x |
| **Scrubbing** | Dual circular dial & linear slider | Dual circular dial & linear slider |

---

## 3. Audio Information & Attribution

- **Vocalist & Commentary:** Sri Ghantasala Venkateswara Rao (1922–1974)
- **Language:** Telugu with Sanskrit verses
- **Duration:** Approximately 1 Hour, 13 Minutes
- **Local Asset:** `assets/audio.m4a` (~27.0 MB)
- **Attribution & Rights:** Full credit is given to Sri Ghantasala Venkateswara Rao for his iconic recitation. The project maintainer does not claim ownership of the recording. The audio remains subject to the rights of its respective copyright owners.

---

## 4. Technical Summary

### 4.1 Asset & Codec Details
- **Container Format:** MPEG-4 Audio (`.m4a`)
- **Asset Size:** ~27.0 MB bundled in `assets/audio.m4a`
- **Track Duration:** ~73 minutes

### 4.2 Android Application
- **Minimum SDK:** API Level 21 (Android 5.0 Lollipop)
- **Foreground Service Permissions:** `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK`, `WAKE_LOCK`
- **Audio Service Engine:** `just_audio`, `just_audio_background`, `audio_session`

### 4.3 Web Application
- **Framework:** Flutter Web (Material 3)
- **Supported Browsers:** Modern releases of Chrome, Safari, Firefox, Edge

---

## 5. Controls Reference

- **Radial Dial Scrubber:** Positioned around `assets/artwork.png`. Touch and mouse gestures map rotational angle to audio playback timestamp.
- **Linear Progress Bar:** Synchronized slider indicating elapsed and total duration with scrubbing feedback.
- **Speed Presets:** Selectable rates (`0.75x`, `1.0x`, `1.25x`, `1.5x`, `2.0x`).
- **Sleep Timer:** Countdown presets (`15m`, `30m`, `45m`, `60m`) with live remaining-time feedback and graceful stop on expiry.

---

## 6. Android APK Sideloading & Installation Guide

1. **Download APK:** Download `app-release.apk` from the official repository release:
   `https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android`
2. **Open the Package:** Tap the downloaded file from your browser downloads or file manager.
3. **Authorize Installation:** If prompted by Android security, allow installation from this source.
4. **Launch & Listen:** Tap *Install* to complete setup. Playback is self-contained and works completely offline.
