import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:features_stream/features_stream.dart';
import 'package:design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';

/// Media list page
/// Demonstrates integration with features_stream package
class MediaListPage extends StatelessWidget {
  const MediaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Library'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: BlocProvider(
        create: (_) => _MediaListBloc()..add(const _LoadMediaItems()),
        child: const _MediaListView(),
      ),
    );
  }
}

class _MediaListView extends StatelessWidget {
  const _MediaListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_MediaListBloc, _MediaListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: LoadingIndicator());
        }

        if (state.error != null) {
          return ErrorView(
            message: state.error!,
            onRetry: () {
              context.read<_MediaListBloc>().add(const _LoadMediaItems());
            },
          );
        }

        if (state.items.isEmpty) {
          return const EmptyState(
            message: 'No media items available',
            icon: Icons.video_library,
          );
        }

        return ListView.builder(
          itemCount: state.items.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final item = state.items[index];
            return _MediaItemCard(item: item);
          },
        );
      },
    );
  }
}

class _MediaItemCard extends StatelessWidget {
  final MediaItem item;

  const _MediaItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ContentCard(
        padding: EdgeInsets.zero,
        child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => sl<PlayerBloc>(),
                child: VideoPlayerPage(mediaItem: item),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedImage(
                    imageUrl: item.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _formatDuration(item.duration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (item.author != null) ...[
                    Text(
                      item.author!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Row(
                    children: [
                      Text(
                        '${item.viewCount} views',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(item.publishedAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else {
      return 'Just now';
    }
  }
}

// Simple BLoC for media list
class _MediaListBloc extends Bloc<_MediaListEvent, _MediaListState> {
  final GetMediaItems _getMediaItems = sl<GetMediaItems>();

  _MediaListBloc() : super(const _MediaListState()) {
    on<_LoadMediaItems>(_onLoadMediaItems);
  }

  Future<void> _onLoadMediaItems(
    _LoadMediaItems event,
    Emitter<_MediaListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _getMediaItems(const GetMediaItemsParams());

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (items) => emit(state.copyWith(
        isLoading: false,
        items: items,
      )),
    );
  }
}

// Events
abstract class _MediaListEvent {
  const _MediaListEvent();
}

class _LoadMediaItems extends _MediaListEvent {
  const _LoadMediaItems();
}

// State
class _MediaListState {
  final bool isLoading;
  final List<MediaItem> items;
  final String? error;

  const _MediaListState({
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  _MediaListState copyWith({
    bool? isLoading,
    List<MediaItem>? items,
    String? error,
  }) {
    return _MediaListState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
    );
  }
}
