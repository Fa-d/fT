import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/media_item.dart';
import '../../../domain/entities/playback_state.dart';

part 'player_state.freezed.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState.initial() = _Initial;
  const factory PlayerState.loading(MediaItem mediaItem) = _Loading;
  const factory PlayerState.ready({
    required MediaItem mediaItem,
    required PlaybackState playbackState,
  }) = _Ready;
  const factory PlayerState.playing({
    required MediaItem mediaItem,
    required PlaybackState playbackState,
  }) = _Playing;
  const factory PlayerState.paused({
    required MediaItem mediaItem,
    required PlaybackState playbackState,
  }) = _Paused;
  const factory PlayerState.buffering({
    required MediaItem mediaItem,
    required PlaybackState playbackState,
  }) = _Buffering;
  const factory PlayerState.completed({
    required MediaItem mediaItem,
    required PlaybackState playbackState,
  }) = _Completed;
  const factory PlayerState.error(String message) = _Error;
}
