# Flutter Clean Architecture - Phased Implementation Guide

## Overview

This guide breaks down the implementation of a Flutter Clean Architecture project into **9 progressive phases**. Each phase builds upon the previous one, allowing you to learn concepts incrementally while building a production-ready application.

**Project Goal**: Build a multi-feature Flutter app demonstrating Clean Architecture with:
- Counter Feature (local storage)
- User Feature (API integration)
- BLoC state management
- Dependency injection
- Error handling
- Network connectivity management
- Modern UI with glassmorphism effects

---

## Phase 1: Foundation & Project Setup

### Learning Objectives
- Understand Flutter project structure
- Set up dependencies correctly
- Configure development environment
- Understand Clean Architecture layers

### Duration Estimate
Foundation setup for understanding the project structure.

### Implementation Steps

#### 1.1 Create New Flutter Project
```bash
flutter create flutter_clean_arch_tutorial
cd flutter_clean_arch_tutorial
```

#### 1.2 Update `pubspec.yaml`
Add these dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter

  # UI
  cupertino_icons: ^1.0.8

  # State Management
  flutter_bloc: ^9.0.0
  equatable: ^2.0.5

  # Dependency Injection
  get_it: ^7.7.0

  # Routing
  go_router: ^13.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  mocktail: ^1.0.3
```

Run `flutter pub get`

#### 1.3 Create Folder Structure
```
lib/
├── core/                    # Shared functionality
│   ├── error/
│   ├── usecases/
│   └── utils/
├── features/                # Feature modules
│   └── counter/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
├── injection_container.dart
└── main.dart
```

#### 1.4 Understand the Architecture Layers

**Domain Layer** (Business Logic - Innermost)
- Entities: Pure business objects
- Repository Interfaces: Contracts defining data operations
- Use Cases: Single-responsibility business operations
- NO dependencies on external frameworks

**Data Layer** (Implementation)
- Models: Entities with JSON serialization
- Repository Implementations: Concrete data operations
- Data Sources: Remote (API) or Local (Storage)

**Presentation Layer** (UI - Outermost)
- Pages/Widgets: UI components
- BLoC: State management and business logic coordination
- Events & States: User actions and UI representations

**Core Layer** (Cross-cutting)
- Error handling, network setup, utilities
- Shared across all features

### Key Concepts
- **Dependency Rule**: Inner layers don't know about outer layers
- **Separation of Concerns**: Each layer has specific responsibilities
- **Dependency Inversion**: Depend on abstractions, not implementations

### Validation
- Project builds successfully: `flutter run`
- Folder structure is created
- Dependencies are installed

---

## Phase 2: Core Infrastructure

### Learning Objectives
- Implement error handling with Either pattern
- Create base UseCase class
- Understand functional programming concepts
- Set up dependency injection

### Implementation Steps

#### 2.1 Add Required Dependencies
Update `pubspec.yaml`:
```yaml
dependencies:
  # Functional Programming (for Either)
  dartz: ^0.10.1
```

#### 2.2 Create Error Classes

**File: `lib/core/error/failures.dart`**
```dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
```

**File: `lib/core/error/exceptions.dart`**
```dart
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}
```

#### 2.3 Create Base UseCase

**File: `lib/core/usecases/usecase.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Base class for all use cases
/// Type: Return type
/// Params: Parameters required by the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Used when no parameters are needed
class NoParams {
  const NoParams();
}
```

#### 2.4 Set Up Dependency Injection

**File: `lib/injection_container.dart`**
```dart
import 'package:get_it/get_it.dart';

// Service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  // We'll register dependencies here in later phases

  //! Features - Counter
  // BLoC
  // Use cases
  // Repository
  // Data sources

  //! Core
  // Utilities

  //! External
  // Third-party packages
}
```

#### 2.5 Update main.dart

**File: `lib/main.dart`**
```dart
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Clean Architecture Tutorial'),
        ),
      ),
    );
  }
}
```

### Key Concepts
- **Either Pattern**: Represents success (Right) or failure (Left)
- **Failure vs Exception**: Failures for domain, exceptions for implementation
- **Service Locator**: GetIt manages dependency injection
- **Generic UseCase**: Template for all business operations

### Validation
- App builds and runs
- No compilation errors
- Dependencies are properly imported

---

## Phase 3: Counter Feature - Domain Layer

### Learning Objectives
- Create domain entities
- Define repository contracts
- Implement use cases with single responsibility
- Understand the dependency rule

### Implementation Steps

#### 3.1 Create Counter Entity

**File: `lib/features/counter/domain/entities/counter_entity.dart`**
```dart
import 'package:equatable/equatable.dart';

/// Pure business object with no external dependencies
class CounterEntity extends Equatable {
  final int value;

  const CounterEntity({required this.value});

  @override
  List<Object> get props => [value];
}
```

#### 3.2 Define Repository Interface

**File: `lib/features/counter/domain/repositories/counter_repository.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/counter_entity.dart';

/// Contract defining what operations are available
/// Implementation details are in the data layer
abstract class CounterRepository {
  Future<Either<Failure, CounterEntity>> getCounter();
  Future<Either<Failure, CounterEntity>> incrementCounter();
  Future<Either<Failure, CounterEntity>> decrementCounter();
  Future<Either<Failure, void>> resetCounter();
}
```

#### 3.3 Create Use Cases

**File: `lib/features/counter/domain/usecases/get_counter.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

class GetCounter implements UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  GetCounter(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    return await repository.getCounter();
  }
}
```

**File: `lib/features/counter/domain/usecases/increment_counter.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

class IncrementCounter implements UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  IncrementCounter(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    return await repository.incrementCounter();
  }
}
```

**File: `lib/features/counter/domain/usecases/decrement_counter.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

class DecrementCounter implements UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  DecrementCounter(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    return await repository.decrementCounter();
  }
}
```

**File: `lib/features/counter/domain/usecases/reset_counter.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/counter_repository.dart';

class ResetCounter implements UseCase<void, NoParams> {
  final CounterRepository repository;

  ResetCounter(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.resetCounter();
  }
}
```

### Key Concepts
- **Entity**: Plain Dart objects with business meaning
- **Repository Interface**: Defines WHAT operations exist, not HOW
- **Use Case**: Single operation with single responsibility
- **Domain Independence**: No Flutter/external dependencies

### Validation
- All domain files compile without errors
- No imports from data or presentation layers
- Each use case has one clear responsibility

---

## Phase 4: Counter Feature - Data Layer

### Learning Objectives
- Implement repository pattern
- Create data sources (local storage)
- Handle exceptions and convert to failures
- Understand models vs entities

### Implementation Steps

#### 4.1 Add Local Storage Dependency

Update `pubspec.yaml`:
```yaml
dependencies:
  shared_preferences: ^2.2.2
