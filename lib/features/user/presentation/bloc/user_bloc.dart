import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

/// BLoC for User feature
/// Handles fetching users from API
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
  }

  /// Handle FetchUsersEvent
  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await getUsers(NoParams());

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (users) => emit(UserLoaded(users: users)),
    );
  }

  /// Handle RefreshUsersEvent
  Future<void> _onRefreshUsers(
    RefreshUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    // Don't show loading for refresh, keep current data visible
    final result = await getUsers(NoParams());

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (users) => emit(UserLoaded(users: users)),
    );
  }
}
