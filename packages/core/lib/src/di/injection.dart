import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';
import '../storage/secure_storage.dart';
import '../storage/cache_manager.dart';
import '../event_sourcing/event_store.dart';
import '../event_sourcing/event_bus.dart';
import '../sync/sync_manager.dart';
import '../sync/conflict_resolver.dart';

/// Service locator
final getIt = GetIt.instance;

/// Initialize core dependencies
Future<void> initializeCore() async {
  // Network
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt()),
  );

  // HTTP Client
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(
    () => ApiClient(
      dio: getIt(),
      baseUrl: 'https://api.example.com',
      enableCertificatePinning: false,
    ),
  );

  // Storage
  getIt.registerLazySingleton(() => SecureStorage());

  final cacheManager = CacheManager();
  await cacheManager.initialize();
  getIt.registerSingleton(cacheManager);

  // Event Sourcing
  final eventStore = EventStore();
  await eventStore.initialize();
  getIt.registerSingleton(eventStore);

  getIt.registerSingleton(EventBus());

  // Sync
  getIt.registerLazySingleton(() => ConflictResolver());
  final syncManager = SyncManager(
    networkInfo: getIt(),
    conflictResolver: getIt(),
  );
  await syncManager.initialize();
  getIt.registerSingleton(syncManager);
}
