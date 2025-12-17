import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_users.dart';

part 'user_event.dart';
part 'user_state.dart';

/// BLoC for User feature with offline-first support
/// Handles fetching users from cache/network
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
  }

  /// Handle FetchUsersEvent (cache-first, then network)
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

  /// Handle RefreshUsersEvent (force network fetch)
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
}
