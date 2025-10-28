import 'package:equatable/equatable.dart';
import 'media_item.dart';

/// Playlist entity
/// Represents a collection of media items
class Playlist extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<MediaItem> items;
  final String? thumbnailUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalDuration; // in seconds
  final bool isPublic;

  const Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    this.thumbnailUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.totalDuration,
    this.isPublic = true,
  });

  /// Get total number of items
  int get itemCount => items.length;

  /// Check if playlist is empty
  bool get isEmpty => items.isEmpty;

  /// Get total duration as Duration
  Duration get totalDurationAsDuration => Duration(seconds: totalDuration);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        items,
        thumbnailUrl,
        createdAt,
        updatedAt,
        totalDuration,
        isPublic,
      ];
}
