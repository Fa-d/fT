import 'package:flutter/material.dart';
import '../../core/constants/stream_constants.dart';

/// Playback speed selector widget
/// Provides a dropdown menu for selecting playback speed
class SpeedSelector extends StatelessWidget {
  final double currentSpeed;
  final Function(double) onSpeedChanged;

  const SpeedSelector({
    super.key,
    required this.currentSpeed,
    required this.onSpeedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '${currentSpeed}x',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onSelected: onSpeedChanged,
      tooltip: 'Playback speed',
      itemBuilder: (context) => StreamConstants.availablePlaybackSpeeds
          .map((speed) => PopupMenuItem(
                value: speed,
                child: Row(
                  children: [
                    Text('${speed}x'),
                    if (currentSpeed == speed)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.check, size: 16),
                      ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
