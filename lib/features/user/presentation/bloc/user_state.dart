part of 'user_bloc.dart';

/// Base class for User States
abstract class UserState {
  const UserState();
}

/// Initial state
class UserInitial extends UserState {}

/// Loading state (initial load)
class UserLoading extends UserState {}

/// Successfully loaded users (non-paginated - legacy)
class UserLoaded extends UserState {
  final List<UserEntity> users;
  final bool isFromCache;
  final bool isStale;

  const UserLoaded({
    required this.users,
    this.isFromCache = false,
    this.isStale = false,
  });
}

/// Successfully loaded paginated users
class UserPaginatedLoaded extends UserState {
  final List<UserEntity> users;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int currentPage;

  const UserPaginatedLoaded({
    required this.users,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    required this.currentPage,
  });

  /// Copy with method for updating state
  UserPaginatedLoaded copyWith({
    List<UserEntity>? users,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? currentPage,
  }) {
    return UserPaginatedLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Error state
class UserError extends UserState {
  final String message;
  final bool hasOfflineData;

  const UserError({
    required this.message,
    this.hasOfflineData = false,
  });
}
