import 'package:flutter/material.dart';
import '../../domain/entities/playback_state.dart';

/// Player controls widget
/// Provides playback controls for video/audio player
class PlayerControls extends StatelessWidget {
  final PlaybackState playbackState;
  final VoidCallback onPlayPause;
  final Function(Duration) onSeek;
  final Function(double) onSpeedChanged;
  final Function(String) onQualityChanged;
  final Function(double) onVolumeChanged;
  final VoidCallback onMuteToggle;
  final VoidCallback onFullscreenToggle;
  final Map<String, String> qualityOptions;

  const PlayerControls({
    super.key,
    required this.playbackState,
    required this.onPlayPause,
    required this.onSeek,
    required this.onSpeedChanged,
    required this.onQualityChanged,
    required this.onVolumeChanged,
    required this.onMuteToggle,
    required this.onFullscreenToggle,
    required this.qualityOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          Row(
            children: [
              Text(
                _formatDuration(playbackState.position),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Expanded(
                child: Slider(
                  value: playbackState.progress.clamp(0.0, 1.0),
                  onChanged: (value) {
                    final newPosition = Duration(
                      milliseconds:
                          (value * playbackState.duration.inMilliseconds)
                              .toInt(),
                    );
                    onSeek(newPosition);
                  },
                  activeColor: Colors.red,
                  inactiveColor: Colors.white30,
                ),
              ),
              Text(
                _formatDuration(playbackState.duration),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Quality control
              if (qualityOptions.isNotEmpty)
                PopupMenuButton<String>(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.settings, color: Colors.white, size: 20),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          playbackState.currentQuality ?? 'Auto',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onSelected: onQualityChanged,
                  tooltip: 'Quality',
                  itemBuilder: (context) => qualityOptions.keys
                      .map(
                        (quality) => PopupMenuItem(
                          value: quality,
                          child: Row(
                            children: [
                              Text(quality),
                              if (playbackState.currentQuality == quality)
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(Icons.check, size: 16),
                                ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),

              // Speed control with current value displayed
              PopupMenuButton<double>(
                icon: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${playbackState.playbackSpeed}x',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onSelected: onSpeedChanged,
                tooltip: 'Playback speed',
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0.5,
                    child: Row(
                      children: [
                        const Text('0.5x'),
                        if (playbackState.playbackSpeed == 0.5)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.check, size: 16),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 0.75,
                    child: Row(
                      children: [
                        const Text('0.75x'),
                        if (playbackState.playbackSpeed == 0.75)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.check, size: 16),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1.0,
                    child: Row(
                      children: [
                        const Text('1.0x'),
                        if (playbackState.playbackSpeed == 1.0)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.check, size: 16),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1.25,
                    child: Row(
                      children: [
                        const Text('1.25x'),
                        if (playbackState.playbackSpeed == 1.25)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.check, size: 16),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1.5,
                    child: Row(
                      children: [
                        const Text('1.5x'),
                        if (playbackState.playbackSpeed == 1.5)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.check, size: 16),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2.0,
                    child: Row(
                      children: [
                        const Text('2.0x'),
                        if (playbackState.playbackSpeed == 2.0)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.check, size: 16),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              // Rewind 10 seconds
              IconButton(
                icon: const Icon(Icons.replay_10, color: Colors.white),
                onPressed: () {
                  final newPosition =
                      playbackState.position - const Duration(seconds: 10);
                  onSeek(
                    newPosition < Duration.zero ? Duration.zero : newPosition,
                  );
                },
              ),

              // Play/Pause
              IconButton(
                icon: Icon(
                  playbackState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 48,
                ),
                onPressed: onPlayPause,
              ),

              // Forward 10 seconds
              IconButton(
                icon: const Icon(Icons.forward_10, color: Colors.white),
                onPressed: () {
                  final newPosition =
                      playbackState.position + const Duration(seconds: 10);
                  onSeek(
                    newPosition > playbackState.duration
                        ? playbackState.duration
                        : newPosition,
                  );
                },
              ),

              // Volume control
              _VolumeControl(
                playbackState: playbackState,
                onVolumeChanged: onVolumeChanged,
                onMuteToggle: onMuteToggle,
              ),

              // Fullscreen toggle
              IconButton(
                icon: Icon(
                  playbackState.isFullscreen
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen,
                  color: Colors.white,
                ),
                onPressed: onFullscreenToggle,
                tooltip: playbackState.isFullscreen ? 'Exit fullscreen' : 'Fullscreen',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }
}

/// Volume control widget with slider
/// Following clean architecture with local interaction state
/// - Source of truth: PlaybackState from BLoC
/// - Local state: Only for smooth slider dragging UX
class _VolumeControl extends StatefulWidget {
  final PlaybackState playbackState;
  final Function(double) onVolumeChanged;
  final VoidCallback onMuteToggle;

  const _VolumeControl({
    required this.playbackState,
    required this.onVolumeChanged,
    required this.onMuteToggle,
  });

  @override
  State<_VolumeControl> createState() => _VolumeControlState();
}

class _VolumeControlState extends State<_VolumeControl> {
  // Local state ONLY for tracking slider drag interaction
  double? _dragVolume;

  @override
  Widget build(BuildContext context) {
    // Use drag volume if dragging, otherwise use BLoC state (source of truth)
    final volume = _dragVolume ?? widget.playbackState.volume;

    return PopupMenuButton(
      icon: Icon(
        widget.playbackState.isMuted
            ? Icons.volume_off
            : volume > 0.5
            ? Icons.volume_up
            : Icons.volume_down,
        color: Colors.white,
      ),
      tooltip: 'Volume',
      offset: const Offset(0, -160),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: StatefulBuilder(
            builder: (context, setPopupState) {
              // Use drag volume if dragging, otherwise use BLoC state
              final currentVolume = _dragVolume ?? widget.playbackState.volume;
              final currentDisplayVolume = widget.playbackState.isMuted ? 0.0 : currentVolume;

              return SizedBox(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.volume_down, size: 20),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
                              ),
                            ),
                            child: Slider(
                              value: currentDisplayVolume.clamp(0.0, 1.0),
                              min: 0,
                              max: 1,
                              onChangeStart: (value) {
                                // Start tracking local drag state
                                setPopupState(() {
                                  _dragVolume = value;
                                });
                              },
                              onChanged: (value) {
                                // Update local drag state for smooth UI in popup
                                setPopupState(() {
                                  _dragVolume = value;
                                });

                                // Send to BLoC (source of truth)
                                widget.onVolumeChanged(value);

                                // If unmuting by moving slider, toggle mute off
                                if (value > 0 && widget.playbackState.isMuted) {
                                  widget.onMuteToggle();
                                }
                              },
                              onChangeEnd: (value) {
                                // Clear local drag state, BLoC state is now the source
                                setPopupState(() {
                                  _dragVolume = null;
                                });
                              },
                              activeColor: Colors.red,
                              inactiveColor: Colors.grey,
                            ),
                          ),
                        ),
                        const Icon(Icons.volume_up, size: 20),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: widget.onMuteToggle,
                      icon: Icon(
                        widget.playbackState.isMuted
                            ? Icons.volume_off
                            : Icons.volume_up,
                        size: 16,
                      ),
                      label: Text(widget.playbackState.isMuted ? 'Unmute' : 'Mute'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
