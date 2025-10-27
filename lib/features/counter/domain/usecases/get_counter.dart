import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

/// Use Case: Get the current counter value
/// Each use case represents ONE specific business action
class GetCounter implements UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  GetCounter(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    return await repository.getCounter();
  }
}
