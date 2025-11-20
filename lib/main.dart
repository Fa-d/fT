import 'package:flutter/material.dart';
import 'core/utils/app_router.dart';
import 'injection_container.dart' as di;

/// Main entry point of the application
/// Initializes dependencies and starts the app
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize dependency injection
    await di.init();

    // Run the app
    runApp(const MyApp());
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
/// Configured with go_router for navigation
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // App title
      title: 'Flutter Clean Architecture',

      // Theme configuration
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

      // Use system theme mode
      themeMode: ThemeMode.system,

      // Router configuration
      routerConfig: AppRouter.router,

      // Debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
