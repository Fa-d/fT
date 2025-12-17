part of 'user_bloc.dart';

/// Base class for User Events
abstract class UserEvent {
  const UserEvent();
}

/// Event: Fetch all users from API
class FetchUsersEvent extends UserEvent {}

/// Event: Refresh the user list
class RefreshUsersEvent extends UserEvent {}
