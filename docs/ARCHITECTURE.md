# Technical Architecture & System Design

**Project:** Bhagavad Gita Audio Player (Android & Web)  
**Repository:** `PrasheelVarma/BhagavadGita`  
**Audio Rendition:** Sri Ghantasala Venkateswara Rao (Telugu Recitation & Commentary, 73 Minutes)  
**Target Environments:** Android (API 21+ Lollipop to Android 15), Web (Modern HTML5 Browsers)

---

## 1. System Overview & Design Principles

The Bhagavad Gita Audio Player is engineered as a zero-dependency, distraction-free devotional listening environment. It serves two distinct distribution targets from a single Flutter/Dart codebase:

```
                                  +---------------------------------------+
                                  |         Bhagavad Gita Codebase        |
                                  |         (Flutter 3 / Dart 3)          |
                                  +---------------------------------------+
                                                     |
                         +---------------------------+---------------------------+
                         |                                                       |
                         v                                                       v
        +---------------------------------+                     +---------------------------------+
        |      Android Native Target      |                     |        Web Client Target        |
        +---------------------------------+                     +---------------------------------+
        | - Bundled Offline Asset (27MB)  |                     | - Responsive Web Presentation   |
        | - Foreground Audio Service      |                     | - Restrained Devotional Web UI  |
        | - Lockscreen & Notification     |                     | - Instant In-Browser Player     |
        | - Audio Session / Focus Mgmt    |                     | - Direct Listening & Downloads  |
        | - Direct Player Lifecycle       |                     | - Persistent State Controller   |
        +---------------------------------+                     +---------------------------------+
                         |                                                       |
                         v                                                       v
        +---------------------------------+                     +---------------------------------+
        |       Android OS Subsystems     |                     |      Standard Web Browsers      |
        |  (MediaSessionCompat / Service) |                     |  (Chrome, Safari, Firefox, Edge)|
        +---------------------------------+                     +---------------------------------+
```

### Core Architecture Principles

1. **Self-Contained Offline Integrity (Android):** The complete 73-minute recitation is packaged as a bundled asset (`assets/audio.m4a`). Playback does not depend on external content delivery networks (CDNs), streaming servers, or network sockets.
2. **Zero Telemetry & Absolute Privacy:** The codebase contains no advertising SDKs, tracking pixels, device fingerprinting, or user analytics. No user accounts or authentication barriers exist.
3. **Dual Scrubbing Mathematics:** Seek operations are supported through both a radial dial scrubber (mapped via polar coordinates $[-\pi, \pi]$ around the artwork) and a synchronized linear progress bar.
4. **Persistent Playback During Web Navigation:** On the web target, the `AudioPlayerController` resides in the root `WebsiteApp` state, persisting audio streams seamlessly while the user navigates between Home, Product Specs, Downloads, Chapter Index, About, and Contact pages.

---

## 2. Directory Layout & Module Boundaries

```
BhagavadGita/
├── android/                           # Native Android Gradle configuration & manifests
│   └── app/src/main/
│       ├── AndroidManifest.xml        # Foreground service & media permissions
│       └── res/                       # Icons, adaptive drawables, splash styles
├── assets/                            # Bundled media & static imagery
│   ├── artwork.png                    # Album artwork (dial centerpiece)
│   ├── audio.m4a                      # 73-min Ghantasala recitation (AAC, 27 MB)
│   ├── img1.png / img2.png            # Visual elements & branding badges
│   └── splash.png                     # Native launcher splash asset
├── docs/                              # Architecture, technical specs & guides
│   └── ARCHITECTURE.md                # System engineering specification
├── lib/
│   ├── main.dart                      # Runtime entry point & platform routing
│   ├── screens/
│   │   ├── player_screen.dart         # Core playback UI, dial scrubber & controls
│   │   └── splash_screen.dart         # Mobile startup animation
│   ├── services/
│   │   └── audio_player_controller.dart # Player state machine & audio session wrapper
│   └── web/                           # Public-facing product website & web player
│       ├── pages/
│       │   ├── about_page.dart        # Rendition heritage, cultural context & credits
│       │   ├── contact_page.dart      # Issue tracker, GitHub links & contributions
│       │   ├── home_page.dart         # Product showcase, platform matrix & specs
│       │   └── player_page.dart       # Web viewport framing for the core player
│       ├── theme.dart                 # Color tokens, typography & responsive breakpoints
│       ├── website_app.dart           # Web application shell & routing state
│       ├── utils/
│       │   ├── url_launcher_helper.dart # Platform-agnostic URL launcher
│       │   ├── url_launcher_stub.dart   # Fallback stub
│       │   └── url_launcher_web.dart    # Web-specific `window.open` integration
│       └── widgets/
│           ├── website_footer.dart    # Comprehensive product sitemap & copyright
│           └── website_header.dart    # Sticky glassmorphic navigation header
└── web/                               # Flutter web compilation harness
    ├── index.html                     # HTML5 entry, preloader & meta tags
    ├── manifest.json                  # PWA metadata & theme configuration
    └── favicon.png                    # Browser tab icon
```

