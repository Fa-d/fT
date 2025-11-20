import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'core/bloc/connectivity_bloc.dart';
import 'core/database/database_service.dart';
import 'core/network/api_client.dart';
import 'core/network/network_info.dart';

// Counter Feature
import 'features/counter/data/datasources/counter_local_datasource.dart';
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/repositories/counter_repository.dart';
import 'features/counter/domain/usecases/decrement_counter.dart';
import 'features/counter/domain/usecases/get_counter.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/domain/usecases/reset_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';

// User Feature
import 'features/user/data/datasources/user_local_datasource.dart';
import 'features/user/data/datasources/user_remote_datasource.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_users.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

/// Service Locator instance
/// sl = Service Locator
final sl = GetIt.instance;

/// Initialize all dependencies
/// This function should be called in main() before runApp()
Future<void> init() async {
  // ========================================
  // Features - Counter
  // ========================================

  // BLoC
  sl.registerFactory(
    () => CounterBloc(
      getCounter: sl(),
      incrementCounter: sl(),
      decrementCounter: sl(),
      resetCounter: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetCounter(sl()));
  sl.registerLazySingleton(() => IncrementCounter(sl()));
  sl.registerLazySingleton(() => DecrementCounter(sl()));
  sl.registerLazySingleton(() => ResetCounter(sl()));

  // Repository
  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // ========================================
  // Features - User
  // ========================================

  // BLoC
  sl.registerFactory(
    () => UserBloc(getUsers: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(isar: sl()),
  );

  // ========================================
  // Core
  // ========================================

  // Database
  final isar = await DatabaseService.initialize();
  sl.registerLazySingleton<Isar>(() => isar);

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // Connectivity BLoC (global)
  sl.registerLazySingleton(
    () => ConnectivityBloc(networkInfo: sl()),
  );

  // API Client
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl()),
  );

  // ========================================
  // External Dependencies
  // ========================================

  // Connectivity
  sl.registerLazySingleton(() => Connectivity());

  // Dio
  sl.registerLazySingleton(() => Dio());

  // SharedPreferences (async initialization)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
