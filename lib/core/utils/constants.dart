import 'package:flutter/foundation.dart';

/// App-wide constants and global state management
class AppConstants {
  // Shared Preferences Keys
  static const String counterKey = 'counter_value';

  // API Endpoints
  static const String usersEndpoint = '/users';

  // Error Messages
  static const String serverErrorMessage = 'Server error occurred';
  static const String cacheErrorMessage = 'Failed to access local storage';
  static const String networkErrorMessage = 'No internet connection';
  static const String unexpectedErrorMessage = 'An unexpected error occurred';

  // App Configuration
  static const String appTitle = 'Flutter Clean Architecture';
  static const String appVersion = '1.0.0';

  // Cache Configuration
  static const int maxCacheAge = 3600; // 1 hour in seconds
  static const int maxCacheSize = 100; // Maximum number of cached items

  // API Configuration
  static const int apiTimeout = 30; // seconds
  static const int apiRetryAttempts = 3;
}

// Global state management using ValueNotifier (CT/mobile-app pattern)
// These can be accessed throughout the app using Provider or direct access

/// Global user state
ValueNotifier<dynamic> currentUser = ValueNotifier(null);

/// Global theme state
ValueNotifier<bool> isDarkMode = ValueNotifier(false);

/// Global loading state
ValueNotifier<bool> isLoading = ValueNotifier(false);

/// Global network status
ValueNotifier<bool> isNetworkConnected = ValueNotifier(true);

/// Global notification count
ValueNotifier<int> notificationCount = ValueNotifier(0);

/// Continue watching list (for content-based apps)
ValueNotifier<List<dynamic>> continueWatchList = ValueNotifier([]);

/// User preferences
ValueNotifier<Map<String, dynamic>> userPreferences = ValueNotifier({});

/// Recently accessed items
ValueNotifier<List<dynamic>> recentItems = ValueNotifier([]);

/// App-wide error state
ValueNotifier<String?> globalError = ValueNotifier(null);

/// Feature flags
ValueNotifier<Map<String, bool>> featureFlags = ValueNotifier({
  'offlineMode': true,
  'pushNotifications': false,
  'analytics': true,
  'crashReporting': true,
});

// Utility functions for global state management

/// Clear all global state
void clearGlobalState() {
  currentUser.value = null;
  isLoading.value = false;
  notificationCount.value = 0;
  continueWatchList.value = [];
  userPreferences.value = {};
  recentItems.value = [];
  globalError.value = null;
}

/// Set loading state globally
void setGlobalLoading(bool loading) {
  isLoading.value = loading;
}

/// Set global error message
void setGlobalError(String? error) {
  globalError.value = error;
}

/// Update notification count
void updateNotificationCount(int count) {
  notificationCount.value = count;
}

/// Add item to recent items
void addToRecentItems(dynamic item) {
  final items = List<dynamic>.from(recentItems.value);
  items.remove(item); // Remove if already exists
  items.insert(0, item); // Add to beginning
  if (items.length > 10) items.removeLast(); // Keep only last 10
  recentItems.value = items;
}

/// Update user preference
void updateUserPreference(String key, dynamic value) {
  final prefs = Map<String, dynamic>.from(userPreferences.value);
  prefs[key] = value;
  userPreferences.value = prefs;
}

/// Get user preference
dynamic getUserPreference(String key) {
  return userPreferences.value[key];
}

/// Toggle feature flag
void toggleFeatureFlag(String flag, bool enabled) {
  final flags = Map<String, bool>.from(featureFlags.value);
  flags[flag] = enabled;
  featureFlags.value = flags;
}

/// Check if feature flag is enabled
bool isFeatureEnabled(String flag) {
  return featureFlags.value[flag] ?? false;
}
