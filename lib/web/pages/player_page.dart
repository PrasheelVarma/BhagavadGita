import 'package:flutter/material.dart';

import '../../screens/player_screen.dart';
import '../../services/audio_player_controller.dart';
import '../theme.dart';

/// Player page — wraps the existing PlayerScreen for the website.
/// Preserves the player's original design and controls untouched;
/// the surrounding frame adapts to desktop/tablet/mobile viewports.
class PlayerPage extends StatelessWidget {
  final AudioPlayerController controller;

  const PlayerPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > GitaLayout.mobileBreakpoint;

    if (!isWide) {
      // On mobile-width browsers, let the player fill the full width
      // exactly as it does on Android — no extra framing needed.
      return PlayerScreen(controller: controller);
    }

    // On wider viewports, center the player inside a constrained column
    // with a subtle background to frame it naturally.
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: GitaColors.warmWhite,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: PlayerScreen(controller: controller),
            ),
          ),
        ),
      ),
    );
  }
}
