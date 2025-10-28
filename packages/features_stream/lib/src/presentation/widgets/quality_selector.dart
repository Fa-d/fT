import 'package:flutter/material.dart';

/// Quality selector widget
/// Provides a dropdown menu for selecting video quality
class QualitySelector extends StatelessWidget {
  final String? currentQuality;
  final Map<String, String> qualityOptions;
  final Function(String) onQualityChanged;

  const QualitySelector({
    super.key,
    required this.currentQuality,
    required this.qualityOptions,
    required this.onQualityChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (qualityOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.settings, color: Colors.white, size: 20),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              currentQuality ?? 'Auto',
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
          .map((quality) => PopupMenuItem(
                value: quality,
                child: Row(
                  children: [
                    Text(quality),
                    if (currentQuality == quality)
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
