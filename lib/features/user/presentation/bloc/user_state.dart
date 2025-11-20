import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

/// Base class for User States
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class UserInitial extends UserState {}

/// Loading state
class UserLoading extends UserState {}

/// Successfully loaded users
class UserLoaded extends UserState {
  final List<UserEntity> users;
  final bool isFromCache;
  final bool isStale;

  const UserLoaded({
    required this.users,
    this.isFromCache = false,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [users, isFromCache, isStale];
}

/// Error state
class UserError extends UserState {
  final String message;
  final bool hasOfflineData;

  const UserError({
    required this.message,
    this.hasOfflineData = false,
  });

  @override
  List<Object?> get props => [message, hasOfflineData];
}
