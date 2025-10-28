library;

// Error Handling
export 'src/error/exceptions.dart';
export 'src/error/failures.dart';

// Event Sourcing
export 'src/event_sourcing/domain_event.dart';
export 'src/event_sourcing/event_store.dart';
export 'src/event_sourcing/event_bus.dart';
export 'src/event_sourcing/aggregate_root.dart';

// CQRS
export 'src/cqrs/command.dart';
export 'src/cqrs/query.dart';
export 'src/cqrs/command_handler.dart';
export 'src/cqrs/query_handler.dart';

// Use Cases
export 'src/usecases/usecase.dart';

// Network
export 'src/network/api_client.dart';
export 'src/network/network_info.dart';
export 'src/network/certificate_pinning.dart';

// Storage
export 'src/storage/secure_storage.dart';
export 'src/storage/cache_manager.dart';

// Sync
export 'src/sync/sync_manager.dart';
export 'src/sync/conflict_resolver.dart';

// Utils
export 'src/utils/logger.dart';
export 'src/utils/isolate_helper.dart';
export 'src/utils/constants.dart';

// DI
export 'src/di/injection.dart';
