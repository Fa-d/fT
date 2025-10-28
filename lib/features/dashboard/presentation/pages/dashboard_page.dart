import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

/// Dashboard page demonstrating:
/// - BLoC state management
/// - Responsive UI
/// - Error handling
/// - Pull-to-refresh
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Flutter Platform'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              context.read<DashboardBloc>().add(
                    const DashboardEvent.syncRequested(),
                  );
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return state.when(
            initial: () => const LoadingIndicator(),
            loading: () => const LoadingIndicator(message: 'Loading system stats...'),
            loaded: (stats) => RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(
                      const DashboardEvent.refreshRequested(),
                    );
                // Wait for the refresh to complete
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ContentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Store',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Total Events: ${stats.eventCount}'),
                        const SizedBox(height: 16),
                        Text(
                          'Synchronization',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Pending Changes: ${stats.pendingSyncCount}'),
                        Text('Status: ${stats.syncStatus}'),
                        Text(
                          'Last Sync: ${_formatTime(stats.lastSyncTime)}',
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Network',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              stats.isOnline
                                  ? Icons.wifi
                                  : Icons.wifi_off,
                              color: stats.isOnline
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              stats.isOnline ? 'Online' : 'Offline',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ContentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Feature Demos',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        _DemoButton(
                          icon: Icons.video_library,
                          title: 'Video Streaming',
                          description: 'Watch videos with offline support',
                          onTap: () => context.go('/media'),
                        ),
                        const SizedBox(height: 8),
                        _DemoButton(
                          icon: Icons.chat,
                          title: 'Real-Time Chat',
                          description: 'Coming soon...',
                          onTap: null,
                          isDisabled: true,
                        ),
                        const SizedBox(height: 8),
                        _DemoButton(
                          icon: Icons.feed,
                          title: 'Social Feed',
                          description: 'Coming soon...',
                          onTap: null,
                          isDisabled: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ContentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advanced Features',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        _FeatureTile(
                          icon: Icons.event_note,
                          title: 'Event Sourcing',
                          description:
                              'All state changes captured as immutable events',
                        ),
                        _FeatureTile(
                          icon: Icons.sync_alt,
                          title: 'Offline-First Sync',
                          description:
                              'Automatic background synchronization with conflict resolution',
                        ),
                        _FeatureTile(
                          icon: Icons.architecture,
                          title: 'CQRS Pattern',
                          description:
                              'Separate read and write models for optimal performance',
                        ),
                        _FeatureTile(
                          icon: Icons.security,
                          title: 'Advanced Security',
                          description:
                              'Certificate pinning, secure storage, biometric auth',
                        ),
                        _FeatureTile(
                          icon: Icons.speed,
                          title: 'Performance',
                          description:
                              'Compute isolates, advanced caching, memory optimization',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            error: (message) => ErrorView(
              message: message,
              onRetry: () {
                context.read<DashboardBloc>().add(
                      const DashboardEvent.refreshRequested(),
                    );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class _DemoButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool isDisabled;

  const _DemoButton({
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDisabled ? Colors.grey[100] : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDisabled ? Colors.grey[300]! : AppColors.primary.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDisabled
                      ? Colors.grey[300]
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isDisabled ? Colors.grey[600] : AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: isDisabled ? Colors.grey[600] : null,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDisabled ? Colors.grey[500] : null,
                          ),
                    ),
                  ],
                ),
              ),
              if (!isDisabled)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
