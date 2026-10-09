import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:bhagavad_gita/screens/player_screen.dart';
import 'package:bhagavad_gita/screens/splash_screen.dart';
import 'package:bhagavad_gita/services/audio_player_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    // Lock orientation strictly to portrait on mobile devices
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize just_audio_background for media notification and session support.
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.reshapel.bhagavadgita.channel.audio',
      androidNotificationChannelName: 'Bhagavad Gita Playback',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'mipmap/ic_launcher',
    );
    // Configure audio session for media playback, audio focus handling,
    // and interruption / headphone disconnect handling.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  runApp(const BhagavadGitaApp());
}

class BhagavadGitaApp extends StatelessWidget {
  const BhagavadGitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhagavad Gita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: const Color(0xFFFDFDFD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F),
          primary: const Color(0xFFD32F2F),
          secondary: const Color(0xFFFFCDD2),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          ),
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: Color(0xFFD32F2F),
          inactiveTrackColor: Color(0xFFFFCDD2),
          thumbColor: Color(0xFFD32F2F),
          overlayColor: Color(0x33D32F2F),
          trackHeight: 6,
        ),
      ),
      home: Builder(
        builder: (context) => SplashScreen(
          onSplashComplete: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const GitaPlayerScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 600),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GitaPlayerScreen extends StatefulWidget {
  const GitaPlayerScreen({super.key});

  @override
  State<GitaPlayerScreen> createState() => _GitaPlayerScreenState();
}

class _GitaPlayerScreenState extends State<GitaPlayerScreen> {
  late AudioPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = AudioPlayerController();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _playerController.initialize('assets/audio.m4a');
    } on AudioInitializationException catch (e) {
      debugPrint('Error loading audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading audio: ${e.message}')),
        );
      }
    } catch (e) {
      debugPrint('Error loading audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading audio: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerScreen(controller: _playerController);
  }
}
