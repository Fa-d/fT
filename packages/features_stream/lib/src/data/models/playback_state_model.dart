import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/playback_state.dart';

part 'playback_state_model.freezed.dart';
part 'playback_state_model.g.dart';

@freezed
class PlaybackStateModel with _$PlaybackStateModel {
  const PlaybackStateModel._();

  const factory PlaybackStateModel({
    required String mediaItemId,
    required int positionInMilliseconds,
    required int durationInMilliseconds,
    required bool isPlaying,
    required bool isBuffering,
    @Default(1.0) double playbackSpeed,
    String? currentQuality,
    @Default(1.0) double volume,
    @Default(false) bool isMuted,
    required String lastUpdated,
  }) = _PlaybackStateModel;

  factory PlaybackStateModel.fromJson(Map<String, dynamic> json) =>
      _$PlaybackStateModelFromJson(json);

  /// Convert to domain entity
  PlaybackState toEntity() {
    return PlaybackState(
      mediaItemId: mediaItemId,
      position: Duration(milliseconds: positionInMilliseconds),
      duration: Duration(milliseconds: durationInMilliseconds),
      isPlaying: isPlaying,
      isBuffering: isBuffering,
      playbackSpeed: playbackSpeed,
      currentQuality: currentQuality,
      volume: volume,
      isMuted: isMuted,
      lastUpdated: DateTime.parse(lastUpdated),
    );
  }

  /// Create from domain entity
  factory PlaybackStateModel.fromEntity(PlaybackState entity) {
    return PlaybackStateModel(
      mediaItemId: entity.mediaItemId,
      positionInMilliseconds: entity.position.inMilliseconds,
      durationInMilliseconds: entity.duration.inMilliseconds,
      isPlaying: entity.isPlaying,
      isBuffering: entity.isBuffering,
      playbackSpeed: entity.playbackSpeed,
      currentQuality: entity.currentQuality,
      volume: entity.volume,
      isMuted: entity.isMuted,
      lastUpdated: entity.lastUpdated.toIso8601String(),
    );
  }
}
