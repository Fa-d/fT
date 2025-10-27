import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

/// Base UseCase class that all use cases should extend
/// T - The return type of the use case
/// Params - The parameters required for the use case
abstract class UseCase<T, Params> {
  /// Call method that executes the use case
  /// Returns Either a Failure (Left) or the result T (Right)
  Future<Either<Failure, T>> call(Params params);
}

/// Class to be used when a UseCase doesn't require any parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
