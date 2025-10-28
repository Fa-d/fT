import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:design_system/design_system.dart';
import '../../domain/entities/media_item.dart';
import '../bloc/player/player_bloc.dart';
import '../bloc/player/player_event.dart';
import '../bloc/player/player_state.dart';
import '../widgets/player_controls.dart';

/// Video player page
/// Demonstrates video playback with full controls
class VideoPlayerPage extends StatefulWidget {
  final MediaItem mediaItem;

  const VideoPlayerPage({
    super.key,
    required this.mediaItem,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late PlayerBloc _playerBloc;
  bool _isInitialized = false;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _playerBloc = context.read<PlayerBloc>();
      _playerBloc.add(PlayerEvent.initialize(widget.mediaItem));
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _playerBloc.add(const PlayerEvent.dispose());
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });

    if (_showControls) {
      _startHideControlsTimer();
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _onControlInteraction() {
    _startHideControlsTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mediaItem.title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: LoadingIndicator(),
            ),
            loading: (mediaItem) => const Center(
              child: LoadingIndicator(),
            ),
            ready: (mediaItem, playbackState) =>
                _buildPlayer(context, playbackState),
            playing: (mediaItem, playbackState) =>
                _buildPlayer(context, playbackState),
            paused: (mediaItem, playbackState) =>
                _buildPlayer(context, playbackState),
            buffering: (mediaItem, playbackState) =>
                _buildPlayer(context, playbackState, showBuffering: true),
            completed: (mediaItem, playbackState) =>
                _buildPlayer(context, playbackState),
            error: (message) => ErrorView(
              message: message,
              onRetry: () {
                context
                    .read<PlayerBloc>()
                    .add(PlayerEvent.initialize(widget.mediaItem));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayer(
    BuildContext context,
    playbackState, {
    bool showBuffering = false,
  }) {
    final bloc = context.read<PlayerBloc>();

    return Column(
      children: [
        // Video player
        Expanded(
          child: GestureDetector(
            onTap: _toggleControls,
            child: Container(
              color: Colors.black,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      if (bloc.videoPlayerService.nativeController != null &&
                          bloc.videoPlayerService.isInitialized)
                        VideoPlayer(bloc.videoPlayerService.nativeController),
                      if (showBuffering)
                        const Center(
                          child: LoadingIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Player controls (with animation)
        AnimatedOpacity(
          opacity: _showControls ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: _showControls
              ? PlayerControls(
                  playbackState: playbackState,
                  qualityOptions: widget.mediaItem.qualityOptions,
                  onPlayPause: () {
                    _onControlInteraction();
                    if (playbackState.isPlaying) {
                      context.read<PlayerBloc>().add(const PlayerEvent.pause());
                    } else {
                      context.read<PlayerBloc>().add(const PlayerEvent.play());
                    }
                  },
                  onSeek: (position) {
                    _onControlInteraction();
                    context.read<PlayerBloc>().add(PlayerEvent.seekTo(position));
                  },
                  onSpeedChanged: (speed) {
                    _onControlInteraction();
                    context.read<PlayerBloc>().add(PlayerEvent.setSpeed(speed));
                  },
                  onQualityChanged: (quality) {
                    _onControlInteraction();
                    context.read<PlayerBloc>().add(PlayerEvent.setQuality(quality));
                  },
                  onVolumeChanged: (volume) {
                    _onControlInteraction();
                    context.read<PlayerBloc>().add(PlayerEvent.setVolume(volume));
                  },
                  onMuteToggle: () {
                    _onControlInteraction();
                    context.read<PlayerBloc>().add(const PlayerEvent.toggleMute());
                  },
                )
              : const SizedBox.shrink(),
        ),

        // Media info
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.mediaItem.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.mediaItem.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (widget.mediaItem.author != null) ...[
                    Text(
                      widget.mediaItem.author!,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Text(
                    '${widget.mediaItem.viewCount} views',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
