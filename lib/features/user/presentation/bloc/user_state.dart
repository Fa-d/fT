part of 'user_bloc.dart';

/// Base class for User States
abstract class UserState {
  const UserState();
}

/// Initial state
class UserInitial extends UserState {}

/// Loading state
class UserLoading extends UserState {}

/// Successfully loaded users
class UserLoaded extends UserState {
  final List<dynamic> users;
  final bool isFromCache;
  final bool isStale;

  const UserLoaded({
    required this.users,
    this.isFromCache = false,
    this.isStale = false,
  });
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
