import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:features_stream/src/presentation/pages/video_player_page.dart';
import 'package:features_stream/src/presentation/bloc/player/player_bloc.dart';
import 'package:features_stream/src/presentation/bloc/player/player_event.dart';
import 'package:features_stream/src/presentation/bloc/player/player_state.dart';
import 'package:features_stream/src/domain/entities/media_item.dart';
import 'package:features_stream/src/domain/entities/playback_state.dart';

// Mock classes
class MockPlayerBloc extends Mock implements PlayerBloc {}

// Fake classes for fallback values
class FakePlayerEvent extends Fake implements PlayerEvent {}

class FakeMediaItem extends Fake implements MediaItem {}

void main() {
  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakePlayerEvent());
    registerFallbackValue(FakeMediaItem());
  });

  group('VideoPlayerPage Widget Tests', () {
    late MockPlayerBloc mockPlayerBloc;
    late MediaItem testMediaItem;

    setUp(() {
      mockPlayerBloc = MockPlayerBloc();
      testMediaItem = MediaItem(
        id: '1',
        title: 'Test Video',
        description: 'Test Description',
        duration: const Duration(minutes: 5),
        thumbnailUrl: 'https://example.com/thumb.jpg',
        streamUrl: 'https://example.com/video.mp4',
        type: MediaType.video,
        qualityOptions: {
          '720p': 'https://example.com/video-720p.mp4',
          '1080p': 'https://example.com/video-1080p.mp4',
        },
        publishedAt: DateTime.now(),
        author: 'Test Author',
        viewCount: 1000,
      );

      // Setup default when/thenAnswer for stream
      when(() => mockPlayerBloc.stream).thenAnswer(
        (_) => const Stream.empty(),
      );

      // Setup default videoController
      when(() => mockPlayerBloc.videoController).thenReturn(null);
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: BlocProvider<PlayerBloc>.value(
          value: mockPlayerBloc,
          child: VideoPlayerPage(mediaItem: testMediaItem),
        ),
      );
    }

    testWidgets('displays loading state initially', (tester) async {
      // Arrange
      when(() => mockPlayerBloc.state).thenReturn(const PlayerState.initial());

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays video player when ready', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      when(() => mockPlayerBloc.state).thenReturn(
        PlayerState.ready(
          mediaItem: testMediaItem,
          playbackState: playbackState,
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      // Video player widget should be present
      expect(find.byType(AspectRatio), findsOneWidget);
    });

    testWidgets('displays error state with retry button', (tester) async {
      // Arrange
      const errorMessage = 'Failed to load video';
      when(() => mockPlayerBloc.state).thenReturn(
        const PlayerState.error(errorMessage),
      );
      when(() => mockPlayerBloc.add(any())).thenReturn(null);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Verify retry button triggers event
      await tester.tap(find.text('Retry'));
      await tester.pump();

      verify(() => mockPlayerBloc.add(PlayerEvent.initialize(testMediaItem)))
          .called(greaterThanOrEqualTo(1));
    });

    testWidgets('displays media title and description', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      when(() => mockPlayerBloc.state).thenReturn(
        PlayerState.playing(
          mediaItem: testMediaItem,
          playbackState: playbackState,
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.text('Test Video'), findsWidgets); // Appears in AppBar and info section
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('Test Author'), findsOneWidget);
      expect(find.text('1000 views'), findsOneWidget);
    });

    testWidgets('initializes player on mount', (tester) async {
      // Arrange
      when(() => mockPlayerBloc.state).thenReturn(const PlayerState.initial());
      when(() => mockPlayerBloc.add(any())).thenReturn(null);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Verify initialize event was added
      verify(() => mockPlayerBloc.add(PlayerEvent.initialize(testMediaItem)))
          .called(1);
    });

    testWidgets('displays loading indicator when buffering', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: const Duration(seconds: 10),
        duration: const Duration(minutes: 5),
        isPlaying: true,
        isBuffering: true,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      when(() => mockPlayerBloc.state).thenReturn(
        PlayerState.buffering(
          mediaItem: testMediaItem,
          playbackState: playbackState,
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('back button pops navigation', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      when(() => mockPlayerBloc.state).thenReturn(
        PlayerState.playing(
          mediaItem: testMediaItem,
          playbackState: playbackState,
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert - AppBar should have back button
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('play button triggers play event when paused', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      when(() => mockPlayerBloc.state).thenReturn(
        PlayerState.paused(
          mediaItem: testMediaItem,
          playbackState: playbackState,
        ),
      );
      when(() => mockPlayerBloc.add(any())).thenReturn(null);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap play button
      final playButton = find.byIcon(Icons.play_arrow);
      expect(playButton, findsOneWidget);

      await tester.tap(playButton);
      await tester.pump();

      // Assert
      verify(() => mockPlayerBloc.add(const PlayerEvent.play())).called(1);
    });

    testWidgets('pause button triggers pause event when playing', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: const Duration(seconds: 30),
        duration: const Duration(minutes: 5),
        isPlaying: true,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      when(() => mockPlayerBloc.state).thenReturn(
        PlayerState.playing(
          mediaItem: testMediaItem,
          playbackState: playbackState,
        ),
      );
      when(() => mockPlayerBloc.add(any())).thenReturn(null);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap pause button
      final pauseButton = find.byIcon(Icons.pause);
      expect(pauseButton, findsOneWidget);

      await tester.tap(pauseButton);
      await tester.pump();

      // Assert
      verify(() => mockPlayerBloc.add(const PlayerEvent.pause())).called(1);
    });
  });
}
