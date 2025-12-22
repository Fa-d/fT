import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/user_bloc.dart';
import '../widgets/user_card.dart';

/// User List Page - Displays paginated list of users from API
/// Demonstrates API integration, infinite scroll pagination, and pull-to-refresh
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ScrollController _scrollController = ScrollController();
  UserBloc? _userBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && _userBloc != null) {
      _userBloc!.add(LoadMoreUsersEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Trigger at 90% scroll
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _userBloc = sl<UserBloc>()..add(FetchUsersPaginatedEvent());
        return _userBloc!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users from API (Paginated)'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
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
            } else if (state is UserPaginatedLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(RefreshUsersPaginatedEvent());
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.hasReachedMax
                      ? state.users.length
                      : state.users.length + 1, // +1 for loading indicator
                  itemBuilder: (context, index) {
                    if (index >= state.users.length) {
                      // Show loading indicator at the bottom
                      return state.isLoadingMore
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink();
                    }
                    return UserCard(user: state.users[index]);
                  },
                ),
              );
            } else if (state is UserLoaded) {
              // Legacy non-paginated state
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(RefreshUsersEvent());
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
                          context
                              .read<UserBloc>()
                              .add(FetchUsersPaginatedEvent());
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
