import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/counter_entity.dart';

/// Counter Repository Interface (Contract)
/// This defines WHAT operations are available, not HOW they're implemented
/// The data layer will implement this interface
abstract class CounterRepository {
  /// Get the current counter value
  Future<Either<Failure, CounterEntity>> getCounter();

  /// Increment the counter
  Future<Either<Failure, CounterEntity>> incrementCounter();

  /// Decrement the counter
  Future<Either<Failure, CounterEntity>> decrementCounter();

  /// Reset the counter to zero
  Future<Either<Failure, CounterEntity>> resetCounter();
}
