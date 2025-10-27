import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/counter_entity.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_datasource.dart';
import '../models/counter_model.dart';

/// Implementation of CounterRepository
/// This is where the actual implementation happens
/// Handles error conversion from Exceptions to Failures
class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource localDataSource;

  CounterRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, CounterEntity>> getCounter() async {
    try {
      final counterModel = await localDataSource.getCachedCounter();
      return Right(counterModel);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> incrementCounter() async {
    try {
      // Get current value
      final currentCounter = await localDataSource.getCachedCounter();
      // Increment
      final newCounter = CounterModel(value: currentCounter.value + 1);
      // Save
      await localDataSource.cacheCounter(newCounter);
      return Right(newCounter);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> decrementCounter() async {
    try {
      // Get current value
      final currentCounter = await localDataSource.getCachedCounter();
      // Decrement
      final newCounter = CounterModel(value: currentCounter.value - 1);
      // Save
      await localDataSource.cacheCounter(newCounter);
      return Right(newCounter);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> resetCounter() async {
    try {
      // Reset to zero
      const newCounter = CounterModel(value: 0);
      // Save
      await localDataSource.cacheCounter(newCounter);
      return Right(newCounter);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }
}
