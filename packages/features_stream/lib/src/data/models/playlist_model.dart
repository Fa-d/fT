import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/playlist.dart';
import 'media_item_model.dart';

part 'playlist_model.freezed.dart';
part 'playlist_model.g.dart';

@freezed
class PlaylistModel with _$PlaylistModel {
  const PlaylistModel._();

  const factory PlaylistModel({
    required String id,
    required String name,
    required String description,
    required List<MediaItemModel> items,
    String? thumbnailUrl,
    required String createdAt,
    required String updatedAt,
    required int totalDuration,
    @Default(true) bool isPublic,
  }) = _PlaylistModel;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);

  /// Convert to domain entity
  Playlist toEntity() {
    return Playlist(
      id: id,
      name: name,
      description: description,
      items: items.map((item) => item.toEntity()).toList(),
      thumbnailUrl: thumbnailUrl,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      totalDuration: totalDuration,
      isPublic: isPublic,
    );
  }

  /// Create from domain entity
  factory PlaylistModel.fromEntity(Playlist entity) {
    return PlaylistModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      items: entity.items.map((item) => MediaItemModel.fromEntity(item)).toList(),
      thumbnailUrl: entity.thumbnailUrl,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
      totalDuration: entity.totalDuration,
      isPublic: entity.isPublic,
    );
  }
}
