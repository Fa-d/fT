import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/usecases/get_characters_paginated.dart';

part 'character_event.dart';
part 'character_state.dart';

/// BLoC for Character feature with pagination support
/// Handles fetching characters from Rick and Morty API (826 characters total)
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersPaginated getCharactersPaginated;

  CharacterBloc({
    required this.getCharactersPaginated,
  }) : super(CharacterInitial()) {
    on<FetchCharactersPaginatedEvent>(_onFetchCharactersPaginated);
    on<LoadMoreCharactersEvent>(_onLoadMoreCharacters);
    on<RefreshCharactersPaginatedEvent>(_onRefreshCharactersPaginated);
  }

  /// Handle FetchCharactersPaginatedEvent (initial paginated load)
  Future<void> _onFetchCharactersPaginated(
    FetchCharactersPaginatedEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharacterLoading());

    // Fetch first page (20 items per page for Rick and Morty API)
    final result = await getCharactersPaginated(
      const GetCharactersPaginatedParams.initial(),
    );

    result.fold(
      (failure) => emit(CharacterError(message: failure.message)),
      (paginatedResponse) => emit(CharacterPaginatedLoaded(
        characters: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
        totalCount: paginatedResponse.totalItems,
      )),
    );
  }

  /// Handle LoadMoreCharactersEvent (load next page)
  Future<void> _onLoadMoreCharacters(
    LoadMoreCharactersEvent event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;

    // Only load more if we're in paginated state and haven't reached max
    if (currentState is CharacterPaginatedLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      // Set loading more flag
      emit(currentState.copyWith(isLoadingMore: true));

      // Create params for next page
      final params = GetCharactersPaginatedParams(
        paginationParams: PaginationParams(
          page: currentState.currentPage + 1,
          limit: 20, // Rick and Morty API returns 20 per page
        ),
      );

      final result = await getCharactersPaginated(params);

      result.fold(
        (failure) {
          // On error, keep current state but stop loading
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (paginatedResponse) {
          // Append new characters to existing list
          final updatedCharacters = [
            ...currentState.characters,
            ...paginatedResponse.data,
          ];

          emit(CharacterPaginatedLoaded(
            characters: updatedCharacters,
            hasReachedMax: !paginatedResponse.hasMore,
            currentPage: paginatedResponse.currentPage,
            totalCount: paginatedResponse.totalItems,
            isLoadingMore: false,
          ));
        },
      );
    }
  }

  /// Handle RefreshCharactersPaginatedEvent (refresh character list)
  Future<void> _onRefreshCharactersPaginated(
    RefreshCharactersPaginatedEvent event,
    Emitter<CharacterState> emit,
  ) async {
    // Reset to first page
    final result = await getCharactersPaginated(
      const GetCharactersPaginatedParams.initial(),
    );

    result.fold(
      (failure) => emit(CharacterError(message: failure.message)),
      (paginatedResponse) => emit(CharacterPaginatedLoaded(
        characters: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
        totalCount: paginatedResponse.totalItems,
      )),
    );
  }
}
