import 'dart:async';
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
  Timer? _sleepTimer;
  Duration? _sleepTimerRemaining;
  Timer? _countdownTicker;

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
    _sleepTimer?.cancel();
    _countdownTicker?.cancel();
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isLandscape ? 44 : 56),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF8E0E00), // Deep temple vermillion
                Color(0xFFB71C1C), // Royal devotional red
                Color(0xFFE65100), // Sacred saffron
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8E0E00).withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFFFFD54F), // Golden ornamental bottom trim
                width: 1.5,
              ),
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Text(
                'Bhagavad Gita',
                style: TextStyle(
                  fontSize: isLandscape ? 17 : 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: const [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
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
          child: isLandscape
              ? _buildLandscapeLayout()
              : _buildPortraitLayout(),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 1. Unified Divine Chakra Artwork Seeker
          _DivineChakraSeekControl(
            size: 260,
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

          // 2. Horizontal seek slider & synchronized time indicators
          _buildSliderSection(),

          // 3. Devotional Media Controls Console Card
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFFFFE082),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.10),
                  blurRadius: 16,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: _buildPlaybackControls(),
          ),

          // 4. Dedicated Devotional Utility Toolbar (Speed, Timer, Loop)
          _buildBottomUtilityBar(),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Scaled Divine Chakra Artwork Seeker
          Expanded(
            flex: 4,
            child: Center(
              child: _DivineChakraSeekControl(
                size: 190,
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
            ),
          ),

          const SizedBox(width: 16),

          // Right: Seek slider + Controls + Utility Toolbar
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSliderSection(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFFFE082),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildPlaybackControls(),
                ),
                _buildBottomUtilityBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 5,
            activeTrackColor: const Color(0xFFD32F2F),
            inactiveTrackColor: const Color(0xFFFFCC80),
            thumbColor: const Color(0xFFD32F2F),
            overlayColor: const Color(0xFFD32F2F).withValues(alpha: 0.15),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 7.5,
              elevation: 3,
            ),
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
            horizontal: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFFE0B2),
                    width: 1,
                  ),
                ),
                child: Text(
                  _formatDuration(
                    Duration(milliseconds: _sliderValue.round()),
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB71C1C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFFE0B2),
                    width: 1,
                  ),
                ),
                child: Text(
                  _formatDuration(
                    _controller.duration,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.brown.shade700,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _setSleepTimer(Duration? duration) {
    _sleepTimer?.cancel();
    _countdownTicker?.cancel();

    if (duration == null || duration == Duration.zero) {
      setState(() {
        _sleepTimerRemaining = null;
      });
      return;
    }

    setState(() {
      _sleepTimerRemaining = duration;
    });

    _countdownTicker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sleepTimerRemaining == null ||
          _sleepTimerRemaining! <= const Duration(seconds: 1)) {
        timer.cancel();
      } else {
        setState(() {
          _sleepTimerRemaining =
              _sleepTimerRemaining! - const Duration(seconds: 1);
        });
      }
    });

    _sleepTimer = Timer(duration, () {
      _countdownTicker?.cancel();
      setState(() {
        _sleepTimerRemaining = null;
      });
      _controller.pause();
    });
  }

  String _formatSleepTimer(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _showSleepTimerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final options = [
          (label: 'Off', duration: null),
          (label: '15 Minutes', duration: const Duration(minutes: 15)),
          (label: '30 Minutes', duration: const Duration(minutes: 30)),
          (label: '45 Minutes', duration: const Duration(minutes: 45)),
          (label: '60 Minutes', duration: const Duration(minutes: 60)),
        ];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E7),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: const Color(0xFFFFCC80), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bedtime_rounded,
                      color: Color(0xFFB71C1C), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Sleep Timer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...options.map((opt) {
                final isSelected = opt.duration == null
                    ? _sleepTimerRemaining == null
                    : _sleepTimerRemaining != null &&
                        _sleepTimerRemaining!.inMinutes <=
                            opt.duration!.inMinutes &&
                        _sleepTimerRemaining!.inMinutes >
                            opt.duration!.inMinutes - 15;
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: isSelected
                      ? const Color(0xFFD32F2F).withValues(alpha: 0.12)
                      : Colors.transparent,
                  leading: Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isSelected
                        ? const Color(0xFFD32F2F)
                        : Colors.grey.shade400,
                  ),
                  title: Text(
                    opt.label,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFFB71C1C)
                          : Colors.brown.shade800,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _setSleepTimer(opt.duration);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showSpeedSelectorSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        const speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E7),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: const Color(0xFFFFCC80), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speed_rounded, color: Color(0xFFB71C1C), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Playback Speed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: speeds.map((s) {
                  final isSelected = _controller.speed == s;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      _controller.setSpeed(s);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFD32F2F)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFD32F2F)
                              : const Color(0xFFFFCC80),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withValues(
                                alpha: isSelected ? 0.22 : 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${s}x',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : Colors.brown.shade800,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomUtilityBar() {
    final speed = _controller.speed;
    final isSpeedActive = speed != 1.0;
    final isTimerActive = _sleepTimerRemaining != null;
    final isLoopActive = _controller.isLooping;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Playback Speed Pill (Tap or Hold to select speed directly)
        _buildUtilityPill(
          icon: Icons.speed_rounded,
          label: '${speed}x',
          tooltip: 'Hold or tap to select playback speed',
          isActive: isSpeedActive,
          onTap: _showSpeedSelectorSheet,
          onLongPress: _showSpeedSelectorSheet,
        ),
        const SizedBox(width: 12),

        // Sleep Timer Pill
        _buildUtilityPill(
          icon: isTimerActive
              ? Icons.bedtime_rounded
              : Icons.bedtime_outlined,
          label: isTimerActive
              ? _formatSleepTimer(_sleepTimerRemaining!)
              : 'Timer',
          tooltip: 'Sleep Timer',
          isActive: isTimerActive,
          onTap: _showSleepTimerSheet,
          onLongPress: _showSleepTimerSheet,
        ),
        const SizedBox(width: 12),

        // Single Track Loop Pill
        _buildUtilityPill(
          icon: Icons.repeat_one_rounded,
          label: isLoopActive ? 'Loop' : 'Once',
          tooltip: isLoopActive
              ? 'Single Track Loop: On'
              : 'Single Track Loop: Off',
          isActive: isLoopActive,
          onTap: () => _controller.toggleLoop(),
          onLongPress: () => _controller.toggleLoop(),
        ),
      ],
    );
  }

  Widget _buildUtilityPill({
    required IconData icon,
    required String label,
    required String tooltip,
    required bool isActive,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFFD32F2F)
                  : Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isActive
                    ? const Color(0xFFD32F2F)
                    : const Color(0xFFFFCC80),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isActive ? Colors.white : const Color(0xFFB71C1C),
                ),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : Colors.brown.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _selectedIntervalIndex = 2; // Default to 30s

  static const List<({String label, int seconds})> _jumpIntervals = [
    (label: '10s', seconds: 10),
    (label: '15s', seconds: 15),
    (label: '30s', seconds: 30),
    (label: '1m', seconds: 60),
    (label: '2m', seconds: 120),
    (label: '5m', seconds: 300),
    (label: '10m', seconds: 600),
    (label: '15m', seconds: 900),
  ];

  ({String label, int seconds}) get _currentInterval =>
      _jumpIntervals[_selectedIntervalIndex];

  void _jump(int seconds) {
    if (!_controller.isInitialized || _controller.isLoading) return;
    final currentMs = _controller.position.inMilliseconds;
    final totalMs = _controller.duration.inMilliseconds;
    if (totalMs <= 0) return;

    final targetMs = (currentMs + (seconds * 1000)).clamp(0, totalMs);
    _controller.seek(Duration(milliseconds: targetMs));
  }

  Widget _buildPlaybackControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Creative interactive circular dial: hold & swipe left/right to change jump duration
        _CircularIntervalDial(
          selectedIndex: _selectedIntervalIndex,
          intervals: _jumpIntervals,
          onIntervalChanged: (newIndex) {
            setState(() {
              _selectedIntervalIndex = newIndex;
            });
          },
        ),

        const SizedBox(height: 18),

        // Symmetrical Controls Row: [ -Skip ]  [ Play/Pause ]  [ +Skip ]
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSkipButton(
              icon: Icons.replay_rounded,
              label: '-${_currentInterval.label}',
              tooltip: 'Rewind ${_currentInterval.label}',
              onPressed: _controller.isInitialized && !_controller.isLoading
                  ? () => _jump(-_currentInterval.seconds)
                  : null,
            ),
            const SizedBox(width: 24),
            _buildCenterActionButton(),
            const SizedBox(width: 24),
            _buildSkipButton(
              icon: Icons.forward_rounded,
              label: '+${_currentInterval.label}',
              tooltip: 'Forward ${_currentInterval.label}',
              onPressed: _controller.isInitialized && !_controller.isLoading
                  ? () => _jump(_currentInterval.seconds)
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkipButton({
    required IconData icon,
    required String label,
    required String tooltip,
    required VoidCallback? onPressed,
  }) {
    final isEnabled = onPressed != null;
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          splashColor: const Color(0xFFFFCC80).withValues(alpha: 0.4),
          child: Ink(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: isEnabled
                    ? const Color(0xFFFFB74D)
                    : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: isEnabled ? 0.12 : 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isEnabled
                      ? const Color(0xFFD32F2F)
                      : Colors.grey.shade400,
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isEnabled
                        ? const Color(0xFFD32F2F)
                        : Colors.grey.shade400,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterActionButton() {
    if (_controller.isLoading) {
      return Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD32F2F)),
            ),
          ),
        ),
      );
    }

    if (_controller.hasError) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await _controller.tryRecover();
          },
          borderRadius: BorderRadius.circular(36),
          child: Ink(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFFF7043), Color(0xFFD32F2F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD32F2F).withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.refresh_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
      );
    }

    IconData icon = Icons.play_arrow_rounded;

    if (_controller.isPlaying) {
      icon = Icons.pause_rounded;
    } else if (_controller.isCompleted) {
      icon = Icons.replay_rounded;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (_controller.isCompleted) {
            _controller.restart();
          } else {
            _controller.togglePlayPause();
          }
        },
        borderRadius: BorderRadius.circular(36),
        child: Ink(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFE53935), Color(0xFFC62828)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD32F2F).withValues(alpha: 0.4),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 42,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Interactive circular dial to hold and swipe left/right to adjust skip interval duration.
