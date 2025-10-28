// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaItemModelImpl _$$MediaItemModelImplFromJson(Map<String, dynamic> json) =>
    _$MediaItemModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      durationInSeconds: (json['durationInSeconds'] as num).toInt(),
      streamUrl: json['streamUrl'] as String,
      type: json['type'] as String,
      qualityOptions: Map<String, String>.from(json['qualityOptions'] as Map),
      publishedAt: json['publishedAt'] as String,
      author: json['author'] as String?,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MediaItemModelImplToJson(
  _$MediaItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'thumbnailUrl': instance.thumbnailUrl,
  'durationInSeconds': instance.durationInSeconds,
  'streamUrl': instance.streamUrl,
  'type': instance.type,
  'qualityOptions': instance.qualityOptions,
  'publishedAt': instance.publishedAt,
  'author': instance.author,
  'viewCount': instance.viewCount,
};
