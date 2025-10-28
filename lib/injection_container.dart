import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Core
import 'package:core/core.dart' as core;
import 'core/network/api_client.dart';

// Stream Feature
import 'package:features_stream/features_stream.dart';

/// Service Locator instance
/// sl = Service Locator
final sl = GetIt.instance;

/// Initialize all dependencies
/// This function should be called in main() before runApp()
Future<void> init() async {
  // ========================================
  // Features - Stream
  // ========================================

  // BLoCs
  sl.registerFactory(
    () => PlayerBloc(savePlaybackStateUseCase: sl()),
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

  sl.registerLazySingleton<StreamLocalDataSource>(
    () => StreamLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Services
  sl.registerLazySingleton(() => DownloadManager());

  // ========================================
  // Core
  // ========================================

  // API Client
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl()),
  );

  // Network Info
  sl.registerLazySingleton<core.NetworkInfo>(
    () => core.NetworkInfoImpl(sl()),
  );

  // ========================================
  // External Dependencies
  // ========================================

  // Dio
  sl.registerLazySingleton(() => Dio());

  // Connectivity
  sl.registerLazySingleton(() => Connectivity());

  // SharedPreferences (async initialization)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
