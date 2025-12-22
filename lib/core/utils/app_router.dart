import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/counter/presentation/pages/counter_page.dart';
import '../../features/user/domain/entities/user_entity.dart';
import '../../features/user/presentation/pages/user_detail_page.dart';
import '../../features/user/presentation/pages/user_list_page.dart';
import '../../features/character/domain/entities/character_entity.dart';
import '../../features/character/presentation/pages/character_list_page.dart';
import '../../features/character/presentation/pages/character_detail_page.dart';

/// App Router using go_router
/// Centralized routing configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Counter page route (home)
      GoRoute(
        path: '/',
        name: 'counter',
        builder: (context, state) => const CounterPage(),
      ),
      // User list page route
      GoRoute(
        path: '/users',
        name: 'users',
        builder: (context, state) => const UserListPage(),
        routes: [
          // User detail page (nested route)
          GoRoute(
            path: 'detail',
            name: 'user-detail',
            builder: (context, state) {
              final user = state.extra as UserEntity;
              // Use classic Material Design version
              return UserDetailPage(user: user);
            },
          ),
        ],
      ),
      // Character list page route (Rick and Morty)
      GoRoute(
        path: '/characters',
        name: 'characters',
        builder: (context, state) => const CharacterListPage(),
      ),
      // Character detail page route
      GoRoute(
        path: '/character/:id',
        name: 'character-detail',
        builder: (context, state) {
          final character = state.extra as CharacterEntity;
          return CharacterDetailPage(character: character);
        },
      ),
    ],
    // Error page
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri.path}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
