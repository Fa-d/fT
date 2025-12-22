import 'package:equatable/equatable.dart';

/// Generic paginated response wrapper
class PaginatedResponse<T> extends Equatable {
  final List<T> data;
  final int currentPage;
  final int totalItems;
  final bool hasMore;

  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.totalItems,
    required this.hasMore,
  });

  /// Create a paginated response
  factory PaginatedResponse.fromData({
    required List<T> data,
    required int currentPage,
    required int requestedLimit,
    int? totalItems,
  }) {
    // If data is less than requested limit, there's no more data
    final hasMore = data.length >= requestedLimit;

    return PaginatedResponse(
      data: data,
      currentPage: currentPage,
      totalItems: totalItems ?? data.length,
      hasMore: hasMore,
    );
  }

  @override
  List<Object?> get props => [data, currentPage, totalItems, hasMore];
}
