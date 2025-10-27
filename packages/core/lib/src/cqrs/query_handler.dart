import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import 'query.dart';

/// Base class for all query handlers
/// Query handlers process queries and return results
abstract class QueryHandler<TQuery extends Query, TResult> {
  /// Handle the query and return a result
  Future<Either<Failure, TResult>> handle(TQuery query);
}
