// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DownloadEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDownloads,
    required TResult Function(MediaItem mediaItem, String quality)
        startDownload,
    required TResult Function(String taskId) pauseDownload,
    required TResult Function(String taskId) resumeDownload,
    required TResult Function(String taskId) cancelDownload,
    required TResult Function(String taskId) deleteDownload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDownloads,
    TResult? Function(MediaItem mediaItem, String quality)? startDownload,
    TResult? Function(String taskId)? pauseDownload,
    TResult? Function(String taskId)? resumeDownload,
    TResult? Function(String taskId)? cancelDownload,
    TResult? Function(String taskId)? deleteDownload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDownloads,
    TResult Function(MediaItem mediaItem, String quality)? startDownload,
    TResult Function(String taskId)? pauseDownload,
    TResult Function(String taskId)? resumeDownload,
    TResult Function(String taskId)? cancelDownload,
    TResult Function(String taskId)? deleteDownload,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDownloads value) loadDownloads,
    required TResult Function(_StartDownload value) startDownload,
    required TResult Function(_PauseDownload value) pauseDownload,
    required TResult Function(_ResumeDownload value) resumeDownload,
    required TResult Function(_CancelDownload value) cancelDownload,
    required TResult Function(_DeleteDownload value) deleteDownload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDownloads value)? loadDownloads,
    TResult? Function(_StartDownload value)? startDownload,
    TResult? Function(_PauseDownload value)? pauseDownload,
    TResult? Function(_ResumeDownload value)? resumeDownload,
    TResult? Function(_CancelDownload value)? cancelDownload,
    TResult? Function(_DeleteDownload value)? deleteDownload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDownloads value)? loadDownloads,
    TResult Function(_StartDownload value)? startDownload,
    TResult Function(_PauseDownload value)? pauseDownload,
    TResult Function(_ResumeDownload value)? resumeDownload,
    TResult Function(_CancelDownload value)? cancelDownload,
    TResult Function(_DeleteDownload value)? deleteDownload,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadEventCopyWith<$Res> {
  factory $DownloadEventCopyWith(
          DownloadEvent value, $Res Function(DownloadEvent) then) =
      _$DownloadEventCopyWithImpl<$Res, DownloadEvent>;
}

/// @nodoc
class _$DownloadEventCopyWithImpl<$Res, $Val extends DownloadEvent>
    implements $DownloadEventCopyWith<$Res> {
  _$DownloadEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadDownloadsImplCopyWith<$Res> {
  factory _$$LoadDownloadsImplCopyWith(
          _$LoadDownloadsImpl value, $Res Function(_$LoadDownloadsImpl) then) =
      __$$LoadDownloadsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadDownloadsImplCopyWithImpl<$Res>
    extends _$DownloadEventCopyWithImpl<$Res, _$LoadDownloadsImpl>
    implements _$$LoadDownloadsImplCopyWith<$Res> {
  __$$LoadDownloadsImplCopyWithImpl(
      _$LoadDownloadsImpl _value, $Res Function(_$LoadDownloadsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadDownloadsImpl implements _LoadDownloads {
  const _$LoadDownloadsImpl();

  @override
  String toString() {
    return 'DownloadEvent.loadDownloads()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadDownloadsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDownloads,
    required TResult Function(MediaItem mediaItem, String quality)
        startDownload,
    required TResult Function(String taskId) pauseDownload,
    required TResult Function(String taskId) resumeDownload,
    required TResult Function(String taskId) cancelDownload,
    required TResult Function(String taskId) deleteDownload,
  }) {
    return loadDownloads();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDownloads,
    TResult? Function(MediaItem mediaItem, String quality)? startDownload,
    TResult? Function(String taskId)? pauseDownload,
    TResult? Function(String taskId)? resumeDownload,
    TResult? Function(String taskId)? cancelDownload,
    TResult? Function(String taskId)? deleteDownload,
  }) {
    return loadDownloads?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDownloads,
    TResult Function(MediaItem mediaItem, String quality)? startDownload,
    TResult Function(String taskId)? pauseDownload,
    TResult Function(String taskId)? resumeDownload,
    TResult Function(String taskId)? cancelDownload,
    TResult Function(String taskId)? deleteDownload,
    required TResult orElse(),
  }) {
    if (loadDownloads != null) {
      return loadDownloads();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDownloads value) loadDownloads,
    required TResult Function(_StartDownload value) startDownload,
    required TResult Function(_PauseDownload value) pauseDownload,
    required TResult Function(_ResumeDownload value) resumeDownload,
    required TResult Function(_CancelDownload value) cancelDownload,
    required TResult Function(_DeleteDownload value) deleteDownload,
  }) {
    return loadDownloads(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDownloads value)? loadDownloads,
    TResult? Function(_StartDownload value)? startDownload,
    TResult? Function(_PauseDownload value)? pauseDownload,
    TResult? Function(_ResumeDownload value)? resumeDownload,
    TResult? Function(_CancelDownload value)? cancelDownload,
    TResult? Function(_DeleteDownload value)? deleteDownload,
  }) {
    return loadDownloads?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDownloads value)? loadDownloads,
    TResult Function(_StartDownload value)? startDownload,
    TResult Function(_PauseDownload value)? pauseDownload,
    TResult Function(_ResumeDownload value)? resumeDownload,
    TResult Function(_CancelDownload value)? cancelDownload,
    TResult Function(_DeleteDownload value)? deleteDownload,
    required TResult orElse(),
  }) {
    if (loadDownloads != null) {
      return loadDownloads(this);
    }
    return orElse();
  }
}

