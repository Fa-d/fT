part of 'user_bloc.dart';

/// Base class for User Events
abstract class UserEvent {
  const UserEvent();
}

/// Event: Fetch all users from API (non-paginated - legacy)
class FetchUsersEvent extends UserEvent {}

/// Event: Refresh the user list (non-paginated - legacy)
class RefreshUsersEvent extends UserEvent {}

/// Event: Fetch initial page of users with pagination
class FetchUsersPaginatedEvent extends UserEvent {}

/// Event: Load more users (next page)
class LoadMoreUsersEvent extends UserEvent {}

/// Event: Refresh paginated user list
class RefreshUsersPaginatedEvent extends UserEvent {}
