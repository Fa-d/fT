library features_stream;

// Domain - Entities
export 'src/domain/entities/media_item.dart';
export 'src/domain/entities/playback_state.dart';
export 'src/domain/entities/download_task.dart';
export 'src/domain/entities/playlist.dart';

// Domain - Repositories
export 'src/domain/repositories/stream_repository.dart';

// Domain - Use Cases
export 'src/domain/usecases/get_media_item.dart';
export 'src/domain/usecases/get_media_items.dart';
export 'src/domain/usecases/start_download.dart';
export 'src/domain/usecases/get_downloads.dart';
export 'src/domain/usecases/save_playback_state.dart';
export 'src/domain/usecases/get_playback_history.dart';

// Domain - Events
export 'src/domain/events/playback_events.dart';

// Data - Models
export 'src/data/models/media_item_model.dart';
export 'src/data/models/download_task_model.dart';
export 'src/data/models/playback_state_model.dart';
export 'src/data/models/playlist_model.dart';

// Data - Data Sources
export 'src/data/datasources/stream_local_data_source.dart';
export 'src/data/datasources/stream_remote_data_source.dart';

// Data - Repositories
export 'src/data/repositories/stream_repository_impl.dart';

// Data - Services
export 'src/data/services/download_manager.dart';

// Presentation - BLoC
export 'src/presentation/bloc/player/player_bloc.dart';
export 'src/presentation/bloc/player/player_event.dart';
export 'src/presentation/bloc/player/player_state.dart';
export 'src/presentation/bloc/download/download_bloc.dart';
export 'src/presentation/bloc/download/download_event.dart';
export 'src/presentation/bloc/download/download_state.dart';

// Presentation - Pages
export 'src/presentation/pages/video_player_page.dart';

// Presentation - Widgets
export 'src/presentation/widgets/player_controls.dart';
