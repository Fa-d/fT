import 'package:equatable/equatable.dart';

/// Base class for User Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Fetch all users from API
class FetchUsersEvent extends UserEvent {}

/// Event: Refresh the user list
class RefreshUsersEvent extends UserEvent {}
