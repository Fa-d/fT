# Troubleshooting Guide

## Common Issues and Solutions

### 1. go_router Navigation Error (FIXED)

**Error**:
```
_AssertionError ('package:go_router/src/delegate.dart':
Failed assertion: line 116 pos 7: 'currentConfiguration.isNotEmpty':
You have popped the last page off of the stack,
there are no pages left to show)
```

**Problem**: Using `Navigator.of(context).pop()` with go_router causes conflicts.

**Solution**: When using go_router, always use go_router's navigation methods.

**Fix Applied**: Changed from `Navigator.of(context).pop()` to `context.go('/')` in user_list_page.dart:27-28

**Correct Navigation with go_router**:
```dart
// ❌ WRONG - Don't use Navigator.pop() with go_router
Navigator.of(context).pop();

// ✅ CORRECT - Use go_router methods
context.go('/');          // Go to a specific route
context.pop();            // Go back (if stack allows)
```

---

### 2. "No Internet Connection" Error When Fetching Users

**Problem**: The app shows "No internet connection" error when trying to fetch users from the API.

**Solution**: This was caused by missing Android internet permissions.

**Fix Applied**:
Added the following permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

**Why This Happens**:
- Android apps require explicit permission to access the internet
- Without these permissions, all network requests will fail
- Flutter doesn't automatically add these permissions

**After Applying Fix**:
1. Stop the app completely
2. Rebuild and run: `flutter run`
3. The API calls should now work properly

---

### 3. API Call Errors

**Error Types and What They Mean**:

- **Connection Timeout**: The request took too long (>5 seconds)
  - Solution: Check your internet speed or try again

- **Server Error**: The API returned an error status code
  - Solution: The API service might be down, try again later

- **Network Error**: Can't reach the server
  - Solution: Check your internet connection

- **SSL Certificate Error**: Security certificate issues
  - Solution: Check if you're using HTTPS correctly

---

### 4. Build Issues

**If build fails**:
```bash
# Clean the build
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

---

### 5. State Not Updating

**Problem**: Counter or users list not updating

**Solution**:
- Make sure you're using BLoC events properly
- Check that you're not modifying state directly
- Verify the repository and use cases are registered in dependency injection

---

### 6. Hot Reload Not Working for Dependency Injection

**Problem**: Changes to dependency injection not reflected after hot reload

**Solution**:
- Hot restart the app (Shift + R in terminal)
- Or fully stop and restart the app
- Dependency injection only runs once at app startup

---

### 7. macOS Network Issues (FIXED)

**Problem**: "Network error. Please check your internet connection" on macOS

**Solution**: macOS apps need network client entitlement to make outbound API calls.

**Fix Applied**:
Added to `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:
```xml
<key>com.apple.security.network.client</key>
<true/>
```

**After applying fix**:
```bash
# Stop the app
# Clean and rebuild
flutter clean
flutter run -d macos
```

---

### 8. iOS Build Issues

**Note**: For iOS network access:

Add the following to `ios/Runner/Info.plist`:
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

---

## Testing the API

The app uses [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for demo purposes.

**Test the API directly**:
```bash
curl https://jsonplaceholder.typicode.com/users
```

If this works in your browser/terminal but not in the app, it's likely a permissions issue.

---

## Debugging Network Calls

**Enable Dio logging** (already enabled in the project):
- Check the console output when making API calls
- You'll see the request URL, headers, and response
- Look for error messages in the logs

**In the code** (`lib/core/network/api_client.dart`):
```dart
dio.interceptors.add(
  LogInterceptor(
    requestBody: true,
    responseBody: true,
    error: true,
    request: true,
  ),
);
```

---

## Platform-Specific Notes

### Android
- ✅ Internet permissions added (`AndroidManifest.xml`)
- ✅ Network state permission added
- Works on Android 5.0+ (API 21+)

### macOS
- ✅ Network client entitlement added (DebugProfile.entitlements)
- ✅ Network client entitlement added (Release.entitlements)
- Works on macOS 10.14+
- **IMPORTANT**: After changing entitlements, you MUST rebuild with `flutter clean && flutter run`

### iOS
- May need additional Info.plist configuration
- Works on iOS 12.0+

### Web
- No permissions needed
- CORS might be an issue with some APIs
- JSONPlaceholder works fine

### Desktop (Windows, Linux)
- No permissions needed
- Should work out of the box

---

## Getting Help

If you encounter issues:

1. Check the console for error messages
2. Run `flutter doctor` to check your setup
3. Try `flutter clean && flutter pub get`
4. Make sure you have internet connectivity
5. Check the [Flutter documentation](https://flutter.dev/docs)

---

## Verification Steps

After fixing the internet permission issue:

1. **Rebuild the app**:
   ```bash
   flutter clean
   flutter run
   ```

2. **Test Counter Feature**:
   - Click increment/decrement buttons
   - Counter should persist after app restart

3. **Test User List Feature**:
   - Navigate to "View User List"
   - Should see a loading indicator
   - Should display list of 10 users
   - Pull down to refresh

4. **Test Error Handling**:
   - Turn off internet on your device
   - Try to fetch users
   - Should see appropriate error message
   - Turn on internet and tap retry
   - Should successfully load users

---

## Performance Tips

- The app uses proper state management (BLoC)
- API responses are not cached (you can add this feature)
- SharedPreferences is efficient for small data (like counter)
- For larger datasets, consider using Hive or SQLite

---

## Next Steps for Learning

1. Add offline caching for user data
2. Implement search functionality
3. Add user detail page
4. Write unit tests
5. Add integration tests
6. Implement error logging (Crashlytics)
