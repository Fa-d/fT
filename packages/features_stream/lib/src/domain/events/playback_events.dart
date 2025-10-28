import 'package:core/core.dart';

/// Base class for playback-related domain events
/// Demonstrates event sourcing pattern for video/audio playback

/// Video playback started event
class VideoPlaybackStartedEvent extends DomainEvent {
  final String mediaItemId;
  final String mediaTitle;
  final Duration position;

  VideoPlaybackStartedEvent({
    required this.mediaItemId,
    required this.mediaTitle,
    required this.position,
    String? aggregateId,
    int aggregateVersion = 1,
  }) : super(
          aggregateId: aggregateId ?? mediaItemId,
          eventType: 'VideoPlaybackStarted',
          aggregateVersion: aggregateVersion,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventType': eventType,
        'aggregateId': aggregateId,
        'aggregateVersion': aggregateVersion,
        'timestamp': timestamp.toIso8601String(),
        'mediaItemId': mediaItemId,
        'mediaTitle': mediaTitle,
        'position': position.inMilliseconds,
      };
}

/// Video playback paused event
class VideoPlaybackPausedEvent extends DomainEvent {
  final String mediaItemId;
  final Duration position;
  final Duration duration;

  VideoPlaybackPausedEvent({
    required this.mediaItemId,
    required this.position,
    required this.duration,
    String? aggregateId,
    int aggregateVersion = 1,
  }) : super(
          aggregateId: aggregateId ?? mediaItemId,
          eventType: 'VideoPlaybackPaused',
          aggregateVersion: aggregateVersion,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventType': eventType,
        'aggregateId': aggregateId,
        'aggregateVersion': aggregateVersion,
        'timestamp': timestamp.toIso8601String(),
        'mediaItemId': mediaItemId,
        'position': position.inMilliseconds,
        'duration': duration.inMilliseconds,
        'progress': position.inMilliseconds / duration.inMilliseconds,
      };
}

/// Video playback completed event
class VideoPlaybackCompletedEvent extends DomainEvent {
  final String mediaItemId;
  final String mediaTitle;
  final Duration duration;

  VideoPlaybackCompletedEvent({
    required this.mediaItemId,
    required this.mediaTitle,
    required this.duration,
    String? aggregateId,
    int aggregateVersion = 1,
  }) : super(
          aggregateId: aggregateId ?? mediaItemId,
          eventType: 'VideoPlaybackCompleted',
          aggregateVersion: aggregateVersion,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventType': eventType,
        'aggregateId': aggregateId,
        'aggregateVersion': aggregateVersion,
        'timestamp': timestamp.toIso8601String(),
        'mediaItemId': mediaItemId,
        'mediaTitle': mediaTitle,
        'duration': duration.inMilliseconds,
      };
}

/// Video download started event
class VideoDownloadStartedEvent extends DomainEvent {
  final String downloadTaskId;
  final String mediaItemId;
  final String mediaTitle;
  final String quality;

  VideoDownloadStartedEvent({
    required this.downloadTaskId,
    required this.mediaItemId,
    required this.mediaTitle,
    required this.quality,
    String? aggregateId,
    int aggregateVersion = 1,
  }) : super(
          aggregateId: aggregateId ?? downloadTaskId,
          eventType: 'VideoDownloadStarted',
          aggregateVersion: aggregateVersion,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventType': eventType,
        'aggregateId': aggregateId,
        'aggregateVersion': aggregateVersion,
        'timestamp': timestamp.toIso8601String(),
        'downloadTaskId': downloadTaskId,
        'mediaItemId': mediaItemId,
        'mediaTitle': mediaTitle,
        'quality': quality,
      };
}

/// Video download completed event
class VideoDownloadCompletedEvent extends DomainEvent {
  final String downloadTaskId;
  final String mediaItemId;
  final String localPath;

  VideoDownloadCompletedEvent({
    required this.downloadTaskId,
    required this.mediaItemId,
    required this.localPath,
    String? aggregateId,
    int aggregateVersion = 1,
  }) : super(
          aggregateId: aggregateId ?? downloadTaskId,
          eventType: 'VideoDownloadCompleted',
          aggregateVersion: aggregateVersion,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventType': eventType,
        'aggregateId': aggregateId,
        'aggregateVersion': aggregateVersion,
        'timestamp': timestamp.toIso8601String(),
        'downloadTaskId': downloadTaskId,
        'mediaItemId': mediaItemId,
        'localPath': localPath,
      };
}

/// Playback speed changed event
class PlaybackSpeedChangedEvent extends DomainEvent {
  final String mediaItemId;
  final double oldSpeed;
  final double newSpeed;

  PlaybackSpeedChangedEvent({
    required this.mediaItemId,
    required this.oldSpeed,
    required this.newSpeed,
    String? aggregateId,
    int aggregateVersion = 1,
  }) : super(
          aggregateId: aggregateId ?? mediaItemId,
          eventType: 'PlaybackSpeedChanged',
          aggregateVersion: aggregateVersion,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventType': eventType,
        'aggregateId': aggregateId,
        'aggregateVersion': aggregateVersion,
        'timestamp': timestamp.toIso8601String(),
        'mediaItemId': mediaItemId,
        'oldSpeed': oldSpeed,
        'newSpeed': newSpeed,
      };
}
