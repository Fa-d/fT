// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerEventCopyWith<$Res> {
  factory $PlayerEventCopyWith(
          PlayerEvent value, $Res Function(PlayerEvent) then) =
      _$PlayerEventCopyWithImpl<$Res, PlayerEvent>;
}

/// @nodoc
class _$PlayerEventCopyWithImpl<$Res, $Val extends PlayerEvent>
    implements $PlayerEventCopyWith<$Res> {
  _$PlayerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitializeImplCopyWith<$Res> {
  factory _$$InitializeImplCopyWith(
          _$InitializeImpl value, $Res Function(_$InitializeImpl) then) =
      __$$InitializeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MediaItem mediaItem});
}

/// @nodoc
class __$$InitializeImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$InitializeImpl>
    implements _$$InitializeImplCopyWith<$Res> {
  __$$InitializeImplCopyWithImpl(
      _$InitializeImpl _value, $Res Function(_$InitializeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaItem = null,
  }) {
    return _then(_$InitializeImpl(
      null == mediaItem
          ? _value.mediaItem
          : mediaItem // ignore: cast_nullable_to_non_nullable
              as MediaItem,
    ));
  }
}

/// @nodoc

class _$InitializeImpl implements _Initialize {
  const _$InitializeImpl(this.mediaItem);

  @override
  final MediaItem mediaItem;

