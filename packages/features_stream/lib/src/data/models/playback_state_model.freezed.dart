// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlaybackStateModel _$PlaybackStateModelFromJson(Map<String, dynamic> json) {
  return _PlaybackStateModel.fromJson(json);
}

/// @nodoc
mixin _$PlaybackStateModel {
  String get mediaItemId => throw _privateConstructorUsedError;
  int get positionInMilliseconds => throw _privateConstructorUsedError;
  int get durationInMilliseconds => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isBuffering => throw _privateConstructorUsedError;
  double get playbackSpeed => throw _privateConstructorUsedError;
  String? get currentQuality => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  String get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this PlaybackStateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybackStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybackStateModelCopyWith<PlaybackStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackStateModelCopyWith<$Res> {
  factory $PlaybackStateModelCopyWith(
    PlaybackStateModel value,
    $Res Function(PlaybackStateModel) then,
  ) = _$PlaybackStateModelCopyWithImpl<$Res, PlaybackStateModel>;
  @useResult
  $Res call({
    String mediaItemId,
    int positionInMilliseconds,
    int durationInMilliseconds,
    bool isPlaying,
    bool isBuffering,
    double playbackSpeed,
    String? currentQuality,
    double volume,
    bool isMuted,
    String lastUpdated,
  });
}

/// @nodoc
class _$PlaybackStateModelCopyWithImpl<$Res, $Val extends PlaybackStateModel>
    implements $PlaybackStateModelCopyWith<$Res> {
  _$PlaybackStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybackStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaItemId = null,
    Object? positionInMilliseconds = null,
    Object? durationInMilliseconds = null,
    Object? isPlaying = null,
    Object? isBuffering = null,
    Object? playbackSpeed = null,
    Object? currentQuality = freezed,
    Object? volume = null,
    Object? isMuted = null,
    Object? lastUpdated = null,
  }) {
    return _then(
      _value.copyWith(
            mediaItemId: null == mediaItemId
                ? _value.mediaItemId
                : mediaItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            positionInMilliseconds: null == positionInMilliseconds
                ? _value.positionInMilliseconds
                : positionInMilliseconds // ignore: cast_nullable_to_non_nullable
                      as int,
            durationInMilliseconds: null == durationInMilliseconds
                ? _value.durationInMilliseconds
                : durationInMilliseconds // ignore: cast_nullable_to_non_nullable
                      as int,
            isPlaying: null == isPlaying
                ? _value.isPlaying
                : isPlaying // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBuffering: null == isBuffering
                ? _value.isBuffering
                : isBuffering // ignore: cast_nullable_to_non_nullable
                      as bool,
            playbackSpeed: null == playbackSpeed
                ? _value.playbackSpeed
                : playbackSpeed // ignore: cast_nullable_to_non_nullable
                      as double,
            currentQuality: freezed == currentQuality
                ? _value.currentQuality
                : currentQuality // ignore: cast_nullable_to_non_nullable
                      as String?,
            volume: null == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                      as double,
            isMuted: null == isMuted
                ? _value.isMuted
                : isMuted // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastUpdated: null == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaybackStateModelImplCopyWith<$Res>
    implements $PlaybackStateModelCopyWith<$Res> {
  factory _$$PlaybackStateModelImplCopyWith(
    _$PlaybackStateModelImpl value,
    $Res Function(_$PlaybackStateModelImpl) then,
  ) = __$$PlaybackStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String mediaItemId,
    int positionInMilliseconds,
    int durationInMilliseconds,
    bool isPlaying,
    bool isBuffering,
    double playbackSpeed,
    String? currentQuality,
    double volume,
    bool isMuted,
    String lastUpdated,
  });
}

/// @nodoc
class __$$PlaybackStateModelImplCopyWithImpl<$Res>
    extends _$PlaybackStateModelCopyWithImpl<$Res, _$PlaybackStateModelImpl>
    implements _$$PlaybackStateModelImplCopyWith<$Res> {
  __$$PlaybackStateModelImplCopyWithImpl(
    _$PlaybackStateModelImpl _value,
    $Res Function(_$PlaybackStateModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybackStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaItemId = null,
    Object? positionInMilliseconds = null,
    Object? durationInMilliseconds = null,
    Object? isPlaying = null,
    Object? isBuffering = null,
    Object? playbackSpeed = null,
    Object? currentQuality = freezed,
    Object? volume = null,
    Object? isMuted = null,
    Object? lastUpdated = null,
  }) {
    return _then(
      _$PlaybackStateModelImpl(
        mediaItemId: null == mediaItemId
            ? _value.mediaItemId
            : mediaItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        positionInMilliseconds: null == positionInMilliseconds
            ? _value.positionInMilliseconds
            : positionInMilliseconds // ignore: cast_nullable_to_non_nullable
                  as int,
        durationInMilliseconds: null == durationInMilliseconds
            ? _value.durationInMilliseconds
            : durationInMilliseconds // ignore: cast_nullable_to_non_nullable
                  as int,
        isPlaying: null == isPlaying
            ? _value.isPlaying
            : isPlaying // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBuffering: null == isBuffering
            ? _value.isBuffering
            : isBuffering // ignore: cast_nullable_to_non_nullable
                  as bool,
        playbackSpeed: null == playbackSpeed
            ? _value.playbackSpeed
            : playbackSpeed // ignore: cast_nullable_to_non_nullable
                  as double,
        currentQuality: freezed == currentQuality
            ? _value.currentQuality
            : currentQuality // ignore: cast_nullable_to_non_nullable
                  as String?,
        volume: null == volume
            ? _value.volume
            : volume // ignore: cast_nullable_to_non_nullable
                  as double,
        isMuted: null == isMuted
            ? _value.isMuted
            : isMuted // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastUpdated: null == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybackStateModelImpl extends _PlaybackStateModel {
  const _$PlaybackStateModelImpl({
    required this.mediaItemId,
    required this.positionInMilliseconds,
    required this.durationInMilliseconds,
    required this.isPlaying,
    required this.isBuffering,
    this.playbackSpeed = 1.0,
    this.currentQuality,
    this.volume = 1.0,
    this.isMuted = false,
    required this.lastUpdated,
  }) : super._();

  factory _$PlaybackStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybackStateModelImplFromJson(json);

  @override
  final String mediaItemId;
  @override
  final int positionInMilliseconds;
  @override
  final int durationInMilliseconds;
  @override
  final bool isPlaying;
  @override
  final bool isBuffering;
  @override
  @JsonKey()
  final double playbackSpeed;
  @override
  final String? currentQuality;
  @override
  @JsonKey()
  final double volume;
  @override
  @JsonKey()
  final bool isMuted;
  @override
  final String lastUpdated;

  @override
  String toString() {
    return 'PlaybackStateModel(mediaItemId: $mediaItemId, positionInMilliseconds: $positionInMilliseconds, durationInMilliseconds: $durationInMilliseconds, isPlaying: $isPlaying, isBuffering: $isBuffering, playbackSpeed: $playbackSpeed, currentQuality: $currentQuality, volume: $volume, isMuted: $isMuted, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybackStateModelImpl &&
            (identical(other.mediaItemId, mediaItemId) ||
                other.mediaItemId == mediaItemId) &&
            (identical(other.positionInMilliseconds, positionInMilliseconds) ||
                other.positionInMilliseconds == positionInMilliseconds) &&
            (identical(other.durationInMilliseconds, durationInMilliseconds) ||
                other.durationInMilliseconds == durationInMilliseconds) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isBuffering, isBuffering) ||
                other.isBuffering == isBuffering) &&
            (identical(other.playbackSpeed, playbackSpeed) ||
                other.playbackSpeed == playbackSpeed) &&
            (identical(other.currentQuality, currentQuality) ||
                other.currentQuality == currentQuality) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mediaItemId,
    positionInMilliseconds,
    durationInMilliseconds,
    isPlaying,
    isBuffering,
    playbackSpeed,
    currentQuality,
    volume,
    isMuted,
    lastUpdated,
  );

  /// Create a copy of PlaybackStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybackStateModelImplCopyWith<_$PlaybackStateModelImpl> get copyWith =>
      __$$PlaybackStateModelImplCopyWithImpl<_$PlaybackStateModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybackStateModelImplToJson(this);
  }
}

abstract class _PlaybackStateModel extends PlaybackStateModel {
  const factory _PlaybackStateModel({
    required final String mediaItemId,
    required final int positionInMilliseconds,
    required final int durationInMilliseconds,
    required final bool isPlaying,
    required final bool isBuffering,
    final double playbackSpeed,
    final String? currentQuality,
    final double volume,
    final bool isMuted,
    required final String lastUpdated,
  }) = _$PlaybackStateModelImpl;
  const _PlaybackStateModel._() : super._();

  factory _PlaybackStateModel.fromJson(Map<String, dynamic> json) =
      _$PlaybackStateModelImpl.fromJson;

  @override
  String get mediaItemId;
  @override
  int get positionInMilliseconds;
  @override
  int get durationInMilliseconds;
  @override
  bool get isPlaying;
  @override
  bool get isBuffering;
  @override
  double get playbackSpeed;
  @override
  String? get currentQuality;
  @override
  double get volume;
  @override
  bool get isMuted;
  @override
  String get lastUpdated;

  /// Create a copy of PlaybackStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybackStateModelImplCopyWith<_$PlaybackStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
