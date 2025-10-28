import 'package:flutter/material.dart';
import '../../domain/entities/playback_state.dart';
import 'quality_selector.dart';
import 'speed_selector.dart';
import 'progress_bar.dart';

/// Player controls widget
/// Provides playback controls using extracted reusable widgets
class PlayerControls extends StatelessWidget {
  final PlaybackState playbackState;
  final VoidCallback onPlayPause;
  final Function(Duration) onSeek;
  final Function(double) onSpeedChanged;
  final Function(String) onQualityChanged;
  final Function(double) onVolumeChanged;
  final VoidCallback onMuteToggle;
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
          ProgressBar(
            playbackState: playbackState,
            onSeek: onSeek,
          ),

          const SizedBox(height: 8),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Quality control
              QualitySelector(
                currentQuality: playbackState.currentQuality,
                qualityOptions: qualityOptions,
                onQualityChanged: onQualityChanged,
              ),

              // Speed control
              SpeedSelector(
                currentSpeed: playbackState.playbackSpeed,
                onSpeedChanged: onSpeedChanged,
              ),

              // Seek buttons and play/pause
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Rewind
                    IconButton(
                      icon: const Icon(Icons.replay_10, color: Colors.white),
                      onPressed: () {
                        final newPosition =
                            playbackState.position - const Duration(seconds: 10);
                        onSeek(newPosition < Duration.zero
                            ? Duration.zero
                            : newPosition);
                      },
                    ),

                    // Play/Pause
                    IconButton(
                      icon: Icon(
                        playbackState.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 48,
                      ),
                      onPressed: onPlayPause,
                    ),

                    // Forward
                    IconButton(
                      icon: const Icon(Icons.forward_10, color: Colors.white),
                      onPressed: () {
                        final newPosition =
                            playbackState.position + const Duration(seconds: 10);
                        onSeek(newPosition > playbackState.duration
                            ? playbackState.duration
                            : newPosition);
                      },
                    ),
                  ],
                ),
              ),

              // Volume control
              _VolumeControl(
                playbackState: playbackState,
                onVolumeChanged: onVolumeChanged,
                onMuteToggle: onMuteToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Volume control widget with slider
/// Uses ValueNotifier for reactive UI updates without setState
/// Follows Flutter best practices for UI-level reactive state
class _VolumeControl extends StatelessWidget {
  final PlaybackState playbackState;
  final Function(double) onVolumeChanged;
  final VoidCallback onMuteToggle;

  const _VolumeControl({
    required this.playbackState,
    required this.onVolumeChanged,
    required this.onMuteToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Use ValueNotifier for reactive UI updates during drag
    final dragValueNotifier = ValueNotifier<double?>(null);

    return PopupMenuButton(
      icon: Icon(
        playbackState.isMuted
            ? Icons.volume_off
            : playbackState.volume > 0.5
                ? Icons.volume_up
                : Icons.volume_down,
        color: Colors.white,
      ),
      tooltip: 'Volume',
      offset: const Offset(0, -160),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder<double?>(
                  valueListenable: dragValueNotifier,
                  builder: (context, dragValue, _) {
                    final currentVolume = dragValue ?? playbackState.volume;
                    final displayVolume =
                        playbackState.isMuted ? 0.0 : currentVolume;

                    return Row(
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
                              value: displayVolume.clamp(0.0, 1.0),
                              min: 0,
                              max: 1,
                              onChangeStart: (value) {
                                dragValueNotifier.value = value;
                              },
                              onChanged: (value) {
                                // Update reactive UI
                                dragValueNotifier.value = value;

                                // Unmute if increasing from 0
                                if (value > 0 && playbackState.isMuted) {
                                  onMuteToggle();
                                }

                                // Send to BLoC
                                onVolumeChanged(value);
                              },
                              onChangeEnd: (value) {
                                // Clear drag state, return to BLoC control
                                dragValueNotifier.value = null;
                              },
                              activeColor: Colors.red,
                              inactiveColor: Colors.grey,
                            ),
                          ),
                        ),
                        const Icon(Icons.volume_up, size: 20),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: onMuteToggle,
                  icon: Icon(
                    playbackState.isMuted ? Icons.volume_off : Icons.volume_up,
                    size: 16,
                  ),
                  label: Text(
                    playbackState.isMuted ? 'Unmute' : 'Mute',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
