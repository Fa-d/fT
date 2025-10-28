// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaybackStateModelImpl _$$PlaybackStateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlaybackStateModelImpl(
      mediaItemId: json['mediaItemId'] as String,
      positionInMilliseconds: (json['positionInMilliseconds'] as num).toInt(),
      durationInMilliseconds: (json['durationInMilliseconds'] as num).toInt(),
      isPlaying: json['isPlaying'] as bool,
      isBuffering: json['isBuffering'] as bool,
      playbackSpeed: (json['playbackSpeed'] as num?)?.toDouble() ?? 1.0,
      currentQuality: json['currentQuality'] as String?,
      volume: (json['volume'] as num?)?.toDouble() ?? 1.0,
      isMuted: json['isMuted'] as bool? ?? false,
      lastUpdated: json['lastUpdated'] as String,
    );

Map<String, dynamic> _$$PlaybackStateModelImplToJson(
        _$PlaybackStateModelImpl instance) =>
    <String, dynamic>{
      'mediaItemId': instance.mediaItemId,
      'positionInMilliseconds': instance.positionInMilliseconds,
      'durationInMilliseconds': instance.durationInMilliseconds,
      'isPlaying': instance.isPlaying,
      'isBuffering': instance.isBuffering,
      'playbackSpeed': instance.playbackSpeed,
      'currentQuality': instance.currentQuality,
      'volume': instance.volume,
      'isMuted': instance.isMuted,
      'lastUpdated': instance.lastUpdated,
    };