abstract class _LoadDownloads implements DownloadEvent {
  const factory _LoadDownloads() = _$LoadDownloadsImpl;
}

/// @nodoc
abstract class _$$StartDownloadImplCopyWith<$Res> {
  factory _$$StartDownloadImplCopyWith(
          _$StartDownloadImpl value, $Res Function(_$StartDownloadImpl) then) =
      __$$StartDownloadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MediaItem mediaItem, String quality});
}

/// @nodoc
class __$$StartDownloadImplCopyWithImpl<$Res>
    extends _$DownloadEventCopyWithImpl<$Res, _$StartDownloadImpl>
    implements _$$StartDownloadImplCopyWith<$Res> {
  __$$StartDownloadImplCopyWithImpl(
      _$StartDownloadImpl _value, $Res Function(_$StartDownloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaItem = null,
    Object? quality = null,
  }) {
    return _then(_$StartDownloadImpl(
      mediaItem: null == mediaItem
          ? _value.mediaItem
          : mediaItem // ignore: cast_nullable_to_non_nullable
              as MediaItem,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StartDownloadImpl implements _StartDownload {
  const _$StartDownloadImpl({required this.mediaItem, required this.quality});

  @override
  final MediaItem mediaItem;
  @override
  final String quality;

  @override
  String toString() {
    return 'DownloadEvent.startDownload(mediaItem: $mediaItem, quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartDownloadImpl &&
            (identical(other.mediaItem, mediaItem) ||
                other.mediaItem == mediaItem) &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mediaItem, quality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartDownloadImplCopyWith<_$StartDownloadImpl> get copyWith =>
      __$$StartDownloadImplCopyWithImpl<_$StartDownloadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDownloads,
    required TResult Function(MediaItem mediaItem, String quality)
        startDownload,
    required TResult Function(String taskId) pauseDownload,
    required TResult Function(String taskId) resumeDownload,
    required TResult Function(String taskId) cancelDownload,
    required TResult Function(String taskId) deleteDownload,
  }) {
    return startDownload(mediaItem, quality);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDownloads,
    TResult? Function(MediaItem mediaItem, String quality)? startDownload,
    TResult? Function(String taskId)? pauseDownload,
    TResult? Function(String taskId)? resumeDownload,
    TResult? Function(String taskId)? cancelDownload,
    TResult? Function(String taskId)? deleteDownload,
  }) {
    return startDownload?.call(mediaItem, quality);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDownloads,
    TResult Function(MediaItem mediaItem, String quality)? startDownload,
    TResult Function(String taskId)? pauseDownload,
    TResult Function(String taskId)? resumeDownload,
    TResult Function(String taskId)? cancelDownload,
    TResult Function(String taskId)? deleteDownload,
    required TResult orElse(),
  }) {
    if (startDownload != null) {
      return startDownload(mediaItem, quality);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDownloads value) loadDownloads,
    required TResult Function(_StartDownload value) startDownload,
    required TResult Function(_PauseDownload value) pauseDownload,
    required TResult Function(_ResumeDownload value) resumeDownload,
    required TResult Function(_CancelDownload value) cancelDownload,
    required TResult Function(_DeleteDownload value) deleteDownload,
  }) {
    return startDownload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDownloads value)? loadDownloads,
    TResult? Function(_StartDownload value)? startDownload,
    TResult? Function(_PauseDownload value)? pauseDownload,
    TResult? Function(_ResumeDownload value)? resumeDownload,
    TResult? Function(_CancelDownload value)? cancelDownload,
    TResult? Function(_DeleteDownload value)? deleteDownload,
  }) {
    return startDownload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDownloads value)? loadDownloads,
    TResult Function(_StartDownload value)? startDownload,
    TResult Function(_PauseDownload value)? pauseDownload,
    TResult Function(_ResumeDownload value)? resumeDownload,
    TResult Function(_CancelDownload value)? cancelDownload,
    TResult Function(_DeleteDownload value)? deleteDownload,
    required TResult orElse(),
  }) {
    if (startDownload != null) {
      return startDownload(this);
    }
    return orElse();
  }
}

