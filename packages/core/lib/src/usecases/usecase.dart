import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

/// Base class for use cases
/// Use cases represent single actions in the application
/// Following Clean Architecture principles
abstract class UseCase<Type, Params> {
  /// Execute the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// No parameters use case
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Stream-based use case for real-time data
abstract class StreamUseCase<Type, Params> {
  /// Execute the use case and return a stream
  Stream<Either<Failure, Type>> call(Params params);
}
