import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:core/core.dart' as core;

// Stream Feature
import 'package:features_stream/features_stream.dart';

// Dashboard Feature
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/domain/usecases/get_system_stats.dart';
import 'features/dashboard/domain/repositories/dashboard_repository.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';

/// Service Locator instance
/// sl = Service Locator
final sl = GetIt.instance;

/// Initialize all dependencies
/// This function should be called in main() before runApp()
Future<void> init() async {
  // ========================================
  // Features - Dashboard
  // ========================================

  // BLoC
  sl.registerFactory(
    () => DashboardBloc(
      getSystemStats: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetSystemStats(sl()));

  // Repositories
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      eventStore: core.getIt.get<core.EventStore>(),
      syncManager: core.getIt.get<core.SyncManager>(),
    ),
  );

  // ========================================
  // Features - Stream
  // ========================================

  // BLoCs
  sl.registerFactory(
    () => PlayerBloc(
      savePlaybackStateUseCase: sl(),
      videoPlayerService: VideoPlayerServiceImpl(),
    ),
  );

  sl.registerFactory(
    () => DownloadBloc(
      getDownloadsUseCase: sl(),
      startDownloadUseCase: sl(),
      downloadManager: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetMediaItem(sl()));
  sl.registerLazySingleton(() => GetMediaItems(sl()));
  sl.registerLazySingleton(() => StartDownload(sl()));
  sl.registerLazySingleton(() => GetDownloads(sl()));
  sl.registerLazySingleton(() => SavePlaybackState(sl()));
  sl.registerLazySingleton(() => GetPlaybackHistory(sl()));

  // Repository
  sl.registerLazySingleton<StreamRepository>(
    () => StreamRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<StreamRemoteDataSource>(
    () => StreamRemoteDataSourceImpl(apiClient: sl()),
  );

  // Use Hive-based data source for better performance
  // Note: HiveInitializer.initialize() must be called in main.dart before di.init()
  sl.registerLazySingleton<StreamLocalDataSource>(() {
    final dataSource = StreamLocalDataSourceHive();
    // Hive boxes are already initialized by HiveInitializer in main.dart
    // The data source will use existing opened boxes
    dataSource.init(); // This will be synchronous since boxes are already open
    return dataSource;
  });

  // For backward compatibility with SharedPreferences
  // Uncomment this if you want to use SharedPreferences instead of Hive
  // sl.registerLazySingleton<StreamLocalDataSource>(
  //   () => StreamLocalDataSourceImpl(sharedPreferences: sl()),
  // );

  // Services
  sl.registerLazySingleton(() => DownloadManager());

  // Video Player Service
  sl.registerFactory<VideoPlayerService>(() => VideoPlayerServiceImpl());

  // ========================================
  // External Dependencies
  // ========================================
  // Note: Dio, Connectivity, NetworkInfo, and ApiClient are already
  // registered by core.initializeCore() in main.dart

  // SharedPreferences (async initialization)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
