import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/user_bloc.dart';
import '../widgets/user_card.dart';

/// User List Page - Displays list of users from API
/// Demonstrates API integration, ListView, and pull-to-refresh
class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users from API'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Use go_router navigation instead of Navigator.pop()
                context.go('/');
              },
              tooltip: 'Back to Counter',
            ),
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading users...'),
                  ],
                ),
              );
            } else if (state is UserLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(RefreshUsersEvent());
                  // Wait for the refresh to complete
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return UserCard(user: state.users[index]);
                  },
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        style: TextStyle(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<UserBloc>().add(FetchUsersEvent());
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