abstract class _StartDownload implements DownloadEvent {
  const factory _StartDownload(
      {required final MediaItem mediaItem,
      required final String quality}) = _$StartDownloadImpl;

  MediaItem get mediaItem;
  String get quality;
  @JsonKey(ignore: true)
  _$$StartDownloadImplCopyWith<_$StartDownloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PauseDownloadImplCopyWith<$Res> {
  factory _$$PauseDownloadImplCopyWith(
          _$PauseDownloadImpl value, $Res Function(_$PauseDownloadImpl) then) =
      __$$PauseDownloadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$PauseDownloadImplCopyWithImpl<$Res>
    extends _$DownloadEventCopyWithImpl<$Res, _$PauseDownloadImpl>
    implements _$$PauseDownloadImplCopyWith<$Res> {
  __$$PauseDownloadImplCopyWithImpl(
      _$PauseDownloadImpl _value, $Res Function(_$PauseDownloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$PauseDownloadImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PauseDownloadImpl implements _PauseDownload {
  const _$PauseDownloadImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'DownloadEvent.pauseDownload(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PauseDownloadImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PauseDownloadImplCopyWith<_$PauseDownloadImpl> get copyWith =>
      __$$PauseDownloadImplCopyWithImpl<_$PauseDownloadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDownloads,
    required TResult Function(MediaItem mediaItem, String quality)
        startDownload,
    required TResult Function(String taskId) pauseDownload,
    required TResult Function(String taskId) resumeDownload,
    required TResult Function(String taskId) cancelDownload,
    required TResult Function(String taskId) deleteDownload,
  }) {
    return pauseDownload(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDownloads,
    TResult? Function(MediaItem mediaItem, String quality)? startDownload,
    TResult? Function(String taskId)? pauseDownload,
    TResult? Function(String taskId)? resumeDownload,
    TResult? Function(String taskId)? cancelDownload,
    TResult? Function(String taskId)? deleteDownload,
  }) {
    return pauseDownload?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDownloads,
    TResult Function(MediaItem mediaItem, String quality)? startDownload,
    TResult Function(String taskId)? pauseDownload,
    TResult Function(String taskId)? resumeDownload,
    TResult Function(String taskId)? cancelDownload,
    TResult Function(String taskId)? deleteDownload,
    required TResult orElse(),
  }) {
    if (pauseDownload != null) {
      return pauseDownload(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDownloads value) loadDownloads,
    required TResult Function(_StartDownload value) startDownload,
    required TResult Function(_PauseDownload value) pauseDownload,
    required TResult Function(_ResumeDownload value) resumeDownload,
    required TResult Function(_CancelDownload value) cancelDownload,
    required TResult Function(_DeleteDownload value) deleteDownload,
  }) {
    return pauseDownload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDownloads value)? loadDownloads,
    TResult? Function(_StartDownload value)? startDownload,
    TResult? Function(_PauseDownload value)? pauseDownload,
    TResult? Function(_ResumeDownload value)? resumeDownload,
    TResult? Function(_CancelDownload value)? cancelDownload,
    TResult? Function(_DeleteDownload value)? deleteDownload,
  }) {
    return pauseDownload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDownloads value)? loadDownloads,
    TResult Function(_StartDownload value)? startDownload,
    TResult Function(_PauseDownload value)? pauseDownload,
    TResult Function(_ResumeDownload value)? resumeDownload,
    TResult Function(_CancelDownload value)? cancelDownload,
    TResult Function(_DeleteDownload value)? deleteDownload,
    required TResult orElse(),
  }) {
    if (pauseDownload != null) {
      return pauseDownload(this);
    }
    return orElse();
  }
}

