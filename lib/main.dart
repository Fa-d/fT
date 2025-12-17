import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/utils/app_router.dart';
import 'core/utils/constants.dart';
import 'injection_container.dart' as di;

/// Main entry point of the application
/// Initializes dependencies and starts the app
void main() async {
  debugPrint('🚀 App starting...');

  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    debugPrint('⚙️ Initializing dependencies...');

    // Initialize dependency injection
    await di.init();

    debugPrint('✅ Dependencies initialized successfully');

    // Run the app with providers
    runApp(const MyApp());

    debugPrint('✅ App launched successfully');
  } catch (e, stackTrace) {
    // Catch and log any initialization errors
    debugPrint('❌ INITIALIZATION ERROR: $e');
    debugPrint('Stack trace: $stackTrace');

    // Show error screen
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Initialization Error:\n\n$e',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    ));
  }
}

/// Root widget of the application
/// Configured with CT/mobile-app pattern using ValueNotifier providers
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider for global state management (CT/mobile-app pattern)
    // Provides access to ValueNotifier instances throughout the app
    return MultiProvider(
      providers: [
        // Global user state
        ChangeNotifierProvider<ValueNotifier<dynamic>>(
          create: (_) => currentUser,
        ),

        // Theme state (light/dark mode)
        ChangeNotifierProvider<ValueNotifier<bool>>(
          create: (_) => isDarkMode,
        ),

        // Global loading state
        ChangeNotifierProvider<ValueNotifier<bool>>(
          create: (_) => isLoading,
        ),

        // Network connectivity status
        ChangeNotifierProvider<ValueNotifier<bool>>(
          create: (_) => isNetworkConnected,
        ),

        // Notification count
        ChangeNotifierProvider<ValueNotifier<int>>(
          create: (_) => notificationCount,
        ),

        // User preferences
        ChangeNotifierProvider<ValueNotifier<Map<String, dynamic>>>(
          create: (_) => userPreferences,
        ),

        // Feature flags
        ChangeNotifierProvider<ValueNotifier<Map<String, bool>>>(
          create: (_) => featureFlags,
        ),
      ],
      child: Consumer<ValueNotifier<bool>>(
        builder: (context, themeNotifier, _) {
          return MaterialApp.router(
            // App title from constants
            title: AppConstants.appTitle,

            // Theme configuration based on global state
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
              ),
            ),

            // Dark theme configuration
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
              ),
            ),

            // Use theme from global state
            themeMode: themeNotifier.value ? ThemeMode.dark : ThemeMode.light,

            // Router configuration
            routerConfig: AppRouter.router,

            // Debug banner
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
