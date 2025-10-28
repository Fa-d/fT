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
  final Map<String, String> qualityOptions;

  const PlayerControls({
    Key? key,
    required this.playbackState,
    required this.onPlayPause,
    required this.onSeek,
    required this.onSpeedChanged,
    required this.onQualityChanged,
    required this.onVolumeChanged,
    required this.onMuteToggle,
    required this.qualityOptions,
  }) : super(key: key);

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
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onSelected: onQualityChanged,
                  tooltip: 'Quality',
                  itemBuilder: (context) => qualityOptions.keys
                      .map((quality) => PopupMenuItem(
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
                          ))
                      .toList(),
                ),

              // Speed control
              PopupMenuButton<double>(
                icon: const Icon(Icons.speed, color: Colors.white),
                onSelected: onSpeedChanged,
                tooltip: 'Playback speed',
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 0.5, child: Text('0.5x')),
                  const PopupMenuItem(value: 0.75, child: Text('0.75x')),
                  const PopupMenuItem(value: 1.0, child: Text('1.0x')),
                  const PopupMenuItem(value: 1.25, child: Text('1.25x')),
                  const PopupMenuItem(value: 1.5, child: Text('1.5x')),
                  const PopupMenuItem(value: 2.0, child: Text('2.0x')),
                ],
              ),

              // Rewind 10 seconds
              IconButton(
                icon: const Icon(Icons.replay_10, color: Colors.white),
                onPressed: () {
                  final newPosition = playbackState.position -
                      const Duration(seconds: 10);
                  onSeek(newPosition < Duration.zero
                      ? Duration.zero
                      : newPosition);
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
                  final newPosition = playbackState.position +
                      const Duration(seconds: 10);
                  onSeek(newPosition > playbackState.duration
                      ? playbackState.duration
                      : newPosition);
                },
              ),

              // Mute toggle
              IconButton(
                icon: Icon(
                  playbackState.isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: onMuteToggle,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Speed indicator
          Text(
            '${playbackState.playbackSpeed}x',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
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