abstract class _PauseDownload implements DownloadEvent {
  const factory _PauseDownload(final String taskId) = _$PauseDownloadImpl;

  String get taskId;
  @JsonKey(ignore: true)
  _$$PauseDownloadImplCopyWith<_$PauseDownloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResumeDownloadImplCopyWith<$Res> {
  factory _$$ResumeDownloadImplCopyWith(_$ResumeDownloadImpl value,
          $Res Function(_$ResumeDownloadImpl) then) =
      __$$ResumeDownloadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$ResumeDownloadImplCopyWithImpl<$Res>
    extends _$DownloadEventCopyWithImpl<$Res, _$ResumeDownloadImpl>
    implements _$$ResumeDownloadImplCopyWith<$Res> {
  __$$ResumeDownloadImplCopyWithImpl(
      _$ResumeDownloadImpl _value, $Res Function(_$ResumeDownloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$ResumeDownloadImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResumeDownloadImpl implements _ResumeDownload {
  const _$ResumeDownloadImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'DownloadEvent.resumeDownload(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResumeDownloadImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResumeDownloadImplCopyWith<_$ResumeDownloadImpl> get copyWith =>
      __$$ResumeDownloadImplCopyWithImpl<_$ResumeDownloadImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDownloads,
    required TResult Function(MediaItem mediaItem, String quality)
        startDownload,
    required TResult Function(String taskId) pauseDownload,
    required TResult Function(String taskId) resumeDownload,
    required TResult Function(String taskId) cancelDownload,
    required TResult Function(String taskId) deleteDownload,
  }) {
    return resumeDownload(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDownloads,
    TResult? Function(MediaItem mediaItem, String quality)? startDownload,
    TResult? Function(String taskId)? pauseDownload,
    TResult? Function(String taskId)? resumeDownload,
    TResult? Function(String taskId)? cancelDownload,
    TResult? Function(String taskId)? deleteDownload,
  }) {
    return resumeDownload?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDownloads,
    TResult Function(MediaItem mediaItem, String quality)? startDownload,
    TResult Function(String taskId)? pauseDownload,
    TResult Function(String taskId)? resumeDownload,
    TResult Function(String taskId)? cancelDownload,
    TResult Function(String taskId)? deleteDownload,
    required TResult orElse(),
  }) {
    if (resumeDownload != null) {
      return resumeDownload(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDownloads value) loadDownloads,
    required TResult Function(_StartDownload value) startDownload,
    required TResult Function(_PauseDownload value) pauseDownload,
    required TResult Function(_ResumeDownload value) resumeDownload,
    required TResult Function(_CancelDownload value) cancelDownload,
    required TResult Function(_DeleteDownload value) deleteDownload,
  }) {
    return resumeDownload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDownloads value)? loadDownloads,
    TResult? Function(_StartDownload value)? startDownload,
    TResult? Function(_PauseDownload value)? pauseDownload,
    TResult? Function(_ResumeDownload value)? resumeDownload,
    TResult? Function(_CancelDownload value)? cancelDownload,
    TResult? Function(_DeleteDownload value)? deleteDownload,
  }) {
    return resumeDownload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDownloads value)? loadDownloads,
    TResult Function(_StartDownload value)? startDownload,
    TResult Function(_PauseDownload value)? pauseDownload,
    TResult Function(_ResumeDownload value)? resumeDownload,
    TResult Function(_CancelDownload value)? cancelDownload,
    TResult Function(_DeleteDownload value)? deleteDownload,
    required TResult orElse(),
  }) {
    if (resumeDownload != null) {
      return resumeDownload(this);
    }
    return orElse();
  }
}

