import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

/// Use Case: Decrement the counter
class DecrementCounter implements UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  DecrementCounter(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    return await repository.decrementCounter();
  }
}