```

#### 4.2 Create Counter Model

**File: `lib/features/counter/data/models/counter_model.dart`**
```dart
import '../../domain/entities/counter_entity.dart';

/// Extends entity and adds JSON serialization
class CounterModel extends CounterEntity {
  const CounterModel({required super.value});

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(value: json['value'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  factory CounterModel.fromEntity(CounterEntity entity) {
    return CounterModel(value: entity.value);
  }
}
```

#### 4.3 Create Local Data Source

**File: `lib/features/counter/data/datasources/counter_local_datasource.dart`**
```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/counter_model.dart';

abstract class CounterLocalDataSource {
  Future<CounterModel> getCounter();
  Future<CounterModel> incrementCounter();
  Future<CounterModel> decrementCounter();
  Future<void> resetCounter();
}

const String CACHED_COUNTER = 'CACHED_COUNTER';

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CounterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CounterModel> getCounter() async {
    try {
      final jsonString = sharedPreferences.getString(CACHED_COUNTER);
      if (jsonString != null) {
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return CounterModel.fromJson(jsonMap);
      } else {
        // Return default counter if none exists
        return const CounterModel(value: 0);
      }
    } catch (e) {
      throw CacheException('Failed to get counter: $e');
    }
  }

  @override
  Future<CounterModel> incrementCounter() async {
    try {
      final counter = await getCounter();
      final newCounter = CounterModel(value: counter.value + 1);
      await _cacheCounter(newCounter);
      return newCounter;
    } catch (e) {
      throw CacheException('Failed to increment counter: $e');
    }
  }

  @override
  Future<CounterModel> decrementCounter() async {
    try {
      final counter = await getCounter();
      final newCounter = CounterModel(value: counter.value - 1);
      await _cacheCounter(newCounter);
      return newCounter;
    } catch (e) {
      throw CacheException('Failed to decrement counter: $e');
    }
  }

  @override
  Future<void> resetCounter() async {
    try {
      await sharedPreferences.remove(CACHED_COUNTER);
    } catch (e) {
      throw CacheException('Failed to reset counter: $e');
    }
  }

  Future<void> _cacheCounter(CounterModel counter) async {
    try {
      final jsonString = json.encode(counter.toJson());
      await sharedPreferences.setString(CACHED_COUNTER, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache counter: $e');
    }
  }
}
```

#### 4.4 Implement Repository

**File: `lib/features/counter/data/repositories/counter_repository_impl.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/counter_entity.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_datasource.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource localDataSource;

  CounterRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, CounterEntity>> getCounter() async {
    try {
      final counter = await localDataSource.getCounter();
      return Right(counter);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> incrementCounter() async {
    try {
      final counter = await localDataSource.incrementCounter();
      return Right(counter);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> decrementCounter() async {
    try {
      final counter = await localDataSource.decrementCounter();
      return Right(counter);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetCounter() async {
    try {
      await localDataSource.resetCounter();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
```

### Key Concepts
- **Model vs Entity**: Models add serialization to entities
- **Data Source**: Handles actual storage operations
- **Repository Implementation**: Converts exceptions to failures
- **Try-Catch**: Exception handling at repository level

### Validation
- Data layer compiles successfully
- Repository implements the domain interface
- Exception to failure conversion is correct

---

## Phase 5: Counter Feature - Presentation Layer (BLoC)

### Learning Objectives
- Implement BLoC pattern
- Create events and states
- Connect UI to business logic
- Handle loading and error states

### Implementation Steps

#### 5.1 Create BLoC Events

**File: `lib/features/counter/presentation/bloc/counter_event.dart`**
```dart
import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class GetCounterEvent extends CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

class ResetCounterEvent extends CounterEvent {}
```

#### 5.2 Create BLoC States

**File: `lib/features/counter/presentation/bloc/counter_state.dart`**
```dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/counter_entity.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {}

class CounterLoading extends CounterState {}

class CounterLoaded extends CounterState {
  final CounterEntity counter;

  const CounterLoaded({required this.counter});

  @override
  List<Object> get props => [counter];
}

class CounterError extends CounterState {
  final String message;

  const CounterError({required this.message});

  @override
  List<Object> get props => [message];
}
```

#### 5.3 Create BLoC

**File: `lib/features/counter/presentation/bloc/counter_bloc.dart`**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/decrement_counter.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../domain/usecases/reset_counter.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounter getCounter;
  final IncrementCounter incrementCounter;
  final DecrementCounter decrementCounter;
  final ResetCounter resetCounter;

  CounterBloc({
    required this.getCounter,
    required this.incrementCounter,
    required this.decrementCounter,
    required this.resetCounter,
  }) : super(CounterInitial()) {
    on<GetCounterEvent>(_onGetCounter);
    on<IncrementCounterEvent>(_onIncrementCounter);
    on<DecrementCounterEvent>(_onDecrementCounter);
    on<ResetCounterEvent>(_onResetCounter);
  }

  Future<void> _onGetCounter(
    GetCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());
    final result = await getCounter(const NoParams());
    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (counter) => emit(CounterLoaded(counter: counter)),
    );
  }

  Future<void> _onIncrementCounter(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());
    final result = await incrementCounter(const NoParams());
    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (counter) => emit(CounterLoaded(counter: counter)),
    );
  }

  Future<void> _onDecrementCounter(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());
    final result = await decrementCounter(const NoParams());
    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (counter) => emit(CounterLoaded(counter: counter)),
    );
  }

  Future<void> _onResetCounter(
    ResetCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());
    final result = await resetCounter(const NoParams());
    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (_) => add(GetCounterEvent()), // Get counter after reset
    );
  }
}
```

### Key Concepts
- **Events**: Represent user actions
- **States**: Represent UI conditions
- **BLoC**: Processes events, calls use cases, emits states
- **Separation**: BLoC doesn't know about UI widgets

### Validation
- BLoC compiles successfully
- Events and states are properly defined
- Use cases are correctly integrated

---

## Phase 6: Counter Feature - UI Layer

### Learning Objectives
- Build widgets with BLoC
- Handle different states in UI
- Create reusable widget components
- Wire up dependency injection

### Implementation Steps

#### 6.1 Create Counter Display Widget

**File: `lib/features/counter/presentation/widgets/counter_display.dart`**
```dart
import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final int value;

  const CounterDisplay({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Current Count',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$value',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### 6.2 Create Counter Controls Widget

**File: `lib/features/counter/presentation/widgets/counter_controls.dart`**
```dart
import 'package:flutter/material.dart';

class CounterControls extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  const CounterControls({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: 'decrement',
              onPressed: onDecrement,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'increment',
              onPressed: onIncrement,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset'),
        ),
      ],
    );
  }
}
```

#### 6.3 Create Counter Page

**File: `lib/features/counter/presentation/pages/counter_page.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';
import '../widgets/counter_controls.dart';
import '../widgets/counter_display.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CounterBloc>()..add(GetCounterEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter Feature'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              if (state is CounterLoading) {
                return const CircularProgressIndicator();
              } else if (state is CounterLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CounterDisplay(value: state.counter.value),
                    const SizedBox(height: 32),
                    CounterControls(
                      onIncrement: () => context.read<CounterBloc>().add(
                            IncrementCounterEvent(),
                          ),
                      onDecrement: () => context.read<CounterBloc>().add(
                            DecrementCounterEvent(),
                          ),
                      onReset: () => context.read<CounterBloc>().add(
                            ResetCounterEvent(),
                          ),
                    ),
                  ],
                );
              } else if (state is CounterError) {
                return Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                );
              }
              return const Text('Press button to start');
            },
          ),
        ),
      ),
    );
  }
}
```

#### 6.4 Update Dependency Injection

**File: `lib/injection_container.dart`**
```dart
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/counter/data/datasources/counter_local_datasource.dart';
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/repositories/counter_repository.dart';
import 'features/counter/domain/usecases/decrement_counter.dart';
import 'features/counter/domain/usecases/get_counter.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/domain/usecases/reset_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Counter

  // Bloc
  sl.registerFactory(
    () => CounterBloc(
      getCounter: sl(),
      incrementCounter: sl(),
      decrementCounter: sl(),
      resetCounter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCounter(sl()));
  sl.registerLazySingleton(() => IncrementCounter(sl()));
  sl.registerLazySingleton(() => DecrementCounter(sl()));
  sl.registerLazySingleton(() => ResetCounter(sl()));

  // Repository
  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
```

#### 6.5 Update main.dart

**File: `lib/main.dart`**
```dart
import 'package:flutter/material.dart';
import 'features/counter/presentation/pages/counter_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}
```

### Key Concepts
- **BlocProvider**: Provides BLoC to widget tree
- **BlocBuilder**: Rebuilds UI based on state
- **Widget Composition**: Reusable components
- **Dependency Injection**: GetIt provides dependencies

### Validation
- Run the app: Counter increments, decrements, resets
- Counter persists across app restarts
- Loading state shows briefly
- No errors in console

---

## Phase 7: User Feature - Complete Implementation

### Learning Objectives
- Implement API integration
- Create remote data sources
- Handle network errors
- Build list and detail pages
- Add routing with go_router

### Implementation Steps

#### 7.1 Add Network Dependencies

Update `pubspec.yaml`:
```yaml
dependencies:
  dio: ^5.4.0
```

#### 7.2 Create API Client

**File: `lib/core/network/api_client.dart`**
```dart
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }
}
```

#### 7.3 Create User Entity

**File: `lib/features/user/domain/entities/user_entity.dart`**
```dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String website;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.website,
  });

  @override
  List<Object> get props => [id, name, email, username, phone, website];
}
```

#### 7.4 Create User Repository Interface

**File: `lib/features/user/domain/repositories/user_repository.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
}
```

#### 7.5 Create GetUsers Use Case

**File: `lib/features/user/domain/usecases/get_users.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUsers implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await repository.getUsers();
  }
}
```

#### 7.6 Create User Model

**File: `lib/features/user/data/models/user_model.dart`**
```dart
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.username,
    required super.phone,
    required super.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'website': website,
    };
  }
}
```

#### 7.7 Create Remote Data Source

**File: `lib/features/user/data/datasources/user_remote_datasource.dart`**
```dart
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await apiClient.get('/users');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        return jsonList
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to fetch users');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException('Server error: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
```

#### 7.8 Implement User Repository

**File: `lib/features/user/data/repositories/user_repository_impl.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
```

#### 7.9 Create User BLoC (Events, States, BLoC)

**File: `lib/features/user/presentation/bloc/user_event.dart`**
```dart
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UserEvent {}