abstract class _ResumeDownload implements DownloadEvent {
  const factory _ResumeDownload(final String taskId) = _$ResumeDownloadImpl;

  String get taskId;
  @JsonKey(ignore: true)
  _$$ResumeDownloadImplCopyWith<_$ResumeDownloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelDownloadImplCopyWith<$Res> {
  factory _$$CancelDownloadImplCopyWith(_$CancelDownloadImpl value,
          $Res Function(_$CancelDownloadImpl) then) =
      __$$CancelDownloadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$CancelDownloadImplCopyWithImpl<$Res>
    extends _$DownloadEventCopyWithImpl<$Res, _$CancelDownloadImpl>
    implements _$$CancelDownloadImplCopyWith<$Res> {
  __$$CancelDownloadImplCopyWithImpl(
      _$CancelDownloadImpl _value, $Res Function(_$CancelDownloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$CancelDownloadImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CancelDownloadImpl implements _CancelDownload {
  const _$CancelDownloadImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'DownloadEvent.cancelDownload(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelDownloadImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelDownloadImplCopyWith<_$CancelDownloadImpl> get copyWith =>
      __$$CancelDownloadImplCopyWithImpl<_$CancelDownloadImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDownloads,
    required TResult Function(MediaItem mediaItem, String quality)
        startDownload,
    required TResult Function(String taskId) pauseDownload,
    required TResult Function(String taskId) resumeDownload,
    required TResult Function(String taskId) cancelDownload,
    required TResult Function(String taskId) deleteDownload,
  }) {
    return cancelDownload(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDownloads,
    TResult? Function(MediaItem mediaItem, String quality)? startDownload,
    TResult? Function(String taskId)? pauseDownload,
    TResult? Function(String taskId)? resumeDownload,
    TResult? Function(String taskId)? cancelDownload,
    TResult? Function(String taskId)? deleteDownload,
  }) {
    return cancelDownload?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDownloads,
    TResult Function(MediaItem mediaItem, String quality)? startDownload,
    TResult Function(String taskId)? pauseDownload,
    TResult Function(String taskId)? resumeDownload,
    TResult Function(String taskId)? cancelDownload,
    TResult Function(String taskId)? deleteDownload,
    required TResult orElse(),
  }) {
    if (cancelDownload != null) {
      return cancelDownload(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDownloads value) loadDownloads,
    required TResult Function(_StartDownload value) startDownload,
    required TResult Function(_PauseDownload value) pauseDownload,
    required TResult Function(_ResumeDownload value) resumeDownload,
    required TResult Function(_CancelDownload value) cancelDownload,
    required TResult Function(_DeleteDownload value) deleteDownload,
  }) {
    return cancelDownload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDownloads value)? loadDownloads,
    TResult? Function(_StartDownload value)? startDownload,
    TResult? Function(_PauseDownload value)? pauseDownload,
    TResult? Function(_ResumeDownload value)? resumeDownload,
    TResult? Function(_CancelDownload value)? cancelDownload,
    TResult? Function(_DeleteDownload value)? deleteDownload,
  }) {
    return cancelDownload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDownloads value)? loadDownloads,
    TResult Function(_StartDownload value)? startDownload,
    TResult Function(_PauseDownload value)? pauseDownload,
    TResult Function(_ResumeDownload value)? resumeDownload,
    TResult Function(_CancelDownload value)? cancelDownload,
    TResult Function(_DeleteDownload value)? deleteDownload,
    required TResult orElse(),
  }) {
    if (cancelDownload != null) {
      return cancelDownload(this);
    }
    return orElse();
  }
}

