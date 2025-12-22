part of 'character_bloc.dart';

/// Base class for Character States
abstract class CharacterState {
  const CharacterState();
}

/// Initial state
class CharacterInitial extends CharacterState {}

/// Loading state (initial load)
class CharacterLoading extends CharacterState {}

/// Successfully loaded paginated characters
class CharacterPaginatedLoaded extends CharacterState {
  final List<CharacterEntity> characters;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int currentPage;
  final int totalCount;

  const CharacterPaginatedLoaded({
    required this.characters,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    required this.currentPage,
    required this.totalCount,
  });

  /// Copy with method for updating state
  CharacterPaginatedLoaded copyWith({
    List<CharacterEntity>? characters,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? currentPage,
    int? totalCount,
  }) {
    return CharacterPaginatedLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

/// Error state
class CharacterError extends CharacterState {
  final String message;

  const CharacterError({required this.message});
}
