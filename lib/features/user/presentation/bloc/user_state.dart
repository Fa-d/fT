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

  const UserLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

/// Error state
class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
