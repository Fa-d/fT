import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/get_users_paginated.dart';

part 'user_event.dart';
part 'user_state.dart';

/// BLoC for User feature with offline-first support and pagination
/// Handles fetching users from cache/network with pagination support
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  final GetUsersPaginated getUsersPaginated;

  UserBloc({
    required this.getUsers,
    required this.getUsersPaginated,
  }) : super(UserInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
    on<FetchUsersPaginatedEvent>(_onFetchUsersPaginated);
    on<LoadMoreUsersEvent>(_onLoadMoreUsers);
    on<RefreshUsersPaginatedEvent>(_onRefreshUsersPaginated);
  }

  /// Handle FetchUsersEvent (cache-first, then network) - Legacy
  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    // Use cache-first strategy (forceRefresh: false)
    final result = await getUsers(const GetUsersParams(forceRefresh: false));

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (users) => emit(UserLoaded(users: users)),
    );
  }

  /// Handle RefreshUsersEvent (force network fetch) - Legacy
  Future<void> _onRefreshUsers(
    RefreshUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    // Don't show loading for refresh, keep current data visible
    // Force refresh from network (forceRefresh: true)
    final result = await getUsers(const GetUsersParams(forceRefresh: true));

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (users) => emit(UserLoaded(users: users)),
    );
  }

  /// Handle FetchUsersPaginatedEvent (initial paginated load)
  Future<void> _onFetchUsersPaginated(
    FetchUsersPaginatedEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    // Fetch first page
    final result = await getUsersPaginated(
      const GetUsersPaginatedParams.initial(),
    );

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (paginatedResponse) => emit(UserPaginatedLoaded(
        users: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
      )),
    );
  }

  /// Handle LoadMoreUsersEvent (load next page)
  Future<void> _onLoadMoreUsers(
    LoadMoreUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state;

    // Only load more if we're in paginated state and haven't reached max
    if (currentState is UserPaginatedLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      // Set loading more flag
      emit(currentState.copyWith(isLoadingMore: true));

      // Create params for next page
      // Use same limit as initial (3 for testing, can be configured)
      final params = GetUsersPaginatedParams(
        paginationParams: PaginationParams(
          page: currentState.currentPage + 1,
          limit: 3, // Match the initial limit for consistent pagination
        ),
      );

      final result = await getUsersPaginated(params);

      result.fold(
        (failure) {
          // On error, keep current state but stop loading
          emit(currentState.copyWith(isLoadingMore: false));
          // Optionally emit error with current data
          // emit(UserError(message: failure.message, hasOfflineData: true));
        },
        (paginatedResponse) {
          // Append new users to existing list
          final updatedUsers = [
            ...currentState.users,
            ...paginatedResponse.data,
          ];

          emit(UserPaginatedLoaded(
            users: updatedUsers,
            hasReachedMax: !paginatedResponse.hasMore,
            currentPage: paginatedResponse.currentPage,
            isLoadingMore: false,
          ));
        },
      );
    }
  }

  /// Handle RefreshUsersPaginatedEvent (refresh paginated list)
  Future<void> _onRefreshUsersPaginated(
    RefreshUsersPaginatedEvent event,
    Emitter<UserState> emit,
  ) async {
    // Reset to first page
    final result = await getUsersPaginated(
      const GetUsersPaginatedParams(
        paginationParams: PaginationParams.initial(),
        forceRefresh: true,
      ),
    );

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (paginatedResponse) => emit(UserPaginatedLoaded(
        users: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
      )),
    );
  }
}
