import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/media_item.dart';

part 'player_event.freezed.dart';

@freezed
class PlayerEvent with _$PlayerEvent {
  const factory PlayerEvent.initialize(MediaItem mediaItem) = _Initialize;
  const factory PlayerEvent.play() = _Play;
  const factory PlayerEvent.pause() = _Pause;
  const factory PlayerEvent.seekTo(Duration position) = _SeekTo;
  const factory PlayerEvent.setSpeed(double speed) = _SetSpeed;
  const factory PlayerEvent.setQuality(String quality) = _SetQuality;
  const factory PlayerEvent.setVolume(double volume) = _SetVolume;
  const factory PlayerEvent.toggleMute() = _ToggleMute;
  const factory PlayerEvent.updatePosition(Duration position) = _UpdatePosition;
  const factory PlayerEvent.updateBuffering(bool isBuffering) = _UpdateBuffering;
  const factory PlayerEvent.videoCompleted() = _VideoCompleted;
  const factory PlayerEvent.dispose() = _Dispose;
}
