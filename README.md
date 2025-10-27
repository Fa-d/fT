# Flutter Clean Architecture Tutorial

A comprehensive Flutter application demonstrating Clean Architecture principles and best practices. This project is designed as a learning resource to understand Flutter development with proper architecture.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Project Structure](#project-structure)
- [Key Concepts](#key-concepts)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [Learning Path](#learning-path)

## Overview

This project transforms a simple counter app into a full-featured application following Clean Architecture principles. It includes two main features:
1. **Counter Feature**: Local storage with state management
2. **User Feature**: API integration with remote data

## Architecture

The project follows **Clean Architecture** with three main layers:

### 1. Presentation Layer
- **UI Components**: Widgets, Pages
- **State Management**: BLoC (Business Logic Component)
- **Events & States**: User actions and UI states

### 2. Domain Layer
- **Entities**: Core business objects
- **Use Cases**: Business logic operations
- **Repository Interfaces**: Contracts (what operations exist)

### 3. Data Layer
- **Models**: JSON serialization
- **Repository Implementations**: How operations are performed
- **Data Sources**: Remote (API) and Local (Storage)

### 4. Core Layer
- **Network**: API client configuration
- **Error Handling**: Failures and Exceptions
- **Utilities**: Constants, helpers
- **Base Classes**: UseCase base class

## Features

### Counter Feature (Local Storage)
- Increment/Decrement counter
- Reset counter
- Persistent storage using SharedPreferences
- Clean Architecture implementation
- BLoC state management
- Error handling

### User Feature (API Integration)
- Fetch users from REST API
- Display user list
- User detail page with **Glassmorphism** (iOS/macOS style)
- Frosted glass effects with blur
- Hero animations
- Gradient backgrounds with depth
- Tap on user card to view details
- Pull-to-refresh functionality
- Network error handling
- Loading states
- Custom widgets
- Nested routing demonstration

### Cross-Cutting Concerns
- Dependency Injection (get_it)
- Routing (go_router)
- Theme support (Light/Dark mode)
- Material Design 3
- Comprehensive documentation

## Project Structure

```
lib/
├── core/                          # Core functionality
│   ├── error/
│   │   ├── exceptions.dart        # Exception classes
│   │   └── failures.dart          # Failure classes (Either pattern)
│   ├── network/
│   │   └── api_client.dart        # Dio wrapper for API calls
│   ├── usecases/
│   │   └── usecase.dart           # Base UseCase class
│   └── utils/
│       ├── app_router.dart        # go_router configuration
│       └── constants.dart         # App constants
│
├── features/                      # Feature modules
│   ├── counter/                   # Counter feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── counter_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── counter_model.dart
│   │   │   └── repositories/
│   │   │       └── counter_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── counter_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── counter_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_counter.dart
│   │   │       ├── increment_counter.dart
│   │   │       ├── decrement_counter.dart
│   │   │       └── reset_counter.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── counter_bloc.dart
│   │       │   ├── counter_event.dart
│   │       │   └── counter_state.dart
│   │       ├── pages/
│   │       │   └── counter_page.dart
│   │       └── widgets/
│   │           ├── counter_controls.dart
│   │           └── counter_display.dart
│   │
│   └── user/                      # User feature
│       ├── data/
│       │   ├── datasources/
│       │   │   └── user_remote_datasource.dart
│       │   ├── models/
│       │   │   └── user_model.dart
│       │   └── repositories/
│       │       └── user_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user_entity.dart
│       │   ├── repositories/
│       │   │   └── user_repository.dart
│       │   └── usecases/
│       │       └── get_users.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── user_bloc.dart
│           │   ├── user_event.dart
│           │   └── user_state.dart
│           ├── pages/
│           │   ├── user_list_page.dart
│           │   └── user_detail_page.dart
│           └── widgets/
│               └── user_card.dart
│
├── injection_container.dart       # Dependency injection setup
└── main.dart                      # App entry point
```

## Key Concepts

### 1. Clean Architecture Benefits
- **Separation of Concerns**: Each layer has a specific responsibility
- **Testability**: Easy to unit test each layer independently
- **Maintainability**: Changes in one layer don't affect others
- **Scalability**: Easy to add new features following the same pattern

### 2. BLoC Pattern
```dart
// Event: User action
IncrementCounterEvent()

// BLoC: Processes event, calls use case
counterBloc.add(IncrementCounterEvent())

// State: UI reacts to new state
CounterLoaded(counter: 1)
```

### 3. Dependency Injection
```dart
// Register dependencies
sl.registerFactory(() => CounterBloc(getCounter: sl()));

// Use in UI
final bloc = sl<CounterBloc>();
```

### 4. Either Pattern (Error Handling)
```dart
// Returns either Failure (Left) or Success (Right)
Either<Failure, CounterEntity> result = await getCounter();

result.fold(
  (failure) => print('Error: ${failure.message}'),
  (counter) => print('Success: ${counter.value}'),
);
```

### 5. Repository Pattern
```dart
// Interface (Domain Layer)
abstract class CounterRepository {
  Future<Either<Failure, CounterEntity>> getCounter();
}

// Implementation (Data Layer)
class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource localDataSource;

  @override
  Future<Either<Failure, CounterEntity>> getCounter() async {
    // Implementation details
  }
}
```

## Dependencies

### State Management
- **flutter_bloc**: BLoC pattern implementation
- **equatable**: Value equality for events/states

### Dependency Injection
- **get_it**: Service locator pattern

### Network
- **dio**: HTTP client for API calls

### Storage
- **shared_preferences**: Local key-value storage

### Routing
- **go_router**: Declarative routing

### Functional Programming
- **dartz**: Either type for error handling

### Testing
- **bloc_test**: Testing BLoCs
- **mocktail**: Mocking dependencies

## Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart 3.9.2 or higher

### Installation

1. Navigate to the project directory
```bash
cd /path/to/project
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

### Running Tests
```bash
flutter test
```

### Building for Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## Learning Path

### Beginner Level
1. **Start with main.dart**: Understand app initialization
2. **Explore Counter Feature**: Simple local storage example
3. **Understand BLoC**: Events, States, and how they connect
4. **Study Widgets**: Reusable UI components

### Intermediate Level
1. **Study Clean Architecture Layers**: Domain → Data → Presentation
2. **Explore User Feature**: API integration and error handling
3. **Understand Dependency Injection**: How components are wired
4. **Learn Routing**: Navigation with go_router

### Advanced Level
1. **Study Error Handling**: Either pattern and failure types
2. **Explore Repository Pattern**: Abstraction and implementation
3. **Master UseCase Pattern**: Single responsibility principle
4. **Write Tests**: Unit tests for each layer

## Flutter Concepts Demonstrated

### 1. Widgets
- StatelessWidget vs StatefulWidget
- Custom widgets
- Widget composition
- Hero animations

### 2. State Management
- BLoC pattern
- State immutability
- Event-driven architecture
- Stream-based state

### 3. Navigation
- Declarative routing with go_router
- Nested routes
- Passing data between routes (extra parameter)
- Hero animations between pages
- Error pages

### 4. Networking
- HTTP requests
- JSON serialization
- Error handling
- Timeouts and retries

### 5. Local Storage
- SharedPreferences
- Data persistence
- Cache management

### 6. UI/UX
- Material Design 3
- **Glassmorphism effects** (frosted glass, iOS/macOS style)
- BackdropFilter with blur
- Theme customization
- Dark mode
- Responsive layouts
- Loading states
- Error states
- Pull-to-refresh
- Gradient backgrounds
- Glow effects

### 7. Best Practices
- Clean Architecture
- SOLID principles
- Dependency injection
- Error handling
- Code documentation
- Project organization

## API Used

This project uses [JSONPlaceholder](https://jsonplaceholder.typicode.com/) - a free fake REST API for testing and prototyping.

## Next Steps

To extend this project, consider adding:

1. **Authentication Feature**: Login/logout with JWT
2. **CRUD Operations**: Create, update, delete users
3. **Offline Support**: Cache API responses
4. **Search Functionality**: Filter and search users
5. **Unit Tests**: Comprehensive test coverage
6. **Integration Tests**: End-to-end testing
7. **CI/CD Pipeline**: Automated testing and deployment
8. **Analytics**: Track user behavior
9. **Crashlytics**: Error reporting
10. **Internationalization**: Multi-language support

## Resources

### Official Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)

### Architecture
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

### State Management
- [BLoC Library](https://bloclibrary.dev/)

### Packages
- [get_it](https://pub.dev/packages/get_it)
- [dio](https://pub.dev/packages/dio)
- [go_router](https://pub.dev/packages/go_router)

## License

This project is created for educational purposes.

---

Happy Learning!
