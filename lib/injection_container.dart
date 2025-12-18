import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core imports
import 'core/bloc/connectivity_bloc.dart';
import 'core/database/database_service.dart';
import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'core/utils/constants.dart';

// Feature: Counter
import 'features/counter/data/datasources/counter_local_datasource.dart';
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/repositories/counter_repository.dart';
import 'features/counter/domain/usecases/decrement_counter.dart';
import 'features/counter/domain/usecases/get_counter.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/domain/usecases/reset_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';

// Feature: User
import 'features/user/data/datasources/user_local_datasource.dart';
import 'features/user/data/datasources/user_remote_datasource.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_users.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

/// Service Locator instance (CT/mobile-app pattern)
/// sl = Service Locator
/// Provides access to all dependencies throughout the app
final GetIt sl = GetIt.instance;

/// Initialize all dependencies (CT/mobile-app pattern)
/// This function should be called in main() before runApp()
/// Safe to call multiple times - will skip if already initialized
///
/// Dependencies are registered in order of dependency:
/// 1. External dependencies (SharedPreferences, Isar, etc.)
/// 2. Core services (Network, Database, etc.)
/// 3. Feature-specific dependencies (repositories, use cases, BLoCs)
Future<void> init() async {
  // Check if already initialized to prevent duplicate registrations
  // This is important for hot restart and testing
  if (sl.isRegistered<SharedPreferences>()) {
    debugPrint('Service Locator already initialized');
    return;
  }

  debugPrint('Initializing Service Locator...');

  // ============================================
  // EXTERNAL DEPENDENCIES (Layer 0)
  // Must be initialized first as they don't depend on anything
  // ============================================

  // SharedPreferences for simple key-value storage
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  debugPrint('✓ SharedPreferences initialized');

  // Isar database for complex object storage
  final isar = await DatabaseService.initialize();
  sl.registerLazySingleton<Isar>(() => isar);
  debugPrint('✓ Isar database initialized');

  // Connectivity for network status monitoring
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  debugPrint('✓ Connectivity initialized');

  // Dio HTTP client with interceptors
  final dio = Dio();
  sl.registerLazySingleton<Dio>(() => dio);
  debugPrint('✓ Dio initialized');

  // ============================================
  // CORE SERVICES (Layer 1)
  // Core app services that feature modules depend on
  // ============================================

  // Network information service
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
  debugPrint('✓ NetworkInfo initialized');

  // API client with error handling and logging
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl()),
  );
  debugPrint('✓ ApiClient initialized');

  // Global connectivity BLoC for app-wide network status
  sl.registerLazySingleton<ConnectivityBloc>(
    () => ConnectivityBloc(networkInfo: sl()),
  );
  debugPrint('✓ ConnectivityBloc initialized');

  // ============================================
  // FEATURE: COUNTER (Layer 2)
  // Simple counter feature with local storage
  // ============================================

  _initCounterFeature();

  // ============================================
  // FEATURE: USER (Layer 2)
  // User management with remote API and local cache
  // ============================================

  _initUserFeature();

  // ============================================
  // GLOBAL STATE MANAGEMENT (CT/mobile-app pattern)
  // Initialize ValueNotifier instances for global state
  // ============================================

  _initGlobalState();

  debugPrint('Service Locator initialization complete!');
}

/// Initialize Counter feature dependencies
void _initCounterFeature() {
  debugPrint('  Initializing Counter feature...');

  // Data layer
  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(localDataSource: sl()),
  );

  // Domain layer - Use Cases
  sl.registerLazySingleton<GetCounter>(
    () => GetCounter(sl()),
  );
  sl.registerLazySingleton<IncrementCounter>(
    () => IncrementCounter(sl()),
  );
  sl.registerLazySingleton<DecrementCounter>(
    () => DecrementCounter(sl()),
  );
  sl.registerLazySingleton<ResetCounter>(
    () => ResetCounter(sl()),
  );

  // Presentation layer - BLoC (Factory for new instances)
  sl.registerFactory<CounterBloc>(
    () => CounterBloc(
      getCounter: sl(),
      incrementCounter: sl(),
      decrementCounter: sl(),
      resetCounter: sl(),
    ),
  );

  debugPrint('  ✓ Counter feature initialized');
}

/// Initialize User feature dependencies
void _initUserFeature() {
  debugPrint('  Initializing User feature...');

  // Data layer - Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(isar: sl()),
  );

  // Data layer - Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Domain layer - Use Cases
  sl.registerLazySingleton<GetUsers>(
    () => GetUsers(sl()),
  );

  // Presentation layer - BLoC (Factory for new instances)
  sl.registerFactory<UserBloc>(
    () => UserBloc(getUsers: sl()),
  );

  debugPrint('  ✓ User feature initialized');
}

/// Initialize global state management (CT/mobile-app pattern)
/// Sets up ValueNotifier instances that can be accessed globally
void _initGlobalState() {
  debugPrint('  Initializing global state management...');

  // Note: Global ValueNotifier instances are already created in constants.dart
  // and used directly via MultiProvider in main.dart
  // No need to register them in the service locator

  debugPrint('  ✓ Global state management initialized');
}

/// Reset the service locator (useful for testing)
void resetServiceLocator() {
  debugPrint('Resetting Service Locator...');
  sl.reset();
  debugPrint('✓ Service Locator reset complete');
}

/// Check if service locator is initialized
bool get isServiceLocatorInitialized => sl.isRegistered<SharedPreferences>();
