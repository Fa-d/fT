import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart' as core;
import 'package:design_system/design_system.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app/app_router.dart';
import 'app/injection_container.dart' as di;
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_event.dart';

/// Advanced Flutter Platform - Production-Ready Example
///
/// This application demonstrates:
/// - Event Sourcing with SQLite-based event store
/// - CQRS pattern for command/query separation
/// - Offline-first architecture with automatic sync
/// - Multi-module package structure
/// - Advanced BLoC patterns with Hydrated BLoC
/// - Real-time features with WebSocket
/// - Certificate pinning for security
/// - Performance optimization with isolates
/// - Background sync management
/// - Conflict resolution strategies
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hydrated BLoC for state persistence
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // Initialize core dependencies (event store, sync manager, etc.)
  await core.initializeCore();

  // Initialize app-specific dependencies
  await di.init();

  runApp(const AdvancedFlutterApp());
}

class AdvancedFlutterApp extends StatelessWidget {
  const AdvancedFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.getIt<DashboardBloc>()
            ..add(DashboardEvent.started()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Advanced Flutter Platform',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
