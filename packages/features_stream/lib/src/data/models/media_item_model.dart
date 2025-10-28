import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/media_item.dart';

part 'media_item_model.freezed.dart';
part 'media_item_model.g.dart';

@freezed
class MediaItemModel with _$MediaItemModel {
  const MediaItemModel._();

  const factory MediaItemModel({
    required String id,
    required String title,
    required String description,
    required String thumbnailUrl,
    required int durationInSeconds,
    required String streamUrl,
    required String type,
    required Map<String, String> qualityOptions,
    required String publishedAt,
    String? author,
    @Default(0) int viewCount,
  }) = _MediaItemModel;

  factory MediaItemModel.fromJson(Map<String, dynamic> json) =>
      _$MediaItemModelFromJson(json);

  /// Convert to domain entity
  MediaItem toEntity() {
    return MediaItem(
      id: id,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      duration: Duration(seconds: durationInSeconds),
      streamUrl: streamUrl,
      type: type == 'video' ? MediaType.video : MediaType.audio,
      qualityOptions: qualityOptions,
      publishedAt: DateTime.parse(publishedAt),
      author: author,
      viewCount: viewCount,
    );
  }

  /// Create from domain entity
  factory MediaItemModel.fromEntity(MediaItem entity) {
    return MediaItemModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      thumbnailUrl: entity.thumbnailUrl,
      durationInSeconds: entity.duration.inSeconds,
      streamUrl: entity.streamUrl,
      type: entity.type == MediaType.video ? 'video' : 'audio',
      qualityOptions: entity.qualityOptions,
      publishedAt: entity.publishedAt.toIso8601String(),
      author: entity.author,
      viewCount: entity.viewCount,
    );
  }
}
