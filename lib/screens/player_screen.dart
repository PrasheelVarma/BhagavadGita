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

    final value =
        _controller.position.inMilliseconds.toDouble();
    final value = _controller.position.inMilliseconds.toDouble();
    final max = _controller.duration.inMilliseconds.toDouble();

    final max =
        _controller.duration.inMilliseconds.toDouble();

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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 220,
                      width: 220,
                      fit: BoxFit.cover,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 40),
                  const SizedBox(height: 32),

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

                  const SizedBox(height: 48),
                  const SizedBox(height: 40),

                  _CircularSeekControl(
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

                  const SizedBox(height: 40),

                  // Slider - always enabled except during loading
                  Slider(
                    value: _sliderValue,
                    min: 0,
                    max: _controller.duration > Duration.zero
                        ? _controller.duration.inMilliseconds
                            .toDouble()
                        : 1,
                    onChanged: _controller.isInitialized &&
                            !_controller.isLoading
                        ? (value) {
                            setState(() {
                              // Visual slider update while dragging.
                            });
                          }
                        : null,
                    onChangeEnd: _controller.isInitialized &&
                            !_controller.isLoading
                        ? (value) {
                            _controller.seek(
                              Duration(
                                milliseconds: value.round(),
                              ),
                            );
                          }
                        : null,
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      showValueIndicator: ShowValueIndicator.always,
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
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(
                            _controller.position,
                            Duration(milliseconds: _sliderValue.round()),
                          ),
                        ),
                        Text(
                          _formatDuration(
                            _controller.duration,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildPlaybackButton(),

                  const SizedBox(height: 60),
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
      // Show recovery button for recoverable errors
      return ElevatedButton.icon(
        onPressed: () async {
          // Try to recover from error
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

    if (_controller.isCompleted) {
      // Only show replay button if not busy
      return ElevatedButton.icon(
        onPressed: _controller.isBusy
            ? null
            : () => _controller.restart(),
        icon: const Icon(
          Icons.replay_rounded,
          size: 24,
        ),
        label: const Text('Replay'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(180, 60),
        ),
      );
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

    // Normal play/pause - disable only if busy
    return ElevatedButton.icon(
      onPressed: _controller.isBusy
          ? null
          : () => _controller.togglePlayPause(),
          : () {
              if (_controller.isCompleted) {
                _controller.restart();
              } else {
                _controller.togglePlayPause();
              }
            },
      icon: Icon(
        _controller.isPlaying
            ? Icons.pause_rounded
            : Icons.play_arrow_rounded,
        icon,
        size: 36,
      ),
      label: Text(
        _controller.isPlaying ? 'Pause' : 'Play',
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

class _CircularSeekControl extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const _CircularSeekControl({
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  State<_CircularSeekControl> createState() => _CircularSeekControlState();
}

class _CircularSeekControlState extends State<_CircularSeekControl> {
  double _dragAngle = -1;
  static const double _size = 150.0;

  void _updateAngle(Offset localPosition) {
    final center = const Offset(_size / 2, _size / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    
    var angle = math.atan2(dy, dx) + math.pi / 2;
    if (angle < 0) angle += 2 * math.pi;

    setState(() {
      _dragAngle = angle;
    });

    if (widget.duration > Duration.zero) {
      final percent = angle / (2 * math.pi);
      final dragMillis = widget.duration.inMilliseconds * percent;
      widget.onChanged?.call(Duration(milliseconds: dragMillis.round()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final percent = widget.duration.inMilliseconds > 0
        ? widget.position.inMilliseconds / widget.duration.inMilliseconds
        : 0.0;

    return GestureDetector(
      onPanDown: (details) => _updateAngle(details.localPosition),
      onPanUpdate: (details) => _updateAngle(details.localPosition),
      onPanEnd: (details) {
        if (_dragAngle >= 0 && widget.duration > Duration.zero) {
          final percent = _dragAngle / (2 * math.pi);
          final dragMillis = widget.duration.inMilliseconds * percent;
          widget.onChangeEnd?.call(Duration(milliseconds: dragMillis.round()));
        }
        setState(() {
          _dragAngle = -1;
        });
      },
      child: CustomPaint(
        size: const Size(_size, _size),
        painter: _CircularSeekPainter(
          progress: _dragAngle >= 0 ? _dragAngle / (2 * math.pi) : percent,
        ),
      ),
    );
  }
}

class _CircularSeekPainter extends CustomPainter {
  final double progress;
  _CircularSeekPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final progressPaint = Paint()
      ..color = const Color(0xFFD32F2F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      progress * 2 * math.pi,
      false,
      progressPaint,
    );

    final thumbAngle = -math.pi / 2 + progress * 2 * math.pi;
    final thumbOffset = Offset(
      center.dx + radius * math.cos(thumbAngle),
      center.dy + radius * math.sin(thumbAngle),
    );

    final thumbPaint = Paint()..color = const Color(0xFFD32F2F);
    canvas.drawCircle(thumbOffset, 12, thumbPaint);
    final thumbShadow = Paint()..color = Colors.white;
    canvas.drawCircle(thumbOffset, 8, thumbShadow);
  }

  @override
  bool shouldRepaint(covariant _CircularSeekPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
