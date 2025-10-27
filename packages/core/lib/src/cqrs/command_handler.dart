import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import 'command.dart';

/// Base class for all command handlers
/// Command handlers process commands and return results
abstract class CommandHandler<TCommand extends Command, TResult> {
  /// Handle the command and return a result
  Future<Either<Failure, TResult>> handle(TCommand command);
}
