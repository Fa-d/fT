import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/system_stats.dart';

/// Dashboard repository interface
/// Following dependency inversion principle
abstract class DashboardRepository {
  Future<Either<Failure, SystemStats>> getSystemStats();
}