---

## 3. Audio Engine & State Management Architecture

### 3.1 Audio Subsystem Stack

```
+-------------------------------------------------------------------+
|                           UI Layer                                |
|        PlayerScreen (Mobile)  /  PlayerPage (Web Shell)           |
+-------------------------------------------------------------------+
                                  |
                                  v
+-------------------------------------------------------------------+
|               services/audio_player_controller.dart               |
|  - ValueNotifier / ChangeNotifier State Machine                   |
|  - Play / Pause / Seek / Speed / Loop / Sleep Timer logic         |
|  - Stream subscriptions (position, duration, playerState)        |
+-------------------------------------------------------------------+
                                  |
                +-----------------+-----------------+
                | (Android Native)                  | (Flutter Web)
                v                                   v
+-------------------------------+   +-------------------------------+
|     just_audio_background     |   |          just_audio           |
| - Android Foreground Service  |   | - HTML5 Audio Element         |
| - MediaSessionCompat Handler  |   | - Web Audio API Decode        |
| - Notification MediaStyle     |   | - Asset stream handler        |
+-------------------------------+   +-------------------------------+
                |
                v
+-------------------------------+
|         audio_session         |
| - AUDIOFOCUS_GAIN             |
| - Headset unplugged (Duck/    |
|   Pause on noisy broadcast)   |
+-------------------------------+
```

### 3.2 State Controller Contract (`AudioPlayerController`)

The `AudioPlayerController` abstracts the underlying `just_audio.AudioPlayer` instance to prevent platform-specific leaks into UI widgets:

| State Field | Type | Description |
|---|---|---|
| `playerState` | `PlayerState` | Combination of `playing` (boolean) and `processingState` (idle, loading, buffering, ready, completed). |
| `position` | `Duration` | Current playback timestamp, synchronized at ~200ms intervals. |
| `duration` | `Duration` | Total media length (01:13:40 for bundled Ghantasala recording). |
| `speed` | `double` | Playback speed rate (`0.75x`, `1.0x`, `1.25x`, `1.5x`, `2.0x`). |
| `isLooping` | `bool` | Single-track continuous repeat toggle. |
| `sleepTimer` | `Duration?` | Active countdown budget (`15m`, `30m`, `45m`, `60m`) terminating playback upon expiry. |

### 3.3 Audio Focus & Interruption Policy (Android)

Android audio session configuration is declared in `main.dart`:

```dart
final session = await AudioSession.instance;
await session.configure(const AudioSessionConfiguration.music());
```

- **Becoming Noisy:** When wired headphones or Bluetooth audio devices disconnect, the session triggers an immediate pause to prevent unexpected speaker output.
- **Transient Loss (Phone Calls / GPS Navigation):** Handles ducking or temporary pauses, resuming automatically when system focus returns.

---

## 4. Radial Scrubber Mathematics

The centerpiece of `PlayerScreen` is the circular dial surrounding `assets/artwork.png`. It allows intuitive seek operations alongside traditional linear sliders.

```
                         -Y (12 o'clock / Start: 00:00)
                                      |
                                      |  theta = 0
                                      |
         theta = -pi/2 (-90 deg)      |       theta = +pi/2 (+90 deg)
         -X <-------------------------+-------------------------> +X
                                      |
                                      |
                                      |  theta = +-pi (180 deg)
                                     +Y (6 o'clock / Midpoint: 36:50)
```