abstract class _CancelDownload implements DownloadEvent {
  const factory _CancelDownload(final String taskId) = _$CancelDownloadImpl;

  String get taskId;
  @JsonKey(ignore: true)
  _$$CancelDownloadImplCopyWith<_$CancelDownloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteDownloadImplCopyWith<$Res> {
  factory _$$DeleteDownloadImplCopyWith(_$DeleteDownloadImpl value,
          $Res Function(_$DeleteDownloadImpl) then) =
      __$$DeleteDownloadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$DeleteDownloadImplCopyWithImpl<$Res>
    extends _$DownloadEventCopyWithImpl<$Res, _$DeleteDownloadImpl>
    implements _$$DeleteDownloadImplCopyWith<$Res> {
  __$$DeleteDownloadImplCopyWithImpl(
      _$DeleteDownloadImpl _value, $Res Function(_$DeleteDownloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$DeleteDownloadImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteDownloadImpl implements _DeleteDownload {
  const _$DeleteDownloadImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'DownloadEvent.deleteDownload(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteDownloadImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteDownloadImplCopyWith<_$DeleteDownloadImpl> get copyWith =>
      __$$DeleteDownloadImplCopyWithImpl<_$DeleteDownloadImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDownloads,
    required TResult Function(MediaItem mediaItem, String quality)
        startDownload,
    required TResult Function(String taskId) pauseDownload,
    required TResult Function(String taskId) resumeDownload,
    required TResult Function(String taskId) cancelDownload,
    required TResult Function(String taskId) deleteDownload,
  }) {
    return deleteDownload(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDownloads,
    TResult? Function(MediaItem mediaItem, String quality)? startDownload,
    TResult? Function(String taskId)? pauseDownload,
    TResult? Function(String taskId)? resumeDownload,
    TResult? Function(String taskId)? cancelDownload,
    TResult? Function(String taskId)? deleteDownload,
  }) {
    return deleteDownload?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDownloads,
    TResult Function(MediaItem mediaItem, String quality)? startDownload,
    TResult Function(String taskId)? pauseDownload,
    TResult Function(String taskId)? resumeDownload,
    TResult Function(String taskId)? cancelDownload,
    TResult Function(String taskId)? deleteDownload,
    required TResult orElse(),
  }) {
    if (deleteDownload != null) {
      return deleteDownload(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDownloads value) loadDownloads,
    required TResult Function(_StartDownload value) startDownload,
    required TResult Function(_PauseDownload value) pauseDownload,
    required TResult Function(_ResumeDownload value) resumeDownload,
    required TResult Function(_CancelDownload value) cancelDownload,
    required TResult Function(_DeleteDownload value) deleteDownload,
  }) {
    return deleteDownload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDownloads value)? loadDownloads,
    TResult? Function(_StartDownload value)? startDownload,
    TResult? Function(_PauseDownload value)? pauseDownload,
    TResult? Function(_ResumeDownload value)? resumeDownload,
    TResult? Function(_CancelDownload value)? cancelDownload,
    TResult? Function(_DeleteDownload value)? deleteDownload,
  }) {
    return deleteDownload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDownloads value)? loadDownloads,
    TResult Function(_StartDownload value)? startDownload,
    TResult Function(_PauseDownload value)? pauseDownload,
    TResult Function(_ResumeDownload value)? resumeDownload,
    TResult Function(_CancelDownload value)? cancelDownload,
    TResult Function(_DeleteDownload value)? deleteDownload,
    required TResult orElse(),
  }) {
    if (deleteDownload != null) {
      return deleteDownload(this);
    }
    return orElse();
  }
}

abstract class _DeleteDownload implements DownloadEvent {
  const factory _DeleteDownload(final String taskId) = _$DeleteDownloadImpl;

  String get taskId;
  @JsonKey(ignore: true)
  _$$DeleteDownloadImplCopyWith<_$DeleteDownloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
