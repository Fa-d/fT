import 'package:equatable/equatable.dart';

/// Counter entity - Pure business object
/// Contains only business logic, no implementation details
class CounterEntity extends Equatable {
  final int value;

  const CounterEntity({required this.value});

  @override
  List<Object?> get props => [value];
}
