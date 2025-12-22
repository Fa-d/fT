import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

/// Implementation of UserRepository with offline-first approach
///
/// Uses stale-while-revalidate strategy:
/// 1. Return cached data immediately if available
/// 2. Fetch fresh data from network in background
/// 3. Update cache with fresh data
/// 4. Gracefully degrade to cache when offline
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  /// Cache duration - data older than this is considered stale
  static const cacheDuration = Duration(minutes: 30);

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({
    bool forceRefresh = false,
  }) async {
    try {
      // Check if cache is stale
      final isCacheStale = await localDataSource.isCacheStale(cacheDuration);
      final isConnected = await networkInfo.isConnected;

      // Strategy: Stale-While-Revalidate

      // 1. Return cached data immediately if available and not forcing refresh
      List<UserEntity>? cachedUsers;
      if (!forceRefresh) {
        try {
          final cached = await localDataSource.getCachedUsers();
          cachedUsers = cached;

          // If cache is fresh and we're offline, return it
          if (!isCacheStale || !isConnected) {
            return Right(cachedUsers);
          }
        } on CacheException {
          // No cache available, continue to fetch from network
        }
      }

      // 2. Fetch from network if connected
      if (isConnected) {
        try {
          final remoteUsers = await remoteDataSource.getUsers();

          // Cache the fresh data
          await localDataSource.cacheUsers(remoteUsers);

          return Right(remoteUsers);
        } on ServerException catch (e) {
          // If network fails but we have cache, return cache
          if (cachedUsers != null && cachedUsers.isNotEmpty) {
            return Right(cachedUsers);
          }
          return Left(ServerFailure(e.message));
        } on NetworkException catch (e) {
          // If network error but we have cache, return cache
          if (cachedUsers != null && cachedUsers.isNotEmpty) {
            return Right(cachedUsers);
          }
          return Left(NetworkFailure(e.message));
        }
      }

      // 3. If offline and no cache, return failure
      if (cachedUsers == null || cachedUsers.isEmpty) {
        return const Left(
          NetworkFailure('No internet connection and no cached data available'),
        );
      }

      // 4. Return cached data (already handled above, but safety check)
      return Right(cachedUsers);
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<UserEntity>>> getUsersPaginated({
    required PaginationParams params,
    bool forceRefresh = false,
  }) async {
    try {
      final isConnected = await networkInfo.isConnected;

      // For pagination, we always try to fetch from network when connected
      // Caching paginated data is complex, so we keep it simple for now
      if (isConnected) {
        try {
          final paginatedResponse =
              await remoteDataSource.getUsersPaginated(params);

          return Right(paginatedResponse);
        } on ServerException catch (e) {
          return Left(ServerFailure(e.message));
        } on NetworkException catch (e) {
          return Left(NetworkFailure(e.message));
        }
      }

      // If offline, return failure
      return const Left(
        NetworkFailure(
          'No internet connection. Pagination requires network access.',
        ),
      );
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    try {
      final isConnected = await networkInfo.isConnected;

      // Try cache first
      try {
        final cachedUser = await localDataSource.getCachedUserById(id);
        if (cachedUser != null && !isConnected) {
          return Right(cachedUser);
        }
      } on CacheException {
        // Continue to network
      }

      // Fetch from network if connected
      if (isConnected) {
        try {
          final remoteUser = await remoteDataSource.getUserById(id);
          return Right(remoteUser);
        } on ServerException catch (e) {
          // Try to return from cache if network fails
          try {
            final cachedUser = await localDataSource.getCachedUserById(id);
            if (cachedUser != null) {
              return Right(cachedUser);
            }
          } on CacheException {
            // Fall through to error
          }
          return Left(ServerFailure(e.message));
        } on NetworkException catch (e) {
          try {
            final cachedUser = await localDataSource.getCachedUserById(id);
            if (cachedUser != null) {
              return Right(cachedUser);
            }
          } on CacheException {
            // Fall through to error
          }
          return Left(NetworkFailure(e.message));
        }
      }

      // Offline, try cache
      try {
        final cachedUser = await localDataSource.getCachedUserById(id);
        if (cachedUser != null) {
          return Right(cachedUser);
        }
      } on CacheException {
        // Fall through to error
      }

      return const Left(
        NetworkFailure('No internet connection and no cached data available'),
      );
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }
}
