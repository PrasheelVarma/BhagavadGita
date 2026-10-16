# Bhagavad Gita Product Specification & Feature Guide

**Document Version:** 1.0.0  
**Associated Codebase:** `PrasheelVarma/BhagavadGita`  
**Platforms:** Android (v1.0 Native APK) & Web Application (PWA)

---

## 1. Product Mission & Value Proposition

The Bhagavad Gita Audio Player provides a sacred, distraction-free environment dedicated exclusively to the legendary 73-minute Telugu recitation and commentary by **Sri Ghantasala Venkateswara Rao**. 

Unlike general video or music platforms that insert commercial interruptions, algorithmic recommendations, social notifications, or data tracking, this product operates on three steadfast commitments:
1. **Zero Distraction:** Direct access to playback with no pre-roll ads, banners, or suggested feeds.
2. **Offline Independence:** Native Android distribution embeds the full high-fidelity audio asset (27 MB), ensuring 100% playback reliability without network connectivity.
3. **Respect for Privacy:** No account creation, no analytics telemetry, and no device permission harvesting.

---

## 2. Platform Comparison Matrix

| Capability | Web Application (`/player`) | Native Android App (v1.0 APK) |
|---|---|---|
| **Installation Requirement** | Zero (Instant browser launch) | One-time APK sideload / installation |
| **Network Requirement** | Requires connection on initial page load | 100% offline; zero network required |
| **Audio File Size** | Cached by browser after first load | 27.0 MB bundled inside APK |
| **Background Playback** | Supported in browser tabs (desktop) | Native OS background service (`just_audio_background`) |
| **Lock-Screen Controls** | Dependent on browser media session | Native system lock-screen media controls & artwork |
| **Notification Drawer** | Basic browser media notification | Native Android `MediaStyle` notification with seek |
| **Hardware Audio Focus** | Browser managed | Pauses on headphone disconnect ("Becoming Noisy") |
| **Sleep Timer** | Integrated (15m, 30m, 45m, 60m) | Integrated (15m, 30m, 45m, 60m) |
| **Speed Adjustment** | 0.75x, 1.0x, 1.25x, 1.5x, 2.0x | 0.75x, 1.0x, 1.25x, 1.5x, 2.0x |
| **Looping Mode** | Continuous single-track loop | Continuous single-track loop |
| **Scrubber Controls** | Radial circular dial + Linear slider | Radial circular dial + Linear slider |

---

## 3. Audio Provenance & Heritage

### 3.1 The Rendition
- **Vocalist & Composer:** Sri Ghantasala Venkateswara Rao (1922–1974)
- **Language:** Telugu with Sanskrit Slokas
- **Format:** Melodic chanting of seminal Sanskrit verses followed by fluent Telugu poetic paraphrase and spiritual commentary (*Tatparyam*).
- **Duration:** 1 Hour, 13 Minutes, 40 Seconds (73:40)
- **Cultural Significance:** Recognized as the standard Telugu devotional audio rendition of the Bhagavad Gita across Andhra Pradesh, Telangana, and the global Telugu diaspora for over five decades.

### 3.2 Chapters Covered in the 73-Minute Rendition

