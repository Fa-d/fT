import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/character_bloc.dart';
import '../widgets/character_card.dart';

/// Character List Page - Displays paginated list of Rick and Morty characters
/// Demonstrates infinite scroll pagination with 826 characters
class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final ScrollController _scrollController = ScrollController();
  CharacterBloc? _characterBloc;

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
    if (_isBottom && _characterBloc != null) {
      _characterBloc!.add(LoadMoreCharactersEvent());
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
        _characterBloc = sl<CharacterBloc>()..add(FetchCharactersPaginatedEvent());
        return _characterBloc!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rick and Morty Characters'),
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
        body: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading characters...'),
                  ],
                ),
              );
            } else if (state is CharacterPaginatedLoaded) {
              return Column(
                children: [
                  // Progress indicator
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Loaded ${state.characters.length} of ${state.totalCount} characters',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ),
                  // Character list
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<CharacterBloc>().add(
                              RefreshCharactersPaginatedEvent(),
                            );
                        await Future.delayed(const Duration(seconds: 1));
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.hasReachedMax
                            ? state.characters.length
                            : state.characters.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.characters.length) {
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
                          return CharacterCard(
                            character: state.characters[index],
                            onTap: () {
                              context.push(
                                '/character/${state.characters[index].id}',
                                extra: state.characters[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CharacterError) {
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
                              .read<CharacterBloc>()
                              .add(FetchCharactersPaginatedEvent());
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