class RefreshUsersEvent extends UserEvent {}
```

**File: `lib/features/user/presentation/bloc/user_state.dart`**
```dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserEntity> users;

  const UserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}
```

**File: `lib/features/user/presentation/bloc/user_bloc.dart`**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<GetUsersEvent>(_onGetUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
  }

  Future<void> _onGetUsers(
    GetUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await getUsers(const NoParams());
    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (users) => emit(UserLoaded(users: users)),
    );
  }

  Future<void> _onRefreshUsers(
    RefreshUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    // Don't show loading for refresh
    final result = await getUsers(const NoParams());
    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (users) => emit(UserLoaded(users: users)),
    );
  }
}
```

#### 7.10 Create User Card Widget

**File: `lib/features/user/presentation/widgets/user_card.dart`**
```dart
import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name[0].toUpperCase()),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
```

#### 7.11 Create User List Page

**File: `lib/features/user/presentation/pages/user_list_page.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../widgets/user_card.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(GetUsersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(RefreshUsersEvent());
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return UserCard(
                      user: user,
                      onTap: () => context.push('/user/${user.id}', extra: user),
                    );
                  },
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<UserBloc>().add(GetUsersEvent()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No users'));
          },
        ),
      ),
    );
  }
}
```

#### 7.12 Create User Detail Page

**File: `lib/features/user/presentation/pages/user_detail_page.dart`**
```dart
import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserDetailPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'user_${user.id}',
                child: CircleAvatar(
                  radius: 60,
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoCard(
              context,
              'Personal Information',
              [
                _buildInfoRow(Icons.person, 'Name', user.name),
                _buildInfoRow(Icons.account_circle, 'Username', user.username),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              context,
              'Contact Information',
              [
                _buildInfoRow(Icons.email, 'Email', user.email),
                _buildInfoRow(Icons.phone, 'Phone', user.phone),
                _buildInfoRow(Icons.language, 'Website', user.website),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

#### 7.13 Set Up Routing

**File: `lib/core/utils/app_router.dart`**
```dart
import 'package:go_router/go_router.dart';
import '../../features/counter/presentation/pages/counter_page.dart';
import '../../features/user/domain/entities/user_entity.dart';
import '../../features/user/presentation/pages/user_detail_page.dart';
import '../../features/user/presentation/pages/user_list_page.dart';

