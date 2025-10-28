import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:features_stream/src/presentation/widgets/player_controls.dart';
import 'package:features_stream/src/domain/entities/playback_state.dart';

void main() {
  group('PlayerControls Widget Tests', () {
    Widget createTestWidget({
      required PlaybackState playbackState,
      required VoidCallback onPlayPause,
      required Function(Duration) onSeek,
      required Function(double) onSpeedChanged,
      required Function(String) onQualityChanged,
      required Function(double) onVolumeChanged,
      required VoidCallback onMuteToggle,
      Map<String, String>? qualityOptions,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: PlayerControls(
            playbackState: playbackState,
            onPlayPause: onPlayPause,
            onSeek: onSeek,
            onSpeedChanged: onSpeedChanged,
            onQualityChanged: onQualityChanged,
            onVolumeChanged: onVolumeChanged,
            onMuteToggle: onMuteToggle,
            qualityOptions: qualityOptions ?? {},
          ),
        ),
      );
    }

    testWidgets('displays play button when paused', (tester) async {
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

      bool playPausePressed = false;

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () => playPausePressed = true,
          onSeek: (_) {},
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);

      // Tap play button
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pump();

      expect(playPausePressed, isTrue);
    });

    testWidgets('displays pause button when playing', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: true,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      bool playPausePressed = false;

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () => playPausePressed = true,
          onSeek: (_) {},
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsNothing);

      // Tap pause button
      await tester.tap(find.byIcon(Icons.pause));
      await tester.pump();

      expect(playPausePressed, isTrue);
    });

    testWidgets('skip forward button works correctly', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: const Duration(seconds: 10),
        duration: const Duration(minutes: 5),
        isPlaying: true,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      Duration? seekedPosition;

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (position) => seekedPosition = position,
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert - Find skip forward button
      final skipForwardButton = find.byIcon(Icons.forward_10);
      expect(skipForwardButton, findsOneWidget);

      // Tap skip forward button
      await tester.tap(skipForwardButton);
      await tester.pump();

      expect(seekedPosition, isNotNull);
      expect(seekedPosition, const Duration(seconds: 20));
    });

    testWidgets('skip backward button works correctly', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: const Duration(seconds: 20),
        duration: const Duration(minutes: 5),
        isPlaying: true,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      Duration? seekedPosition;

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (position) => seekedPosition = position,
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert - Find skip backward button
      final skipBackwardButton = find.byIcon(Icons.replay_10);
      expect(skipBackwardButton, findsOneWidget);

      // Tap skip backward button
      await tester.tap(skipBackwardButton);
      await tester.pump();

      expect(seekedPosition, isNotNull);
      expect(seekedPosition, const Duration(seconds: 10));
    });

    testWidgets('displays current playback speed', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.5,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (_) {},
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert - Check for speed display
      expect(find.text('1.5x'), findsOneWidget);
    });

    testWidgets('displays mute icon when muted', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 0.0,
        playbackSpeed: 1.0,
        isMuted: true,
        lastUpdated: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (_) {},
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert
      expect(find.byIcon(Icons.volume_off), findsOneWidget);
    });

    testWidgets('displays volume icon when not muted', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 0.8,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (_) {},
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert
      expect(find.byIcon(Icons.volume_up), findsOneWidget);
    });

    testWidgets('mute toggle button triggers callback', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: Duration.zero,
        duration: const Duration(minutes: 5),
        isPlaying: false,
        isBuffering: false,
        volume: 0.8,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      bool muteToggled = false;

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (_) {},
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () => muteToggled = true,
        ),
      );

      // Assert
      final muteButton = find.byIcon(Icons.volume_up);
      expect(muteButton, findsOneWidget);

      // Tap mute button
      await tester.tap(muteButton);
      await tester.pump();

      expect(muteToggled, isTrue);
    });

    testWidgets('progress slider exists and shows position', (tester) async {
      // Arrange
      final playbackState = PlaybackState(
        mediaItemId: 'test-1',
        position: const Duration(seconds: 30),
        duration: const Duration(minutes: 2),
        isPlaying: true,
        isBuffering: false,
        volume: 1.0,
        playbackSpeed: 1.0,
        isMuted: false,
        lastUpdated: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (_) {},
          onSpeedChanged: (_) {},
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert - Slider should exist
      expect(find.byType(Slider), findsOneWidget);

      // Check time display
      expect(find.text('00:30'), findsOneWidget);
      expect(find.text('02:00'), findsOneWidget);
    });

    testWidgets('speed menu exists with speed options', (tester) async {
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

      double? selectedSpeed;

      // Act
      await tester.pumpWidget(
        createTestWidget(
          playbackState: playbackState,
          onPlayPause: () {},
          onSeek: (_) {},
          onSpeedChanged: (speed) => selectedSpeed = speed,
          onQualityChanged: (_) {},
          onVolumeChanged: (_) {},
          onMuteToggle: () {},
        ),
      );

      // Assert - Speed button should exist
      final speedButton = find.byIcon(Icons.speed);
      expect(speedButton, findsOneWidget);

      // Tap speed button to open menu
      await tester.tap(speedButton);
      await tester.pumpAndSettle();

      // Check speed options are available
      expect(find.text('0.5x'), findsOneWidget);
      expect(find.text('1.0x'), findsWidgets); // Multiple instances (menu + indicator)
      expect(find.text('1.5x'), findsOneWidget);
      expect(find.text('2.0x'), findsOneWidget);

      // Select 1.5x speed
      await tester.tap(find.text('1.5x'));
      await tester.pumpAndSettle();

      expect(selectedSpeed, 1.5);
    });
  });
}
