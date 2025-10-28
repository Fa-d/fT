// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DownloadTaskModelImpl _$$DownloadTaskModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DownloadTaskModelImpl(
      id: json['id'] as String,
      mediaItem:
          MediaItemModel.fromJson(json['mediaItem'] as Map<String, dynamic>),
      status: json['status'] as String,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      localPath: json['localPath'] as String?,
      totalBytes: (json['totalBytes'] as num?)?.toInt(),
      downloadedBytes: (json['downloadedBytes'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String,
      completedAt: json['completedAt'] as String?,
      errorMessage: json['errorMessage'] as String?,
      quality: json['quality'] as String,
    );

Map<String, dynamic> _$$DownloadTaskModelImplToJson(
        _$DownloadTaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mediaItem': instance.mediaItem,
      'status': instance.status,
      'progress': instance.progress,
      'localPath': instance.localPath,
      'totalBytes': instance.totalBytes,
      'downloadedBytes': instance.downloadedBytes,
      'createdAt': instance.createdAt,
      'completedAt': instance.completedAt,
      'errorMessage': instance.errorMessage,
      'quality': instance.quality,
    };
