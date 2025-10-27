import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/counter_model.dart';

/// Contract for Counter Local Data Source
abstract class CounterLocalDataSource {
  /// Get cached counter value
  Future<CounterModel> getCachedCounter();

  /// Cache counter value
  Future<void> cacheCounter(CounterModel counterModel);
}

/// Implementation of CounterLocalDataSource using SharedPreferences
class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CounterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CounterModel> getCachedCounter() async {
    try {
      final value = sharedPreferences.getInt(AppConstants.counterKey);
      if (value != null) {
        return CounterModel(value: value);
      } else {
        // Return default value if not found
        return const CounterModel(value: 0);
      }
    } catch (e) {
      throw CacheException('Failed to get counter from cache: $e');
    }
  }

  @override
  Future<void> cacheCounter(CounterModel counterModel) async {
    try {
      await sharedPreferences.setInt(
        AppConstants.counterKey,
        counterModel.value,
      );
    } catch (e) {
      throw CacheException('Failed to cache counter: $e');
    }
  }
}
