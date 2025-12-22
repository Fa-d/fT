import 'package:flutter/material.dart';
import '../../domain/entities/character_entity.dart';

/// Character Detail Page - Displays full information about a Rick and Morty character
class CharacterDetailPage extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Character Image Header
            Hero(
              tag: 'character_${character.id}',
              child: Image.network(
                character.image,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 100),
                  );
                },
              ),
            ),
            // Character Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  // Status Card
                  _buildInfoCard(
                    context,
                    'Status',
                    [
                      _buildInfoRow(
                        Icons.circle,
                        'Status',
                        character.status,
                        statusColor: _getStatusColor(character.status),
                      ),
                      _buildInfoRow(Icons.science, 'Species', character.species),
                      if (character.type.isNotEmpty)
                        _buildInfoRow(Icons.info, 'Type', character.type),
                      _buildInfoRow(Icons.wc, 'Gender', character.gender),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Location Card
                  _buildInfoCard(
                    context,
                    'Location',
                    [
                      _buildInfoRow(
                        Icons.location_on,
                        'Last known location',
                        character.locationName,
                      ),
                      _buildInfoRow(
                        Icons.public,
                        'Origin',
                        character.originName,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: statusColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