class _CircularIntervalDial extends StatefulWidget {
  final int selectedIndex;
  final List<({String label, int seconds})> intervals;
  final ValueChanged<int> onIntervalChanged;

  const _CircularIntervalDial({
    required this.selectedIndex,
    required this.intervals,
    required this.onIntervalChanged,
  });

  @override
  State<_CircularIntervalDial> createState() => _CircularIntervalDialState();
}

class _CircularIntervalDialState extends State<_CircularIntervalDial> {
  double _dragAccumulator = 0;
  double _rotationAngle = 0;

  void _handleDragUpdate(DragUpdateDetails details) {
    _dragAccumulator += details.delta.dx;
    setState(() {
      _rotationAngle += details.delta.dx * 0.035;
    });

    const threshold = 26.0;
    if (_dragAccumulator > threshold) {
      final nextIndex =
          (widget.selectedIndex + 1).clamp(0, widget.intervals.length - 1);
      if (nextIndex != widget.selectedIndex) {
        widget.onIntervalChanged(nextIndex);
      }
      _dragAccumulator = 0;
    } else if (_dragAccumulator < -threshold) {
      final prevIndex =
          (widget.selectedIndex - 1).clamp(0, widget.intervals.length - 1);
      if (prevIndex != widget.selectedIndex) {
        widget.onIntervalChanged(prevIndex);
      }
      _dragAccumulator = 0;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    _dragAccumulator = 0;
  }

  void _step(int delta) {
    final next =
        (widget.selectedIndex + delta).clamp(0, widget.intervals.length - 1);
    if (next != widget.selectedIndex) {
      setState(() {
        _rotationAngle += delta * 0.5;
      });
      widget.onIntervalChanged(next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.intervals[widget.selectedIndex];
    final canGoPrev = widget.selectedIndex > 0;
    final canGoNext = widget.selectedIndex < widget.intervals.length - 1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Step Arrow
        IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          iconSize: 28,
          color: canGoPrev ? const Color(0xFFD32F2F) : Colors.grey.shade300,
          splashRadius: 18,
          tooltip: canGoPrev ? 'Decrease skip time' : null,
          onPressed: canGoPrev ? () => _step(-1) : null,
        ),

        // Interactive Swipeable Circular Dial
        GestureDetector(
          onHorizontalDragUpdate: _handleDragUpdate,
          onHorizontalDragEnd: _handleDragEnd,
          onTap: () {
            final next = (widget.selectedIndex + 1) % widget.intervals.length;
            _step(next - widget.selectedIndex);
          },
          child: Tooltip(
            message: 'Swipe left/right or tap to change skip interval',
            child: SizedBox(
              width: 78,
              height: 78,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating notched ring
                  Transform.rotate(
                    angle: _rotationAngle,
                    child: CustomPaint(
                      size: const Size(78, 78),
                      painter: _DialNotchPainter(
                        totalSteps: widget.intervals.length,
                        currentIndex: widget.selectedIndex,
                      ),
                    ),
                  ),

                  // Center circular disc
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          Colors.white,
                          Color(0xFFFFF8E1),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFFFFB74D),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.18),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            current.label,
                            key: ValueKey<String>(current.label),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFD32F2F),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const Text(
                          'SWIPE',
                          style: TextStyle(
                            fontSize: 7.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE65100),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Right Step Arrow
        IconButton(
          icon: const Icon(Icons.chevron_right_rounded),
          iconSize: 28,
          color: canGoNext ? const Color(0xFFD32F2F) : Colors.grey.shade300,
          splashRadius: 18,
          tooltip: canGoNext ? 'Increase skip time' : null,
          onPressed: canGoNext ? () => _step(1) : null,
        ),
      ],
    );
  }
}

class _DialNotchPainter extends CustomPainter {
  final int totalSteps;
  final int currentIndex;

