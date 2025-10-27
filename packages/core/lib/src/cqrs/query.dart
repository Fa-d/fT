import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Base class for all queries in CQRS pattern
/// Queries represent read operations (no state changes)
/// Queries should be named as questions (GetUser, FindProducts, etc.)
abstract class Query<T> extends Equatable {
  /// Unique identifier for this query
  final String queryId;

  /// Timestamp when the query was created
  final DateTime timestamp;

  Query({
    String? queryId,
    DateTime? timestamp,
  })  : queryId = queryId ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [queryId, timestamp];
}

/// Query parameters for pagination
class PaginationParams extends Equatable {
  final int page;
  final int pageSize;
  final String? sortBy;
  final SortOrder sortOrder;

  const PaginationParams({
    this.page = 1,
    this.pageSize = 20,
    this.sortBy,
    this.sortOrder = SortOrder.descending,
  });

  int get offset => (page - 1) * pageSize;

  @override
  List<Object?> get props => [page, pageSize, sortBy, sortOrder];
}

enum SortOrder { ascending, descending }

/// Paginated query result
class PaginatedResult<T> {
  final List<T> items;
  final int totalCount;
  final int page;
  final int pageSize;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginatedResult({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  })  : hasNextPage = (page * pageSize) < totalCount,
        hasPreviousPage = page > 1;

  int get totalPages => (totalCount / pageSize).ceil();
}
