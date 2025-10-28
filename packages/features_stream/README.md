# Features Stream Package

Video and audio streaming feature with offline support and advanced playback capabilities.

## Overview

This package implements a complete video/audio streaming solution following Clean Architecture principles with event sourcing integration.

## Features Implemented

### ✅ Domain Layer
- **Entities**:
  - `MediaItem` - Represents video/audio content with metadata
  - `PlaybackState` - Tracks playback progress and state
  - `DownloadTask` - Manages offline downloads
  - `Playlist` - Collections of media items

- **Repositories** (Interfaces):
  - `StreamRepository` - Defines contracts for streaming operations

- **Use Cases**:
  - `GetMediaItem` - Fetch single media item
  - `GetMediaItems` - Fetch media list with pagination
  - `StartDownload` - Initiate offline download
  - `GetDownloads` - Retrieve download tasks
  - `SavePlaybackState` - Persist playback position
  - `GetPlaybackHistory` - Fetch playback history

- **Domain Events** (Event Sourcing):
  - `VideoPlaybackStartedEvent`
  - `VideoPlaybackPausedEvent`
  - `VideoPlaybackCompletedEvent`
  - `VideoDownloadStartedEvent`
  - `VideoDownloadCompletedEvent`
  - `PlaybackSpeedChangedEvent`

### ✅ Data Layer
- **Models** (with Freezed & JSON serialization):
  - `MediaItemModel`
  - `PlaybackStateModel`
  - `DownloadTaskModel`
  - `PlaylistModel`

- **Data Sources**:
  - `StreamLocalDataSource` - Local storage with SharedPreferences
  - `StreamRemoteDataSource` - API integration (with mock data)

- **Repository Implementation**:
  - `StreamRepositoryImpl` - Offline-first implementation with network fallback

### ✅ Presentation Layer
- **BLoCs**:
  - `PlayerBloc` - Video player state management
  - `DownloadBloc` - Download management

- **Pages**:
  - `VideoPlayerPage` - Full-featured video player UI

- **Widgets**:
  - `PlayerControls` - Playback controls (play/pause/seek/speed/volume)

## Architecture Highlights

### Clean Architecture
```
domain/
  ├── entities/          # Business objects
  ├── repositories/      # Repository interfaces
  ├── usecases/          # Business logic
  └── events/            # Domain events

data/
  ├── models/            # Data transfer objects
  ├── datasources/       # Data sources (local/remote)
  └── repositories/      # Repository implementations

presentation/
  ├── bloc/              # State management
  ├── pages/             # UI pages
  └── widgets/           # Reusable UI components
```

### Event Sourcing Integration
All playback actions are captured as immutable events:
- Enables complete playback history tracking
- Allows analytics and insights
- Facilitates debugging and auditing

### Offline-First Approach
- Downloads stored locally with metadata
- Playback state persisted for resume functionality
- Network-aware data fetching with graceful degradation

## Dependencies

```yaml
dependencies:
  # Core
  core: (local package)
  design_system: (local package)

  # State Management
  flutter_bloc: ^8.1.6
  hydrated_bloc: ^9.1.5

  # Video/Audio
  video_player: ^2.8.2
  chewie: ^1.7.5
  audioplayers: ^6.0.0

  # Download & Cache
  flutter_downloader: ^1.11.6
  path_provider: ^2.1.2
  shared_preferences: ^2.2.2

  # Utilities
  dartz: ^0.10.1
  equatable: ^2.0.5
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
```

## Usage Example

```dart
// Initialize PlayerBloc
final playerBloc = PlayerBloc(
  savePlaybackStateUseCase: getIt<SavePlaybackState>(),
);

// Navigate to video player
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => BlocProvider.value(
      value: playerBloc,
      child: VideoPlayerPage(mediaItem: mediaItem),
    ),
  ),
);
```

## Player Features

- ✅ Play/Pause/Seek controls
- ✅ Variable playback speed (0.5x - 2.0x)
- ✅ Volume control and mute
- ✅ Progress bar with time display
- ✅ Skip forward/backward 10 seconds
- ✅ Loading and buffering states
- ✅ Error handling with retry
- ✅ Playback state persistence

## Download Features

- ✅ Start/pause/resume downloads
- ✅ Download progress tracking
- ✅ Quality selection
- ✅ Local storage management
- ✅ Download history

## Future Enhancements

### Planned Features
- Picture-in-Picture (PiP) mode
- Background audio playback
- HLS/DASH adaptive streaming
- Quality switching during playback
- Playlist management
- Casting support (Chromecast)
- Subtitle support
- Live streaming

### TODOs
- Integrate flutter_downloader for actual downloads
- Implement quality switching logic
- Add native platform code for PiP
- Implement background playback service
- Add comprehensive unit tests
- Add widget tests
- Add integration tests

## Code Generation

After making changes to Freezed models, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Testing

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## Notes

### Known Issues
1. BLoC event handlers need to be refactored to use pattern matching (follow dashboard BLoC pattern)
2. Download integration with flutter_downloader is stubbed
3. Quality switching requires video controller re-initialization

### Implementation Status
- ✅ Domain layer - 100% complete
- ✅ Data layer - 100% complete (with mock remote data)
- ⚠️ Presentation layer - 90% complete (needs BLoC refactoring)
- ⚠️ Testing - 0% (not implemented)

## Integration with Main App

To use this package in the main app:

1. Add dependency injection setup
2. Register use cases and repositories
3. Provide BLoCs at appropriate levels
4. Navigate to VideoPlayerPage with MediaItem

Example DI setup:
```dart
// Register use cases
getIt.registerLazySingleton(() => GetMediaItem(getIt()));
getIt.registerLazySingleton(() => StartDownload(getIt()));
getIt.registerLazySingleton(() => SavePlaybackState(getIt()));

// Register repository
getIt.registerLazySingleton<StreamRepository>(
  () => StreamRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
    networkInfo: getIt(),
  ),
);

// Register data sources
getIt.registerLazySingleton<StreamRemoteDataSource>(
  () => StreamRemoteDataSourceImpl(apiClient: getIt()),
);

getIt.registerLazySingleton<StreamLocalDataSource>(
  () => StreamLocalDataSourceImpl(sharedPreferences: getIt()),
);
```

## License

Part of the Advanced Flutter Platform project.
