import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

/// User Detail Page - Shows detailed information about a user
/// Demonstrates passing data between routes and detailed UI layout
class UserDetailPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with avatar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                children: [
                  // Large avatar
                  Hero(
                    tag: 'user_avatar_${user.id}',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        user.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User name
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // User ID chip
                  Chip(
                    label: Text('ID: ${user.id}'),
                    avatar: const Icon(Icons.badge, size: 16),
                  ),
                ],
              ),
            ),

            // Contact information section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Contact Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Email card
                  _InfoCard(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    content: user.email,
                    onTap: () {
                      // In a real app, you could launch email client
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Email: ${user.email}'),
                          action: SnackBarAction(
                            label: 'Copy',
                            onPressed: () {
                              // In a real app, copy to clipboard
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // Phone card
                  _InfoCard(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    content: user.phone,
                    onTap: () {
                      // In a real app, you could launch phone dialer
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Phone: ${user.phone}'),
                          action: SnackBarAction(
                            label: 'Call',
                            onPressed: () {
                              // In a real app, launch phone
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Additional info section
                  Text(
                    'Additional Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Info note
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'This is demo data from JSONPlaceholder API. '
                              'In a real app, you would fetch complete user details '
                              'including address, company, website, etc.',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Edit feature not implemented'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Message feature not implemented'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.message),
                          label: const Text('Message'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom widget for information cards
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback onTap;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
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
