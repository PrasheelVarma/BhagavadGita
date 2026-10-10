import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onSplashComplete;

  const SplashScreen({
    super.key,
    required this.onSplashComplete,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _imageFade;
  late final Animation<double> _imageScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleFade;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // 1. Splash image entrance (scale & fade)
    _imageFade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _imageScale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    // 2. Title entrance (slide up & fade)
    _titleFade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.35, 0.8, curve: Curves.easeIn),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.35, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // 3. Subtitle entrance
    _subtitleFade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.55, 0.95, curve: Curves.easeIn),
    );

    _animController.forward();

    _navigationTimer = Timer(const Duration(milliseconds: 2600), () {
      if (mounted) {
        widget.onSplashComplete();
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxAvailable = math.min(size.width * 0.72, size.height * 0.40);
    final imageWidth = maxAvailable.clamp(160.0, 300.0);
    final isShort = size.height < 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF8E7), // Sacred warm dawn
              Color(0xFFFFECD2), // Soft golden amber
              Color(0xFFFFF3E0), // Saffron aura
              Color(0xFFFAF7F2), // Divine ivory pearl
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: isShort ? 12 : 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildArtwork(imageWidth),
                      SizedBox(height: isShort ? 20 : 32),
                      _buildTitleSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArtwork(double imageWidth) {
    return FadeTransition(
      opacity: _imageFade,
      child: ScaleTransition(
        scale: _imageScale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient Golden Breathing Glow
            AnimatedBuilder(
              animation: _animController,
              builder: (context, _) {
                final pulse =
                    math.sin(_animController.value * math.pi) * 0.5 + 0.5;
                return Container(
                  width: imageWidth * 0.92 + (pulse * 16),
                  height: imageWidth * 0.92 + (pulse * 16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFB300).withValues(
                          alpha: 0.25 + (pulse * 0.2),
                        ),
                        blurRadius: 36 + (pulse * 12),
                        spreadRadius: 6 + (pulse * 6),
                      ),
                      BoxShadow(
                        color: const Color(0xFFD32F2F).withValues(
                          alpha: 0.12 + (pulse * 0.1),
                        ),
                        blurRadius: 40,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                );
              },
            ),

            // Splash Image Container
            Container(
              width: imageWidth,
              height: imageWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFD54F),
                  width: 3.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD32F2F).withValues(alpha: 0.22),
                    blurRadius: 22,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/splash.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return FadeTransition(
      opacity: _titleFade,
      child: SlideTransition(
        position: _titleSlide,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bhagavad Gita',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFFB71C1C),
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    color: Color(0x33B71C1C),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Animated Tagline Capsule
            FadeTransition(
              opacity: _subtitleFade,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFFFCC80),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '✦',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Song of the Spirit',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '✦',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
