# Flutter ProGuard Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.**  { *; }

# audio_service and just_audio rules for background playback
-keep class com.ryanheise.** { *; }
-keep class com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio.** { *; }

# Android Media & AudioSession
-keep class androidx.media.** { *; }
-keep class androidx.media3.** { *; }
-keep class com.google.android.exoplayer2.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}
