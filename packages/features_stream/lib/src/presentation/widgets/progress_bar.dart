import 'package:flutter/material.dart';
import '../../domain/entities/playback_state.dart';

/// Progress bar widget with time labels
/// Shows current position, duration, and seekable slider
class ProgressBar extends StatelessWidget {
  final PlaybackState playbackState;
  final Function(Duration) onSeek;

  const ProgressBar({
    super.key,
    required this.playbackState,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    (value * playbackState.duration.inMilliseconds).toInt(),
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