  @override
  String toString() {
    return 'PlayerEvent.initialize(mediaItem: $mediaItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializeImpl &&
            (identical(other.mediaItem, mediaItem) ||
                other.mediaItem == mediaItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mediaItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitializeImplCopyWith<_$InitializeImpl> get copyWith =>
      __$$InitializeImplCopyWithImpl<_$InitializeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return initialize(mediaItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return initialize?.call(mediaItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(mediaItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class _Initialize implements PlayerEvent {
  const factory _Initialize(final MediaItem mediaItem) = _$InitializeImpl;

  MediaItem get mediaItem;
  @JsonKey(ignore: true)
  _$$InitializeImplCopyWith<_$InitializeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlayImplCopyWith<$Res> {
  factory _$$PlayImplCopyWith(
          _$PlayImpl value, $Res Function(_$PlayImpl) then) =
      __$$PlayImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$PlayImpl>
    implements _$$PlayImplCopyWith<$Res> {
  __$$PlayImplCopyWithImpl(_$PlayImpl _value, $Res Function(_$PlayImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PlayImpl implements _Play {
  const _$PlayImpl();

  @override
  String toString() {
    return 'PlayerEvent.play()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlayImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return play();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return play?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (play != null) {
      return play();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return play(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return play?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (play != null) {
      return play(this);
    }
    return orElse();
  }
}

abstract class _Play implements PlayerEvent {
  const factory _Play() = _$PlayImpl;
}

/// @nodoc
abstract class _$$PauseImplCopyWith<$Res> {
  factory _$$PauseImplCopyWith(
          _$PauseImpl value, $Res Function(_$PauseImpl) then) =
      __$$PauseImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PauseImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$PauseImpl>
    implements _$$PauseImplCopyWith<$Res> {
  __$$PauseImplCopyWithImpl(
      _$PauseImpl _value, $Res Function(_$PauseImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PauseImpl implements _Pause {
  const _$PauseImpl();

  @override
  String toString() {
    return 'PlayerEvent.pause()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PauseImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return pause();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return pause?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (pause != null) {
      return pause();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return pause(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return pause?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (pause != null) {
      return pause(this);
    }
    return orElse();
  }
}

abstract class _Pause implements PlayerEvent {
  const factory _Pause() = _$PauseImpl;
}

/// @nodoc
abstract class _$$SeekToImplCopyWith<$Res> {
  factory _$$SeekToImplCopyWith(
          _$SeekToImpl value, $Res Function(_$SeekToImpl) then) =
      __$$SeekToImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Duration position});
}

/// @nodoc
class __$$SeekToImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$SeekToImpl>
    implements _$$SeekToImplCopyWith<$Res> {
  __$$SeekToImplCopyWithImpl(
      _$SeekToImpl _value, $Res Function(_$SeekToImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
  }) {
    return _then(_$SeekToImpl(
      null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$SeekToImpl implements _SeekTo {
  const _$SeekToImpl(this.position);

  @override
  final Duration position;

  @override
  String toString() {
    return 'PlayerEvent.seekTo(position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeekToImpl &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeekToImplCopyWith<_$SeekToImpl> get copyWith =>
      __$$SeekToImplCopyWithImpl<_$SeekToImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return seekTo(position);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return seekTo?.call(position);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (seekTo != null) {
      return seekTo(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return seekTo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return seekTo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (seekTo != null) {
      return seekTo(this);
    }
    return orElse();
  }
}

abstract class _SeekTo implements PlayerEvent {
  const factory _SeekTo(final Duration position) = _$SeekToImpl;

  Duration get position;
  @JsonKey(ignore: true)
  _$$SeekToImplCopyWith<_$SeekToImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetSpeedImplCopyWith<$Res> {
  factory _$$SetSpeedImplCopyWith(
          _$SetSpeedImpl value, $Res Function(_$SetSpeedImpl) then) =
      __$$SetSpeedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double speed});
}

/// @nodoc
class __$$SetSpeedImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$SetSpeedImpl>
    implements _$$SetSpeedImplCopyWith<$Res> {
  __$$SetSpeedImplCopyWithImpl(
      _$SetSpeedImpl _value, $Res Function(_$SetSpeedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
  }) {
    return _then(_$SetSpeedImpl(
      null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SetSpeedImpl implements _SetSpeed {
  const _$SetSpeedImpl(this.speed);

  @override
  final double speed;

  @override
  String toString() {
    return 'PlayerEvent.setSpeed(speed: $speed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetSpeedImpl &&
            (identical(other.speed, speed) || other.speed == speed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, speed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetSpeedImplCopyWith<_$SetSpeedImpl> get copyWith =>
      __$$SetSpeedImplCopyWithImpl<_$SetSpeedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return setSpeed(speed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return setSpeed?.call(speed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (setSpeed != null) {
      return setSpeed(speed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return setSpeed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return setSpeed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (setSpeed != null) {
      return setSpeed(this);
    }
    return orElse();
  }
}

abstract class _SetSpeed implements PlayerEvent {
  const factory _SetSpeed(final double speed) = _$SetSpeedImpl;

  double get speed;
  @JsonKey(ignore: true)
  _$$SetSpeedImplCopyWith<_$SetSpeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetQualityImplCopyWith<$Res> {
  factory _$$SetQualityImplCopyWith(
          _$SetQualityImpl value, $Res Function(_$SetQualityImpl) then) =
      __$$SetQualityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String quality});
}

/// @nodoc
class __$$SetQualityImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$SetQualityImpl>
    implements _$$SetQualityImplCopyWith<$Res> {
  __$$SetQualityImplCopyWithImpl(
      _$SetQualityImpl _value, $Res Function(_$SetQualityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quality = null,
  }) {
    return _then(_$SetQualityImpl(
      null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetQualityImpl implements _SetQuality {
  const _$SetQualityImpl(this.quality);

  @override
  final String quality;

  @override
  String toString() {
    return 'PlayerEvent.setQuality(quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetQualityImpl &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetQualityImplCopyWith<_$SetQualityImpl> get copyWith =>
      __$$SetQualityImplCopyWithImpl<_$SetQualityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return setQuality(quality);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return setQuality?.call(quality);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (setQuality != null) {
      return setQuality(quality);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return setQuality(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return setQuality?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (setQuality != null) {
      return setQuality(this);
    }
    return orElse();
  }
}

abstract class _SetQuality implements PlayerEvent {
  const factory _SetQuality(final String quality) = _$SetQualityImpl;

  String get quality;
  @JsonKey(ignore: true)
  _$$SetQualityImplCopyWith<_$SetQualityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetVolumeImplCopyWith<$Res> {
  factory _$$SetVolumeImplCopyWith(
          _$SetVolumeImpl value, $Res Function(_$SetVolumeImpl) then) =
      __$$SetVolumeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double volume});
}

/// @nodoc
class __$$SetVolumeImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$SetVolumeImpl>
    implements _$$SetVolumeImplCopyWith<$Res> {
  __$$SetVolumeImplCopyWithImpl(
      _$SetVolumeImpl _value, $Res Function(_$SetVolumeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? volume = null,
  }) {
    return _then(_$SetVolumeImpl(
      null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SetVolumeImpl implements _SetVolume {
  const _$SetVolumeImpl(this.volume);

  @override
  final double volume;

  @override
  String toString() {
    return 'PlayerEvent.setVolume(volume: $volume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetVolumeImpl &&
            (identical(other.volume, volume) || other.volume == volume));
  }

  @override
  int get hashCode => Object.hash(runtimeType, volume);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetVolumeImplCopyWith<_$SetVolumeImpl> get copyWith =>
      __$$SetVolumeImplCopyWithImpl<_$SetVolumeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return setVolume(volume);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return setVolume?.call(volume);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (setVolume != null) {
      return setVolume(volume);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return setVolume(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return setVolume?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (setVolume != null) {
      return setVolume(this);
    }
    return orElse();
  }
}

abstract class _SetVolume implements PlayerEvent {
  const factory _SetVolume(final double volume) = _$SetVolumeImpl;

  double get volume;
  @JsonKey(ignore: true)
  _$$SetVolumeImplCopyWith<_$SetVolumeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleMuteImplCopyWith<$Res> {
  factory _$$ToggleMuteImplCopyWith(
          _$ToggleMuteImpl value, $Res Function(_$ToggleMuteImpl) then) =
      __$$ToggleMuteImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleMuteImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$ToggleMuteImpl>
    implements _$$ToggleMuteImplCopyWith<$Res> {
  __$$ToggleMuteImplCopyWithImpl(
      _$ToggleMuteImpl _value, $Res Function(_$ToggleMuteImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ToggleMuteImpl implements _ToggleMute {
  const _$ToggleMuteImpl();

  @override
  String toString() {
    return 'PlayerEvent.toggleMute()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleMuteImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return toggleMute();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return toggleMute?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return toggleMute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return toggleMute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(this);
    }
    return orElse();
  }
}

abstract class _ToggleMute implements PlayerEvent {
  const factory _ToggleMute() = _$ToggleMuteImpl;
}

/// @nodoc
abstract class _$$ToggleFullscreenImplCopyWith<$Res> {
  factory _$$ToggleFullscreenImplCopyWith(_$ToggleFullscreenImpl value,
          $Res Function(_$ToggleFullscreenImpl) then) =
      __$$ToggleFullscreenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleFullscreenImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$ToggleFullscreenImpl>
    implements _$$ToggleFullscreenImplCopyWith<$Res> {
  __$$ToggleFullscreenImplCopyWithImpl(_$ToggleFullscreenImpl _value,
      $Res Function(_$ToggleFullscreenImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ToggleFullscreenImpl implements _ToggleFullscreen {
  const _$ToggleFullscreenImpl();

  @override
  String toString() {
    return 'PlayerEvent.toggleFullscreen()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleFullscreenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return toggleFullscreen();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return toggleFullscreen?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (toggleFullscreen != null) {
      return toggleFullscreen();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return toggleFullscreen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return toggleFullscreen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (toggleFullscreen != null) {
      return toggleFullscreen(this);
    }
    return orElse();
  }
}

abstract class _ToggleFullscreen implements PlayerEvent {
  const factory _ToggleFullscreen() = _$ToggleFullscreenImpl;
}

/// @nodoc
abstract class _$$UpdatePositionImplCopyWith<$Res> {
  factory _$$UpdatePositionImplCopyWith(_$UpdatePositionImpl value,
          $Res Function(_$UpdatePositionImpl) then) =
      __$$UpdatePositionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Duration position});
}

/// @nodoc
class __$$UpdatePositionImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$UpdatePositionImpl>
    implements _$$UpdatePositionImplCopyWith<$Res> {
  __$$UpdatePositionImplCopyWithImpl(
      _$UpdatePositionImpl _value, $Res Function(_$UpdatePositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
  }) {
    return _then(_$UpdatePositionImpl(
      null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$UpdatePositionImpl implements _UpdatePosition {
  const _$UpdatePositionImpl(this.position);

  @override
  final Duration position;

  @override
  String toString() {
    return 'PlayerEvent.updatePosition(position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePositionImpl &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePositionImplCopyWith<_$UpdatePositionImpl> get copyWith =>
      __$$UpdatePositionImplCopyWithImpl<_$UpdatePositionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return updatePosition(position);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return updatePosition?.call(position);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (updatePosition != null) {
      return updatePosition(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return updatePosition(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return updatePosition?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (updatePosition != null) {
      return updatePosition(this);
    }
    return orElse();
  }
}

abstract class _UpdatePosition implements PlayerEvent {
  const factory _UpdatePosition(final Duration position) = _$UpdatePositionImpl;

  Duration get position;
  @JsonKey(ignore: true)
  _$$UpdatePositionImplCopyWith<_$UpdatePositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateBufferingImplCopyWith<$Res> {
  factory _$$UpdateBufferingImplCopyWith(_$UpdateBufferingImpl value,
          $Res Function(_$UpdateBufferingImpl) then) =
      __$$UpdateBufferingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isBuffering});
}

/// @nodoc
class __$$UpdateBufferingImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$UpdateBufferingImpl>
    implements _$$UpdateBufferingImplCopyWith<$Res> {
  __$$UpdateBufferingImplCopyWithImpl(
      _$UpdateBufferingImpl _value, $Res Function(_$UpdateBufferingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isBuffering = null,
  }) {
    return _then(_$UpdateBufferingImpl(
      null == isBuffering
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UpdateBufferingImpl implements _UpdateBuffering {
  const _$UpdateBufferingImpl(this.isBuffering);

  @override
  final bool isBuffering;

  @override
  String toString() {
    return 'PlayerEvent.updateBuffering(isBuffering: $isBuffering)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBufferingImpl &&
            (identical(other.isBuffering, isBuffering) ||
                other.isBuffering == isBuffering));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isBuffering);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBufferingImplCopyWith<_$UpdateBufferingImpl> get copyWith =>
      __$$UpdateBufferingImplCopyWithImpl<_$UpdateBufferingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return updateBuffering(isBuffering);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return updateBuffering?.call(isBuffering);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (updateBuffering != null) {
      return updateBuffering(isBuffering);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return updateBuffering(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return updateBuffering?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (updateBuffering != null) {
      return updateBuffering(this);
    }
    return orElse();
  }
}

abstract class _UpdateBuffering implements PlayerEvent {
  const factory _UpdateBuffering(final bool isBuffering) =
      _$UpdateBufferingImpl;

  bool get isBuffering;
  @JsonKey(ignore: true)
  _$$UpdateBufferingImplCopyWith<_$UpdateBufferingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VideoCompletedImplCopyWith<$Res> {
  factory _$$VideoCompletedImplCopyWith(_$VideoCompletedImpl value,
          $Res Function(_$VideoCompletedImpl) then) =
      __$$VideoCompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VideoCompletedImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$VideoCompletedImpl>
    implements _$$VideoCompletedImplCopyWith<$Res> {
  __$$VideoCompletedImplCopyWithImpl(
      _$VideoCompletedImpl _value, $Res Function(_$VideoCompletedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$VideoCompletedImpl implements _VideoCompleted {
  const _$VideoCompletedImpl();

  @override
  String toString() {
    return 'PlayerEvent.videoCompleted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VideoCompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return videoCompleted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return videoCompleted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (videoCompleted != null) {
      return videoCompleted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return videoCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return videoCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (videoCompleted != null) {
      return videoCompleted(this);
    }
    return orElse();
  }
}

abstract class _VideoCompleted implements PlayerEvent {
  const factory _VideoCompleted() = _$VideoCompletedImpl;
}

/// @nodoc
abstract class _$$DisposeImplCopyWith<$Res> {
  factory _$$DisposeImplCopyWith(
          _$DisposeImpl value, $Res Function(_$DisposeImpl) then) =
      __$$DisposeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisposeImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$DisposeImpl>
    implements _$$DisposeImplCopyWith<$Res> {
  __$$DisposeImplCopyWithImpl(
      _$DisposeImpl _value, $Res Function(_$DisposeImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DisposeImpl implements _Dispose {
  const _$DisposeImpl();

  @override
  String toString() {
    return 'PlayerEvent.dispose()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisposeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MediaItem mediaItem) initialize,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function(Duration position) seekTo,
    required TResult Function(double speed) setSpeed,
    required TResult Function(String quality) setQuality,
    required TResult Function(double volume) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullscreen,
    required TResult Function(Duration position) updatePosition,
    required TResult Function(bool isBuffering) updateBuffering,
    required TResult Function() videoCompleted,
    required TResult Function() dispose,
  }) {
    return dispose();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MediaItem mediaItem)? initialize,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function(Duration position)? seekTo,
    TResult? Function(double speed)? setSpeed,
    TResult? Function(String quality)? setQuality,
    TResult? Function(double volume)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullscreen,
    TResult? Function(Duration position)? updatePosition,
    TResult? Function(bool isBuffering)? updateBuffering,
    TResult? Function()? videoCompleted,
    TResult? Function()? dispose,
  }) {
    return dispose?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MediaItem mediaItem)? initialize,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function(Duration position)? seekTo,
    TResult Function(double speed)? setSpeed,
    TResult Function(String quality)? setQuality,
    TResult Function(double volume)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullscreen,
    TResult Function(Duration position)? updatePosition,
    TResult Function(bool isBuffering)? updateBuffering,
    TResult Function()? videoCompleted,
    TResult Function()? dispose,
    required TResult orElse(),
  }) {
    if (dispose != null) {
      return dispose();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_SeekTo value) seekTo,
    required TResult Function(_SetSpeed value) setSpeed,
    required TResult Function(_SetQuality value) setQuality,
    required TResult Function(_SetVolume value) setVolume,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleFullscreen value) toggleFullscreen,
    required TResult Function(_UpdatePosition value) updatePosition,
    required TResult Function(_UpdateBuffering value) updateBuffering,
    required TResult Function(_VideoCompleted value) videoCompleted,
    required TResult Function(_Dispose value) dispose,
  }) {
    return dispose(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialize value)? initialize,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_SeekTo value)? seekTo,
    TResult? Function(_SetSpeed value)? setSpeed,
    TResult? Function(_SetQuality value)? setQuality,
    TResult? Function(_SetVolume value)? setVolume,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult? Function(_UpdatePosition value)? updatePosition,
    TResult? Function(_UpdateBuffering value)? updateBuffering,
    TResult? Function(_VideoCompleted value)? videoCompleted,
    TResult? Function(_Dispose value)? dispose,
  }) {
    return dispose?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_SeekTo value)? seekTo,
    TResult Function(_SetSpeed value)? setSpeed,
    TResult Function(_SetQuality value)? setQuality,
    TResult Function(_SetVolume value)? setVolume,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleFullscreen value)? toggleFullscreen,
    TResult Function(_UpdatePosition value)? updatePosition,
    TResult Function(_UpdateBuffering value)? updateBuffering,
    TResult Function(_VideoCompleted value)? videoCompleted,
    TResult Function(_Dispose value)? dispose,
    required TResult orElse(),
  }) {
    if (dispose != null) {
      return dispose(this);
    }
    return orElse();
  }
}

abstract class _Dispose implements PlayerEvent {
  const factory _Dispose() = _$DisposeImpl;
}
