import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/system_stats.dart';
import '../repositories/dashboard_repository.dart';

/// Get system statistics use case
/// Demonstrates clean architecture use case pattern
class GetSystemStats implements UseCase<SystemStats, NoParams> {
  final DashboardRepository repository;

  GetSystemStats(this.repository);

  @override
  Future<Either<Failure, SystemStats>> call(NoParams params) async {
    return repository.getSystemStats();
  }
}