final appRouter = GoRouter(
  initialLocation: '/users',
  routes: [
    GoRoute(
      path: '/counter',
      builder: (context, state) => const CounterPage(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const UserListPage(),
    ),
    GoRoute(
      path: '/user/:id',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return UserDetailPage(user: user);
      },
    ),
  ],
);
```

#### 7.14 Update Dependency Injection

Update `lib/injection_container.dart`:
```dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/api_client.dart';
import 'features/counter/data/datasources/counter_local_datasource.dart';
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/repositories/counter_repository.dart';
import 'features/counter/domain/usecases/decrement_counter.dart';
import 'features/counter/domain/usecases/get_counter.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/domain/usecases/reset_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';
import 'features/user/data/datasources/user_remote_datasource.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_users.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Counter

  // Bloc
  sl.registerFactory(
    () => CounterBloc(
      getCounter: sl(),
      incrementCounter: sl(),
      decrementCounter: sl(),
      resetCounter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCounter(sl()));
  sl.registerLazySingleton(() => IncrementCounter(sl()));
  sl.registerLazySingleton(() => DecrementCounter(sl()));
  sl.registerLazySingleton(() => ResetCounter(sl()));

  // Repository
  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Features - User

  // Bloc
  sl.registerFactory(() => UserBloc(getUsers: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(apiClient: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => ApiClient(dio: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
```

#### 7.15 Update main.dart

**File: `lib/main.dart`**
```dart
import 'package:flutter/material.dart';
import 'core/utils/app_router.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
```

### Key Concepts
- **API Integration**: Dio for network requests
- **Remote Data Source**: Handles API calls
- **Error Handling**: Different exceptions for different errors
- **Routing**: go_router for navigation
- **Hero Animations**: Smooth transitions

### Validation
- Run app and navigate to users page
- Pull to refresh works
- Tap on user to see details
- Error handling works (turn off internet)
- Navigation works correctly

---

## Phase 8: Advanced Features (Optional)

### Learning Objectives
- Implement network connectivity detection
- Add local caching with Isar database
- Create glassmorphism UI effects
- Handle offline/online scenarios

### What to Implement

1. **Network Connectivity**
   - Add `connectivity_plus` package
   - Create connectivity BLoC
   - Show banner when offline
   - Cache data for offline access

2. **Local Database (Isar)**
   - Cache user data
   - Implement cache-first strategy
   - Sync with remote when online

3. **Enhanced UI**
   - Glassmorphism effects on detail page
   - Dark mode support
   - Smooth animations
   - Better loading states

4. **Testing**
   - Unit tests for use cases
   - Widget tests for UI
   - Integration tests

### Implementation Notes
Refer to the existing codebase for implementations of:
- `lib/core/network/network_info.dart`
- `lib/core/database/database_service.dart`
- `lib/features/user/data/datasources/user_local_datasource.dart`
- `lib/core/widgets/connectivity_banner.dart`

---

## Phase 9: API Pagination with Infinite Scroll

### Learning Objectives
- Implement API pagination
- Create reusable pagination infrastructure
- Handle infinite scroll in UI
- Manage paginated state in BLoC
- Understand performance optimization with pagination

### Why Pagination?
Pagination is essential for:
- **Performance**: Load data in chunks instead of all at once
- **User Experience**: Faster initial load times
- **Resource Management**: Reduce memory and bandwidth usage
- **Scalability**: Handle large datasets efficiently

### Implementation Steps

#### 9.1 Create Pagination Core Classes

**File: `lib/core/pagination/pagination_params.dart`**
```dart
import 'package:equatable/equatable.dart';

/// Pagination parameters for API requests
class PaginationParams extends Equatable {
  final int page;
  final int limit;

  const PaginationParams({
    required this.page,
    required this.limit,
  });

  /// Default pagination with 10 items per page
  const PaginationParams.initial()
      : page = 1,
        limit = 10;

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
```

**File: `lib/core/pagination/paginated_response.dart`**
```dart
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
```

#### 9.2 Update Repository Interface

**File: `lib/features/user/domain/repositories/user_repository.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  /// Get list of all users (non-paginated - legacy)
  Future<Either<Failure, List<UserEntity>>> getUsers({
    bool forceRefresh = false,
  });

  /// Get paginated list of users
  Future<Either<Failure, PaginatedResponse<UserEntity>>> getUsersPaginated({
    required PaginationParams params,
    bool forceRefresh = false,
  });

  Future<Either<Failure, UserEntity>> getUserById(int id);
}
```

#### 9.3 Update Remote Data Source

**File: `lib/features/user/data/datasources/user_remote_datasource.dart`**

Add the paginated method:
```dart
abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();

  /// Fetch paginated users from the API
  Future<PaginatedResponse<UserModel>> getUsersPaginated(
    PaginationParams params,
  );

  Future<UserModel> getUserById(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<PaginatedResponse<UserModel>> getUsersPaginated(
    PaginationParams params,
  ) async {
    try {
      final response = await apiClient.get(
        AppConstants.usersEndpoint,
        queryParameters: params.toQueryParams(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final users = jsonList
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Get total count from response headers (if available)
        final totalCountHeader = response.headers.value('x-total-count');
        final totalCount = totalCountHeader != null
            ? int.tryParse(totalCountHeader) ?? users.length
            : null;

        return PaginatedResponse.fromData(
          data: users,
          currentPage: params.page,
          requestedLimit: params.limit,
          totalItems: totalCount,
        );
      } else {
        throw ServerException('Failed to fetch users: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle Dio exceptions...
      throw NetworkException('Network error: ${e.message}');
    }
  }

  // ... other methods
}
```

#### 9.4 Update Repository Implementation

**File: `lib/features/user/data/repositories/user_repository_impl.dart`**

Add the paginated method:
```dart
@override
Future<Either<Failure, PaginatedResponse<UserEntity>>> getUsersPaginated({
  required PaginationParams params,
  bool forceRefresh = false,
}) async {
  try {
    final isConnected = await networkInfo.isConnected;

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

    return const Left(
      NetworkFailure(
        'No internet connection. Pagination requires network access.',
      ),
    );
  } catch (e) {
    return Left(CacheFailure('Unexpected error: $e'));
  }
}
```

#### 9.5 Create Paginated Use Case

**File: `lib/features/user/domain/usecases/get_users_paginated.dart`**
```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use Case: Get paginated users
class GetUsersPaginated
    implements UseCase<PaginatedResponse<UserEntity>, GetUsersPaginatedParams> {
  final UserRepository repository;

  GetUsersPaginated(this.repository);

  @override
  Future<Either<Failure, PaginatedResponse<UserEntity>>> call(
    GetUsersPaginatedParams params,
  ) async {
    return await repository.getUsersPaginated(
      params: params.paginationParams,
      forceRefresh: params.forceRefresh,
    );
  }
}

/// Parameters for GetUsersPaginated use case
class GetUsersPaginatedParams extends Equatable {
  final PaginationParams paginationParams;
  final bool forceRefresh;

  const GetUsersPaginatedParams({
    required this.paginationParams,
    this.forceRefresh = false,
  });

  const GetUsersPaginatedParams.initial()
      : paginationParams = const PaginationParams.initial(),
        forceRefresh = false;

  GetUsersPaginatedParams nextPage() {
    return GetUsersPaginatedParams(
      paginationParams: paginationParams.nextPage(),
      forceRefresh: forceRefresh,
    );
  }

  @override
  List<Object?> get props => [paginationParams, forceRefresh];
}
```

#### 9.6 Update BLoC Events and States

**File: `lib/features/user/presentation/bloc/user_event.dart`**
```dart
part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

// Legacy events
class FetchUsersEvent extends UserEvent {}
class RefreshUsersEvent extends UserEvent {}

// Pagination events
class FetchUsersPaginatedEvent extends UserEvent {}
class LoadMoreUsersEvent extends UserEvent {}
class RefreshUsersPaginatedEvent extends UserEvent {}
```

**File: `lib/features/user/presentation/bloc/user_state.dart`**
```dart
part of 'user_bloc.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}

// Legacy state
class UserLoaded extends UserState {
  final List<dynamic> users;
  final bool isFromCache;
  final bool isStale;

  const UserLoaded({
    required this.users,
    this.isFromCache = false,
    this.isStale = false,
  });
}

// Paginated state
class UserPaginatedLoaded extends UserState {
  final List<dynamic> users;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int currentPage;

  const UserPaginatedLoaded({
    required this.users,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    required this.currentPage,
  });

  UserPaginatedLoaded copyWith({
    List<dynamic>? users,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? currentPage,
  }) {
    return UserPaginatedLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class UserError extends UserState {
  final String message;
  final bool hasOfflineData;

  const UserError({
    required this.message,
    this.hasOfflineData = false,
  });
}
```

#### 9.7 Update BLoC Logic

**File: `lib/features/user/presentation/bloc/user_bloc.dart`**

Add pagination handlers:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/get_users_paginated.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  final GetUsersPaginated getUsersPaginated;

  UserBloc({
    required this.getUsers,
    required this.getUsersPaginated,
  }) : super(UserInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
    on<FetchUsersPaginatedEvent>(_onFetchUsersPaginated);
    on<LoadMoreUsersEvent>(_onLoadMoreUsers);
    on<RefreshUsersPaginatedEvent>(_onRefreshUsersPaginated);
  }

  // ... legacy handlers ...

  /// Handle FetchUsersPaginatedEvent (initial paginated load)
  Future<void> _onFetchUsersPaginated(
    FetchUsersPaginatedEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await getUsersPaginated(
      const GetUsersPaginatedParams.initial(),
    );

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (paginatedResponse) => emit(UserPaginatedLoaded(
        users: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
      )),
    );
  }

  /// Handle LoadMoreUsersEvent (load next page)
  Future<void> _onLoadMoreUsers(
    LoadMoreUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state;

    if (currentState is UserPaginatedLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      // Set loading more flag
      emit(currentState.copyWith(isLoadingMore: true));

      // Create params for next page
      final params = GetUsersPaginatedParams(
        paginationParams: PaginationParams(
          page: currentState.currentPage + 1,
          limit: 10,
        ),
      );

      final result = await getUsersPaginated(params);

      result.fold(
        (failure) {
          // On error, keep current state but stop loading
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (paginatedResponse) {
          // Append new users to existing list
          final updatedUsers = [
            ...currentState.users,
            ...paginatedResponse.data,
          ];

          emit(UserPaginatedLoaded(
            users: updatedUsers,
            hasReachedMax: !paginatedResponse.hasMore,
            currentPage: paginatedResponse.currentPage,
            isLoadingMore: false,
          ));
        },
      );
    }
  }

  /// Handle RefreshUsersPaginatedEvent (refresh paginated list)
  Future<void> _onRefreshUsersPaginated(
    RefreshUsersPaginatedEvent event,
    Emitter<UserState> emit,
  ) async {
    final result = await getUsersPaginated(
      const GetUsersPaginatedParams(
        paginationParams: PaginationParams.initial(),
        forceRefresh: true,
      ),
    );

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (paginatedResponse) => emit(UserPaginatedLoaded(
        users: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
      )),
    );
  }
}
```

#### 9.8 Update UI with Infinite Scroll

**File: `lib/features/user/presentation/pages/user_list_page.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/user_bloc.dart';
import '../widgets/user_card.dart';

/// User List Page with infinite scroll pagination
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<UserBloc>().add(LoadMoreUsersEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Trigger at 90% scroll
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(FetchUsersPaginatedEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users (Paginated)'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserPaginatedLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(RefreshUsersPaginatedEvent());
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.hasReachedMax
                      ? state.users.length
                      : state.users.length + 1, // +1 for loading indicator
                  itemBuilder: (context, index) {
                    if (index >= state.users.length) {
                      // Show loading indicator at the bottom
                      return state.isLoadingMore
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink();
                    }
                    return UserCard(user: state.users[index]);
                  },
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchUsersPaginatedEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
```

#### 9.9 Update Dependency Injection

**File: `lib/injection_container.dart`**

Register the new use case:
```dart
// Feature: User
import 'features/user/domain/usecases/get_users_paginated.dart';

void _initUserFeature() {
  // ... existing code ...

  // Domain layer - Use Cases
  sl.registerLazySingleton<GetUsers>(
    () => GetUsers(sl()),
  );

  sl.registerLazySingleton<GetUsersPaginated>(
    () => GetUsersPaginated(sl()),
  );

  // Presentation layer - BLoC
  sl.registerFactory<UserBloc>(
    () => UserBloc(
      getUsers: sl(),
      getUsersPaginated: sl(),
    ),
  );
}
```

### Key Concepts

#### 1. Pagination Strategy
- **Page-based**: Request data by page number
- **Limit**: Control items per page
- **Infinite Scroll**: Automatically load more when scrolling
- **Pull-to-Refresh**: Reset to first page

#### 2. State Management
- **UserPaginatedLoaded**: Tracks current page, has more data, loading state
- **isLoadingMore**: Show loading indicator while fetching next page
- **hasReachedMax**: Stop loading when no more data

#### 3. Performance Optimization
- **Trigger at 90%**: Load next page before reaching bottom
- **Prevent duplicate requests**: Check `isLoadingMore` and `hasReachedMax`
- **Append data**: Add new items to existing list

#### 4. User Experience
- Initial loading indicator
- Bottom loading indicator during pagination
- Pull-to-refresh support
- Error handling with retry

### Validation

1. Run the app
2. Scroll to bottom - new page loads automatically
3. Pull to refresh - resets to page 1
4. Turn off internet - error message appears
5. Loading indicators show at appropriate times

### Common Patterns

**1. Scroll Detection**
```dart
void _onScroll() {
  if (_isBottom) {
    context.read<UserBloc>().add(LoadMoreUsersEvent());
  }
}

bool get _isBottom {
  if (!_scrollController.hasClients) return false;
  final maxScroll = _scrollController.position.maxScrollExtent;
  final currentScroll = _scrollController.offset;
  return currentScroll >= (maxScroll * 0.9);
}
```

**2. Preventing Duplicate Requests**
```dart
if (currentState.hasReachedMax || currentState.isLoadingMore) {
  return; // Don't load if already loading or no more data
}
```

**3. Appending Data**
```dart
final updatedUsers = [
  ...currentState.users,
  ...paginatedResponse.data,
];
```

### Advanced Enhancements

1. **Cache paginated data**: Store each page separately
2. **Bidirectional scrolling**: Load previous pages
3. **Search with pagination**: Reset pagination on search
4. **Optimistic updates**: Show skeleton loaders
5. **Error recovery**: Retry failed page loads

---

## Phase 10: Large-Scale Pagination with Rick and Morty API

### Learning Objectives
- Implement pagination with a real-world API containing large datasets (826 characters)
- Understand how to adapt pagination to different API response structures
- Learn to work with APIs that have proper pagination metadata
- Practice creating feature modules following Clean Architecture patterns

### Why Rick and Morty API?

The JSONPlaceholder API used in Phase 9 only has 10 users total, which isn't sufficient to properly test pagination. The Rick and Morty API provides:
- **826 total characters** across 42 pages
- **20 characters per page** (ideal for infinite scroll)
- **Proper pagination metadata** (next, prev, count)
- **Different API structure** to learn flexibility
- **Free and reliable** with no authentication required

### API Overview

**Base URL**: `https://rickandmortyapi.com/api`

**Endpoint**: `/character?page=1`

**Response Structure**:
```json
{
  "info": {
    "count": 826,
    "pages": 42,
    "next": "https://rickandmortyapi.com/api/character?page=2",
    "prev": null
  },
  "results": [
    {
      "id": 1,
      "name": "Rick Sanchez",
      "status": "Alive",
      "species": "Human",
      "type": "",
      "gender": "Male",
      "origin": {
        "name": "Earth (C-137)",
        "url": "https://rickandmortyapi.com/api/location/1"
      },
      "location": {
        "name": "Citadel of Ricks",
        "url": "https://rickandmortyapi.com/api/location/3"
      },
      "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      "episode": [...],
      "url": "https://rickandmortyapi.com/api/character/1",
      "created": "2017-11-04T18:48:46.250Z"
    }
  ]
}
```

### Implementation Steps

#### 10.1 Add API Constants

**File: `lib/core/utils/constants.dart`**
```dart
class ApiConstants {
  // ... existing constants ...

  // Rick and Morty API
  static const String rickAndMortyBaseUrl = 'https://rickandmortyapi.com/api';
  static const String charactersEndpoint = '/character';
}
```

#### 10.2 Create Character Entity

**File: `lib/features/character/domain/entities/character_entity.dart`**
```dart
import 'package:equatable/equatable.dart';

/// Character Entity - Domain model for Rick and Morty character
class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String status; // Alive, Dead, or unknown
  final String species;
  final String type;
  final String gender;
  final String image;
  final String locationName;
  final String originName;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.locationName,
    required this.originName,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        locationName,
        originName,
      ];
}
```

#### 10.3 Create Character Model

**File: `lib/features/character/data/models/character_model.dart`**
```dart
import '../../domain/entities/character_entity.dart';

/// Character Model - Data layer representation with JSON serialization
class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.image,
    required super.locationName,
    required super.originName,
  });

  /// Factory constructor to create CharacterModel from JSON
  /// Handles the nested structure of Rick and Morty API response
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String,
      image: json['image'] as String,
      locationName: (json['location'] as Map<String, dynamic>)['name'] as String,
      originName: (json['origin'] as Map<String, dynamic>)['name'] as String,
    );
  }

  /// Convert CharacterModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'location': {'name': locationName},
      'origin': {'name': originName},
    };
  }
}
```

#### 10.4 Create Remote Data Source

**File: `lib/features/character/data/datasources/character_remote_datasource.dart`**
```dart
import 'package:dio/dio.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/utils/constants.dart';
import '../models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<PaginatedResponse<CharacterModel>> getCharactersPaginated(
    PaginationParams params,
  );
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedResponse<CharacterModel>> getCharactersPaginated(
    PaginationParams params,
  ) async {
    // Rick and Morty API uses ?page= parameter (not ?_page= like JSONPlaceholder)
    final response = await dio.get(
      '${ApiConstants.rickAndMortyBaseUrl}${ApiConstants.charactersEndpoint}',
      queryParameters: {'page': params.page},
    );

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;

      // Rick and Morty API structure: { info: {...}, results: [...] }
      final info = data['info'] as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      final characters = results
          .map((json) => CharacterModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return PaginatedResponse(
        data: characters,
        currentPage: params.page,
        totalItems: info['count'] as int, // Total: 826
        hasMore: info['next'] != null, // Check if there's a next page
      );
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
```

**Key Differences from JSONPlaceholder:**
1. Uses `?page=` instead of `?_page=`
2. Response has `info` object with pagination metadata
3. Characters are in `results` array (not top-level)
4. Uses `info['next']` to determine if more pages exist
5. API returns exactly 20 items per page (not configurable)

#### 10.5 Create Repository Interface

**File: `lib/features/character/domain/repositories/character_repository.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, PaginatedResponse<CharacterEntity>>> getCharactersPaginated(
    PaginationParams params,
  );
}
```

#### 10.6 Implement Repository

**File: `lib/features/character/data/repositories/character_repository_impl.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_remote_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResponse<CharacterEntity>>> getCharactersPaginated(
    PaginationParams params,
  ) async {
    try {
      final result = await remoteDataSource.getCharactersPaginated(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch characters: ${e.toString()}'));
    }
  }
}
```

#### 10.7 Create Use Case

**File: `lib/features/character/domain/usecases/get_characters_paginated.dart`**
```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/character_entity.dart';
import '../repositories/character_repository.dart';

class GetCharactersPaginated implements UseCase<PaginatedResponse<CharacterEntity>, GetCharactersPaginatedParams> {
  final CharacterRepository repository;

  GetCharactersPaginated(this.repository);

  @override
  Future<Either<Failure, PaginatedResponse<CharacterEntity>>> call(
    GetCharactersPaginatedParams params,
  ) async {
    return await repository.getCharactersPaginated(params.paginationParams);
  }
}

class GetCharactersPaginatedParams extends Equatable {
  final PaginationParams paginationParams;

  const GetCharactersPaginatedParams({
    this.paginationParams = const PaginationParams.initial(),
  });

  const GetCharactersPaginatedParams.initial()
      : paginationParams = const PaginationParams.initial();

  @override
  List<Object?> get props => [paginationParams];
}
```

#### 10.8 Create BLoC

**File: `lib/features/character/presentation/bloc/character_event.dart`**
```dart
part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object?> get props => [];
}

class FetchCharactersPaginatedEvent extends CharacterEvent {}

class LoadMoreCharactersEvent extends CharacterEvent {}

class RefreshCharactersPaginatedEvent extends CharacterEvent {}
```

**File: `lib/features/character/presentation/bloc/character_state.dart`**
```dart
part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterPaginatedLoaded extends CharacterState {
  final List<CharacterEntity> characters;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int currentPage;
  final int totalCount;

  const CharacterPaginatedLoaded({
    required this.characters,
    required this.hasReachedMax,
    required this.currentPage,
    required this.totalCount,
    this.isLoadingMore = false,
  });

  CharacterPaginatedLoaded copyWith({
    List<CharacterEntity>? characters,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? currentPage,
    int? totalCount,
  }) {
    return CharacterPaginatedLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [characters, hasReachedMax, isLoadingMore, currentPage, totalCount];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError({required this.message});

  @override
  List<Object?> get props => [message];
}
```

**File: `lib/features/character/presentation/bloc/character_bloc.dart`**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/usecases/get_characters_paginated.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersPaginated getCharactersPaginated;

  CharacterBloc({required this.getCharactersPaginated}) : super(CharacterInitial()) {
    on<FetchCharactersPaginatedEvent>(_onFetchCharactersPaginated);
    on<LoadMoreCharactersEvent>(_onLoadMoreCharacters);
    on<RefreshCharactersPaginatedEvent>(_onRefreshCharactersPaginated);
  }

  Future<void> _onFetchCharactersPaginated(
    FetchCharactersPaginatedEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharacterLoading());

    final result = await getCharactersPaginated(
      const GetCharactersPaginatedParams.initial(),
    );

    result.fold(
      (failure) => emit(CharacterError(message: failure.message)),
      (paginatedResponse) => emit(CharacterPaginatedLoaded(
        characters: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
        totalCount: paginatedResponse.totalItems,
      )),
    );
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharactersEvent event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;

    if (currentState is CharacterPaginatedLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      emit(currentState.copyWith(isLoadingMore: true));

      final params = GetCharactersPaginatedParams(
        paginationParams: PaginationParams(
          page: currentState.currentPage + 1,
          limit: 20,
        ),
      );

      final result = await getCharactersPaginated(params);

      result.fold(
        (failure) {
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (paginatedResponse) {
          final updatedCharacters = [
            ...currentState.characters,
            ...paginatedResponse.data,
          ];

          emit(CharacterPaginatedLoaded(
            characters: updatedCharacters,
            hasReachedMax: !paginatedResponse.hasMore,
            currentPage: paginatedResponse.currentPage,
            totalCount: paginatedResponse.totalItems,
            isLoadingMore: false,
          ));
        },
      );
    }
  }

  Future<void> _onRefreshCharactersPaginated(
    RefreshCharactersPaginatedEvent event,
    Emitter<CharacterState> emit,
  ) async {
    final result = await getCharactersPaginated(
      const GetCharactersPaginatedParams.initial(),
    );

    result.fold(
      (failure) => emit(CharacterError(message: failure.message)),
      (paginatedResponse) => emit(CharacterPaginatedLoaded(
        characters: paginatedResponse.data,
        hasReachedMax: !paginatedResponse.hasMore,
        currentPage: paginatedResponse.currentPage,
        totalCount: paginatedResponse.totalItems,
      )),
    );
  }
}
```

#### 10.9 Create Character Card Widget

**File: `lib/features/character/presentation/widgets/character_card.dart`**
```dart
import 'package:flutter/material.dart';
import '../../domain/entities/character_entity.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final VoidCallback? onTap;

  const CharacterCard({
    super.key,
    required this.character,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Character Image with Hero animation
              Hero(
                tag: 'character_${character.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    character.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Character Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildStatusIndicator(character.status),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${character.status} - ${character.species}',
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Last seen: ${character.locationName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'alive':
        color = Colors.green;
        break;
      case 'dead':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
```

#### 10.10 Create Character List Page

**File: `lib/features/character/presentation/pages/character_list_page.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/character_bloc.dart';
import '../widgets/character_card.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final ScrollController _scrollController = ScrollController();
  CharacterBloc? _characterBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && _characterBloc != null) {
      _characterBloc!.add(LoadMoreCharactersEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Trigger at 90% scroll
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _characterBloc = sl<CharacterBloc>()..add(FetchCharactersPaginatedEvent());
        return _characterBloc!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rick and Morty Characters'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => context.go('/'),
              tooltip: 'Back to Counter',
            ),
          ],
        ),
        body: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading characters...'),
                  ],
                ),
              );
            } else if (state is CharacterPaginatedLoaded) {
              return Column(
                children: [
                  // Progress indicator showing X of 826
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Loaded ${state.characters.length} of ${state.totalCount} characters',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ),
                  // Character list
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<CharacterBloc>().add(
                              RefreshCharactersPaginatedEvent(),
                            );
                        await Future.delayed(const Duration(seconds: 1));
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.hasReachedMax
                            ? state.characters.length
                            : state.characters.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.characters.length) {
                            return state.isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }
                          return CharacterCard(
                            character: state.characters[index],
                            onTap: () {
                              context.push(
                                '/character/${state.characters[index].id}',
                                extra: state.characters[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CharacterError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        style: TextStyle(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<CharacterBloc>()
                              .add(FetchCharactersPaginatedEvent());
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
```

#### 10.11 Create Character Detail Page

**File: `lib/features/character/presentation/pages/character_detail_page.dart`**
```dart
import 'package:flutter/material.dart';
import '../../domain/entities/character_entity.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            Hero(
              tag: 'character_${character.id}',
              child: Image.network(
                character.image,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            // Character information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Status',
                    [
                      _buildInfoRow(
                        Icons.circle,
                        'Status',
                        character.status,
                        statusColor: _getStatusColor(character.status),
                      ),
                      _buildInfoRow(Icons.science, 'Species', character.species),
                      if (character.type.isNotEmpty)
                        _buildInfoRow(Icons.info, 'Type', character.type),
                      _buildInfoRow(Icons.wc, 'Gender', character.gender),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Location',
                    [
                      _buildInfoRow(
                        Icons.location_on,
                        'Last known location',
                        character.locationName,
                      ),
                      _buildInfoRow(
                        Icons.public,
                        'Origin',
                        character.originName,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: statusColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
```

#### 10.12 Update Dependency Injection

**File: `lib/injection_container.dart`**

Add Character feature initialization:
```dart
// Add imports
import 'features/character/data/datasources/character_remote_datasource.dart';
import 'features/character/data/repositories/character_repository_impl.dart';
import 'features/character/domain/repositories/character_repository.dart';
import 'features/character/domain/usecases/get_characters_paginated.dart';
import 'features/character/presentation/bloc/character_bloc.dart';

// Add initialization function
void _initCharacterFeature() {
  debugPrint('  Initializing Character feature...');

  // Data layer - Data Sources
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(dio: sl()),
  );

  // Data layer - Repository
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(remoteDataSource: sl()),
  );

  // Domain layer - Use Cases
  sl.registerLazySingleton<GetCharactersPaginated>(
    () => GetCharactersPaginated(sl()),
  );

  // Presentation layer - BLoC (Factory for new instances)
  sl.registerFactory<CharacterBloc>(
    () => CharacterBloc(getCharactersPaginated: sl()),
  );

  debugPrint('  ✓ Character feature initialized');
}

// Call in init() function
Future<void> init() async {
  // ... existing code ...

  _initCharacterFeature();

  // ... rest of code ...
}
```

#### 10.13 Update Routing

**File: `lib/core/utils/app_router.dart`**

Add character routes:
```dart
// Add imports
import '../../features/character/domain/entities/character_entity.dart';
import '../../features/character/presentation/pages/character_list_page.dart';
import '../../features/character/presentation/pages/character_detail_page.dart';

// Add routes
GoRoute(
  path: '/characters',
  name: 'characters',
  builder: (context, state) => const CharacterListPage(),
),
GoRoute(
  path: '/character/:id',
  name: 'character-detail',
  builder: (context, state) {
    final character = state.extra as CharacterEntity;
    return CharacterDetailPage(character: character);
  },
),
```

#### 10.14 Add Navigation Button

**File: `lib/features/counter/presentation/pages/counter_page.dart`**

Add button to navigate to characters:
```dart
OutlinedButton.icon(
  onPressed: () => context.go('/characters'),
  icon: const Icon(Icons.movie),
  label: const Text('View Rick & Morty Characters'),
  style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
  ),
),
```

### Validation Steps

Run the app and test:

1. **Initial Load**:
   - Navigate to Characters page
   - Verify first 20 characters load
   - Check "Loaded 20 of 826 characters" displays

2. **Infinite Scroll**:
   - Scroll down to bottom
   - Verify next 20 characters load automatically
   - Check count updates (40, 60, 80...)
   - Continue until all 826 characters are loaded

3. **Pull to Refresh**:
   - Pull down from top
   - Verify list resets to page 1
   - Check count resets to 20

4. **Detail Navigation**:
   - Tap any character card
   - Verify detail page shows with hero animation
   - Check all character info displays correctly

5. **Error Handling**:
   - Turn off internet
   - Try to refresh
   - Verify error message displays
   - Turn on internet and tap Retry

### Key Concepts Learned

1. **API Adaptation**:
   - Different APIs have different pagination structures
   - Parse nested response objects (`info`, `results`)
   - Handle pagination metadata (`next`, `count`)

2. **Large-Scale Pagination**:
   - Efficiently load 826 items across 42 pages
   - Trigger loading at 90% scroll (not at bottom)
   - Track total count for progress indication

3. **Performance Optimization**:
   - Only load 20 items at a time
   - Use Hero animations for smooth transitions
   - Implement loading states for better UX

4. **Clean Architecture**:
   - Same pattern works for any API
   - Entity stays pure (no JSON logic)
   - Model handles API-specific structure
   - Repository abstracts data source

### Common Patterns

1. **Hero Animations**: Use same tag across list and detail for smooth transitions
2. **Progress Indication**: Show "X of Y" to give users context
3. **Loading States**: `isLoadingMore` flag prevents duplicate requests
4. **Scroll Threshold**: Trigger at 90% instead of 100% for better UX

### Comparison: JSONPlaceholder vs Rick and Morty API

| Feature | JSONPlaceholder | Rick and Morty |
|---------|----------------|----------------|
| Total Items | 10 | 826 |
| Items/Page | Configurable | Fixed at 20 |
| Query Param | `?_page=1&_limit=10` | `?page=1` |
| Response | Direct array | `{info: {...}, results: [...]}` |
| Pagination | Headers | Response `info` object |
| Use Case | Testing, small datasets | Real-world pagination |

---

## Learning Checkpoints

### After Phase 3
Can you answer these?
- What is Clean Architecture?
- What's the difference between Entity and Model?
- Why use repository interfaces?
- What is a Use Case?

### After Phase 6
Can you answer these?
- How does BLoC pattern work?
- What's the data flow from UI to repository?
- How does dependency injection help?
- Why separate widgets into components?

### After Phase 7
Can you answer these?
- How to handle network errors?
- What's the difference between local and remote data sources?
- How does routing work with go_router?
- How to pass data between pages?

### After Phase 9
Can you answer these?
- Why is pagination important for performance?
- How does infinite scroll work?
- What's the difference between page-based and cursor-based pagination?
- How do you prevent duplicate API requests during pagination?
- How does the BLoC manage paginated state?

---

## Best Practices Summary

### 1. Architecture
- Inner layers never depend on outer layers
- Each layer has specific responsibility
- Use abstractions (interfaces) for dependencies

### 2. Code Organization
- Feature-based folder structure
- Group by layer (domain, data, presentation)
- Keep related files together

### 3. State Management
- Events represent actions
- States represent UI conditions
- BLoC connects business logic to UI
- Immutable states

### 4. Error Handling
- Use Either for explicit error handling
- Exceptions in data layer
- Failures in domain layer
- Show user-friendly messages in UI

### 5. Testing Strategy
- Unit test use cases
- Test repository implementations
- Test BLoC events and states
- Widget tests for UI components

---

## Common Pitfalls to Avoid

1. Importing presentation code in domain layer
2. Putting business logic in widgets
3. Not handling all state cases in UI
4. Forgetting to register dependencies
5. Not using const constructors
6. Mutating state directly
7. Not handling async errors
8. Tight coupling between layers

---

## Next Steps After Completion

1. Add authentication feature
2. Implement CRUD operations
3. Add search and filtering
4. Write comprehensive tests
5. Add analytics
6. Implement CI/CD
7. Publish to app stores

---

## Resources

### Official Documentation
- [Flutter Docs](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

### Packages
- [get_it](https://pub.dev/packages/get_it)
- [dio](https://pub.dev/packages/dio)
- [go_router](https://pub.dev/packages/go_router)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [dartz](https://pub.dev/packages/dartz)

---

## Conclusion

This phased approach allows you to:
- Learn concepts incrementally
- Build muscle memory for patterns
- Understand why each piece exists
- Create production-ready code

Start with Phase 1 and work through sequentially. Don't rush. Understand each concept before moving forward. By the end, you'll have a solid foundation in Flutter Clean Architecture.

Happy Learning!
