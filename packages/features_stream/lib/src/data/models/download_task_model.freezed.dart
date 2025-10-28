// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DownloadTaskModel _$DownloadTaskModelFromJson(Map<String, dynamic> json) {
  return _DownloadTaskModel.fromJson(json);
}

/// @nodoc
mixin _$DownloadTaskModel {
  String get id => throw _privateConstructorUsedError;
  MediaItemModel get mediaItem => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  String? get localPath => throw _privateConstructorUsedError;
  int? get totalBytes => throw _privateConstructorUsedError;
  int? get downloadedBytes => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get completedAt => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String get quality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DownloadTaskModelCopyWith<DownloadTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadTaskModelCopyWith<$Res> {
  factory $DownloadTaskModelCopyWith(
          DownloadTaskModel value, $Res Function(DownloadTaskModel) then) =
      _$DownloadTaskModelCopyWithImpl<$Res, DownloadTaskModel>;
  @useResult
  $Res call(
      {String id,
      MediaItemModel mediaItem,
      String status,
      double progress,
      String? localPath,
      int? totalBytes,
      int? downloadedBytes,
      String createdAt,
      String? completedAt,
      String? errorMessage,
      String quality});

  $MediaItemModelCopyWith<$Res> get mediaItem;
}

/// @nodoc
class _$DownloadTaskModelCopyWithImpl<$Res, $Val extends DownloadTaskModel>
    implements $DownloadTaskModelCopyWith<$Res> {
  _$DownloadTaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mediaItem = null,
    Object? status = null,
    Object? progress = null,
    Object? localPath = freezed,
    Object? totalBytes = freezed,
    Object? downloadedBytes = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? errorMessage = freezed,
    Object? quality = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mediaItem: null == mediaItem
          ? _value.mediaItem
          : mediaItem // ignore: cast_nullable_to_non_nullable
              as MediaItemModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      totalBytes: freezed == totalBytes
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      downloadedBytes: freezed == downloadedBytes
          ? _value.downloadedBytes
          : downloadedBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MediaItemModelCopyWith<$Res> get mediaItem {
    return $MediaItemModelCopyWith<$Res>(_value.mediaItem, (value) {
      return _then(_value.copyWith(mediaItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DownloadTaskModelImplCopyWith<$Res>
    implements $DownloadTaskModelCopyWith<$Res> {
  factory _$$DownloadTaskModelImplCopyWith(_$DownloadTaskModelImpl value,
          $Res Function(_$DownloadTaskModelImpl) then) =
      __$$DownloadTaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      MediaItemModel mediaItem,
      String status,
      double progress,
      String? localPath,
      int? totalBytes,
      int? downloadedBytes,
      String createdAt,
      String? completedAt,
      String? errorMessage,
      String quality});

  @override
  $MediaItemModelCopyWith<$Res> get mediaItem;
}

/// @nodoc
class __$$DownloadTaskModelImplCopyWithImpl<$Res>
    extends _$DownloadTaskModelCopyWithImpl<$Res, _$DownloadTaskModelImpl>
    implements _$$DownloadTaskModelImplCopyWith<$Res> {
  __$$DownloadTaskModelImplCopyWithImpl(_$DownloadTaskModelImpl _value,
      $Res Function(_$DownloadTaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mediaItem = null,
    Object? status = null,
    Object? progress = null,
    Object? localPath = freezed,
    Object? totalBytes = freezed,
    Object? downloadedBytes = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? errorMessage = freezed,
    Object? quality = null,
  }) {
    return _then(_$DownloadTaskModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mediaItem: null == mediaItem
          ? _value.mediaItem
          : mediaItem // ignore: cast_nullable_to_non_nullable
              as MediaItemModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      totalBytes: freezed == totalBytes
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      downloadedBytes: freezed == downloadedBytes
          ? _value.downloadedBytes
          : downloadedBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DownloadTaskModelImpl extends _DownloadTaskModel {
  const _$DownloadTaskModelImpl(
      {required this.id,
      required this.mediaItem,
      required this.status,
      this.progress = 0.0,
      this.localPath,
      this.totalBytes,
      this.downloadedBytes,
      required this.createdAt,
      this.completedAt,
      this.errorMessage,
      required this.quality})
      : super._();

  factory _$DownloadTaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DownloadTaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final MediaItemModel mediaItem;
  @override
  final String status;
  @override
  @JsonKey()
  final double progress;
  @override
  final String? localPath;
  @override
  final int? totalBytes;
  @override
  final int? downloadedBytes;
  @override
  final String createdAt;
  @override
  final String? completedAt;
  @override
  final String? errorMessage;
  @override
  final String quality;

  @override
  String toString() {
    return 'DownloadTaskModel(id: $id, mediaItem: $mediaItem, status: $status, progress: $progress, localPath: $localPath, totalBytes: $totalBytes, downloadedBytes: $downloadedBytes, createdAt: $createdAt, completedAt: $completedAt, errorMessage: $errorMessage, quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadTaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mediaItem, mediaItem) ||
                other.mediaItem == mediaItem) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.totalBytes, totalBytes) ||
                other.totalBytes == totalBytes) &&
            (identical(other.downloadedBytes, downloadedBytes) ||
                other.downloadedBytes == downloadedBytes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      mediaItem,
      status,
      progress,
      localPath,
      totalBytes,
      downloadedBytes,
      createdAt,
      completedAt,
      errorMessage,
      quality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadTaskModelImplCopyWith<_$DownloadTaskModelImpl> get copyWith =>
      __$$DownloadTaskModelImplCopyWithImpl<_$DownloadTaskModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DownloadTaskModelImplToJson(
      this,
    );
  }
}

abstract class _DownloadTaskModel extends DownloadTaskModel {
  const factory _DownloadTaskModel(
      {required final String id,
      required final MediaItemModel mediaItem,
      required final String status,
      final double progress,
      final String? localPath,
      final int? totalBytes,
      final int? downloadedBytes,
      required final String createdAt,
      final String? completedAt,
      final String? errorMessage,
      required final String quality}) = _$DownloadTaskModelImpl;
  const _DownloadTaskModel._() : super._();

  factory _DownloadTaskModel.fromJson(Map<String, dynamic> json) =
      _$DownloadTaskModelImpl.fromJson;

  @override
  String get id;
  @override
  MediaItemModel get mediaItem;
  @override
  String get status;
  @override
  double get progress;
  @override
  String? get localPath;
  @override
  int? get totalBytes;
  @override
  int? get downloadedBytes;
  @override
  String get createdAt;
  @override
  String? get completedAt;
  @override
  String? get errorMessage;
  @override
  String get quality;
  @override
  @JsonKey(ignore: true)
  _$$DownloadTaskModelImplCopyWith<_$DownloadTaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
