import 'package:equatable/equatable.dart';

/// Pagination par ameters for API requests
class PaginationParams extends Equatable {
  final int page;
  final int limit;

  const PaginationParams({
    required this.page,
    required this.limit,
  });

  /// Default pagination with 3 items per page (for testing with JSONPlaceholder)
  /// JSONPlaceholder has only 10 users, so use small page size to see pagination
  const PaginationParams.initial()
      : page = 1,
        limit = 3;

  /// Create next page parameters
  PaginationParams nextPage() {
    return PaginationParams(
      page: page + 1,
      limit: limit,
    );
  }

  /// Convert to query parameters for API calls
  Map<String, dynamic> toQueryParams() {
    return {
      '_page': page,
      '_limit': limit,
    };
  }

  @override
  List<Object?> get props => [page, limit];
}
