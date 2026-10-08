import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../services/audio_player_controller.dart';

class PlayerScreen extends StatefulWidget {
  final AudioPlayerController controller;

  const PlayerScreen({
    super.key,
    required this.controller,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final AudioPlayerController _controller;
  double? _dragPosition;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final totalSeconds = duration.inSeconds;

    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  double get _sliderValue {
    if (_dragPosition != null) {
      return _dragPosition!;
    }
    if (_controller.duration <= Duration.zero) {
      return 0;
    }

    final value = _controller.position.inMilliseconds.toDouble();
    final max = _controller.duration.inMilliseconds.toDouble();

    return value.clamp(0.0, max);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bhagavad Gita'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),

                  // Unified Divine Chakra Artwork Seeker
                  _DivineChakraSeekControl(
                    imagePath: 'assets/artwork.png',
                    isPlaying: _controller.isPlaying,
                    position: _dragPosition != null
                        ? Duration(milliseconds: _dragPosition!.round())
                        : _controller.position,
                    duration: _controller.duration,
                    onChanged: (duration) {
                      if (_controller.isInitialized && !_controller.isLoading) {
                        setState(() {
                          _dragPosition = duration.inMilliseconds.toDouble();
                        });
                      }
                    },
                    onChangeEnd: (duration) {
                      if (_controller.isInitialized && !_controller.isLoading) {
                        _controller.seek(duration);
                        setState(() {
                          _dragPosition = null;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Bhagavad Gita',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Song of the Spirit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Horizontal slider - synchronized with circular seeker
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      showValueIndicator: ShowValueIndicator.onDrag,
                    ),
                    child: Slider(
                      value: _sliderValue,
                      min: 0,
                      max: _controller.duration > Duration.zero
                          ? _controller.duration.inMilliseconds.toDouble()
                          : 1,
                      label: _formatDuration(
                          Duration(milliseconds: _sliderValue.round())),
                      onChanged: _controller.isInitialized && !_controller.isLoading
                          ? (value) {
                              setState(() {
                                _dragPosition = value;
                              });
                            }
                          : null,
                      onChangeEnd: _controller.isInitialized && !_controller.isLoading
                          ? (value) {
                              _controller.seek(
                                Duration(milliseconds: value.round()),
                              );
                              setState(() {
                                _dragPosition = null;
                              });
                            }
                          : null,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(
                            Duration(milliseconds: _sliderValue.round()),
                          ),
                          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          _formatDuration(
                            _controller.duration,
                          ),
                          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  _buildPlaybackButton(),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaybackButton() {
    if (_controller.isLoading) {
      return const SizedBox(
        width: 180,
        height: 60,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_controller.hasError) {
      return ElevatedButton.icon(
        onPressed: () async {
          await _controller.tryRecover();
        },
        icon: const Icon(
          Icons.refresh_rounded,
          size: 24,
        ),
        label: const Text('Retry'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.shade300,
          foregroundColor: Colors.white,
          minimumSize: const Size(180, 60),
        ),
      );
    }

    String label = 'Play';
    IconData icon = Icons.play_arrow_rounded;

    if (_controller.isPlaying) {
      label = 'Pause';
      icon = Icons.pause_rounded;
    } else if (_controller.isCompleted) {
      label = 'Replay';
      icon = Icons.replay_rounded;
    } else if (_controller.position > Duration.zero) {
      label = 'Resume';
    }

    return ElevatedButton.icon(
      onPressed: () {
        if (_controller.isCompleted) {
          _controller.restart();
        } else {
          _controller.togglePlayPause();
        }
      },
      icon: Icon(
        icon,
        size: 36,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(180, 60),
      ),
    );
  }
}

/// Unified artwork widget with a layered rotating Divine Chakra halo and an outer circumference seeker.
class _DivineChakraSeekControl extends StatefulWidget {
  final String imagePath;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const _DivineChakraSeekControl({
    required this.imagePath,
    required this.isPlaying,
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  State<_DivineChakraSeekControl> createState() =>
      _DivineChakraSeekControlState();
}

class _DivineChakraSeekControlState extends State<_DivineChakraSeekControl>
    with SingleTickerProviderStateMixin {
  double _dragAngle = -1;
  static const double _size = 276.0;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _updateAngle(Offset localPosition) {
    const center = Offset(_size / 2, _size / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    var angle = math.atan2(dy, dx) + math.pi / 2;
    if (angle < 0) angle += 2 * math.pi;

    setState(() {
      _dragAngle = angle;
    });

    if (widget.duration > Duration.zero) {
      final percent = (angle / (2 * math.pi)).clamp(0.0, 1.0);
      final dragMillis = widget.duration.inMilliseconds * percent;
      widget.onChanged?.call(Duration(milliseconds: dragMillis.round()));
    }
  }

  void _endDrag() {
    if (_dragAngle >= 0 && widget.duration > Duration.zero) {
      final percent = (_dragAngle / (2 * math.pi)).clamp(0.0, 1.0);
      final dragMillis = widget.duration.inMilliseconds * percent;
      widget.onChangeEnd?.call(Duration(milliseconds: dragMillis.round()));
    }
    setState(() {
      _dragAngle = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final percent = widget.duration.inMilliseconds > 0
        ? (widget.position.inMilliseconds / widget.duration.inMilliseconds)
            .clamp(0.0, 1.0)
        : 0.0;

    final currentProgress = _dragAngle >= 0
        ? (_dragAngle / (2 * math.pi)).clamp(0.0, 1.0)
        : percent;

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final animValue = _animController.value;
        final pulse = widget.isPlaying ? (math.sin(animValue * 2 * math.pi) * 0.5 + 0.5) : 0.0;

        return SizedBox(
          width: _size,
          height: _size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Ambient Golden-Saffron Breathing Glow
              Container(
                width: 240 + (pulse * 16),
                height: 240 + (pulse * 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFB300).withValues(alpha: 0.22 + (pulse * 0.20)),
                      blurRadius: 30 + (pulse * 10),
                      spreadRadius: 4 + (pulse * 6),
                    ),
                    BoxShadow(
                      color: const Color(0xFFD32F2F).withValues(alpha: 0.12 + (pulse * 0.10)),
                      blurRadius: 40 + (pulse * 8),
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),

              // 2. Centered Circular Artwork
              Container(
                width: 184,
                height: 184,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFFD54F),
                    width: 3.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD32F2F).withValues(alpha: 0.25),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    widget.imagePath,
                    width: 184,
                    height: 184,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 3. Layered Rotating Chakra Rays & Outer Circumference Seeker
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanDown: (details) => _updateAngle(details.localPosition),
                  onPanUpdate: (details) => _updateAngle(details.localPosition),
                  onPanEnd: (_) => _endDrag(),
                  onPanCancel: () {
                    setState(() {
                      _dragAngle = -1;
                    });
                  },
                  onTapDown: (details) => _updateAngle(details.localPosition),
                  onTapUp: (_) => _endDrag(),
                  child: CustomPaint(
                    size: const Size(_size, _size),
                    painter: _DivineChakraSeekPainter(
                      progress: currentProgress,
                      isDragging: _dragAngle >= 0,
                      isPlaying: widget.isPlaying,
                      animValue: animValue,
                      pulse: pulse,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Painter rendering concentric layered visuals:
/// - Dedicated Inner Halo Band: Rotating 16-ray Sudarshana Chakra & golden aura rays.
/// - Dedicated Outer Orbit: Clear circumference seek track & illuminated jewel thumb.
class _DivineChakraSeekPainter extends CustomPainter {
  final double progress;
  final bool isDragging;
  final bool isPlaying;
  final double animValue;
  final double pulse;

  _DivineChakraSeekPainter({
    required this.progress,
    required this.isDragging,
    required this.isPlaying,
    required this.animValue,
    required this.pulse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Layer Radii:
    // Artwork radius = 92.0
    // Chakra rays inner radius = 98.0, outer radius = 114.0
    // Seek track radius = 126.0 (Clear outer orbit, never hides the chakra rays)
    const chakraInnerRadius = 98.0;
    const chakraOuterRadius = 114.0;
    final seekRadius = (size.width / 2) - 10.0; // 128.0

    // -------------------------------------------------------------
    // LAYER 1: Rotating Sacred Sudarshana Chakra Halo
    // -------------------------------------------------------------
    final rotationAngle = isPlaying ? (animValue * 2 * math.pi) : 0.0;

    // Inner subtle golden boundary ring
    final innerRingPaint = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: 0.35 + (pulse * 0.20))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center, chakraInnerRadius, innerRingPaint);

    // Mid boundary ring
    final midRingPaint = Paint()
      ..color = const Color(0xFFFFB300).withValues(alpha: 0.25 + (pulse * 0.15))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, chakraOuterRadius, midRingPaint);

    // 16 Sacred Chakra Rays / Spokes
    final spokePaint = Paint()
      ..color = const Color(0xFFFF8F00).withValues(alpha: 0.50 + (pulse * 0.30))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final rayTipPaint = Paint()
      ..color = const Color(0xFFD32F2F).withValues(alpha: 0.70 + (pulse * 0.25))
      ..style = PaintingStyle.fill;

    final goldBeadPaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 16; i++) {
      final rayAngle = (i * 2 * math.pi / 16) + rotationAngle;
      final pInner = Offset(
        center.dx + chakraInnerRadius * math.cos(rayAngle),
        center.dy + chakraInnerRadius * math.sin(rayAngle),
      );
      final pOuter = Offset(
        center.dx + chakraOuterRadius * math.cos(rayAngle),
        center.dy + chakraOuterRadius * math.sin(rayAngle),
      );

      // Draw spoke line
      canvas.drawLine(pInner, pOuter, spokePaint);

      // Draw decorative tip bead
      canvas.drawCircle(pOuter, 2.2, rayTipPaint);
      canvas.drawCircle(pOuter, 1.0, goldBeadPaint);
    }

    // -------------------------------------------------------------
    // LAYER 2: Outer Circumference Seek Track (Orbits independently)
    // -------------------------------------------------------------
    // Background track ring
    final trackBgPaint = Paint()
      ..color = const Color(0xFFFFE082).withValues(alpha: 0.40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.5;
    canvas.drawCircle(center, seekRadius, trackBgPaint);

    // Subtle micro-ticks along the track (12 cardinal hours)
    final tickPaint = Paint()
      ..color = const Color(0xFFFFA000).withValues(alpha: 0.40)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 12; i++) {
      final tickAngle = (i * 2 * math.pi / 12) - math.pi / 2;
      final tickPos = Offset(
        center.dx + seekRadius * math.cos(tickAngle),
        center.dy + seekRadius * math.sin(tickAngle),
      );
      canvas.drawCircle(tickPos, (i % 3 == 0) ? 2.2 : 1.4, tickPaint);
    }

    // Active Progress Arc
    if (progress > 0.0) {
      final sweepAngle = (progress * 2 * math.pi).clamp(0.0, 2 * math.pi);
      final progressRect = Rect.fromCircle(center: center, radius: seekRadius);

      final progressPaint = Paint()
        ..shader = const SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: 3 * math.pi / 2,
          colors: [
            Color(0xFFFFD54F),
            Color(0xFFFF7043),
            Color(0xFFD32F2F),
          ],
          stops: [0.0, 0.50, 1.0],
          transform: GradientRotation(-math.pi / 2),
        ).createShader(progressRect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isDragging ? 8.0 : 6.5
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(progressRect, -math.pi / 2, sweepAngle, false, progressPaint);

      // Illuminated Glowing Jewel Thumb
      final thumbAngle = -math.pi / 2 + sweepAngle;
      final thumbOffset = Offset(
        center.dx + seekRadius * math.cos(thumbAngle),
        center.dy + seekRadius * math.sin(thumbAngle),
      );

      // Thumb Outer Halo Glow
      final glowPaint = Paint()
        ..color = const Color(0xFFFFB300).withValues(alpha: 0.60 + (pulse * 0.25))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(thumbOffset, isDragging ? 15 : 12, glowPaint);

      // Outer Gold Rim
      final outerRingPaint = Paint()..color = const Color(0xFFFFD54F);
      canvas.drawCircle(thumbOffset, isDragging ? 10.5 : 9.0, outerRingPaint);

      // Inner Crimson Ruby Core
      final rubyCorePaint = Paint()..color = const Color(0xFFD32F2F);
      canvas.drawCircle(thumbOffset, isDragging ? 7.0 : 5.5, rubyCorePaint);

      // Center White Sparkle
      final centerShinePaint = Paint()..color = Colors.white;
      canvas.drawCircle(thumbOffset + const Offset(-1.2, -1.2), 2.0, centerShinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DivineChakraSeekPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isDragging != isDragging ||
        oldDelegate.isPlaying != isPlaying ||
        oldDelegate.animValue != animValue ||
        oldDelegate.pulse != pulse;
  }
}
