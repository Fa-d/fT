import 'package:equatable/equatable.dart';

/// Media item entity representing a video or audio content
/// Demonstrates clean architecture domain entity
class MediaItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final Duration duration;
  final String streamUrl;
  final MediaType type;
  final Map<String, String> qualityOptions; // quality label -> stream URL
  final DateTime publishedAt;
  final String? author;
  final int viewCount;

  const MediaItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.duration,
    required this.streamUrl,
    required this.type,
    required this.qualityOptions,
    required this.publishedAt,
    this.author,
    this.viewCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        thumbnailUrl,
        duration,
        streamUrl,
        type,
        qualityOptions,
        publishedAt,
        author,
        viewCount,
      ];
}

/// Media type enumeration
enum MediaType {
  video,
  audio,
}