### Trigonometric Calculation:
1. **Touch Coordinate Translation:** Given local gesture coordinate $(P_x, P_y)$ and dial center $(C_x, C_y)$:
   $$\Delta x = P_x - C_x, \quad \Delta y = P_y - C_y$$
2. **Angle Computation:**
   $$\theta = \operatorname{atan2}(\Delta y, \Delta x)$$
   Offsetting reference from 3 o'clock to 12 o'clock:
   $$\phi = \left(\theta + \frac{\pi}{2}\right) \pmod{2\pi}$$
3. **Normalized Position Mapping:**
   $$\text{Progress Ratio } r = \frac{\phi}{2\pi} \in [0.0, 1.0]$$
   $$\text{Target Seek Timestamp} = r \times \text{Total Duration}$$

---

## 5. Public Website Architecture

The web frontend is designed as a calm, distraction-free devotional listening environment. It provides direct listening in modern browsers, download access to the standalone Android APK, and essential project attribution.

### 5.1 Page & Section Organization

```
[ Navigation Header: Logo, Title, Navigation (Home, Player, About, Contact) ]
  │
  ├── 1. Home Page
  │      ├── Hero Section: Clear Introduction, Reverent Artwork & Dual CTAs
  │      ├── Platform Overview: In-Browser Web Stream vs. 100% Offline Android APK
  │      └── Listening Highlights: Offline Android, Dual Scrubber & Ad-Free Focus
  │
  ├── 2. Player Page
  │      ├── Audio Playback Screen (Centered Desktop Frame / Native Mobile Viewport)
  │      └── Dual Radial Dial & Synchronized Linear Timeline
  │
  ├── 3. About Page
  │      ├── Devotional Purpose & Cultural Background
  │      ├── Web vs. Android Platform Comparison
  │      ├── Educational Guide to the 18 Chapters (Sanskrit, Telugu, Themes)
  │      ├── Vocalist Attribution (Sri Ghantasala Venkateswara Rao) & Copyright Notice
  │      └── Technology & Repository Terms
  │
  ├── 4. Contact Page
  │      ├── Feedback & Defect Reporting via GitHub Issues
  │      ├── Maintainer & Source Repository Reference
  │      └── Code Usage & Contribution Policy
  │
  └── 5. Footer
         ├── Cultural Attribution & Non-Ownership Disclaimer
         ├── Clean Navigation Sitemap
         └── Repository & Release Links
```

### 5.2 Responsive Breakpoint Strategy

Defined in `lib/web/theme.dart`:

| Breakpoint | Viewport Width | Layout Behavior |
|---|---|---|
| **Desktop / Wide** | $> 900\text{ px}$ | Two-column hero, side-by-side comparison cards, 3-column features, horizontal navbar. |
| **Tablet** | $600\text{ px} - 900\text{ px}$ | Centered hero, stacked comparison cards, condensed horizontal navbar. |
| **Mobile** | $< 600\text{ px}$ | Single-column stacked layout, full-width touch buttons, popup menu, full-bleed player. |

---

## 6. Security, Privacy & Integrity Specifications

1. **Permission Audit:**
   - Android permissions requested: `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK`, `WAKE_LOCK`.
   - Permissions rejected: Internet access required for playback (none), location (none), camera/mic (none), contacts/storage (none).
2. **Offline Sandboxing:** Once downloaded, the application executes entirely within the client runtime.
3. **Artifact Verification:** Release packages are signed with release keystores and published with verifiable SHA-256 checksums on GitHub.

---

## 7. Build & Deployment Pipelines

### Android Builds
- **Per-ABI Split APKs (reduced download footprint):**
  ```bash
  flutter build apk --split-per-abi --release
  ```
- **Unified App Bundle (Google Play Store):**
  ```bash
  flutter build appbundle --release
  ```

### Web Build
- **Optimized Static Compilation:**
  ```bash
  flutter build web --release --pwa-strategy=offline-first
  ```
  The generated output in `build/web/` is ready for static deployment to GitHub Pages, Cloudflare Pages, or Firebase Hosting.
