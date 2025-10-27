import 'package:get_it/get_it.dart';
import 'package:core/core.dart' as core;
import '../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../features/dashboard/domain/usecases/get_system_stats.dart';
import '../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../features/dashboard/data/repositories/dashboard_repository_impl.dart';

final getIt = GetIt.instance;

/// Initialize application dependencies
Future<void> init() async {
  // Dashboard Feature
  // BLoC
  getIt.registerFactory(
    () => DashboardBloc(
      getSystemStats: getIt(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetSystemStats(getIt()));

  // Repositories
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      eventStore: core.getIt.get<core.EventStore>(),
      syncManager: core.getIt.get<core.SyncManager>(),
    ),
  );
}
