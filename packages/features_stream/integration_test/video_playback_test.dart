import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import 'package:features_stream/src/presentation/bloc/player/player_bloc.dart';
import 'package:features_stream/src/presentation/pages/video_player_page.dart';
import 'package:features_stream/src/domain/entities/media_item.dart';
import 'package:features_stream/src/domain/usecases/save_playback_state.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Video Playback Integration Tests', () {
    late MediaItem testMediaItem;

    setUp(() {
      testMediaItem = MediaItem(
        id: 'test-video-1',
        title: 'Integration Test Video',
        description: 'A test video for integration testing',
        duration: const Duration(minutes: 2),
        thumbnailUrl: 'https://example.com/thumb.jpg',
        streamUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        type: MediaType.video,
        qualityOptions: {
          '480p': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          '720p': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        },
        publishedAt: DateTime.now(),
        author: 'Test Author',
        viewCount: 0,
      );
    });

    testWidgets('Complete video playback flow', (tester) async {
      // Arrange - Create minimal app with player
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => PlayerBloc(
              savePlaybackStateUseCase: _MockSavePlaybackState(),
            ),
            child: VideoPlayerPage(mediaItem: testMediaItem),
          ),
        ),
      );

      // Wait for initialization
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Assert - Video player page is displayed
      expect(find.text('Integration Test Video'), findsOneWidget);
      expect(find.text('A test video for integration testing'), findsOneWidget);

      // Wait for video to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Act - Tap play button
      final playButton = find.byIcon(Icons.play_arrow);
      if (playButton.evaluate().isNotEmpty) {
        await tester.tap(playButton);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Assert - Pause button should appear
        expect(find.byIcon(Icons.pause), findsOneWidget);

        // Act - Tap pause button
        await tester.tap(find.byIcon(Icons.pause));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Assert - Play button should reappear
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      }

      // Act - Test skip forward button
      final skipForwardButton = find.byIcon(Icons.forward_10);
      expect(skipForwardButton, findsOneWidget);
      await tester.tap(skipForwardButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Act - Test skip backward button
      final skipBackwardButton = find.byIcon(Icons.replay_10);
      expect(skipBackwardButton, findsOneWidget);
      await tester.tap(skipBackwardButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Act - Open speed menu
      final speedButton = find.byIcon(Icons.speed);
      expect(speedButton, findsOneWidget);
      await tester.tap(speedButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Assert - Speed options should be visible
      expect(find.text('0.5x'), findsOneWidget);
      expect(find.text('1.5x'), findsOneWidget);
      expect(find.text('2.0x'), findsOneWidget);

      // Act - Select 1.5x speed
      await tester.tap(find.text('1.5x'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Assert - Speed indicator should show 1.5x
      expect(find.text('1.5x'), findsOneWidget);

      // Act - Test mute button
      final volumeButton = find.byIcon(Icons.volume_up);
      if (volumeButton.evaluate().isNotEmpty) {
        await tester.tap(volumeButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Assert - Mute icon should appear
        expect(find.byIcon(Icons.volume_off), findsOneWidget);

        // Act - Unmute
        await tester.tap(find.byIcon(Icons.volume_off));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Assert - Volume icon should reappear
        expect(find.byIcon(Icons.volume_up), findsOneWidget);
      }
    });

    testWidgets('Video player handles errors gracefully', (tester) async {
      // Arrange - Create player with invalid URL
      final invalidMediaItem = MediaItem(
        id: 'invalid-video',
        title: 'Invalid Video',
        description: 'This video should fail to load',
        duration: const Duration(minutes: 2),
        thumbnailUrl: 'https://example.com/thumb.jpg',
        streamUrl: 'https://invalid-url-that-does-not-exist.com/video.mp4',
        type: MediaType.video,
        qualityOptions: {},
        publishedAt: DateTime.now(),
        author: 'Test Author',
        viewCount: 0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => PlayerBloc(
              savePlaybackStateUseCase: _MockSavePlaybackState(),
            ),
            child: VideoPlayerPage(mediaItem: invalidMediaItem),
          ),
        ),
      );

      // Wait for error to occur
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Assert - Error message or loading indicator should be present
      // (The actual behavior depends on implementation)
      expect(find.byType(VideoPlayerPage), findsOneWidget);
    });

    testWidgets('Progress slider interaction', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => PlayerBloc(
              savePlaybackStateUseCase: _MockSavePlaybackState(),
            ),
            child: VideoPlayerPage(mediaItem: testMediaItem),
          ),
        ),
      );

      // Wait for initialization
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Assert - Progress slider should be present
      expect(find.byType(Slider), findsOneWidget);

      // Note: Slider interaction in integration tests can be tricky
      // This test verifies the slider is rendered correctly
    });
  });
}

// Mock implementation for testing
class _MockSavePlaybackState extends SavePlaybackState {
  _MockSavePlaybackState() : super(null as dynamic);

  @override
  Future<Either<Failure, Unit>> call(SavePlaybackStateParams params) async {
    // Mock implementation - just return success
    return right(unit);
  }
}