  _DialNotchPainter({
    required this.totalSteps,
    required this.currentIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw outer subtle track ring
    final trackPaint = Paint()
      ..color = const Color(0xFFFFE0B2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center, radius - 2, trackPaint);

    // Draw radial tick notches
    const notchCount = 16;
    for (int i = 0; i < notchCount; i++) {
      final angle = (i * 2 * math.pi) / notchCount;
      final isMajor = i % 2 == 0;
      final innerR = radius - (isMajor ? 7.0 : 4.0);
      final outerR = radius - 1.0;

      final p1 = Offset(
        center.dx + innerR * math.cos(angle),
        center.dy + innerR * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + outerR * math.cos(angle),
        center.dy + outerR * math.sin(angle),
      );

      final notchPaint = Paint()
        ..color = isMajor ? const Color(0xFFE65100) : const Color(0xFFFFB74D)
        ..strokeWidth = isMajor ? 1.5 : 1.0
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(p1, p2, notchPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DialNotchPainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex;
  }
}

/// Unified artwork widget with a layered rotating Divine Chakra halo and an outer circumference seeker.
/// Unified artwork widget with a layered rotating Divine Chakra halo and an outer circumference seeker.
class _DivineChakraSeekControl extends StatefulWidget {
  final double size;
  final String imagePath;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const _DivineChakraSeekControl({
    this.size = 270.0,
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
    final center = Offset(widget.size / 2, widget.size / 2);
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

    final artDimension = widget.size * 0.66;
    final glowDimension = widget.size * 0.88;

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final animValue = _animController.value;
        final pulse = widget.isPlaying
            ? (math.sin(animValue * 2 * math.pi) * 0.5 + 0.5)
            : 0.0;

        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Ambient Golden-Saffron Breathing Glow
              Container(
                width: glowDimension + (pulse * (widget.size * 0.06)),
                height: glowDimension + (pulse * (widget.size * 0.06)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFB300)
                          .withValues(alpha: 0.22 + (pulse * 0.20)),
                      blurRadius: (widget.size * 0.11) + (pulse * 10),
                      spreadRadius: 3 + (pulse * 5),
                    ),
                    BoxShadow(
                      color: const Color(0xFFD32F2F)
                          .withValues(alpha: 0.12 + (pulse * 0.10)),
                      blurRadius: (widget.size * 0.15) + (pulse * 8),
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),

              // 2. Centered Circular Artwork
              Container(
                width: artDimension,
                height: artDimension,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFFD54F),
                    width: (widget.size * 0.011).clamp(2.0, 3.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD32F2F).withValues(alpha: 0.25),
                      blurRadius: 18,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    widget.imagePath,
                    width: artDimension,
                    height: artDimension,
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
                    size: Size(widget.size, widget.size),
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

    // Dynamic Layer Radii proportional to container width:
    final chakraInnerRadius = (size.width / 2) * 0.71;
    final chakraOuterRadius = (size.width / 2) * 0.83;
    final seekRadius = (size.width / 2) * 0.93;

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
