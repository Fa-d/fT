import 'package:core/core.dart';
import '../models/media_item_model.dart';
import '../models/playlist_model.dart';
import '../../domain/entities/media_item.dart';

/// Remote data source for stream feature
/// Handles API calls for media items, playlists, etc.
abstract class StreamRemoteDataSource {
  /// Get a single media item by ID from the API
  Future<MediaItemModel> getMediaItem(String id);

  /// Get a list of media items with pagination
  Future<List<MediaItemModel>> getMediaItems({
    int page = 1,
    int limit = 20,
    MediaType? type,
  });

  /// Search for media items
  Future<List<MediaItemModel>> searchMediaItems(String query);

  /// Get a playlist by ID
  Future<PlaylistModel> getPlaylist(String id);

  /// Get user playlists
  Future<List<PlaylistModel>> getUserPlaylists();

  /// Create a new playlist
  Future<PlaylistModel> createPlaylist({
    required String name,
    required String description,
  });

  /// Add media item to playlist
  Future<void> addToPlaylist({
    required String playlistId,
    required String mediaItemId,
  });
}

/// Implementation of StreamRemoteDataSource
class StreamRemoteDataSourceImpl implements StreamRemoteDataSource {
  final ApiClient apiClient;

  StreamRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<MediaItemModel> getMediaItem(String id) async {
    // TODO: Replace with actual API endpoint
    // For now, return mock data
    return _getMockMediaItem(id);
  }

  @override
  Future<List<MediaItemModel>> getMediaItems({
    int page = 1,
    int limit = 20,
    MediaType? type,
  }) async {
    // TODO: Replace with actual API endpoint
    // For now, return mock data
    return _getMockMediaItems(limit: limit);
  }

  @override
  Future<List<MediaItemModel>> searchMediaItems(String query) async {
    // TODO: Replace with actual API endpoint
    // For now, return mock data
    return _getMockMediaItems();
  }

  @override
  Future<PlaylistModel> getPlaylist(String id) async {
    // TODO: Replace with actual API endpoint
    return _getMockPlaylist(id);
  }

  @override
  Future<List<PlaylistModel>> getUserPlaylists() async {
    // TODO: Replace with actual API endpoint
    return [_getMockPlaylist('1')];
  }

  @override
  Future<PlaylistModel> createPlaylist({
    required String name,
    required String description,
  }) async {
    // TODO: Replace with actual API endpoint
    return PlaylistModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      items: [],
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      totalDuration: 0,
    );
  }

  @override
  Future<void> addToPlaylist({
    required String playlistId,
    required String mediaItemId,
  }) async {
    // TODO: Replace with actual API endpoint
  }

  // Mock data generators for demonstration
  MediaItemModel _getMockMediaItem(String id) {
    return MediaItemModel(
      id: id,
      title: 'Sample Video $id',
      description: 'This is a sample video for demonstration purposes',
      thumbnailUrl: 'https://picsum.photos/seed/$id/400/300',
      durationInSeconds: 600,
      streamUrl: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
      type: 'video',
      qualityOptions: {
        '1080p': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
        '720p': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
        '480p': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
      },
      publishedAt: DateTime.now().subtract(Duration(days: 7)).toIso8601String(),
      author: 'Content Creator',
      viewCount: 1000,
    );
  }

  List<MediaItemModel> _getMockMediaItems({int limit = 10}) {
    return List.generate(
      limit,
      (index) => _getMockMediaItem(index.toString()),
    );
  }

  PlaylistModel _getMockPlaylist(String id) {
    return PlaylistModel(
      id: id,
      name: 'Sample Playlist',
      description: 'A collection of sample videos',
      items: _getMockMediaItems(limit: 5),
      thumbnailUrl: 'https://picsum.photos/seed/playlist$id/400/300',
      createdAt: DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      totalDuration: 3000,
    );
  }
}