| # | Chapter Name (Sanskrit / Telugu) | Core Discourse & Theme |
|---|---|---|
| 1 | **Arjuna Vishada Yoga** | The crisis of conscience on the battlefield of Kurukshetra. |
| 2 | **Sankhya Yoga** | The eternal nature of the soul (*Atman*), duty, and equanimity. |
| 3 | **Karma Yoga** | Selfless action without attachment to fruits or rewards. |
| 4 | **Jnana Karma Sannyasa Yoga** | Divine descent (*Avatarana*) and the fire of wisdom. |
| 5 | **Karma Sannyasa Yoga** | Harmonizing outer action with inner detachment. |
| 6 | **Dhyana Yoga** | Self-mastery, meditation posture, and control of the mind. |
| 7 | **Jnana Vijnana Yoga** | Knowledge of the Absolute and the divine energies. |
| 8 | **Akshara Brahma Yoga** | The path of departure and remembrance of the Divine. |
| 9 | **Raja Vidya Raja Guhya Yoga** | The sovereign secret of unconditional devotion (*Bhakti*). |
| 10 | **Vibhuti Yoga** | The divine manifestations and splendors in creation. |
| 11 | **Vishwarupa Sandarshana Yoga** | Arjuna's vision of Krishna's cosmic, universal form. |
| 12 | **Bhakti Yoga** | The characteristics of an ideal devotee. |
| 13 | **Kshetra Kshetrajna Vibhaga Yoga** | Distinguishing the field (body) from the knower of the field (spirit). |
| 14 | **Gunatraya Vibhaga Yoga** | The interplay of the three modes of nature (*Sattva*, *Rajas*, *Tamas*). |
| 15 | **Purushottama Yoga** | The Cosmic Tree of life and the Supreme Personality. |
| 16 | **Daivasura Sampad Vibhaga Yoga** | The distinction between divine and degraded qualities. |
| 17 | **Shraddhatraya Vibhaga Yoga** | The threefold nature of faith, worship, food, and charity. |
| 18 | **Moksha Sannyasa Yoga** | Final renunciation, surrender (*Saranagati*), and spiritual victory. |

---

## 4. Technical Specifications

### 4.1 Audio Codec & Asset Details
- **Container Format:** MPEG-4 Audio (`.m4a`)
- **Audio Codec:** Advanced Audio Coding (AAC-LC)
- **Bitrate:** ~48 kbps optimized voice compression
- **Sampling Frequency:** 44.1 kHz
- **Channel Allocation:** 2-channel stereo
- **Decoded Runtime:** 4,420 seconds (73m 40s)
- **Local Path:** `assets/audio.m4a`

### 4.2 Android Application Specifications
- **Package Identifier:** `com.reshapel.bhagavadgita`
- **Minimum OS Version:** Android 5.0 (API Level 21 - Lollipop)
- **Target OS Version:** Android 14/15 (API Level 34/35)
- **Release ABI Targets:** `arm64-v8a`, `armeabi-v7a`, `x86_64`
- **Application Permissions:**
  - `android.permission.FOREGROUND_SERVICE`
  - `android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK`
  - `android.permission.WAKE_LOCK`
- **External Network Access:** NOT REQUESTED in release manifest.

### 4.3 Web Application Specifications
- **Framework:** Flutter Web (Material 3)
- **Design System:** Custom Devotional Token Engine (`GitaColors`, `GitaTextStyles`, `GitaLayout`)
- **Supported Browsers:** Google Chrome, Mozilla Firefox, Apple Safari, Microsoft Edge, Brave, Opera
- **Routing Engine:** Client-side state transition (`/`, `/player`, `/about`, `/contact`) with persistent background audio controller.

---

## 5. User Interface & Controls Reference

### 5.1 Radial Dial Scrubber
- Located symmetrically around `assets/artwork.png`.
- Touch tracking translates radial touch angle $\theta \in [0, 2\pi]$ into an exact audio timestamp.
- Golden tick indicators provide rotational tactile feedback.

### 5.2 Linear Progress Scrubber
- Synchronized slider displaying elapsed time `MM:SS` (left) and remaining/total time `MM:SS` (right).
- Seamless touch scrubbing with instant seek dispatch upon release.

### 5.3 Playback Rate Presets
- `0.75x` — Deliberate cadence for study and pronunciation analysis.
- `1.0x` — Original recording tempo.
- `1.25x` / `1.5x` / `2.0x` — Accelerated listening.

### 5.4 Sleep Timer Engine
- Presets: `15 Min`, `30 Min`, `45 Min`, `60 Min`.
- Live visual countdown display indicating remaining duration.
- Gentle playback cessation upon timer completion.

---

## 6. Installation & Sideloading Guide (Android)

1. **Obtain the APK:** Download `app-release.apk` directly from the official repository release:
   `https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android`
2. **Authorize Package Installer:** If prompted by Android security, enable *"Install unknown apps"* for your browser or file manager.
3. **Complete Installation:** Tap *Install* and allow package registration.
4. **Immediate Offline Playback:** Launch the app. No internet access or login is required; playback begins instantly.
