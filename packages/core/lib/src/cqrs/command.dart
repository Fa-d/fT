import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Base class for all commands in CQRS pattern
/// Commands represent write operations (state changes)
/// Commands should be named in imperative mood (CreateUser, UpdateProfile, etc.)
abstract class Command extends Equatable {
  /// Unique identifier for this command
  final String commandId;

  /// Timestamp when the command was created
  final DateTime timestamp;

  /// User or system that issued this command
  final String? issuedBy;

  /// Additional metadata for the command
  final Map<String, dynamic>? metadata;

  Command({
    String? commandId,
    DateTime? timestamp,
    this.issuedBy,
    this.metadata,
  })  : commandId = commandId ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [commandId, timestamp, issuedBy, metadata];
}

/// Result of command execution
class CommandResult<T> {
  final bool isSuccess;
  final T? data;
  final String? errorMessage;
  final List<String>? validationErrors;

  const CommandResult.success(this.data)
      : isSuccess = true,
        errorMessage = null,
        validationErrors = null;

  const CommandResult.failure(this.errorMessage, [this.validationErrors])
      : isSuccess = false,
        data = null;

  bool get isFailure => !isSuccess;
}
